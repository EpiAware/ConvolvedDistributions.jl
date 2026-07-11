# ============================================================================
# convolve_series(delay, series): timeseries delay convolution
# ============================================================================
#
# `convolve_series` convolves a numeric timeseries with the discretised
# delay PMF of a distribution. With `series` the expected events at times
# `0..t` (e.g. infections), the result is the expected downstream event
# counts at the same times: the EpiNow2-style latent / renewal observation
# layer.
#
# It has its own verb (rather than a `convolved` method) because it returns
# a numeric series, not a distribution: `convolved` is kept strictly for
# the participle idiom of lazy distribution construction, like `truncated`
# and `censored`.
#
# AD-safety. The vector convolution is linear and the PMF depends
# differentiably on the delay parameters (the interval masses route through
# the AD-safe CDF helpers), so gradients flow through ForwardDiff /
# ReverseDiff / Enzyme / Mooncake w.r.t. the delay params.

# --- the discrete delay PMF over the grid 0..maxlag ------------------------

# Probability masses of `delay` on the unit-spaced intervals
# `[0, 1), [1, 2), ..., [maxlag, maxlag + 1)` (scaled by `interval`), as a
# length `maxlag + 1` vector. Masses are the raw CDF differences
# `F((k + 1) interval) - F(k interval)` (no silent renormalise), routed
# through `_cdf_ad_safe` so `Dual`/tracked CDF values survive (no `Float64`
# caching that would break AD).
function _delay_pmf(delay::UnivariateDistribution, maxlag::Integer, interval)
    # Float the grid step so the CDF arguments are floats even for an
    # integer `interval`: the AD-safe Gamma CDF rules attach a `Float64`
    # tangent to the evaluation point, which Mooncake cannot pair with an
    # `Int` primal.
    step = float(interval)
    return map(0:maxlag) do k
        # Clamp at zero: numeric-CDF noise can make the difference of two
        # near-equal tail values fractionally negative, and a mass must not
        # be (matches the CensoredDistributions interval-mass behaviour).
        mass = _cdf_ad_safe(delay, (k + 1) * step) -
               _cdf_ad_safe(delay, k * step)
        max(mass, zero(mass))
    end
end

# --- the causal discrete convolution series ⊛ pmf --------------------------

# Causal discrete convolution of a series with a delay PMF, truncated to the
# series window. `out[i] = Σ_{k≥0} pmf[k + 1] * series[i - k]`, i.e. mass from
# lag `k` carries `series[i - k]` forward to time `i`. The accumulator element
# type is seeded from the product so `Dual`/tracked numbers propagate.
function _causal_convolve(series::AbstractVector, pmf::AbstractVector)
    n = length(series)
    T = promote_type(eltype(series), eltype(pmf))
    out = zeros(T, n)
    @inbounds for i in 1:n
        acc = zero(T)
        kmax = min(length(pmf), i)
        for k in 1:kmax
            acc += pmf[k] * series[i - k + 1]
        end
        out[i] = acc
    end
    return out
end

# --- public API: the timeseries convolution verb ---------------------------

@doc "

Convolve a timeseries with the discretised delay PMF of a distribution.

`convolve_series(delay, series)` discretises `delay` to a PMF over the
unit grid and returns the causal discrete convolution of `series` with
that PMF, truncated to the `series` window. With `series` the expected
events at times `0, 1, ..., t` (e.g. infections), the result is the
expected downstream event counts at the same times (the EpiNow2-style
latent / renewal observation layer).

The PMF masses are the raw CDF differences ``F(k + 1) - F(k)`` over the
grid (no renormalisation), so delay mass beyond the series window — and
any mass below zero — is truncated. The masses depend differentiably on
the delay parameters, so gradients flow under the supported AD backends.

Unlike [`convolved`](@ref), which combines distributions into a single
[`Convolved`](@ref) distribution, this returns a numeric series; the
separate verb keeps `convolved` strictly for distribution construction.

# Arguments
- `delay`: the delay distribution (any `UnivariateDistribution`,
  including a [`Convolved`](@ref) total delay).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

# Keyword Arguments
- `interval`: the discretisation grid width, which is also the series
  time-step. The series is unit-spaced and the causal convolution shifts
  by integer series steps, so this must be `1` (the default); any other
  value is rejected with an `ArgumentError` to avoid conflating the grid
  width with the series step.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(delay, infections)
```

# See also
- [`convolved`](@ref): the distribution-level convolution
- [`Convolved`](@ref): the distribution type
- [`discretise_pmf`](@ref): discretise once and reuse the PMF
"
function convolve_series(
        delay::UnivariateDistribution, series::AbstractVector{<:Real};
        interval = 1)
    # The causal convolution shifts the series by integer SERIES steps, so
    # the PMF bin width must equal the series time-step. `series` is
    # unit-spaced (see the docstring), so only `interval == 1` keeps the
    # discretisation grid aligned with the shift; any other width conflates
    # the two and silently mis-aligns the result. Reject it rather than
    # return a wrong answer.
    _check_unit_interval(interval)
    maxlag = length(series) - 1
    pmf = _delay_pmf(delay, maxlag, interval)
    return convolve_series(pmf, series)
end

# The shared unit-grid guard: the causal convolution shifts by integer
# series steps, so any PMF grid width other than the (unit) series
# time-step silently mis-aligns the result. Reject it instead.
function _check_unit_interval(interval)
    isone(interval) || throw(ArgumentError(
        "interval must be 1: the series is unit-spaced and the causal " *
        "convolution shifts by integer series steps, so a PMF grid width " *
        "other than 1 conflates the discretisation width with the series " *
        "time-step. Got interval = $(interval)."))
    return nothing
end

@doc "

Convolve a timeseries with a caller-supplied discretised delay PMF.

`convolve_series(pmf, series)` returns the causal discrete convolution
of `series` with the probability masses `pmf`, truncated to the `series`
window: `out[i] = sum(pmf[k + 1] * series[i - k] for k in 0:(i - 1))`.
`pmf[k + 1]` is read as the delay mass at integer lag `k` on the same
unit grid as `series`.

The masses are used exactly as given: no renormalisation, no validation
that they sum to one, and no tail correction — mass at lags beyond the
series window (including any `pmf` entries past `length(series)`) is
simply never used, so sub-normalised or window-truncated PMFs stay
truncated. This is the decoupled form of
[`convolve_series(delay, series)`](@ref convolve_series): the caller
owns the discretisation (e.g. double-interval-censored masses from
CensoredDistributions.jl), and this method only convolves. The
convolution is linear, so gradients flow through both `pmf` and
`series` under the supported AD backends.

# Arguments
- `pmf`: the discretised delay probability masses at integer lags
  `0, 1, 2, ...` (used as given).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

# Examples
```@example
using ConvolvedDistributions

pmf = [0.5, 0.3, 0.2]
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(pmf, infections)
```

# See also
- [`discretise_pmf`](@ref): build a reusable [`DelayPMF`](@ref) from a
  delay distribution
"
function convolve_series(
        pmf::AbstractVector{<:Real}, series::AbstractVector{<:Real})
    return _causal_convolve(series, pmf)
end

# --- the build-once delay PMF for repeated vector evaluation ---------------
#
# `convolve_series(delay, series)` rebuilds the delay PMF on every call.
# When one delay PMF is applied across many series (the delay params are
# fixed for the build), `DelayPMF` lets the caller discretise once with
# `discretise_pmf` and reuse it. The object is immutable and holds no
# cache: it is built from the delay's parameter type so the build
# differentiates, and a parameter change means building a new object (no
# stale memo). The masses are exactly the `_delay_pmf` CDF differences,
# so results are identical to the rebuild path.

@doc "
A precomputed discretised delay PMF, built once and reused across many
vector evaluations.

`DelayPMF` holds the raw CDF-difference interval masses of a delay
distribution on the grid `[0, 1), [1, 2), ..., [m, m + 1)` scaled by
`interval` (where `m` is the `maxlag` it was built with), clamped at
zero against numeric-CDF noise but never renormalised, so a single
discretisation is shared across many series or lag lookups instead of
being rebuilt per call.

Build it with [`discretise_pmf`](@ref); apply it with
[`convolve_series`](@ref) (the causal series convolution, unit grid
only) or read masses at integer lags with `pdf(pmf, lag)`. The object
is immutable and carries no mutable cache: the masses keep the delay's
parameter type, so the build and every reuse differentiate cleanly, and
a parameter change is handled by building a fresh object.

# See also
- [`discretise_pmf`](@ref): the build-once constructor
- [`convolve_series`](@ref): apply the PMF across a series
"
struct DelayPMF{V <: AbstractVector, I <: Real}
    "The discretised interval masses over the grid `0..maxlag`."
    masses::V
    "The grid width the masses were discretised on."
    interval::I

    function DelayPMF(masses::V, interval::I) where {
            V <: AbstractVector, I <: Real}
        length(masses) >= 1 ||
            throw(ArgumentError("DelayPMF needs at least one mass"))
        interval > 0 ||
            throw(ArgumentError("DelayPMF interval must be positive"))
        new{V, I}(masses, interval)
    end
end

# The number of grid points is `maxlag + 1`; `_maxlag` is the largest
# integer lag the PMF carries a mass for.
Base.length(pmf::DelayPMF) = length(pmf.masses)
_maxlag(pmf::DelayPMF) = length(pmf.masses) - 1

@doc "

Discretise a delay distribution to a [`DelayPMF`](@ref) once, for reuse
across many series or lag lookups.

`discretise_pmf(delay, maxlag; interval = 1.0)` computes the raw
CDF-difference interval masses of `delay` on the grid
`[0, 1), ..., [maxlag, maxlag + 1)` (scaled by `interval`) and returns
a precomputed [`DelayPMF`](@ref) to pass into
[`convolve_series`](@ref) or `pdf(pmf, lag)`. Building once and reusing
avoids rediscretising the delay per series or per record.

The masses are exactly those the rebuild-every-time
[`convolve_series(delay, series)`](@ref convolve_series) path computes
(raw CDF differences clamped at zero, never renormalised), so a
prebuilt PMF gives numerically identical results. The masses keep the delay's parameter
type, so the discretisation differentiates w.r.t. the delay parameters;
a parameter change is handled by calling `discretise_pmf` again (there
is no stale cache).

# Arguments
- `delay`: the delay distribution to discretise (any
  `UnivariateDistribution`, including a [`Convolved`](@ref) total
  delay).
- `maxlag`: the largest integer lag to carry a mass for; the PMF has
  `maxlag + 1` entries.

# Keyword Arguments
- `interval`: the discretisation grid width (default `1.0`). Only a
  unit grid can be pushed through [`convolve_series`](@ref); other
  widths are for lag lookups.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
# Build the delay PMF once for a 30-step window.
pmf = discretise_pmf(delay, 30)

# Reuse it across many series without rediscretising.
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
counts = convolve_series(pmf, infections)
```

# See also
- [`DelayPMF`](@ref): the precomputed-PMF object
- [`convolve_series`](@ref): apply the PMF across a series
"
function discretise_pmf(delay::UnivariateDistribution, maxlag::Integer;
        interval::Real = 1.0)
    maxlag >= 0 ||
        throw(ArgumentError("maxlag must be non-negative, got $(maxlag)"))
    return DelayPMF(_delay_pmf(delay, maxlag, interval), interval)
end

@doc "

Convolve a timeseries with a precomputed [`DelayPMF`](@ref), reusing
the build-once masses.

`convolve_series(pmf, series)` is the same causal, window-truncated
convolution as [`convolve_series(delay, series)`](@ref convolve_series)
but takes a PMF discretised once via [`discretise_pmf`](@ref) instead
of rebuilding it, so the result is numerically identical to the
rebuild path for the same `delay`. The PMF must be on the unit grid
(`interval == 1`); other grid widths are rejected with an
`ArgumentError` since the causal convolution shifts by integer series
steps.

# Arguments
- `pmf`: a precomputed [`DelayPMF`](@ref) on the unit grid.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

# Examples
```@example
using ConvolvedDistributions, Distributions

pmf = discretise_pmf(Gamma(2.0, 1.0), 6)
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(pmf, infections)
```

# See also
- [`discretise_pmf`](@ref): build the PMF once
"
function convolve_series(pmf::DelayPMF, series::AbstractVector{<:Real})
    _check_unit_interval(pmf.interval)
    return convolve_series(pmf.masses, series)
end

@doc "

Read the precomputed [`DelayPMF`](@ref) masses at integer lags.

`pdf(pmf, lag)` returns the discretised interval mass at `lag` (an
integer, or a vector of integers for a batched read), reusing the
build-once masses instead of re-evaluating CDF differences per lag. A
lag outside `0..maxlag` returns a zero of the PMF's element type (no
mass is carried there). `lag` counts grid steps, not time units: for a
PMF built with `interval != 1`, `pdf(pmf, k)` is the mass on
`[k * interval, (k + 1) * interval)`.

# Arguments
- `pmf`: a precomputed [`DelayPMF`](@ref).
- `lag`: an integer lag, or a vector of integer lags.

# Examples
```@example
using ConvolvedDistributions, Distributions

pmf = discretise_pmf(Gamma(2.0, 1.0), 10)
pdf(pmf, 3)
pdf(pmf, 0:5)
```

# See also
- [`discretise_pmf`](@ref): build the PMF once
"
function pdf(pmf::DelayPMF, lag::Integer)
    (0 <= lag <= _maxlag(pmf)) || return zero(eltype(pmf.masses))
    return @inbounds pmf.masses[lag + 1]
end

function pdf(pmf::DelayPMF, lags::AbstractVector{<:Integer})
    return map(l -> pdf(pmf, l), lags)
end
