# ============================================================================
# convolve_series(delay, series): timeseries delay convolution
# ============================================================================
#
# `convolve_series` convolves a numeric timeseries with a delay PMF on the
# unit lag grid. With `series` the expected events at times `0..t` (e.g.
# infections), the result is the expected downstream event counts at the
# same times: the EpiNow2-style latent / renewal observation layer.
#
# The delay enters as a PMF over integer lags. For a DISCRETE delay the
# lag-`k` mass is simply `pdf(delay, k)`, so the discrete method reads the
# distribution's own PMF directly. A CONTINUOUS delay has no mass on the
# integer grid until it is discretised, and discretisation is a modelling
# choice with more than one answer (single- vs double-interval censoring),
# so passing a continuous delay is rejected: the caller discretises first
# (via `discretise_pmf`, or CensoredDistributions.jl's double-interval
# censored extension) and feeds the resulting PMF to the PMF-vector method.
#
# It has its own verb (rather than a `convolved` method) because it returns
# a numeric series, not a distribution: `convolved` is kept strictly for
# the participle idiom of lazy distribution construction, like `truncated`
# and `censored`.
#
# AD-safety. The vector convolution is linear and the PMF depends
# differentiably on the delay parameters (the discrete PMF through
# `pdf(delay, k)`, the `discretise_pmf` interval masses through the AD-safe
# CDF helpers), so gradients flow through ForwardDiff / ReverseDiff /
# Enzyme / Mooncake w.r.t. the delay params.

# --- the discrete delay PMF over the grid 0..maxlag ------------------------

# Probability masses of `delay` on the unit-spaced intervals
# `[0, 1), [1, 2), ..., [maxlag, maxlag + 1)` (scaled by `interval`), as a
# length `maxlag + 1` vector. Masses are the raw CDF differences
# `F((k + 1) interval) - F(k interval)` (no silent renormalise), routed
# through `cdf_ad_safe` so `Dual`/tracked CDF values survive (no `Float64`
# caching that would break AD).
#
# These CDF-difference masses are the interval-censored-secondary scheme
# with an EXACT primary event: `F(k + 1) - F(k)` is the probability the
# delay lands in day `k` given the primary happened at an exact instant.
# When the PRIMARY is also only known to the day (the usual epi case), the
# masses need double interval censoring, which is CensoredDistributions.jl's
# job — see `discretise_pmf` for the full framing.
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
        mass = cdf_ad_safe(delay, (k + 1) * step) -
               cdf_ad_safe(delay, k * step)
        max(mass, zero(mass))
    end
end

# --- the causal discrete convolution series ⊛ pmf --------------------------

# Causal discrete convolution of a series with a delay PMF, truncated to the
# series window. `out[i] = Σ_{k≥0} pmf[k + 1] * series[i - k]`, i.e. mass from
# lag `k` carries `series[i - k]` forward to time `i`. The accumulator element
# type is seeded from the product so `Dual`/tracked numbers propagate.
function _causal_convolve(series::AbstractVector, pmf::AbstractVector)
    # The @inbounds loop below indexes both vectors from 1; offset axes
    # would silently shift every mass and read past the end.
    Base.require_one_based_indexing(series, pmf)
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

Convolve a timeseries with the PMF of a discrete delay distribution.

`convolve_series(delay, series)` for a `DiscreteUnivariateDistribution`
`delay` reads the delay PMF directly off the integer lag grid — the
lag-`k` mass IS `pdf(delay, k)` — and returns the causal discrete
convolution of `series` with that PMF, truncated to the `series` window.
With `series` the expected events at times `0, 1, ..., t` (e.g.
infections), the result is the expected downstream event counts at the
same times (the EpiNow2-style latent / renewal observation layer).

The masses are `[pdf(delay, k) for k in 0:(length(series) - 1)]`, used as
given: no renormalisation, so any delay mass beyond the series window is
truncated. `pdf(delay, k)` is differentiable in the delay parameters for
the standard discrete families, so gradients flow under the supported AD
backends.

Direct PMF evaluation, NOT a CDF difference: for an integer-support
delay, ``F(k + 1) - F(k) = P(k < X \\le k + 1) = pdf(delay, k + 1)``, an
off-by-one, so the discrete method reads `pdf(delay, k)` and never routes
through [`discretise_pmf`](@ref)'s CDF-difference masses.

Only the integer lags `0, 1, 2, ...` are read. A delay with atoms off the
integer grid is out of scope (a lag grid means masses at the integers),
and mass at negative lags cannot enter a causal convolution, so lags
below `0` are not read (consistent with the causal kernel).

For a CONTINUOUS delay there is no mass on the integer grid until it is
discretised, and discretisation is an explicit modelling choice; that
method throws — see below.

Unlike [`convolved`](@ref), which combines distributions into a single
[`Convolved`](@ref) distribution, this returns a numeric series; the
separate verb keeps `convolved` strictly for distribution construction.

# Arguments
- `delay`: a `DiscreteUnivariateDistribution` (e.g. `Poisson`,
  `DiscreteUniform`, a shifted count delay).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = Poisson(2.0)
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(delay, infections)
```

# See also
- [`convolved`](@ref): the distribution-level convolution
- [`discretise_pmf`](@ref): discretise a continuous delay, then convolve
- [`convolve_series(pmf, series)`](@ref convolve_series): the PMF-vector
  form for caller-owned discretisation
"
function convolve_series(
        delay::DiscreteUnivariateDistribution,
        series::AbstractVector{<:Real})
    # The lag-`k` mass of a discrete delay is `pdf(delay, k)` directly; do
    # NOT reuse the CDF-difference `_delay_pmf`, which would compute
    # `F(k + 1) - F(k) = pdf(delay, k + 1)` for integer support — an
    # off-by-one. Lags run 0..(n - 1); negative-support mass is never read
    # (it cannot enter a causal convolution).
    masses = [pdf(delay, k) for k in 0:(length(series) - 1)]
    return convolve_series(masses, series)
end

@doc "

Reject a continuous delay: discretising it needs an explicit censoring
scheme.

`convolve_series(delay, series)` for a `ContinuousUnivariateDistribution`
(including a [`Convolved`](@ref) total delay) throws an `ArgumentError`.
A continuous delay carries no mass on the integer lag grid until it is
discretised, and there is more than one right way to do that: the naive
CDF-difference scheme is interval-censored on the secondary event with an
EXACT primary, whereas the usual epidemiological case (a primary event
known only to the day) needs double interval censoring. Rather than pick
one silently, the caller discretises first and passes the resulting PMF
to [`convolve_series(pmf, series)`](@ref convolve_series):

- [`discretise_pmf`](@ref)`(delay, maxlag)` for interval-censored-
  secondary masses (exact primary), or
- CensoredDistributions.jl's double-interval-censored extension for
  day-binned primaries.

# See also
- [`discretise_pmf`](@ref): the interval-censored-secondary discretisation
- [`convolve_series(pmf, series)`](@ref convolve_series): convolve a
  caller-supplied PMF
"
function convolve_series(
        delay::ContinuousUnivariateDistribution,
        series::AbstractVector{<:Real})
    throw(ArgumentError(
        "convolve_series does not discretise a continuous delay: " *
        "discretising a continuous delay needs an explicit censoring " *
        "scheme. Use discretise_pmf(delay, maxlag) for " *
        "interval-censored-secondary masses (exact primary), or " *
        "CensoredDistributions.jl's double-interval-censored extension " *
        "for day-binned primaries, then convolve_series(pmf, series)."))
end

@doc "

Convolve a timeseries with a caller-supplied discretised delay PMF.

`convolve_series(pmf, series)` returns the causal discrete convolution
of `series` with the probability masses `pmf`, truncated to the `series`
window:
`out[i] = sum(pmf[k + 1] * series[i - k] for k in 0:(min(length(pmf), i) - 1))`.
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

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

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
    # Mirror the DelayPMF constructor: an empty PMF is a construction
    # bug upstream, not a zero signal — reject it rather than silently
    # returning an all-zero series.
    isempty(pmf) &&
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
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
        # `pdf(pmf, lag)` reads `masses[lag + 1]` under @inbounds, so
        # offset axes would shift every lag and read out of bounds.
        Base.require_one_based_indexing(masses)
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

# Broadcast as a scalar so the idiomatic `pdf.(pmf, lags)` works instead
# of the broadcast machinery trying to iterate the PMF.
Base.broadcastable(pmf::DelayPMF) = Ref(pmf)

@doc "

Discretise a delay distribution to a [`DelayPMF`](@ref) once, for reuse
across many series or lag lookups.

`discretise_pmf(delay, maxlag; interval = 1.0)` computes the raw
CDF-difference interval masses of `delay` on the grid
`[0, 1), ..., [maxlag, maxlag + 1)` (scaled by `interval`) and returns
a precomputed [`DelayPMF`](@ref) to pass into
[`convolve_series`](@ref) or `pdf(pmf, lag)`. Building once and reusing
avoids rediscretising the delay per series or per record.

The masses `F(k + 1) - F(k)` are the interval-censored-secondary scheme
with an EXACT primary event: the probability the delay lands in day `k`
given the primary happened at a precise instant. This is an explicit
modelling choice, not a neutral default. When the PRIMARY is also known
only to the day — the usual epidemiological case — the day-binned masses
need double interval censoring, which is CensoredDistributions.jl's job
(build those masses there and pass them to
[`convolve_series(pmf, series)`](@ref convolve_series)). Reach for
`discretise_pmf` only when the exact-primary assumption is the one you
want.

The masses are clamped at zero against numeric-CDF noise but never
renormalised, so delay mass beyond `maxlag` stays truncated. They keep
the delay's parameter type, so the discretisation differentiates w.r.t.
the delay parameters; a parameter change is handled by calling
`discretise_pmf` again (there is no stale cache).

# Arguments
- `delay`: the delay distribution to discretise (any
  `UnivariateDistribution`, including a [`Convolved`](@ref) total
  delay).
- `maxlag`: the largest integer lag to carry a mass for; the PMF has
  `maxlag + 1` entries.

# Keyword Arguments
- `interval`: the discretisation grid width (default `1.0`). The width
  travels with the [`DelayPMF`](@ref): [`convolve_series`](@ref) reads
  the series on the PMF's own grid, and `pdf(pmf, k)` is the mass on
  `[k * interval, (k + 1) * interval)`.

# Returns
- A [`DelayPMF`](@ref) holding the `maxlag + 1` interval masses and the
  grid width.

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
    # Validate up front: otherwise all O(maxlag) CDF work runs before the
    # DelayPMF constructor rejects the interval with a message naming the
    # type rather than this function.
    interval > 0 ||
        throw(ArgumentError(
            "discretise_pmf interval must be positive, got $(interval)"))
    return DelayPMF(_delay_pmf(delay, maxlag, interval), interval)
end

@doc "

Convolve a timeseries with a precomputed [`DelayPMF`](@ref), reusing
the build-once masses.

`convolve_series(pmf, series)` is the causal, window-truncated
convolution of `series` with a PMF discretised once via
[`discretise_pmf`](@ref) instead of rebuilt per call, so the result is
numerically identical to discretising and convolving in one step. The
series is interpreted on the PMF's own grid: entry `i` of `series` is
the value at time `(i - 1) * pmf.interval`, and lag `k` shifts by `k`
grid steps of that width. The grid width therefore comes from the
discretisation the caller chose — a weekly-binned PMF convolves a
weekly series — and no separate step argument exists to conflict with
it.

# Arguments
- `pmf`: a precomputed [`DelayPMF`](@ref); its `interval` is the grid
  the series is read on.
- `series`: the input timeseries, sampled at steps of `pmf.interval`
  from time 0.

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
    # The grid width comes from the PMF itself: the series is read on
    # steps of `pmf.interval`, so every regular grid is coherent and no
    # unit-width restriction applies.
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
