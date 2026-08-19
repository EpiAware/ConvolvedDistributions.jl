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
function uniform_window_cdf(
        component::UnivariateDistribution,
        window::Uniform, x::Real, partial_expectation::F
    ) where {F}
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
    isinf(h) && return one(T)
    l = max(h - w, dmin)
    F_h = cdf_ad_safe(component, h)
    M_h = partial_expectation(h)
    val = if l > dmin
        (
            h * F_h - l * cdf_ad_safe(component, l) -
                (M_h - partial_expectation(l))
        ) / w
    else
        (h * F_h - M_h) / w
    end
    return convert(T, clamp(val, zero(val), one(val)))::T
end

@doc "

    partial_expectation(component)

The partial first moment ``t \\mapsto \\int_0^t u f(u) \\, \\mathrm{d}u``
for `component`, as a closure over its parameters. The extension point
[`uniform_window_cdf`](@ref) needs: a downstream family adds its own
Uniform-window closed form by defining a method here and calling
`uniform_window_cdf(component, window, x, partial_expectation(component))`
from a [`convolved_cdf`](@ref) method. A family that also wants
[`convolved_ccdf`](@ref)/`convolved_logccdf` closed forms adds the
survival-side companion, [`upper_partial_expectation`](@ref), too.
"
function partial_expectation end

# Recursion P(k+1, y) = P(k, y) - y^k e^{-y}/Γ(k+1) keeps this to one
# regularised-incomplete-gamma call per endpoint rather than two.
function partial_expectation(component::Gamma)
    k, θ = shape(component), scale(component)
    inv_g = inv(SpecialFunctions.gamma(k + 1))
    return function (t)
        y = t / θ
        return k * θ * (cdf_ad_safe(component, t) - y^k * exp(-y) * inv_g)
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
# its regularised form γ(a, z) = Γ(a) P(a, z), read off a unit-scale Gamma.
function partial_expectation(component::Weibull)
    k, λ = shape(component), scale(component)
    s = 1 + inv(k)
    Γs = SpecialFunctions.gamma(s)
    unit_gamma = Gamma(s, one(s))
    return t -> t <= 0 ? zero(float(t)) :
        λ * Γs * cdf_ad_safe(unit_gamma, (t / λ)^k)
end

@doc "

    upper_partial_expectation(component)

The upper partial first moment ``t \\mapsto \\int_t^\\infty u f(u)
\\, \\mathrm{d}u`` for `component`, as a closure over its parameters.
The survival-side companion to [`partial_expectation`](@ref) that
[`uniform_window_ccdf`](@ref) needs: computing it as `mean(component) -
partial_expectation(component)(t)` would cancel to nothing in the upper
tail, where both terms approach the mean.
"
function upper_partial_expectation end

# Q(k + 1, y) = Q(k, y) + y^k e^{-y}/Γ(k+1), the survival mirror of the
# recursion `partial_expectation(::Gamma)` uses. A sum of non-negative
# terms, so the thinning tail never cancels against the mean. Built from
# `exp(logccdf_ad_safe(...))`, not linear-space `ccdf_ad_safe(...)`:
# `ccdf_ad_safe(::Gamma)` is `1 - _gamma_cdf(...)`, which loses accuracy
# in exactly the far right tail this recursion exists to stay accurate
# in, while `logccdf_ad_safe(::Gamma)` computes the survival directly and
# stays accurate there.
function upper_partial_expectation(component::Gamma)
    k, θ = shape(component), scale(component)
    inv_g = inv(SpecialFunctions.gamma(k + 1))
    return function (t)
        t <= 0 && return k * θ * one(float(t))
        y = t / θ
        return k * θ * (exp(logccdf_ad_safe(component, t)) + y^k * exp(-y) * inv_g)
    end
end

function upper_partial_expectation(component::LogNormal)
    μ, σ = meanlogx(component), stdlogx(component)
    shifted = LogNormal(μ + σ^2, σ)
    m = exp(μ + σ^2 / 2)
    return t -> m * ccdf_ad_safe(shifted, t)
end

# The `Gamma`/`Weibull` deep-tail survival floor here is inherited from
# `ccdf_ad_safe(::Gamma)`, a 1e-16 absolute floor.
function upper_partial_expectation(component::Weibull)
    k, λ = shape(component), scale(component)
    s = 1 + inv(k)
    Γs = SpecialFunctions.gamma(s)
    unit_gamma = Gamma(s, one(s))
    return t -> t <= 0 ? λ * Γs :
        λ * Γs * ccdf_ad_safe(unit_gamma, (t / λ)^k)
end

const _WINDOW_FAMILIES = Union{Gamma, LogNormal, Weibull}

function convolved_cdf(
        d::Convolved, components::Tuple{_WINDOW_FAMILIES, Uniform},
        x::Real, ::AnalyticalSolver
    )
    component, window = components
    return uniform_window_cdf(component, window, x, partial_expectation(component))
end

# Mirrored component order (S1.5): dispatch, not a runtime route lookup,
# picks the right side to call `uniform_window_cdf` on.
function convolved_cdf(
        d::Convolved, components::Tuple{Uniform, _WINDOW_FAMILIES},
        x::Real, m::AnalyticalSolver
    )
    return convolved_cdf(d, reverse(components), x, m)
end

# Vector-`x` form (S1.4): `partial_expectation` is built once and shared
# across points, so `Convolved`'s batched `cdf` keeps the closed form's
# speed instead of falling back to quadrature (solver_dispatch.jl).
function convolved_cdf(
        d::Convolved, components::Tuple{_WINDOW_FAMILIES, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver
    )
    component, window = components
    pe = partial_expectation(component)
    return map(xi -> uniform_window_cdf(component, window, xi, pe), x)
end

function convolved_cdf(
        d::Convolved, components::Tuple{Uniform, _WINDOW_FAMILIES},
        x::AbstractVector{<:Real}, m::AnalyticalSolver
    )
    return convolved_cdf(d, reverse(components), x, m)
end

@doc "

    uniform_window_ccdf(component, window, x, partial_expectation,
        upper_partial_expectation)

Complementary CDF of `component + window` at `x` for a `Uniform`
`window`: the survival mirror of [`uniform_window_cdf`](@ref),
``\\bar F_S(x) = (h \\bar F(h) - l \\bar F(l) + N(l) - N(h)) / w``
with ``h = x - a``, ``l = h - w``, `w` the window width, and ``N`` the
[`upper_partial_expectation`](@ref). Adding the two forms telescopes to
``(h - l)/w = 1``, so they are exactly complementary.

Below the component's median the complement of
[`uniform_window_cdf`](@ref) is returned instead: exact there, and it
avoids dividing a mean-sized rounding error by a narrow `w`. Above it,
the survival form is what keeps an upper tail meaningful — `1 - cdf`
cancels to zero once the survival drops below `eps`.

Public for the same reason [`uniform_window_cdf`](@ref) is: a
downstream family supplies the two expectation closures and calls this
from a [`convolved_ccdf`](@ref) method.

# Arguments
- `component`: The non-`Uniform` distribution.
- `window`: The `Uniform` window distribution.
- `x`: Evaluation point.
- `partial_expectation`: `t -> ∫₀ᵗ u f(u) du` for `component`.
- `upper_partial_expectation`: `t -> ∫ₜ^∞ u f(u) du` for `component`.

# Examples
```@example
using ConvolvedDistributions, Distributions

component = Gamma(2.0, 1.5)
ConvolvedDistributions.uniform_window_ccdf(
    component, Uniform(0.0, 2.0), 30.0,
    ConvolvedDistributions.partial_expectation(component),
    ConvolvedDistributions.upper_partial_expectation(component))
```
"
function uniform_window_ccdf(
        component::UnivariateDistribution,
        window::Uniform, x::Real, partial_expectation::F,
        upper_partial_expectation::G
    ) where {F, G}
    a = minimum(window)
    w = maximum(window) - a
    dmin = minimum(component)
    h = x - a
    T = promote_type(float(typeof(x)), partype(component), partype(window))
    h <= dmin && return one(T)
    isinf(h) && return zero(T)
    l = h - w
    F_h = cdf_ad_safe(component, h)
    if l <= dmin || F_h < oftype(F_h, 0.5)
        p = uniform_window_cdf(component, window, x, partial_expectation)
        return convert(T, one(p) - p)::T
    end
    val = (
        h * ccdf_ad_safe(component, h) - l * ccdf_ad_safe(component, l) +
            (upper_partial_expectation(l) - upper_partial_expectation(h))
    ) / w
    return convert(T, clamp(val, zero(val), one(val)))::T
end

# Log CDF: the log of the same closed form `convolved_cdf` returns, so
# `logcdf` and `log(cdf)` are the same number rather than two
# algorithms' answers. Without this method the generic
# `AnalyticalSolver` arm falls through to `log` of the numeric
# quadrature (solver_dispatch.jl), which is accurate only to the
# quadrature's own error and diverges from the closed-form `cdf` the
# same distribution reports.
function convolved_logcdf(
        d::Convolved,
        components::Tuple{_WINDOW_FAMILIES, Uniform}, x::Real,
        ::AnalyticalSolver
    )
    component, window = components
    p = uniform_window_cdf(
        component, window, x,
        partial_expectation(component)
    )
    return p <= 0 ? oftype(float(p), -Inf) : log(p)
end

function convolved_logcdf(
        d::Convolved,
        components::Tuple{Uniform, _WINDOW_FAMILIES}, x::Real,
        m::AnalyticalSolver
    )
    return convolved_logcdf(d, reverse(components), x, m)
end

# Survival: the dedicated closed form, not `1 - cdf`, which cancels to
# exactly zero once the survival drops below `eps`.
function convolved_ccdf(
        d::Convolved,
        components::Tuple{_WINDOW_FAMILIES, Uniform}, x::Real,
        ::AnalyticalSolver
    )
    component, window = components
    return uniform_window_ccdf(
        component, window, x,
        partial_expectation(component),
        upper_partial_expectation(component)
    )
end

function convolved_ccdf(
        d::Convolved,
        components::Tuple{Uniform, _WINDOW_FAMILIES}, x::Real,
        m::AnalyticalSolver
    )
    return convolved_ccdf(d, reverse(components), x, m)
end

# Log survival: the log of the survival closed form above, never
# `log1mexp` of a log CDF -- that route inherits the CDF's rounding
# exactly where the survival is smallest.
function convolved_logccdf(
        d::Convolved,
        components::Tuple{_WINDOW_FAMILIES, Uniform}, x::Real,
        m::AnalyticalSolver
    )
    q = convolved_ccdf(d, components, x, m)
    return q <= 0 ? oftype(float(q), -Inf) : log(q)
end

function convolved_logccdf(
        d::Convolved,
        components::Tuple{Uniform, _WINDOW_FAMILIES}, x::Real,
        m::AnalyticalSolver
    )
    return convolved_logccdf(d, reverse(components), x, m)
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
                logccdf_ad_safe(component, lo), logccdf_ad_safe(component, hi)
            ) :
            logsubexp(
                logcdf_ad_safe(component, hi), logcdf_ad_safe(component, lo)
            )
        isfinite(lg) && return exp(lg) / w
        m = x - (a + b) / 2
        δ = w / (2 * sqrt(oftype(w, 3)))
        return (pdf_ad_safe(component, m - δ) + pdf_ad_safe(component, m + δ)) /
            2
    end
    return max(mass, zero(mass)) / w
end

function convolved_pdf(
        d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::Real, ::AnalyticalSolver
    )
    component, window = components
    return _uniform_window_pdf(component, window, x)
end

# Mirrored component order (S1.5). `component` ranges over every
# `UnivariateDistribution`, including `Uniform` itself, so the mirror
# collides with the method above at `(Uniform, Uniform)`; the tie-break
# below resolves it (Aqua-clean, and the window is symmetric anyway).
function convolved_pdf(
        d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::Real, m::AnalyticalSolver
    )
    return convolved_pdf(d, reverse(components), x, m)
end

function convolved_pdf(
        d::Convolved, components::Tuple{Uniform, Uniform},
        x::Real, ::AnalyticalSolver
    )
    component, window = components
    return _uniform_window_pdf(component, window, x)
end

# Vector-`x` forms (S1.4), mirrored and tie-broken as the scalar methods
# above -- see `convolved_cdf`'s vector form for the batching rationale.
function convolved_pdf(
        d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver
    )
    component, window = components
    return map(xi -> _uniform_window_pdf(component, window, xi), x)
end

function convolved_pdf(
        d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::AbstractVector{<:Real}, m::AnalyticalSolver
    )
    return convolved_pdf(d, reverse(components), x, m)
end

function convolved_pdf(
        d::Convolved, components::Tuple{Uniform, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver
    )
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
            logccdf_ad_safe(component, hi), logccdf_ad_safe(component, lo)
        ) :
        logsubexp(logcdf_ad_safe(component, lo), l_hi)
    result = lg - log(b - a)
    isfinite(result) && return result
    p = _uniform_window_pdf(component, window, x)
    return p <= 0 ? oftype(float(p), -Inf) : log(p)
end

function convolved_logpdf(
        d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::Real, ::AnalyticalSolver
    )
    component, window = components
    return _uniform_window_logpdf(component, window, x)
end

# Mirrored component order (S1.5), with the same `(Uniform, Uniform)`
# tie-break as `convolved_pdf` above.
function convolved_logpdf(
        d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::Real, m::AnalyticalSolver
    )
    return convolved_logpdf(d, reverse(components), x, m)
end

function convolved_logpdf(
        d::Convolved, components::Tuple{Uniform, Uniform},
        x::Real, ::AnalyticalSolver
    )
    component, window = components
    return _uniform_window_logpdf(component, window, x)
end

# Vector-`x` forms (S1.4), mirrored and tie-broken as the scalar methods
# above.
function convolved_logpdf(
        d::Convolved,
        components::Tuple{UnivariateDistribution, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver
    )
    component, window = components
    return map(xi -> _uniform_window_logpdf(component, window, xi), x)
end

function convolved_logpdf(
        d::Convolved,
        components::Tuple{Uniform, UnivariateDistribution},
        x::AbstractVector{<:Real}, m::AnalyticalSolver
    )
    return convolved_logpdf(d, reverse(components), x, m)
end

function convolved_logpdf(
        d::Convolved, components::Tuple{Uniform, Uniform},
        x::AbstractVector{<:Real}, ::AnalyticalSolver
    )
    component, window = components
    return map(xi -> _uniform_window_logpdf(component, window, xi), x)
end
