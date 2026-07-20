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
# choice this package does not make (single- vs double-interval censoring),
# so passing a continuous delay is rejected: the caller discretises first
# (with CensoredDistributions.jl, which owns primary/interval censoring)
# and feeds the resulting PMF to the PMF-vector method, either directly as
# a vector or wrapped in a build-once `DelayPMF`.
#
# It has its own verb (rather than a `convolved` method) because it returns
# a numeric series, not a distribution: `convolved` is kept strictly for
# the participle idiom of lazy distribution construction, like `truncated`
# and `censored`.
#
# AD-safety. The vector convolution is linear, so gradients flow through
# ForwardDiff / ReverseDiff / Enzyme / Mooncake from a `pmf` (and `series`)
# that is itself differentiable in some upstream parameter.

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
off-by-one, so the discrete method reads `pdf(delay, k)` rather than a
CDF-difference mass.

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
discretised, and discretisation is a censoring choice this package does
not make (interval-censored-secondary with an exact primary vs. the usual
epidemiological double-interval-censored case). The caller discretises
first with CensoredDistributions.jl and passes the resulting PMF to
[`convolve_series(pmf, series)`](@ref convolve_series), either as a plain
vector or wrapped in a [`DelayPMF`](@ref) for reuse.

# See also
- [`DelayPMF`](@ref): a build-once PMF wrapper for repeated reuse
- [`convolve_series(pmf, series)`](@ref convolve_series): convolve a
  caller-supplied PMF
"
function convolve_series(
        delay::ContinuousUnivariateDistribution,
        series::AbstractVector{<:Real})
    throw(ArgumentError(
        "convolve_series does not discretise a continuous delay: " *
        "discretising a continuous delay needs an explicit censoring " *
        "scheme. Build the PMF with CensoredDistributions.jl (which " *
        "owns primary/interval censoring), then pass it — as a plain " *
        "vector or a DelayPMF — to convolve_series(pmf, series)."))
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
- [`DelayPMF`](@ref): wrap masses for repeated reuse without rebuilding
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
# `convolve_series(delay, series)` rebuilds the discrete delay PMF on
# every call. When one PMF is applied across many series, `DelayPMF` lets
# the caller wrap it once (however it was built — e.g. by
# CensoredDistributions.jl) and reuse it. The object is immutable and
# holds no cache: results are identical to passing the masses as a plain
# vector each time.

@doc "
A precomputed discretised delay PMF, built once and reused across many
vector evaluations.

`DelayPMF` wraps a caller-supplied delay PMF — masses at integer lags
`0..m` on a grid of width `interval` — so it can be applied across many
series or lag lookups without being rebuilt or re-passed as a bare
vector. This package does not discretise continuous delays itself (that
is a censoring choice CensoredDistributions.jl owns); build the masses
there, or however else is appropriate, and wrap them with
`DelayPMF(masses, interval)`.

Apply it with [`convolve_series`](@ref) (the causal series convolution)
or read masses at integer lags with `pdf(pmf, lag)`. The object is
immutable and carries no mutable cache: the masses keep whatever element
type they were built with, so gradients flow through them under the
supported AD backends when they are themselves differentiable in some
upstream parameter.

# See also
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

Convolve a timeseries with a precomputed [`DelayPMF`](@ref), reusing
its masses without rebuilding them.

`convolve_series(pmf, series)` is the causal, window-truncated
convolution of `series` with `pmf.masses`, numerically identical to
[`convolve_series(pmf.masses, series)`](@ref convolve_series) but
reading the grid width off the `DelayPMF` itself. The series is
interpreted on the PMF's own grid: entry `i` of `series` is the value
at time `(i - 1) * pmf.interval`, and lag `k` shifts by `k` grid steps
of that width. The grid width therefore comes from whoever built the
`DelayPMF` — a weekly-binned PMF convolves a weekly series — and no
separate step argument exists to conflict with it.

# Arguments
- `pmf`: a [`DelayPMF`](@ref); its `interval` is the grid the series is
  read on.
- `series`: the input timeseries, sampled at steps of `pmf.interval`
  from time 0.

# Examples
```@example
using ConvolvedDistributions

pmf = ConvolvedDistributions.DelayPMF([0.5, 0.3, 0.2], 1.0)
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(pmf, infections)
```

# See also
- [`DelayPMF`](@ref): the PMF wrapper
"
function convolve_series(pmf::DelayPMF, series::AbstractVector{<:Real})
    # The grid width comes from the PMF itself: the series is read on
    # steps of `pmf.interval`, so every regular grid is coherent and no
    # unit-width restriction applies.
    return convolve_series(pmf.masses, series)
end

@doc "

Read the [`DelayPMF`](@ref) masses at integer lags.

`pdf(pmf, lag)` returns the PMF's mass at `lag` (an integer, or a vector
of integers for a batched read). A lag outside `0..maxlag` returns a
zero of the PMF's element type (no mass is carried there). `lag` counts
grid steps, not time units: for a PMF built with `interval != 1`,
`pdf(pmf, k)` is the mass on `[k * interval, (k + 1) * interval)`.

# Arguments
- `pmf`: a [`DelayPMF`](@ref).
- `lag`: an integer lag, or a vector of integer lags.

# Examples
```@example
using ConvolvedDistributions

pmf = ConvolvedDistributions.DelayPMF([0.5, 0.3, 0.2], 1.0)
pdf(pmf, 1)
pdf(pmf, 0:2)
```
"
function pdf(pmf::DelayPMF, lag::Integer)
    (0 <= lag <= _maxlag(pmf)) || return zero(eltype(pmf.masses))
    return @inbounds pmf.masses[lag + 1]
end

function pdf(pmf::DelayPMF, lags::AbstractVector{<:Integer})
    return map(l -> pdf(pmf, l), lags)
end
