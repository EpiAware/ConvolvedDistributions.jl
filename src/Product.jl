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

# Value support

Derived from the components, not hardcoded: a `Product` of two
integer-lattice discrete distributions is itself `Discrete`, with its
density computed by exact divisor enumeration and its CDF by an exact
conditioning sum, both replacing quadrature (see [`is_exact`](@ref)).
Otherwise it is `Continuous`, as before.

A `Product` with exactly one integer-lattice discrete side (`x` or `y`,
not both) also evaluates exactly, folding the other side's density/CDF
over the discrete component's own positive lattice window (#115). A
discrete factor with mass at 0 puts an atom at 0 in `Z` mixed with a
continuous density elsewhere -- a measure no `pdf` can represent -- so
`product(...)` rejects that combination with an `ArgumentError` at
construction rather than silently dropping the atom.

# Independence

The construction assumes `X` and `Y` are independent. The density, CDF,
mean and variance below all rely on this; they are not correct for
dependent components.

# Density and CDF computation

This section describes the `Continuous`-typed path (see
\"Value support\" above for the `Discrete` case: an exact divisor
enumeration for the density, and an exact conditioning sum, `O(z)` mass
evaluations, for the CDF).

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
other `Continuous`-typed cases use AD-safe fixed-node Gauss-Legendre
quadrature (`gl_integrate`), the same construction [`Convolved`](@ref)
and [`Difference`](@ref) use: the integral is mapped from the fixed
reference domain ``(-1, 1)`` onto the integration bounds inside the
integrand and reduced as a bare weighted dot product, so every AD
backend specialises on the integrand's own type and component `Dual`s
and tangents propagate. A `Discrete`-typed `Product` never reaches
quadrature at all — see \"Value support\" above.

The `method` field selects the backend: an [`AnalyticalSolver`](@ref)
(the default) uses the analytic product where one exists and falls back
to the numeric path otherwise, while a [`NumericSolver`](@ref) forces
that numeric path even for a `LogNormal`-`LogNormal` pair (useful for
validation). For a `Continuous`-typed `Product` the numeric path is
quadrature; for a `Discrete`-typed one it is the exact divisor/
conditioning-sum fold, never quadrature — `NumericSolver` means \"skip
the closed form\", not \"run Gauss-Legendre\".

# See also
- [`product`](@ref): Constructor function
- [`Convolved`](@ref): The sum ``X + Y``
- [`Difference`](@ref): The signed gap ``X - Y``
"
struct Product{X <: UnivariateDistribution, Y <: UnivariateDistribution,
    M <: AbstractSolverMethod, S <: Distributions.ValueSupport} <:
       AbstractConvolvedDistribution{Distributions.Univariate, S}
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
        _check_mixed_atom_at_zero(x, y)
        S = _components_support((x, y))
        new{X, Y, typeof(method), S}(x, y, method)
    end
end

# A mixed discrete/continuous `Product` whose discrete factor carries
# mass at zero puts an atom at 0 in `Z` (`P(Z = 0) = P(D = 0) > 0`)
# alongside a continuous density elsewhere -- a mixed measure no `pdf`
# can represent -- so construction rejects it outright rather than
# silently dropping the atom (#115). Dispatches on the SAME
# `_mixed_slot` trait the pdf/cdf route uses, so the guard cannot drift
# from what would actually be evaluated; an all-discrete pair (its own
# `P(XY = 0)` atom is already exact, see `_product_lattice_pdf`) or an
# all-continuous pair resolves `_mixed_slot(...) === nothing` and is
# unaffected. The comparison strips any AD tracer first (`primal`,
# mirroring `_lattice_range`): the atom-or-not answer is a structural
# property of the discrete component's parameters, not a differentiated
# quantity, so it must resolve identically under every AD backend.
function _check_mixed_atom_at_zero(x::UnivariateDistribution,
        y::UnivariateDistribution)
    slot = _mixed_slot(_component_support(typeof(x)), _component_support(typeof(y)))
    discrete_comp = _mixed_discrete_component(slot, x, y)
    discrete_comp === nothing && return nothing
    mass_at_zero = Float64(primal(pdf_ad_safe(discrete_comp, 0)))
    mass_at_zero > 0 &&
        throw(ArgumentError(
            "product(...) of a discrete component ($(nameof(typeof(discrete_comp)))) " *
            "with mass at 0 and a continuous component puts an atom at " *
            "0 in the product -- a mixed measure `pdf` cannot represent. " *
            "Exclude the mass at 0 from the discrete component (e.g. a " *
            "shifted or truncated distribution) to use `product`"))
    return nothing
end

# Discrete-typed alias: matches only when both `x` and `y` are
# integer-lattice discrete distributions (see `_components_support` in
# `src/interface.jl`). Used to dispatch to the exact divisor fold.
const _DiscreteProduct = Product{
    <:UnivariateDistribution, <:UnivariateDistribution,
    <:AbstractSolverMethod, Discrete}

# Continuous-typed alias (#115): matches every `Product` with no closed
# form, both the genuinely mixed pairs (one integer-lattice discrete
# side, construction-time guaranteed to carry no mass at 0, see
# `_check_mixed_atom_at_zero` above) and the ordinary all-continuous
# pairs. `_mixed_slot` (interface.jl) narrows further, by dispatch, on
# the component types themselves; a both-continuous pair resolves to
# `nothing` there and falls straight back to the existing quadrature
# path.
const _MixedableProduct = Product{
    <:UnivariateDistribution, <:UnivariateDistribution,
    <:AbstractSolverMethod, Continuous}

# `_has_mixed_fold` (interface.jl): true exactly when one of `x`/`y` is
# integer-lattice discrete and the other is not. `Product` always has
# exactly two components, so no arity guard is needed.
function _has_mixed_fold(d::Product)
    return _mixed_slot(_component_support(typeof(d.x)),
        _component_support(typeof(d.y))) !== nothing
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
- `strict`: When `true`, error (naming the component families) rather
  than silently return an object whose density/CDF would fall back to
  quadrature. `false` by default. See [`evaluation_path`](@ref) to check
  the route after construction instead of asserting it up front.

# Returns
- A [`Product`](@ref) distribution of the product `Z = X * Y`.

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
- [`evaluation_path`](@ref): Check the route without asserting it.
"
function product(x::UnivariateDistribution, y::UnivariateDistribution;
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false)
    return _check_strict(Product(x, y; method = method), strict)
end

# The component-family names for a `strict = true` construction error
# (see `_check_strict` in interface.jl).
_family_names(d::Product) = (nameof(typeof(d.x)), nameof(typeof(d.y)))

# ---------------------------------------------------------------------------
# Interface: params / support / sampling
# ---------------------------------------------------------------------------

params(d::Product) = (params(d.x), params(d.y))

# The element type of the PRODUCT, not a bare `promote_type` of the
# components (see the matching note on `Convolved`/`Difference`
# `Base.eltype`): `Base.promote_op(*, ...)` infers the type `*` actually
# produces.
function Base.eltype(::Type{<:Product{X, Y}}) where {X, Y}
    return Base.promote_op(*, eltype(X), eltype(Y))
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
    return _on_lattice(d, z) && minimum(d) <= z <= maximum(d)
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

# Default `quantile_initial_guess`: product of the component quantiles
# at `p`, exact on the log scale for degenerate components. A
# downstream package overrides this per type.
function quantile_initial_guess(d::Product, p::Real)
    return [float(quantile(d.x, p)) * float(quantile(d.y, p))]
end

# The effective mass window of Y for the multiplicative quadrature. Both
# integrands carry the factor f_Y(y), negligible outside Y's effective
# support, so an infinite upper endpoint is clamped to an extreme
# quantile of Y on AD-stripped params (`_window_quantile`, shared with
# Convolved). Unlike `_difference_window` the LOWER end also needs a
# clamp when it is zero: the density integrand carries a 1/y factor, so
# a zero endpoint is nudged to the matching extreme lower quantile,
# below which Y carries no appreciable mass by construction. `float(...)`
# on the already-set branches matches `_window_quantile`'s own
# `float(...)` wrap, keeping the pair type-stable regardless of whether
# `Y` is continuous or discrete (see `_difference_window`).
function _product_mass_window(d::Product)
    ymin = minimum(d.y)
    ymax = maximum(d.y)
    lo = ymin > 0 ? float(ymin) : _window_quantile(d.y, _CONVOLVED_TAIL)
    hi = isfinite(ymax) ? float(ymax) :
         _window_quantile(d.y, 1 - _CONVOLVED_TAIL)
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
# The quadrature is quantile-panelled on Y (`_panel_integrate`, shared
# with Convolved) so a heavy-tailed Y cannot stretch the window away
# from the integrand's mass (issue #49).
function _product_numeric_pdf(d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))

    lower, upper = _product_pdf_window(d, z)
    upper <= lower && return zero(float(typeof(z)))

    result = _panel_integrate(
        y -> pdf_ad_safe(d.x, z / y) * pdf_ad_safe(d.y, y) / y,
        lower, upper, d.y)
    return max(result, zero(result))
end

# Numeric product CDF:
#   F_Z(z) = P(X Y ≤ z) = ∫ F_X(z / y) f_Y(y) dy   over y ∈ support(Y),
# evaluated in the singularity-free survival form
#   F_Y(upper) - ∫ ccdf_X(z / y) f_Y(y) dy
# (see `_product_cdf_window`). A degenerate window means the direct
# integrand's F_X factor is 1 on all of Y's mass below `upper`, so the
# base term alone is the answer. The quadrature is quantile-panelled on
# Y like the density above (issue #49; a single fixed-node window
# missed this CDF by ~1.4e-2 for a LogNormal(0, 1.5) multiplier).
function _product_numeric_cdf(d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))

    lower, upper = _product_cdf_window(d, z)
    base = cdf_ad_safe(d.y, upper)
    upper <= lower && return clamp(base, zero(base), one(base))

    result = base -
             _panel_integrate(
        y -> ccdf_ad_safe(d.x, z / y) * pdf_ad_safe(d.y, y),
        lower, upper, d.y)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# Exact discrete divisor fold (#85, #89)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_DiscreteProduct` (both `x` and `y` integer-lattice
# discrete). Both components are non-negative by construction, so their
# integer supports lie in `0, 1, 2, ...`.

# P(XY = 0) = P(X = 0) + P(Y = 0) - P(X = 0)P(Y = 0), and for z >= 1
# P(XY = z) = Σ_{k | z} P(X = k) P(Y = z / k) over the positive divisors
# of z, enumerated in pairs up to sqrt(z). Exact, no truncation, and
# O(sqrt(z)) mass evaluations. The accumulator is seeded from the k = 1
# term so the element type comes from the component masses.
function _product_lattice_pdf(d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    insupport(d, z) || return zero(float(typeof(z)))
    zi = Int(primal(z))
    if zi == 0
        px = pdf_ad_safe(d.x, 0)
        py = pdf_ad_safe(d.y, 0)
        return px + py - px * py
    end
    acc = pdf_ad_safe(d.x, 1) * pdf_ad_safe(d.y, zi)
    zi == 1 && return acc
    acc += pdf_ad_safe(d.x, zi) * pdf_ad_safe(d.y, 1)
    for k in 2:isqrt(zi)
        zi % k == 0 || continue
        j = zi ÷ k
        acc += pdf_ad_safe(d.x, k) * pdf_ad_safe(d.y, j)
        j == k || (acc += pdf_ad_safe(d.x, j) * pdf_ad_safe(d.y, k))
    end
    return acc
end

# F_Z(z) = P(Y = 0) + Σ_{y = 1}^{m} P(Y = y) F_X(z / y) + P(Y > m) P(X = 0),
# m = min(floor(z), max(Y)). For y > m the conditional P(X <= z/y) is
# P(X = 0) because X is integer-valued and 0 <= z/y < 1 (m = floor(z), so
# y > m implies z/y < 1), so the unbounded-Y tail is closed exactly
# rather than truncated — `ccdf_ad_safe(d.y, m)` is exactly `0` once
# `m >= max(Y)`, so a bounded Y needs no separate branch either. O(z)
# mass/cdf evaluations (cheaper than the O(sqrt(z)) pdf fold summed up
# to z, since each term here is O(1)). The accumulator is seeded from
# the `y = 0` term.
function _product_lattice_cdf(d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z < minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))

    zi = floor(Int, Float64(primal(z)))
    ymax = maximum(d.y)
    m = isfinite(ymax) ? min(zi, floor(Int, Float64(primal(ymax)))) : zi

    result = pdf_ad_safe(d.y, 0)
    for y in 1:m
        result += pdf_ad_safe(d.y, y) * cdf_ad_safe(d.x, z / y)
    end
    result += ccdf_ad_safe(d.y, m) * pdf_ad_safe(d.x, 0)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# Mixed discrete/continuous fold (#115)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_MixedableProduct` whose `_mixed_slot` resolves
# to `Val(1)`/`Val(2)` (exactly one of `x`/`y` is integer-lattice
# discrete; see `_has_mixed_fold` above). Construction has already
# rejected any discrete factor with mass at 0
# (`_check_mixed_atom_at_zero`), so its support lies in the positive
# lattice `1, 2, 3, ...`. Multiplication commutes, so `Z = X Y` folds
# the same way regardless of which slot the discrete factor sits in:
# writing its pmf as a lattice of point masses and substituting into the
# Mellin convolution collapses it to an exact sum over that lattice,
#   f_Z(z) = Σ_k P(D = k) f_C(z / k) / k,
#   F_Z(z) = Σ_k P(D = k) F_C(z / k),
# evaluated on D's own effective window with the `k = 0` lattice point
# excluded (`_mixed_positive_window` below) -- necessary even though
# construction guarantees `P(D = 0) = 0`, since a `k = 0` term would
# still divide by zero inside the summand before that zero weight could
# cancel it. No continuous quadrature error survives: C's density/CDF is
# evaluated pointwise, not integrated (see `is_exact`).

# `_mixed_discrete_window` (Convolved.jl) as an integer lattice range,
# with `k = 0` excluded even if `minimum(D)` itself reports `0`.
function _mixed_positive_window(D::UnivariateDistribution)
    t0, t1 = _lattice_range(_mixed_discrete_window(D)...)
    return max(t0, 1), t1
end

function _product_mixed_pdf(::Val{1}, d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))
    D = d.x
    t0, t1 = _mixed_positive_window(D)
    t1 < t0 && return zero(float(typeof(z)))
    return _lattice_sum(
        k -> pdf_ad_safe(D, k) * pdf_ad_safe(d.y, z / k) / k, t0, t1)
end
function _product_mixed_pdf(::Val{2}, d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))
    D = d.y
    t0, t1 = _mixed_positive_window(D)
    t1 < t0 && return zero(float(typeof(z)))
    return _lattice_sum(
        k -> pdf_ad_safe(D, k) * pdf_ad_safe(d.x, z / k) / k, t0, t1)
end
_product_mixed_pdf(::Nothing, d::Product, z::Real) = _product_numeric_pdf(d, z)

function _product_mixed_cdf(::Val{1}, d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))
    D = d.x
    t0, t1 = _mixed_positive_window(D)
    t1 < t0 && return zero(float(typeof(z)))
    result = _lattice_sum(
        k -> pdf_ad_safe(D, k) * cdf_ad_safe(d.y, z / k), t0, t1)
    return clamp(result, zero(result), one(result))
end
function _product_mixed_cdf(::Val{2}, d::Product, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))
    D = d.y
    t0, t1 = _mixed_positive_window(D)
    t1 < t0 && return zero(float(typeof(z)))
    result = _lattice_sum(
        k -> pdf_ad_safe(D, k) * cdf_ad_safe(d.x, z / k), t0, t1)
    return clamp(result, zero(result), one(result))
end
_product_mixed_cdf(::Nothing, d::Product, z::Real) = _product_numeric_cdf(d, z)

# Dispatch on the `Discrete` type parameter selects the exact divisor
# fold; `is_exact` (`src/interface.jl`) keys off the same
# `_exact_discrete_route` predicate, so reported and executed exactness
# cannot drift.
_product_pdf_route(d::Product, z::Real) = _product_numeric_pdf(d, z)
_product_pdf_route(d::_DiscreteProduct, z::Real) = _product_lattice_pdf(d, z)
_product_cdf_route(d::Product, z::Real) = _product_numeric_cdf(d, z)
_product_cdf_route(d::_DiscreteProduct, z::Real) = _product_lattice_cdf(d, z)

# Mixed route (#115): more specific than the bare `Product` method
# above, so it wins for any `Continuous`-typed pair.
function _product_pdf_route(d::_MixedableProduct, z::Real)
    return _product_mixed_pdf(
        _mixed_slot(_component_support(typeof(d.x)),
            _component_support(typeof(d.y))), d, z)
end
function _product_cdf_route(d::_MixedableProduct, z::Real)
    return _product_mixed_cdf(
        _mixed_slot(_component_support(typeof(d.x)),
            _component_support(typeof(d.y))), d, z)
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
    return _product_cdf_route(d, z)
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
    c = _product_cdf_route(d, z)
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
    return _product_pdf_route(d, z)
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
    p = _product_pdf_route(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end
