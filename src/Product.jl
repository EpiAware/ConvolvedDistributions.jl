@doc "

Distribution of a product of two independent random variables.

`Product` represents ``Z = X Y`` where `X` and `Y` are independent
univariate distributions with non-negative support. It is the
multiplicative member of the family: where [`Convolved`](@ref) gathers
two delays into one longer gap and [`Difference`](@ref) takes the signed
gap between two events, a product scales one variable by another, as
when a delay is stretched by an independent multiplicative factor.

Both components must satisfy `minimum(d) >= 0`; the constructor throws
an `ArgumentError` otherwise. Sign-crossing supports are future work
(they split the Mellin quadrature into positive and negative branches).
The support of `Z` runs from ``\\min(X)\\min(Y)`` to
``\\max(X)\\max(Y)``, taking the value ``\\infty`` where a component is
unbounded.

# Independence

The construction assumes `X` and `Y` are independent. The density, CDF,
mean and variance below all rely on this; they are not correct for
dependent components.

# Density and CDF computation

The density is the Mellin convolution of the two component densities:

```math
f_Z(z) = \\int f_X(z / y)\\, f_Y(y)\\, \\frac{\\mathrm{d}y}{y}
```

and the CDF integrates `X`'s CDF against `Y`'s density:

```math
F_Z(z) = \\int F_X(z / y)\\, f_Y(y)\\, \\mathrm{d}y ,
```

evaluated numerically in the equivalent survival form
``F_Y(u) - \\int \\bar{F}_X(z / y) f_Y(y)\\,\\mathrm{d}y`` so the
integrand stays bounded when `Y`'s density diverges at zero
(Gamma or Weibull shape below one).

For a `LogNormal`-`LogNormal` pair the closed form
``\\mathrm{LogNormal}(\\mu_X + \\mu_Y, \\sqrt{\\sigma_X^2 + \\sigma_Y^2})``
is used directly unless a [`NumericSolver`](@ref) method is set. All
other cases use AD-safe fixed-node Gauss-Legendre quadrature
(`gl_integrate`), the same construction [`Convolved`](@ref) and
[`Difference`](@ref) use: the integral is mapped from the fixed
reference domain ``(-1, 1)`` onto the integration bounds inside the
integrand and reduced as a bare weighted dot product, so every AD
backend specialises on the integrand's own type and component `Dual`s
and tangents propagate.

The `method` field selects the backend: an [`AnalyticalSolver`](@ref)
(the default) uses the analytic product where one exists and falls back
to quadrature otherwise, while a [`NumericSolver`](@ref) forces the
numeric path even for a `LogNormal`-`LogNormal` pair (useful for
validation).

# See also
- [`product`](@ref): Constructor function
- [`Convolved`](@ref): The sum ``X + Y``
- [`Difference`](@ref): The signed gap ``X - Y``
"
struct Product{X <: UnivariateDistribution, Y <: UnivariateDistribution,
    M <: AbstractSolverMethod} <:
       AbstractConvolvedDistribution{Distributions.Univariate, Continuous}
    "The multiplicand component (the `X` in `Z = X * Y`)."
    x::X
    "The multiplier component (the `Y` in `Z = X * Y`)."
    y::Y
    "Solver method choosing the analytic vs numeric quadrature backend."
    method::M

    function Product(x::X, y::Y;
            method::AbstractSolverMethod = AnalyticalSolver()) where {
            X <: UnivariateDistribution, Y <: UnivariateDistribution}
        (minimum(x) >= 0 && minimum(y) >= 0) ||
            throw(ArgumentError(
                "product requires components with non-negative support " *
                "(minimum(d) >= 0 for both); sign-crossing supports are " *
                "future work"))
        new{X, Y, typeof(method)}(x, y, method)
    end
end

@doc "

Create the distribution of a product of two independent variables.

Returns a [`Product`](@ref) representing ``Z = X Y``, the multiplicative
member of the family (the Mellin convolution): where
[`convolved`](@ref) sums two delays and [`difference`](@ref) takes their
signed gap, a product scales one variable by an independent
multiplicative factor. Both components must have non-negative support
(`minimum(d) >= 0`); sign-crossing supports throw an `ArgumentError`
and are future work.

`X` and `Y` are assumed independent.

# Arguments
- `x`: The multiplicand distribution (the `X` in `Z = X * Y`), a
  `UnivariateDistribution` with non-negative support.
- `y`: The multiplier distribution (the `Y` in `Z = X * Y`), a
  `UnivariateDistribution` with non-negative support.

# Keyword Arguments
- `method`: The solver method, an [`AnalyticalSolver`](@ref) (the default)
  or [`NumericSolver`](@ref). `NumericSolver` forces numeric quadrature
  even for a `LogNormal`-`LogNormal` pair, mirroring `convolved`.

# Examples
```@example
using ConvolvedDistributions, Distributions

# A delay stretched by an independent multiplicative factor;
# the mean is the product of the means (≈ 3.3).
d = product(Gamma(3.0, 1.0), LogNormal(0.0, 0.3))
mean(d)
```

# See also
- [`Product`](@ref): The distribution type
- [`convolved`](@ref): The sum ``X + Y``
- [`difference`](@ref): The signed gap ``X - Y``
"
function product(x::UnivariateDistribution, y::UnivariateDistribution;
        method::AbstractSolverMethod = AnalyticalSolver())
    return Product(x, y; method = method)
end

# ---------------------------------------------------------------------------
# Interface: params / support / sampling
# ---------------------------------------------------------------------------

params(d::Product) = (params(d.x), params(d.y))

function Base.eltype(::Type{<:Product{X, Y}}) where {X, Y}
    return promote_type(eltype(X), eltype(Y))
end

# With non-negative supports the product is monotone in both factors, so
# the ends multiply: the smallest product pairs the two smallest values,
# the largest the two largest. The minima are always finite (>= 0); an
# unbounded maximum propagates as Inf, guarded so a degenerate zero
# component gives 0 rather than the indeterminate 0 * Inf = NaN.
minimum(d::Product) = minimum(d.x) * minimum(d.y)

function maximum(d::Product)
    xmax = maximum(d.x)
    ymax = maximum(d.y)
    (iszero(xmax) || iszero(ymax)) && return zero(xmax) * zero(ymax)
    return xmax * ymax
end

function insupport(d::Product, z::Real)
    return minimum(d) <= z <= maximum(d)
end

function Base.rand(rng::AbstractRNG, d::Product)
    return rand(rng, d.x) * rand(rng, d.y)
end

sampler(d::Product) = d

# ---------------------------------------------------------------------------
# Moments: exact for independent components
# ---------------------------------------------------------------------------
#
# Z = X * Y with X ⟂ Y, so E[Z] = E[X]E[Y] and, via
# E[Z²] = E[X²]E[Y²] with E[W²] = Var[W] + E[W]²,
# Var[Z] = E[X²]E[Y²] - (E[X]E[Y])². Both flow through the component
# parameters via the components' own analytic `mean`/`var`, so the path
# is AD-safe; a component without an analytic moment errors from its own
# call.

@doc "

Mean of the product: the product of the component means,
``\\mathbb{E}[X]\\,\\mathbb{E}[Y]`` (exact under independence).

See also: [`var`](@ref), [`std`](@ref)
"
mean(d::Product) = mean(d.x) * mean(d.y)

@doc "

Variance of the product:
``\\mathbb{E}[X^2]\\mathbb{E}[Y^2] - (\\mathbb{E}[X]\\mathbb{E}[Y])^2``
with ``\\mathbb{E}[W^2] = \\mathrm{Var}[W] + \\mathbb{E}[W]^2``, exact
under independence.

See also: [`mean`](@ref), [`std`](@ref)
"
function var(d::Product)
    mx = mean(d.x)
    my = mean(d.y)
    ex2 = var(d.x) + mx^2
    ey2 = var(d.y) + my^2
    return ex2 * ey2 - (mx * my)^2
end

@doc "

Standard deviation of the product, ``\\sqrt{\\mathrm{Var}[Z]}``.

See also: [`var`](@ref), [`mean`](@ref)
"
std(d::Product) = sqrt(var(d))

# ---------------------------------------------------------------------------
# Analytical fast path for LogNormal * LogNormal
# ---------------------------------------------------------------------------

# `_try_product` returns the analytic product distribution when a closed
# form exists, otherwise `nothing`. Dispatch (rather than `try`/`catch`)
# selects the analytic pair so the path stays differentiable under every
# AD backend. Only LogNormal * LogNormal is enabled: on the log scale the
# product is a sum of two independent normals, so the log-parameters add
# and the log-variances sum.
_try_product(x::UnivariateDistribution, y::UnivariateDistribution) = nothing

function _try_product(x::LogNormal, y::LogNormal)
    μx, σx = params(x)
    μy, σy = params(y)
    return LogNormal(μx + μy, sqrt(σx^2 + σy^2))
end

# The analytic product to use for `d`, or `nothing` when none exists or
# when `d.method` is a `NumericSolver` requesting the numeric path.
function _maybe_analytic(d::Product)
    d.method isa NumericSolver && return nothing
    return _try_product(d.x, d.y)
end

# ---------------------------------------------------------------------------
# Numeric Mellin convolution (AD-safe Gauss-Legendre dot product)
# ---------------------------------------------------------------------------

# Composite window quantile for a `Product` component (issue #45; see
# the `Convolved` method in `src/Convolved.jl`). With both supports
# non-negative the product of the component quantiles at the same `p`
# bounds the product quantile on either side by a union bound, trimming
# at most `2 * _CONVOLVED_TAIL` of mass. Mirrors the exact inversion's
# starting guess in the Optimization extension.
@noinline function _window_quantile(d::Product, p::Real)
    return _window_quantile(d.x, p) * _window_quantile(d.y, p)
end

# The effective mass window of Y for the multiplicative quadrature. Both
# integrands carry the factor f_Y(y), negligible outside Y's effective
# support, so an infinite upper endpoint is clamped to an extreme
# quantile of Y on AD-stripped params (`_window_quantile`, shared with
# Convolved). Unlike `_difference_window` the LOWER end also needs a
# clamp when it is zero: the density integrand carries a 1/y factor, so
# a zero endpoint is nudged to the matching extreme lower quantile,
# below which Y carries no appreciable mass by construction.
function _product_mass_window(d::Product)
    ymin = minimum(d.y)
    ymax = maximum(d.y)
    lo = ymin > 0 ? ymin : _window_quantile(d.y, _CONVOLVED_TAIL)
    hi = isfinite(ymax) ? ymax : _window_quantile(d.y, 1 - _CONVOLVED_TAIL)
    return lo, hi
end

# Density integration window: Y's mass window intersected with the range
# where z / y lands in X's support (mirroring how `_pdf_point_window`
# intersects supports for Convolved). z / y <= max(X) gives
# y >= z / max(X) (0 when X is unbounded above) and z / y >= min(X)
# gives y <= z / min(X) (Inf when min(X) = 0, harmless under `_min2`).
# Callers guard z > minimum(d) >= 0, so the divisions are well defined.
function _product_pdf_window(d::Product, z::Real)
    lo, hi = _product_mass_window(d)
    lower = _max2(lo, z / maximum(d.x))
    upper = _min2(hi, z / minimum(d.x))
    return lower, upper
end

# CDF integration window for the survival (control-variate) form.
# Writing F_X = 1 - ccdf_X inside the direct integral gives
#   F_Z(z) = F_Y(u*) - ∫_{lower}^{u*} ccdf_X(z / y) f_Y(y) dy
# with u* = min(max(Y), z / min(X)) (above u* the direct integrand's
# F_X factor is exactly zero, so nothing is dropped) and
# lower = max(min(Y), z / max(X)) (below it ccdf_X is exactly zero).
# The survival form is used unconditionally: unlike the direct
# F_X-weighted integrand it stays bounded as y -> 0 when f_Y diverges
# there (Gamma/Weibull shape < 1, with X unbounded above so the window
# reaches the singularity) — ccdf_X(z / y) -> 0 kills the integrable
# singularity that the fixed-node rule cannot resolve, which otherwise
# biased the CDF by ~1e-2 (Gamma(0.5) multiplier) to ~7e-2 (Gamma(0.3))
# and broke cdf symmetry between product(X, Y) and product(Y, X).
# Measured against adaptive-quadrature references, the survival form is
# ~1e-12 on the singular cases and no worse than the direct form
# anywhere else (both ~1e-9 worst case elsewhere), so one code path
# suffices. An infinite u* is clamped to an extreme AD-stripped
# quantile of Y; the mass above it contributes at most the tail
# fraction.
function _product_cdf_window(d::Product, z::Real)
    ymin = minimum(d.y)
    ymax = maximum(d.y)
    upper_exact = _min2(ymax, z / minimum(d.x))
    upper = isfinite(upper_exact) ? upper_exact :
            _window_quantile(d.y, 1 - _CONVOLVED_TAIL)
    lower = _max2(ymin, z / maximum(d.x))
    return lower, upper
end

# Numeric product density (the Mellin convolution):
#   f_Z(z) = ∫ f_X(z / y) f_Y(y) / y dy   over y ∈ support(Y), y > 0.
function _product_numeric_pdf(d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))

    lower, upper = _product_pdf_window(d, z)
    upper <= lower && return zero(float(typeof(z)))

    result = gl_integrate(
        y -> _pdf_ad_safe(d.x, z / y) * _pdf_ad_safe(d.y, y) / y,
        lower, upper)
    return max(result, zero(result))
end

# Numeric product CDF:
#   F_Z(z) = P(X Y ≤ z) = ∫ F_X(z / y) f_Y(y) dy   over y ∈ support(Y),
# evaluated in the singularity-free survival form
#   F_Y(upper) - ∫ ccdf_X(z / y) f_Y(y) dy
# (see `_product_cdf_window`). A degenerate window means the direct
# integrand's F_X factor is 1 on all of Y's mass below `upper`, so the
# base term alone is the answer.
function _product_numeric_cdf(d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))

    lower, upper = _product_cdf_window(d, z)
    base = _cdf_ad_safe(d.y, upper)
    upper <= lower && return clamp(base, zero(base), one(base))

    result = base -
             gl_integrate(
        y -> _ccdf_ad_safe(d.x, z / y) * _pdf_ad_safe(d.y, y),
        lower, upper)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# CDF / logcdf / pdf / logpdf
# ---------------------------------------------------------------------------

@doc "

Compute the cumulative distribution function.

Uses the analytic `LogNormal`-`LogNormal` product where it applies,
otherwise AD-safe numeric quadrature of
``\\int F_X(z / y) f_Y(y)\\,\\mathrm{d}y`` in its survival form
``F_Y(u) - \\int \\bar{F}_X(z / y) f_Y(y)\\,\\mathrm{d}y``, which stays
accurate when `Y`'s density diverges at zero (shape below one).

See also: [`logcdf`](@ref)
"
function cdf(d::Product, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return cdf(analytic, z)
    end
    return _product_numeric_cdf(d, z)
end

@doc "

Compute the log cumulative distribution function.

See also: [`cdf`](@ref)
"
function logcdf(d::Product, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logcdf(analytic, z)
    end
    c = _product_numeric_cdf(d, z)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

function ccdf(d::Product, z::Real)
    return 1 - cdf(d, z)
end

function logccdf(d::Product, z::Real)
    logcdf_val = logcdf(d, z)
    if logcdf_val == -Inf
        return zero(logcdf_val)
    elseif logcdf_val >= 0
        return oftype(logcdf_val, -Inf)
    end
    return log1mexp(logcdf_val)
end

@doc "

Compute the probability density function.

Uses the exact analytic `LogNormal`-`LogNormal` density where it
applies, otherwise the AD-safe numeric Mellin convolution
``f_Z(z) = \\int f_X(z / y) f_Y(y) \\frac{\\mathrm{d}y}{y}``.

See also: [`logpdf`](@ref)
"
function pdf(d::Product, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return pdf(analytic, z)
    end
    return _product_numeric_pdf(d, z)
end

@doc "

Compute the log probability density function.

See also: [`pdf`](@ref), [`logcdf`](@ref)
"
function logpdf(d::Product, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logpdf(analytic, z)
    end
    if !insupport(d, z)
        return oftype(float(z), -Inf)
    end
    p = _product_numeric_pdf(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end
