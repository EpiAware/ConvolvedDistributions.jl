# Extensible analytic-pair registry (#77): a load-order-safe mechanism for
# registering a closed-form convolution CDF for a (delay, primary) component
# pair, consulted by `AnalyticalSolver` before the numeric quadrature
# fallback.
#
# This is a DIFFERENT mechanism to `_try_convolve` in `src/Convolved.jl`.
# `_try_convolve` returns a full `Distributions.convolve`-style Distribution
# (feeding pdf/mean/var/rand as well as cdf) for pairs built entirely from
# core Distributions.jl families (Normal+Normal, equal-rate Exponential,
# equal-scale Gamma) and is defined once, in this module, with no
# cross-package load-order concern. A registered analytic pair here supplies
# only a closed-form CDF (most of these -- a delay convolved with a
# window-restricted `Uniform` primary event -- have no named resulting
# distribution, only a closed-form CDF), and is meant to be registered by
# OTHER packages (CensoredDistributions, for its own bespoke primary-event
# families) from their own extension `__init__`, after this package has
# already loaded.
#
# The registry therefore follows the plain-data, load-order-safe pattern
# proven in ComposedDistributions#189/#216 for its leaf-wrapper codec:
# entries are pushed to a plain `Vector`, never added as a new dispatch
# `Method` on a generic function. A lookup is then a type-comparison scan
# over live data, not a call into a growing method table, so it carries no
# world-age/invalidation hazard -- which matters here because `cdf` is a path
# Enzyme's and Mooncake's own rule machinery compile and cache per type
# signature (this package has already hit a real Enzyme-reverse break from
# state that grows *inside* a differentiated call; see `GaussLegendre`'s
# docstring in `src/integration.jl`). A registry entry is looked up once per
# top-level `cdf`/`logcdf` call -- never inside the per-node quadrature loop
# -- so it carries the same cost profile as the `_try_convolve` dispatch it
# sits alongside.

# Plain-data registry entry. Kept a `struct`, not a `NamedTuple`, so the
# vector element type stays concrete and `filter!`/`push!` need no type
# annotation gymnastics; `cdf_fn` is still read out as abstract `Function`
# since the vector holds heterogeneous entries (mirrors `_LeafCodecEntry`'s
# `pattern::Type` field in ComposedDistributions).
struct _AnalyticPairEntry
    delay_type::Type
    primary_type::Type
    cdf_fn::Function
end

const _ANALYTIC_PAIR_REGISTRY = _AnalyticPairEntry[]

@doc "

    register_analytic_pair!(delay_type, primary_type, cdf_fn)

Register a closed-form convolution CDF for a `(delay_type, primary_type)`
component pair, consulted by [`AnalyticalSolver`](@ref) before the numeric
quadrature fallback.

`cdf_fn` is called as `cdf_fn(delay, primary, x)` and must return
``F_{delay+primary}(x)``, the CDF of the sum at `x` -- the same convolution
CDF [`cdf`](@ref) computes numerically for an unregistered pair, just in
closed form. It supplies the CDF only: `pdf`, `mean`, `var` and `rand` on the
resulting [`Convolved`](@ref) are unaffected by a registration and keep using
their existing analytic-distribution or numeric-quadrature paths.

Lookup matches `typeof(delay) <: delay_type` and `typeof(primary) <:
primary_type`, so a registration may target either a concrete family (e.g.
`Distributions.Gamma`) or a broader pattern. It only applies to a
[`Convolved`](@ref) with exactly two components, in the order they were
constructed (`convolved(delay, primary)`); a `NumericSolver` bypasses it, and
a three-or-more-component convolution falls through to the existing pairwise
analytic fold / numeric quadrature untouched.

Call this from an extension's `__init__`, never at module top level:
`__init__` runs once the extension is actually activated, which is exactly
when the registry needs to be populated (see the comment above this file's
registry for why that guarantees no load-order hazard). Registering the same
`(delay_type, primary_type)` pair twice replaces the earlier entry.

# Arguments
- `delay_type`: the delay component's type (or a supertype/pattern it is a
  subtype of).
- `primary_type`: the primary-event component's type (or a
  supertype/pattern it is a subtype of).
- `cdf_fn`: `(delay, primary, x) -> Real` computing the closed-form
  convolution CDF.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Re-registering a pair replaces the earlier entry (here, re-registering one
# of the package's own built-in closed forms under its existing name).
ConvolvedDistributions.register_analytic_pair!(
    Gamma, Uniform, ConvolvedDistributions._gamma_uniform_cdf)

d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
cdf(d, 3.0)  # dispatches through the registered closed form
```

# See also
- [`AnalyticalSolver`](@ref): the solver method this registry feeds.
"
function register_analytic_pair!(delay_type::Type, primary_type::Type, cdf_fn)
    filter!(
        e -> !(e.delay_type == delay_type && e.primary_type == primary_type),
        _ANALYTIC_PAIR_REGISTRY)
    push!(_ANALYTIC_PAIR_REGISTRY,
        _AnalyticPairEntry(delay_type, primary_type, cdf_fn))
    return nothing
end

# The LAST-registered entry whose pattern matches `(D, P)` (so a later, more
# specific registration wins over an earlier, more general one for the same
# pair -- see `register_analytic_pair!`'s docstring), or `nothing` when
# unregistered. A plain reverse linear scan over a handful of entries, run
# once per top-level `cdf`/`logcdf` call, never per quadrature node.
function _registered_analytic_pair(::Type{D}, ::Type{P}) where {D, P}
    for e in Iterators.reverse(_ANALYTIC_PAIR_REGISTRY)
        D <: e.delay_type && P <: e.primary_type && return e
    end
    return nothing
end

# ---------------------------------------------------------------------------
# Distributions.jl-native closed forms: uniform-window primary-censored CDFs
# ---------------------------------------------------------------------------
#
# The observed delay in a primary-event-censored model is
# `X = delay + primary`, with `primary` restricted to a census window --
# a `Uniform`. `Distributions.convolve` has no method for these pairs (the
# result is not itself a named distribution), so they cannot use
# `_try_convolve`; they are exactly what this registry is for. The three
# forms below (Gamma/LogNormal/Weibull + Uniform) are ported from
# CensoredDistributions' `primarycensored_cdf.jl` -- validated there against
# the primarycensored R package (see its docs for the derivation) -- not
# re-derived here. All four families involved (Gamma, LogNormal, Weibull,
# Uniform) are core Distributions.jl types this module already imports, so
# these are registered at module load, not gated behind an extension
# `__init__`: there is no cross-package load-order hazard for a pair defined
# in the same module as the registry itself.

# Shared arithmetic shape of the three uniform-window forms, derived by
# integration by parts on the partial expectation:
#   F_{S+}(d) = (d·F_T(d) - q·F_T(q) - (M_T(d) - M_T(q))) / w_P
# where `d = x - u_min`, `q = max(d - w_P, s_min)`, `w_P` is the primary
# window width, `F_T` is the delay CDF, and `M_T(t) = ∫₀ᵗ u f_T(u) du` is the
# partial first moment of the delay. Pass `F_T_q = M_T_q = 0` when `q` is
# clamped to the delay's minimum (both terms drop out cleanly).
function _uniform_window_cdf_formula(d, q, F_T_d, F_T_q, M_T_d, M_T_q, pwindow)
    return (d * F_T_d - q * F_T_q - (M_T_d - M_T_q)) / pwindow
end

@doc "
Closed-form convolution CDF for a `Gamma` delay with a `Uniform` primary
event. Partial first moment is ``M_T(t) = k\\theta \\cdot F_T(t; k+1,
\\theta)``, obtained from ``F_T(\\cdot; k, \\theta)`` via the recursion
``P(k+1, y) = P(k, y) - y^k e^{-y} / \\Gamma(k+1)`` so each endpoint pays one
regularised-lower-incomplete-gamma call, not two.

Ported from CensoredDistributions' analytical Gamma+Uniform primary-censored
CDF (validated there against the primarycensored R package); registered as
the `(Gamma, Uniform)` [`register_analytic_pair!`](@ref) entry.
"
function _gamma_uniform_cdf(delay::Gamma, primary::Uniform, x::Real)
    k = shape(delay)
    θ = scale(delay)
    pmin = minimum(primary)
    pwindow = maximum(primary) - pmin

    d = x - pmin
    d <= 0 && return zero(float(d))

    q = max(d - pwindow, minimum(delay))

    inv_gamma_kp1 = inv(SpecialFunctions.gamma(k + 1))
    E_T = k * θ

    yd = d / θ
    F_T_d = _gamma_cdf(k, θ, d)
    M_T_d = E_T * (F_T_d - yd^k * exp(-yd) * inv_gamma_kp1)

    if q > 0
        yq = q / θ
        F_T_q = _gamma_cdf(k, θ, q)
        M_T_q = E_T * (F_T_q - yq^k * exp(-yq) * inv_gamma_kp1)
    else
        F_T_q = zero(F_T_d)
        M_T_q = zero(M_T_d)
    end

    return _uniform_window_cdf_formula(d, q, F_T_d, F_T_q, M_T_d, M_T_q, pwindow)
end

@doc "
Closed-form convolution CDF for a `LogNormal` delay with a `Uniform` primary
event. Partial first moment is
``M_T(t) = e^{\\mu + \\sigma^2/2} \\cdot F_T(t;\\, \\mu + \\sigma^2,\\, \\sigma)``,
i.e. the mean times the CDF of the parameter-shifted `LogNormal`.

Ported from CensoredDistributions' analytical LogNormal+Uniform
primary-censored CDF (validated there against the primarycensored R
package); registered as the `(LogNormal, Uniform)`
[`register_analytic_pair!`](@ref) entry.
"
function _lognormal_uniform_cdf(delay::LogNormal, primary::Uniform, x::Real)
    μ = meanlogx(delay)
    σ = stdlogx(delay)
    pmin = minimum(primary)
    pwindow = maximum(primary) - pmin

    d = x - pmin
    d <= 0 && return zero(float(d))

    q = max(d - pwindow, minimum(delay))

    dist_shifted = LogNormal(μ + σ^2, σ)
    E_T = exp(μ + σ^2 / 2)

    F_T_d = cdf(delay, d)
    M_T_d = E_T * cdf(dist_shifted, d)

    if q > 0
        F_T_q = cdf(delay, q)
        M_T_q = E_T * cdf(dist_shifted, q)
    else
        F_T_q = zero(F_T_d)
        M_T_q = zero(M_T_d)
    end

    return _uniform_window_cdf_formula(d, q, F_T_d, F_T_q, M_T_d, M_T_q, pwindow)
end

@doc "
Closed-form convolution CDF for a `Weibull` delay with a `Uniform` primary
event. Partial first moment is ``M_T(t) = \\lambda \\cdot g(t)`` where
``g(t) = \\gamma(1 + 1/k, (t/\\lambda)^k)`` is the lower incomplete gamma
function evaluated via the regularised form, ``\\gamma(a, z) = \\Gamma(a)
\\cdot P(a, z)``.

Ported from CensoredDistributions' analytical Weibull+Uniform
primary-censored CDF (validated there against the primarycensored R
package); registered as the `(Weibull, Uniform)`
[`register_analytic_pair!`](@ref) entry.
"
function _weibull_uniform_cdf(delay::Weibull, primary::Uniform, x::Real)
    k = shape(delay)
    λ = scale(delay)
    pmin = minimum(primary)
    pwindow = maximum(primary) - pmin

    d = x - pmin
    d <= 0 && return zero(float(d))

    q = max(d - pwindow, minimum(delay))

    a = 1 + 1 / k
    Γa = SpecialFunctions.gamma(a)
    one_a = one(a)
    weibull_g(t) = t <= 0 ? zero(t) : Γa * _gamma_cdf(a, one_a, (t / λ)^k)

    F_T_d = cdf(delay, d)
    M_T_d = λ * weibull_g(d)

    if q > 0
        F_T_q = cdf(delay, q)
        M_T_q = λ * weibull_g(q)
    else
        F_T_q = zero(F_T_d)
        M_T_q = zero(M_T_d)
    end

    return _uniform_window_cdf_formula(d, q, F_T_d, F_T_q, M_T_d, M_T_q, pwindow)
end

register_analytic_pair!(Gamma, Uniform, _gamma_uniform_cdf)
register_analytic_pair!(LogNormal, Uniform, _lognormal_uniform_cdf)
register_analytic_pair!(Weibull, Uniform, _weibull_uniform_cdf)
