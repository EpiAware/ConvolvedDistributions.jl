# Closed-form convolution CDF and density for a distribution convolved
# with a `Uniform` window, ported from CensoredDistributions'
# `primarycensored_cdf.jl` (derivation and validation against the
# primarycensored R package documented there). Each family supplies only
# its partial expectation, `partial_expectation` below; the shared
# arithmetic is `uniform_window_cdf`.

@doc "

    uniform_window_cdf(component, window, x, partial_expectation)

CDF of `component + window` at `x` for a `Uniform` `window`, given
`partial_expectation(t) = ∫₀ᵗ u f(u) du` for `component`. Derived by
integration by parts:
``F_S(x) = (h F(h) - l F(l) - (M(h) - M(l))) / w``
with ``h = x - a``, ``l = \\max(h - w, \\min(\\mathrm{component}))``, `w`
the window width.

Public so a downstream package can add a family without re-deriving the
algebra: supply [`partial_expectation`](@ref) and call this from a
[`convolved_cdf`](@ref) method.

# Arguments
- `component`: The non-`Uniform` distribution.
- `window`: The `Uniform` window distribution.
- `x`: Evaluation point.
- `partial_expectation`: `t -> ∫₀ᵗ u f(u) du` for `component`.

# Examples
```@example
using ConvolvedDistributions, Distributions

component = Gamma(2.0, 1.5)
k, θ = shape(component), scale(component)
partial_expectation = t -> k * θ * cdf(Gamma(k + 1, θ), t)
ConvolvedDistributions.uniform_window_cdf(
    component, Uniform(0.0, 2.0), 3.0, partial_expectation)
```
"
function uniform_window_cdf(component::UnivariateDistribution,
        window::Uniform, x::Real, partial_expectation::F) where {F}
    a = minimum(window)
    w = maximum(window) - a
    dmin = minimum(component)
    h = x - a
    # Result type predicted from both components and `x`, then
    # converted rather than asserted: the boundary branch below builds
    # its zero from a constant, and a ReverseDiff tracked real detaches
    # from its tape on a constant, so the branch types differ even
    # though the values agree (commit 640c2c2).
    T = promote_type(float(typeof(x)), partype(component), partype(window))
    h <= dmin && return zero(T)
    l = max(h - w, dmin)
    F_h = cdf_ad_safe(component, h)
    M_h = partial_expectation(h)
    val = if l > dmin
        (h * F_h - l * cdf_ad_safe(component, l) -
         (M_h - partial_expectation(l))) / w
    else
        (h * F_h - M_h) / w
    end
    return convert(T, val)::T
end

@doc "

    partial_expectation(component)

The partial first moment ``t \\mapsto \\int_0^t u f(u) \\, \\mathrm{d}u``
for `component`, as a closure over its parameters. The extension point
[`uniform_window_cdf`](@ref) needs: a downstream family adds its own
Uniform-window closed form by defining a method here and calling
`uniform_window_cdf(component, window, x, partial_expectation(component))`
from a [`convolved_cdf`](@ref) method.
"
function partial_expectation end

# Recursion P(k+1, y) = P(k, y) - y^k e^{-y}/Γ(k+1) keeps this to one
# regularised-incomplete-gamma call per endpoint rather than two.
function partial_expectation(component::Gamma)
    k, θ = shape(component), scale(component)
    inv_g = inv(SpecialFunctions.gamma(k + 1))
    return function (t)
        y = t / θ
        return k * θ * (_gamma_cdf(k, θ, t) - y^k * exp(-y) * inv_g)
    end
end

# The partial expectation is the mean times the CDF of the
# parameter-shifted LogNormal(μ + σ², σ).
function partial_expectation(component::LogNormal)
    μ, σ = meanlogx(component), stdlogx(component)
    shifted = LogNormal(μ + σ^2, σ)
    m = exp(μ + σ^2 / 2)
    return t -> m * cdf_ad_safe(shifted, t)
end

# g(t) = γ(1 + 1/k, (t/λ)^k), the lower incomplete gamma function via
# its regularised form γ(a, z) = Γ(a) P(a, z).
function partial_expectation(component::Weibull)
    k, λ = shape(component), scale(component)
    s = 1 + inv(k)
    Γs = SpecialFunctions.gamma(s)
    return t -> t <= 0 ? zero(float(t)) :
                λ * Γs * _gamma_cdf(s, one(s), (t / λ)^k)
end

const _WINDOW_FAMILIES = Union{Gamma, LogNormal, Weibull}

function convolved_cdf(d::Convolved, components::Tuple{_WINDOW_FAMILIES, Uniform},
        x::Real, ::AnalyticalSolver)
    component, window = components
    return uniform_window_cdf(component, window, x, partial_expectation(component))
end

# Mirrored component order (S1.5): dispatch, not a runtime route lookup,
# picks the right side to call `uniform_window_cdf` on.
function convolved_cdf(d::Convolved, components::Tuple{Uniform, _WINDOW_FAMILIES},
        x::Real, m::AnalyticalSolver)
    return convolved_cdf(d, reverse(components), x, m)
end

# Vector-`x` form (S1.4): `partial_expectation` is built once and shared
# across points, so `Convolved`'s batched `cdf` keeps the closed form's
# speed instead of falling back to quadrature (solver_dispatch.jl).
function convolved_cdf(d::Convolved, components::Tuple{_WINDOW_FAMILIES, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    component, window = components
    pe = partial_expectation(component)
    return map(xi -> uniform_window_cdf(component, window, xi, pe), x)
end

function convolved_cdf(d::Convolved, components::Tuple{Uniform, _WINDOW_FAMILIES},
        x::AbstractVector{<:Real}, m::AnalyticalSolver)
    return convolved_cdf(d, reverse(components), x, m)
end

# f_S(x) = (F(x-a) - F(x-b)) / w, exact for any `component`. Computed
# from `ccdf` in the upper tail so the subtraction does not cancel. Once
# the linear-space difference itself is at the noise floor, rescue it
# with the same `logsubexp` construction `convolved_logpdf` uses. Some
# families' AD-safe `logcdf`/`logccdf` themselves saturate this deep in
# a tail (traded away for shape differentiability); when that leaves
# the rescue at zero too, fall back to a two-point average of the raw
# density, which stays accurate there since nothing cancels or
# saturates in a direct `pdf` evaluation.
function _uniform_window_pdf(component, window::Uniform, x::Real)
    a, b = minimum(window), maximum(window)
    w = b - a
    hi, lo = x - a, x - b
    F_hi = cdf_ad_safe(component, hi)
    mass = F_hi > oftype(F_hi, 0.5) ?
           ccdf_ad_safe(component, lo) - ccdf_ad_safe(component, hi) :
           F_hi - cdf_ad_safe(component, lo)
    if lo > minimum(component) && mass < sqrt(eps(typeof(mass)))
        lg = F_hi > oftype(F_hi, 0.5) ?
             logsubexp(
            logccdf_ad_safe(component, lo), logccdf_ad_safe(component, hi)) :
             logsubexp(
            logcdf_ad_safe(component, hi), logcdf_ad_safe(component, lo))
        isfinite(lg) && return exp(lg) / w
        m = x - (a + b) / 2
        δ = w / (2 * sqrt(oftype(w, 3)))
        return (pdf_ad_safe(component, m - δ) + pdf_ad_safe(component, m + δ)) /
               2
    end
    return max(mass, zero(mass)) / w
end

function convolved_pdf(d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::Real, ::AnalyticalSolver)
    component, window = components
    return _uniform_window_pdf(component, window, x)
end

# Mirrored component order (S1.5). `component` ranges over every
# `UnivariateDistribution`, including `Uniform` itself, so the mirror
# collides with the method above at `(Uniform, Uniform)`; the tie-break
# below resolves it (Aqua-clean, and the window is symmetric anyway).
function convolved_pdf(d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::Real, m::AnalyticalSolver)
    return convolved_pdf(d, reverse(components), x, m)
end

function convolved_pdf(d::Convolved, components::Tuple{Uniform, Uniform},
        x::Real, ::AnalyticalSolver)
    component, window = components
    return _uniform_window_pdf(component, window, x)
end

# Vector-`x` forms (S1.4), mirrored and tie-broken as the scalar methods
# above -- see `convolved_cdf`'s vector form for the batching rationale.
function convolved_pdf(d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    component, window = components
    return map(xi -> _uniform_window_pdf(component, window, xi), x)
end

function convolved_pdf(d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::AbstractVector{<:Real}, m::AnalyticalSolver)
    return convolved_pdf(d, reverse(components), x, m)
end

function convolved_pdf(d::Convolved, components::Tuple{Uniform, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    component, window = components
    return map(xi -> _uniform_window_pdf(component, window, xi), x)
end

# Tail-stable log form: `logsubexp` on the same two branches the density
# above uses, rather than `log` of the (possibly cancelled) linear-space
# density. A component's `logccdf_ad_safe` can itself saturate to `-Inf`
# deep in a right tail (its Gamma method trades tail precision for shape
# differentiability), which would misreport a tiny-but-nonzero density
# as exactly zero; recover that case from the already-guarded linear
# density instead.
function _uniform_window_logpdf(component, window::Uniform, x::Real)
    a, b = minimum(window), maximum(window)
    hi, lo = x - a, x - b
    l_hi = logcdf_ad_safe(component, hi)
    l_hi == -Inf && return oftype(float(l_hi), -Inf)
    lg = l_hi > log(oftype(l_hi, 0.5)) ?
         logsubexp(
        logccdf_ad_safe(component, hi), logccdf_ad_safe(component, lo)) :
         logsubexp(logcdf_ad_safe(component, lo), l_hi)
    result = lg - log(b - a)
    isfinite(result) && return result
    p = _uniform_window_pdf(component, window, x)
    return p <= 0 ? oftype(float(p), -Inf) : log(p)
end

function convolved_logpdf(d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::Real, ::AnalyticalSolver)
    component, window = components
    return _uniform_window_logpdf(component, window, x)
end

# Mirrored component order (S1.5), with the same `(Uniform, Uniform)`
# tie-break as `convolved_pdf` above.
function convolved_logpdf(d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::Real, m::AnalyticalSolver)
    return convolved_logpdf(d, reverse(components), x, m)
end

function convolved_logpdf(d::Convolved, components::Tuple{Uniform, Uniform},
        x::Real, ::AnalyticalSolver)
    component, window = components
    return _uniform_window_logpdf(component, window, x)
end

# Vector-`x` forms (S1.4), mirrored and tie-broken as the scalar methods
# above.
function convolved_logpdf(d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    component, window = components
    return map(xi -> _uniform_window_logpdf(component, window, xi), x)
end

function convolved_logpdf(d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::AbstractVector{<:Real}, m::AnalyticalSolver)
    return convolved_logpdf(d, reverse(components), x, m)
end

function convolved_logpdf(d::Convolved, components::Tuple{Uniform, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    component, window = components
    return map(xi -> _uniform_window_logpdf(component, window, xi), x)
end
