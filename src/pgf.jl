# ============================================================================
# Probability generating function (issue #90)
# ============================================================================
#
# pgf(d, s) = E[s^X] for a discrete univariate distribution, mirroring
# Distributions.jl's mgf(d, t)/cf(d, t) calling convention
# (`pgf(d::UnivariateDistribution, s)`). No upstream `pgf` exists in
# Distributions.jl and none has been proposed there, so the primitive is
# defined here; keeping the signature convention identical means a future
# upstream migration is a cheap rename, not a redesign.
#
# The generic carries no fallback body: a distribution with no registered
# method (a closed form below, or the `DiscreteUnivariateDistribution`
# series fallback) raises a plain `MethodError` rather than silently
# returning a wrong or partial answer.

@doc "

Probability generating function, ``\\mathrm{pgf}(d, s) = \\mathbb{E}[s^X]``,
for a discrete univariate distribution `d`.

Mirrors the `Distributions.mgf`/`Distributions.cf` calling convention
(`pgf(d::UnivariateDistribution, s)`). Closed forms are registered for
the standard count families (`Poisson`, `Bernoulli`, `Binomial`,
`Geometric`, `NegativeBinomial`); any other `DiscreteUnivariateDistribution`
falls back to a truncated series. There is no method for a continuous
distribution, and no fallback silently truncates a series it cannot
bound — both raise rather than return an approximate or wrong answer.

# Arguments
- `d`: A discrete univariate distribution.
- `s`: The generating-function argument. `|s| <= 1` is always accepted;
  a specific method may accept a wider domain where its series converges
  (see [`Geometric`](@ref)/[`NegativeBinomial`](@ref) below).

# Examples
```@example
using ConvolvedDistributions, Distributions

ConvolvedDistributions.pgf(Poisson(2.0), 0.5)
ConvolvedDistributions.pgf(Binomial(5, 0.3), -1.0)
```
"
function pgf end

# ---------------------------------------------------------------------------
# Closed forms
# ---------------------------------------------------------------------------

@doc "

Closed-form pgf of a `Poisson`: ``\\exp(\\lambda (s - 1))``. Entire in `s`
(the series converges for every `s`), so there is no domain guard.
"
function pgf(d::Poisson, s::Real)
    return exp(d.λ * (s - 1))
end

@doc "

Closed-form pgf of a `Bernoulli`: ``1 - p + p s``, the `n = 1` case of
[`Binomial`](@ref)'s pgf.
"
function pgf(d::Bernoulli, s::Real)
    return 1 - d.p + d.p * s
end

@doc "

Closed-form pgf of a `Binomial`: ``(1 - p + p s)^n``. A polynomial in
`s`, so there is no domain guard.
"
function pgf(d::Binomial, s::Real)
    return (1 - d.p + d.p * s)^d.n
end

# Shared |s| < 1/(1-p) domain guard for Geometric/NegativeBinomial: both
# closed forms divide by `1 - (1-p)s`, singular at `s = 1/(1-p)` and
# sign-flipped beyond it, so a series value outside the guard would be a
# silently wrong answer rather than the true (divergent) sum.
function _pgf_ratio_domain_guard(fam::Symbol, p::Real, s::Real)
    bound = 1 / (1 - p)
    abs(s) < bound || throw(DomainError(s,
        "pgf(::$fam, s) requires |s| < 1/(1-p) = $bound"))
    return nothing
end

@doc "

Closed-form pgf of a `Geometric`: ``p / (1 - (1-p) s)`` for
``|s| < 1/(1-p)`` (the `r = 1` case of [`NegativeBinomial`](@ref)'s pgf).
Raises a `DomainError` outside that domain — the series diverges there.
"
function pgf(d::Geometric, s::Real)
    _pgf_ratio_domain_guard(:Geometric, d.p, s)
    return d.p / (1 - (1 - d.p) * s)
end

@doc "

Closed-form pgf of a `NegativeBinomial`: ``(p / (1 - (1-p) s))^r`` for
``|s| < 1/(1-p)``. Raises a `DomainError` outside that domain — the
series diverges there.
"
function pgf(d::NegativeBinomial, s::Real)
    _pgf_ratio_domain_guard(:NegativeBinomial, d.p, s)
    return (d.p / (1 - (1 - d.p) * s))^d.r
end

# ---------------------------------------------------------------------------
# Truncated-series fallback
# ---------------------------------------------------------------------------

# Mass tolerance for the truncated-series fallback: the sum stops once the
# accumulated probability mass is within this of 1. The branch that uses
# it requires `|s| <= 1`, so by the triangle inequality the dropped tail's
# contribution to the pgf value itself is bounded by the same quantity
# (`|sum_{k>K} s^k p_k| <= sum_{k>K} p_k = 1 - mass`) — one mass check
# doubles as the remainder-tail bound.
const _PGF_SERIES_TOL = 1.0e2 * eps(Float64)

# Term budget before the fallback raises rather than returning a partial
# sum: a distribution whose mass approaches 1 too slowly (e.g. an
# extreme-tailed Geometric) cannot be truncated safely.
const _PGF_SERIES_MAX_TERMS = 100_000

@doc "

Probability generating function for a discrete distribution with no
registered closed form: the series
``\\sum_{k \\ge \\mathrm{minimum}(d)} s^k \\, \\mathrm{pdf}(d, k)``.

A finite support sums exactly. An infinite support truncates once the
accumulated probability mass is within `1 - $(_PGF_SERIES_TOL)` of 1,
which (since `|s| <= 1` is required here) bounds the dropped tail's
contribution to the returned value by the same amount. Raises an
`ArgumentError` for a distribution unbounded below (the sum has no
starting point), a `DomainError` for `|s| > 1` with unbounded support
(the tail cannot be bounded without a closed form), and an
`ErrorException` if the mass tolerance is not reached within
`$(_PGF_SERIES_MAX_TERMS)` terms — never a silent partial sum.
"
function pgf(d::DiscreteUnivariateDistribution, s::Real)
    lo = minimum(d)
    isfinite(lo) || throw(ArgumentError(
        "pgf fallback requires a distribution bounded below; " *
        "minimum($(nameof(typeof(d)))) is not finite"))
    lo_i = Int(lo)
    hi = maximum(d)
    isfinite(hi) && return _pgf_series_sum(d, s, lo_i, Int(hi))

    abs(s) <= 1 || throw(DomainError(s,
        "pgf fallback for $(nameof(typeof(d))) (unbounded support, no " *
        "closed form registered) requires |s| <= 1 to bound the tail"))
    return _pgf_series_sum(d, s, lo_i, nothing)
end

# Shared truncated-series loop. `hi === nothing` sums until the mass
# tolerance is met (unbounded support), otherwise it sums the exact
# finite range `[lo, hi]`. The accumulator is seeded from the first term
# so its element type follows `s` and `pdf(d, ·)` — dual numbers from
# either propagate.
function _pgf_series_sum(d, s::Real, lo::Int, hi::Union{Int, Nothing})
    p0 = pdf(d, lo)
    acc = s^lo * p0
    mass = p0
    k = lo
    while hi === nothing ? mass < 1 - _PGF_SERIES_TOL : k < hi
        k += 1
        if hi === nothing && k - lo > _PGF_SERIES_MAX_TERMS
            throw(ErrorException(
                "pgf fallback for $(nameof(typeof(d))) did not reach " *
                "the mass tolerance within $_PGF_SERIES_MAX_TERMS terms; " *
                "the tail could not be bounded"))
        end
        pk = pdf(d, k)
        acc += s^k * pk
        mass += pk
    end
    return acc
end

# ---------------------------------------------------------------------------
# Structural extension: Convolved (sum of independents)
# ---------------------------------------------------------------------------

@doc "

Probability generating function of a [`Convolved`](@ref) whose
components are all discrete: independence makes it the product of the
component transforms, ``\\mathrm{pgf}_X(s) = \\prod_i \\mathrm{pgf}_{X_i}(s)``.

Checking each component with `applicable` (rather than an explicit
`DiscreteUnivariateDistribution` test) makes nesting recurse for free —
a nested `Convolved` component is itself checked the same way, so an
all-discrete combination at any depth works. A continuous component, or
one with no `pgf` method at all (`Difference`/`Product` do not define
one; composing a random-length sum is out of scope here, see #91), raises
a descriptive `ArgumentError` naming the offending component type(s).

# Examples
```@example
using ConvolvedDistributions, Distributions

d = convolved(Poisson(2.0), Poisson(3.0))
ConvolvedDistributions.pgf(d, 0.5) ≈
    ConvolvedDistributions.pgf(Poisson(5.0), 0.5)
```
"
function pgf(d::Convolved, s::Real)
    bad = filter(c -> !applicable(pgf, c, s), d.components)
    isempty(bad) || throw(ArgumentError(
        "pgf(::Convolved, s) requires every component to have a pgf " *
        "method (discrete components only); no method for " *
        "$(nameof.(typeof.(bad)))"))
    return prod(c -> pgf(c, s), d.components)
end
