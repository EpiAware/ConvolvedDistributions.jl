module ConvolvedDistributionsForwardDiffExt

import ConvolvedDistributions: _gamma_cdf, _primal
using ConvolvedDistributions: _gamma_cdf_value_and_partials,
                              _logcdf_ad_safe, _logccdf_ad_safe
using Distributions: Distributions, Gamma
using ForwardDiff: ForwardDiff, Dual, value, partials

# Strip a ForwardDiff `Dual` to its primal `Float64` for the
# non-differentiable quadrature-window quantile (`_finite_window` in
# `src/Convolved.jl`). Recurses through nested `Dual`s so a higher-order tag
# chain still reduces to the scalar value.
_primal(x::Dual) = _primal(value(x))

# Forward-mode AD via explicit `Dual` methods on `_gamma_cdf`.
# ForwardDiff dispatches on `Dual` argument types (not via ChainRules),
# so the reverse-mode rule in `ConvolvedDistributionsChainRulesCoreExt`
# never fires for forward-mode. Each Dual/Real combination of the three
# arguments needs its own method declaration; the shared `_dual_impl`
# helper extracts values, then defers to
# `_gamma_cdf_value_and_partials` (in `src/gamma_ad.jl`) for the
# primal and analytical partials — the same helper the ChainRules and
# Enzyme extensions use, so the formulas are not duplicated here.

_val(x) = x isa Dual ? value(x) : x
# The tag `T` and partial-width `N` of the first `Dual` among the args; every
# `_gamma_cdf` Dual entry has at least one, so this never falls through.
_dual_tag(x::Dual{T}, rest...) where {T} = T
_dual_tag(::Real, rest...) = _dual_tag(rest...)
_dual_width(x::Dual{T, V, N}, rest...) where {T, V, N} = N
_dual_width(::Real, rest...) = _dual_width(rest...)
function _par(x, ::Val{N}) where {N}
    x isa Dual ? partials(x) : ForwardDiff.Partials(ntuple(_ -> zero(_val(x)), N))
end

function _dual_impl(k, θ, x)
    T = _dual_tag(k, θ, x)
    N = _dual_width(k, θ, x)
    kv = _val(k)
    θv = _val(θ)
    xv = _val(x)
    Ω, dk, dθ, dx = _gamma_cdf_value_and_partials(kv, θv, xv)
    new_partials = dk * _par(k, Val(N)) + dθ * _par(θ, Val(N)) + dx * _par(x, Val(N))
    return Dual{T}(Ω, new_partials)
end

# Cover every combination of (k, θ, x) where at least one argument is a
# `Dual`, routing all of them to `_dual_impl`. `Dual <: Real`, so the
# slots typed `::Real` already accept a `Dual`; the seven methods below
# therefore overlap, and (as with any ForwardDiff multi-argument overload
# set) the overlaps need explicit resolvers — the three double-`Dual`
# methods resolve the pairwise intersections of the single-`Dual` methods,
# and the all-`Dual` method resolves the triple intersection.
#
# The `Dual` slots are deliberately unparametrised: a shared `{T, V, N}`
# parametrisation across slots pins the tags equal, so the resolvers do
# not dominate the mixed-tag intersections and `detect_ambiguities` flags
# every partial pair. `_dual_impl` reads the tag/width from the first
# `Dual` at run time. Two edge cases remain unsupported (they error
# inside the helper, not via ambiguous dispatch): nested `Dual`s, and
# mixed tags across arguments (their partials would be combined under a
# single tag, which ForwardDiff never asks for in a single
# differentiation pass).
function _gamma_cdf(k::Dual, θ::Dual, x::Dual)
    return _dual_impl(k, θ, x)
end
function _gamma_cdf(k::Dual, θ::Dual, x::Real)
    return _dual_impl(k, θ, x)
end
function _gamma_cdf(k::Dual, θ::Real, x::Dual)
    return _dual_impl(k, θ, x)
end
function _gamma_cdf(k::Real, θ::Dual, x::Dual)
    return _dual_impl(k, θ, x)
end
function _gamma_cdf(k::Dual, θ::Real, x::Real)
    return _dual_impl(k, θ, x)
end
function _gamma_cdf(k::Real, θ::Dual, x::Real)
    return _dual_impl(k, θ, x)
end
function _gamma_cdf(k::Real, θ::Real, x::Dual)
    return _dual_impl(k, θ, x)
end

# AD-safe `logcdf`/`logccdf` for a Gamma differentiated through its shape/scale
# (or evaluation point). The stock `Distributions.logcdf(::Gamma)` routes through
# `StatsFuns._gammalogcdf`, which has no `Dual` method, so a `truncated(Gamma;
# lower)` normaliser (built eagerly at construction) breaks under ForwardDiff
# when the Gamma params carry `Dual`s. Routing through `_logcdf_ad_safe` /
# `_logccdf_ad_safe` (which evaluate `_gamma_cdf`, carrying the analytical
# shape/scale partials) closes that gap. Methods are added only for `Dual` args
# StatsFuns cannot handle, so the float path is untouched; the
# `Gamma{<:Dual}` method catches `Dual` params with a constant evaluation point
# (the truncation lower bound), the `::Dual` evaluation-point method catches a
# `Dual` bound, and the both-`Dual` method resolves their overlap.
Distributions.logcdf(d::Gamma{<:Dual}, x::Real) = _logcdf_ad_safe(d, x)
Distributions.logcdf(d::Gamma, x::Dual) = _logcdf_ad_safe(d, x)
Distributions.logcdf(d::Gamma{<:Dual}, x::Dual) = _logcdf_ad_safe(d, x)
Distributions.logccdf(d::Gamma{<:Dual}, x::Real) = _logccdf_ad_safe(d, x)
Distributions.logccdf(d::Gamma, x::Dual) = _logccdf_ad_safe(d, x)
Distributions.logccdf(d::Gamma{<:Dual}, x::Dual) = _logccdf_ad_safe(d, x)

end
