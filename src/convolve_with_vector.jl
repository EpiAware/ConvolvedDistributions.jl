# ============================================================================
# convolve_series(delay, series): timeseries delay convolution
# ============================================================================
#
# `convolve_series` convolves a numeric timeseries with a delay PMF on the
# unit lag grid. With `series` the expected events at times `0..t` (e.g.
# infections), the result is the expected downstream event counts at the
# same times: the EpiNow2-style latent / renewal observation layer.
#
# The delay enters as a PMF over integer lags. A caller-supplied PMF is a
# plain `AbstractVector{<:Real}` of masses at lags `0, 1, 2, ...`; a
# `DiscreteNonParametric` carries its own (regular) lag grid and masses,
# matching ModifiedDistributions' discrete-delay vocabulary for free
# cross-package consistency. For a DISCRETE parametric delay the lag-`k`
# mass is simply `pdf(delay, k)`, so that method reads the distribution's
# own PMF directly. A CONTINUOUS delay has no mass on the integer grid until
# it is discretised, and discretisation is a modelling choice this package
# does not make (single- vs double-interval censoring), so passing a
# continuous delay is rejected: the caller discretises first (with
# CensoredDistributions.jl, which owns primary/interval censoring) and feeds
# the resulting PMF to the PMF-vector method.
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
    # The lag-`k` mass of a discrete delay is `pdf(delay, k)` directly; a
    # CDF-difference `F(k + 1) - F(k) = pdf(delay, k + 1)` on integer support
    # would be an off-by-one. Lags run 0..(n - 1); negative-support mass is
    # never read (it cannot enter a causal convolution).
    masses = [pdf(delay, k) for k in 0:(length(series) - 1)]
    # These masses are the distribution's own PMF read on the series window,
    # so any shortfall is deliberate window truncation, not a mis-normalised
    # input: skip the normalisation check the caller-facing vector method runs.
    return convolve_series(masses, series; check_normalisation = false)
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
[`convolve_series(pmf, series)`](@ref convolve_series), as a plain vector
of masses or a `Distributions.DiscreteNonParametric` delay.

# See also
- [`convolve_series(pmf, series)`](@ref convolve_series): convolve a
  caller-supplied PMF vector
"
function convolve_series(
        delay::ContinuousUnivariateDistribution,
        series::AbstractVector{<:Real})
    throw(ArgumentError(
        "convolve_series does not discretise a continuous delay: " *
        "discretising a continuous delay needs an explicit censoring " *
        "scheme. Build the PMF with CensoredDistributions.jl (which " *
        "owns primary/interval censoring), then pass it — as a plain " *
        "vector of masses or a DiscreteNonParametric delay — to " *
        "convolve_series(pmf, series)."))
end

@doc "

Convolve a timeseries with a `DiscreteNonParametric` delay on its own
regular lag grid.

`convolve_series(delay, series)` for a `DiscreteNonParametric` delay reads
the masses off `probs(delay)` and the grid off `support(delay)`. The
support must be a regular grid (equal spacing) aligned to zero — i.e. the
support values are non-negative integer multiples of the grid step — so the
masses sit on consecutive integer lags `0, 1, 2, ...`; a support point at
`k * step` carries its mass to lag `k`, with unfilled lags carrying no mass
(a delay whose support starts above zero shifts the series forward). The
grid step is the series' own sampling interval, so a weekly-binned delay
convolves a weekly series; it does not enter the arithmetic, exactly as a
plain mass vector convolves positionally.

Using `DiscreteNonParametric` matches ModifiedDistributions' discrete-delay
representation, so a delay built once is reused across the org's convolution
and reporting surfaces without a bespoke wrapper type. Its masses sum to one
by construction, so no normalisation check is applied.

# Arguments
- `delay`: a `DiscreteNonParametric` whose support is a regular,
  zero-aligned lag grid.
- `series`: the input timeseries, sampled at the support's grid step from 0.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = DiscreteNonParametric([0, 1, 2], [0.5, 0.3, 0.2])
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(delay, infections)
```

# See also
- [`convolve_series(pmf, series)`](@ref convolve_series): the plain-vector
  form on the unit grid
"
function convolve_series(
        delay::DiscreteNonParametric, series::AbstractVector{<:Real})
    xs = support(delay)
    ps = probs(delay)
    lags = _regular_grid_lags(xs)
    # Scatter the masses onto their integer lags, leaving unfilled lags at
    # zero (a support starting above lag 0 is a forward shift). The element
    # type follows the masses so a differentiable mass carries through.
    masses = zeros(eltype(ps), lags[end] + 1)
    @inbounds for (k, p) in zip(lags, ps)
        masses[k + 1] = p
    end
    # `probs` sum to one by construction, so the normalisation check would
    # never fire; skip it.
    return convolve_series(masses, series; check_normalisation = false)
end

# Map a sorted `DiscreteNonParametric` support to the non-negative integer
# lags it lands on, validating that it is a regular grid aligned to zero.
# The support is sorted and unique (a `DiscreteNonParametric` invariant), so
# the spacing is positive; it must also be constant and divide each support
# value into a whole number of steps from zero.
function _regular_grid_lags(xs::AbstractVector{<:Real})
    first(xs) >= 0 || throw(ArgumentError(
        "convolve_series needs a delay on non-negative lags; the support " *
        "starts at $(first(xs)) (negative lags cannot enter a causal " *
        "convolution)"))
    # A single support point defines no grid step, so read it as a unit-grid
    # point mass: the value is the lag directly and must be a whole number.
    length(xs) == 1 && return [_grid_step_index(first(xs), one(first(xs)))]
    step = xs[2] - xs[1]
    for i in 2:length(xs)
        isapprox(xs[i] - xs[i - 1], step; rtol = 1e-8, atol = 1e-12) ||
            throw(ArgumentError(
                "convolve_series needs a DiscreteNonParametric delay on a " *
                "regular lag grid (equal spacing); got support $(collect(xs)) " *
                "with uneven spacing. Resample it onto a regular grid first."))
    end
    return [_grid_step_index(x, step) for x in xs]
end

# The integer lag a support value sits on: `x / step` rounded, checked to be
# a non-negative whole number of steps from zero (the grid is aligned to 0).
function _grid_step_index(x::Real, step::Real)
    q = x / step
    k = round(Int, q)
    (k >= 0 && isapprox(q, k; rtol = 1e-8, atol = 1e-12)) || throw(ArgumentError(
        "convolve_series needs a DiscreteNonParametric delay whose support " *
        "lies on a grid aligned to zero (each support value a whole number " *
        "of steps from 0); support value $x is not a multiple of the grid " *
        "step $step"))
    return k
end

@doc "

Convolve a timeseries with a caller-supplied discretised delay PMF.

`convolve_series(pmf, series)` returns the causal discrete convolution
of `series` with the probability masses `pmf`, truncated to the `series`
window:
`out[i] = sum(pmf[k + 1] * series[i - k] for k in 0:(min(length(pmf), i) - 1))`.
`pmf[k + 1]` is read as the delay mass at integer lag `k` on the same
unit grid as `series`.

The masses are convolved exactly as given: no renormalisation and no tail
correction — mass at lags beyond the series window (including any `pmf`
entries past `length(series)`) is simply never used, so a genuinely
window-truncated PMF stays truncated. What the method does check, by
default, is normalisation: if the supplied masses sum to something far
from one (more than `5%` off), it emits a one-line warning, since a PMF
that has silently lost a large fraction of its mass is usually a mistake
rather than intentional truncation. The masses are still used unchanged —
the warning informs, it does not rescale. Pass `check_normalisation =
false` to silence it for a deliberately truncated or unnormalised PMF (and
in a differentiated hot loop, where the intent is fixed once). This is the
decoupled form of [`convolve_series(delay, series)`](@ref convolve_series):
the caller owns the discretisation (e.g. double-interval-censored masses
from CensoredDistributions.jl), and this method only convolves. The
convolution is linear, so gradients flow through both `pmf` and `series`
under the supported AD backends.

# Arguments
- `pmf`: the discretised delay probability masses at integer lags
  `0, 1, 2, ...` (used as given).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

# Keywords
- `check_normalisation`: warn when the masses sum far from one (default
  `true`); set `false` to silence it for an intentionally truncated or
  unnormalised PMF.

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
- [`convolve_series(delay, series)`](@ref convolve_series): read the PMF
  off a discrete or `DiscreteNonParametric` delay directly
"
function convolve_series(
        pmf::AbstractVector{<:Real}, series::AbstractVector{<:Real};
        check_normalisation::Bool = true)
    # An empty PMF is a construction bug upstream, not a zero signal —
    # reject it rather than silently returning an all-zero series.
    isempty(pmf) &&
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    if check_normalisation && !_pmf_normalisation_ok(pmf)
        @warn "convolve_series: the supplied PMF masses sum to $(sum(pmf)), " *
              "not ≈ 1; they are convolved as given (no rescaling). Pass " *
              "check_normalisation = false to silence this if the truncation " *
              "is intentional." maxlog=1
    end
    return _causal_convolve(series, pmf)
end

# Whether supplied masses sum close enough to one to pass the normalisation
# check. The 5% band lets ordinary finite-grid tail truncation through while
# flagging gross mis-normalisation (e.g. a PMF that lost a quarter of its
# mass) — the silent large-mass-loss failure mode. The sum only feeds a
# comparison, so it never touches a returned gradient, and the comparison
# resolves to a plain `Bool` under every AD backend.
function _pmf_normalisation_ok(pmf::AbstractVector{<:Real})
    return isapprox(sum(pmf), one(eltype(pmf)); atol = 5e-2, rtol = 5e-2)
end
