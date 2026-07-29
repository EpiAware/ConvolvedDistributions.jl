# Closed-form convolution CDF and density for a delay convolved with a
# `Uniform` window, ported from CensoredDistributions'
# `primarycensored_cdf.jl` (derivation and validation against the
# primarycensored R package documented there). Each family supplies only
# its partial first moment; the shared arithmetic is `uniform_window_cdf`.

@doc "

    uniform_window_cdf(delay, primary, x, partial_mean)

CDF of `delay + primary` at `x` for a `Uniform` `primary`, given
`partial_mean(t) = ∫₀ᵗ u f_T(u) du` for `delay`. Derived by integration
by parts:
``F_S(x) = (h F_T(h) - l F_T(l) - (M(h) - M(l))) / w``
with ``h = x - a``, ``l = \\max(h - w, \\min(T))``, `w` the window
width.

Public so a downstream package can add a family without re-deriving
the algebra: supply `partial_mean` and call this from a
[`convolved_cdf`](@ref) method.

# Arguments
- `delay`: The delay distribution `T`.
- `primary`: The `Uniform` primary/window distribution.
- `x`: Evaluation point.
- `partial_mean`: `t -> ∫₀ᵗ u f_T(u) du` for `delay`.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = Gamma(2.0, 1.5)
k, θ = shape(delay), scale(delay)
partial_mean = t -> k * θ * cdf(Gamma(k + 1, θ), t)
ConvolvedDistributions.uniform_window_cdf(
    delay, Uniform(0.0, 2.0), 3.0, partial_mean)
```
"
function uniform_window_cdf(delay::UnivariateDistribution,
        primary::Uniform, x::Real, partial_mean::F) where {F}
    a = minimum(primary)
    w = maximum(primary) - a
    dmin = minimum(delay)
    h = x - a
    # Result type predicted from both components and `x`, then
    # converted rather than asserted: the boundary branch below builds
    # its zero from a constant, and a ReverseDiff tracked real detaches
    # from its tape on a constant, so the branch types differ even
    # though the values agree (commit 640c2c2).
    T = promote_type(float(typeof(x)), partype(delay), partype(primary))
    h <= dmin && return zero(T)
    l = max(h - w, dmin)
    F_h = cdf_ad_safe(delay, h)
    M_h = partial_mean(h)
    val = if l > dmin
        (h * F_h - l * cdf_ad_safe(delay, l) - (M_h - partial_mean(l))) / w
    else
        (h * F_h - M_h) / w
    end
    return convert(T, val)::T
end

# Partial first moment ∫₀ᵗ u f_T(u) du for each shipped delay family.

# Recursion P(k+1, y) = P(k, y) - y^k e^{-y}/Γ(k+1) keeps this to one
# regularised-incomplete-gamma call per endpoint rather than two.
function _partial_mean(delay::Gamma)
    k, θ = shape(delay), scale(delay)
    inv_g = inv(SpecialFunctions.gamma(k + 1))
    return function (t)
        y = t / θ
        return k * θ * (_gamma_cdf(k, θ, t) - y^k * exp(-y) * inv_g)
    end
end

# The partial mean is the mean times the CDF of the parameter-shifted
# LogNormal(μ + σ², σ).
function _partial_mean(delay::LogNormal)
    μ, σ = meanlogx(delay), stdlogx(delay)
    shifted = LogNormal(μ + σ^2, σ)
    m = exp(μ + σ^2 / 2)
    return t -> m * cdf_ad_safe(shifted, t)
end

# g(t) = γ(1 + 1/k, (t/λ)^k), the lower incomplete gamma function via
# its regularised form γ(a, z) = Γ(a) P(a, z).
function _partial_mean(delay::Weibull)
    k, λ = shape(delay), scale(delay)
    s = 1 + inv(k)
    Γs = SpecialFunctions.gamma(s)
    return t -> t <= 0 ? zero(float(t)) :
                λ * Γs * _gamma_cdf(s, one(s), (t / λ)^k)
end

const _WINDOW_DELAY = Union{Gamma, LogNormal, Weibull}

function convolved_cdf(delay::_WINDOW_DELAY, primary::Uniform, x::Real,
        ::AnalyticalSolver)
    return uniform_window_cdf(delay, primary, x, _partial_mean(delay))
end

# Mirrored component order (S1.5): dispatch, not a runtime route lookup,
# picks the right side to call `uniform_window_cdf` on.
function convolved_cdf(primary::Uniform, delay::_WINDOW_DELAY, x::Real,
        m::AnalyticalSolver)
    return convolved_cdf(delay, primary, x, m)
end

# Vector-`x` form (S1.4): `partial_mean` is built once and shared across
# points, so `Convolved`'s batched `cdf` keeps the closed form's speed
# instead of falling back to quadrature (solver_dispatch.jl).
function convolved_cdf(delay::_WINDOW_DELAY, primary::Uniform,
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    partial_mean = _partial_mean(delay)
    return map(xi -> uniform_window_cdf(delay, primary, xi, partial_mean), x)
end

function convolved_cdf(primary::Uniform, delay::_WINDOW_DELAY,
        x::AbstractVector{<:Real}, m::AnalyticalSolver)
    return convolved_cdf(delay, primary, x, m)
end

# f_S(x) = (F_T(x-a) - F_T(x-b)) / w, exact for any delay T. Computed
# from `ccdf` in the upper tail so the subtraction does not cancel. Once
# the linear-space difference itself is at the noise floor, rescue it
# with the same `logsubexp` construction `convolved_logpdf` uses. Some
# families' AD-safe `logcdf`/`logccdf` themselves saturate this deep in
# a tail (traded away for shape differentiability); when that leaves
# the rescue at zero too, fall back to a two-point average of the raw
# density, which stays accurate there since nothing cancels or
# saturates in a direct `pdf` evaluation.
function _uniform_window_pdf(delay, primary::Uniform, x::Real)
    a, b = minimum(primary), maximum(primary)
    w = b - a
    hi, lo = x - a, x - b
    F_hi = cdf_ad_safe(delay, hi)
    mass = F_hi > oftype(F_hi, 0.5) ?
           ccdf_ad_safe(delay, lo) - ccdf_ad_safe(delay, hi) :
           F_hi - cdf_ad_safe(delay, lo)
    if lo > minimum(delay) && mass < sqrt(eps(typeof(mass)))
        lg = F_hi > oftype(F_hi, 0.5) ?
             logsubexp(logccdf_ad_safe(delay, lo), logccdf_ad_safe(delay, hi)) :
             logsubexp(logcdf_ad_safe(delay, hi), logcdf_ad_safe(delay, lo))
        isfinite(lg) && return exp(lg) / w
        m = x - (a + b) / 2
        δ = w / (2 * sqrt(oftype(w, 3)))
        return (pdf_ad_safe(delay, m - δ) + pdf_ad_safe(delay, m + δ)) / 2
    end
    return max(mass, zero(mass)) / w
end

function convolved_pdf(delay::UnivariateDistribution, primary::Uniform,
        x::Real, ::AnalyticalSolver)
    return _uniform_window_pdf(delay, primary, x)
end

# Mirrored component order (S1.5). `delay` ranges over every
# `UnivariateDistribution`, including `Uniform` itself, so the mirror
# collides with the method above at `(Uniform, Uniform)`; the tie-break
# below resolves it (Aqua-clean, and the window is symmetric anyway).
function convolved_pdf(primary::Uniform, delay::UnivariateDistribution,
        x::Real, m::AnalyticalSolver)
    return convolved_pdf(delay, primary, x, m)
end

function convolved_pdf(primary::Uniform, delay::Uniform, x::Real,
        ::AnalyticalSolver)
    return _uniform_window_pdf(delay, primary, x)
end

# Vector-`x` forms (S1.4), mirrored and tie-broken as the scalar methods
# above -- see `convolved_cdf`'s vector form for the batching rationale.
function convolved_pdf(delay::UnivariateDistribution, primary::Uniform,
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    return map(xi -> _uniform_window_pdf(delay, primary, xi), x)
end

function convolved_pdf(primary::Uniform, delay::UnivariateDistribution,
        x::AbstractVector{<:Real}, m::AnalyticalSolver)
    return convolved_pdf(delay, primary, x, m)
end

function convolved_pdf(primary::Uniform, delay::Uniform,
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    return map(xi -> _uniform_window_pdf(delay, primary, xi), x)
end

# Tail-stable log form: `logsubexp` on the same two branches the density
# above uses, rather than `log` of the (possibly cancelled) linear-space
# density. A component's `logccdf_ad_safe` can itself saturate to `-Inf`
# deep in a right tail (its Gamma method trades tail precision for shape
# differentiability), which would misreport a tiny-but-nonzero density
# as exactly zero; recover that case from the already-guarded linear
# density instead.
function _uniform_window_logpdf(delay, primary::Uniform, x::Real)
    a, b = minimum(primary), maximum(primary)
    hi, lo = x - a, x - b
    l_hi = logcdf_ad_safe(delay, hi)
    l_hi == -Inf && return oftype(float(l_hi), -Inf)
    lg = l_hi > log(oftype(l_hi, 0.5)) ?
         logsubexp(logccdf_ad_safe(delay, hi), logccdf_ad_safe(delay, lo)) :
         logsubexp(logcdf_ad_safe(delay, lo), l_hi)
    result = lg - log(b - a)
    isfinite(result) && return result
    p = _uniform_window_pdf(delay, primary, x)
    return p <= 0 ? oftype(float(p), -Inf) : log(p)
end

function convolved_logpdf(delay::UnivariateDistribution, primary::Uniform,
        x::Real, ::AnalyticalSolver)
    return _uniform_window_logpdf(delay, primary, x)
end

# Mirrored component order (S1.5), with the same `(Uniform, Uniform)`
# tie-break as `convolved_pdf` above.
function convolved_logpdf(primary::Uniform, delay::UnivariateDistribution,
        x::Real, m::AnalyticalSolver)
    return convolved_logpdf(delay, primary, x, m)
end

function convolved_logpdf(primary::Uniform, delay::Uniform, x::Real,
        ::AnalyticalSolver)
    return _uniform_window_logpdf(delay, primary, x)
end

# Vector-`x` forms (S1.4), mirrored and tie-broken as the scalar methods
# above.
function convolved_logpdf(delay::UnivariateDistribution, primary::Uniform,
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    return map(xi -> _uniform_window_logpdf(delay, primary, xi), x)
end

function convolved_logpdf(primary::Uniform, delay::UnivariateDistribution,
        x::AbstractVector{<:Real}, m::AnalyticalSolver)
    return convolved_logpdf(delay, primary, x, m)
end

function convolved_logpdf(primary::Uniform, delay::Uniform,
        x::AbstractVector{<:Real}, ::AnalyticalSolver)
    return map(xi -> _uniform_window_logpdf(delay, primary, xi), x)
end
