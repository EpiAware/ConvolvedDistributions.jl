@doc "

Distribution of a difference of two independent random variables.

`Difference` represents ``Z = X - Y`` where `X` and `Y` are independent
univariate distributions. It is the dual of [`Convolved`](@ref) (the sum
``X + Y``): a convolution of `X` with the reflection of `Y`. Where a
convolution gathers two delays into one longer gap, a difference is the
signed gap between two events, so it arises as a derived observation
(for example the offset between two independently timed measurements)
rather than as a delay leaf.

Because the subtraction reflects `Y`, the support of `Z` is in general
two-sided and can be negative: it runs from ``\\min(X) - \\max(Y)`` to
``\\max(X) - \\min(Y)``, taking the value ``\\pm\\infty`` where a component
is unbounded. `Z` is therefore not a non-negative delay distribution;
treat a `Difference` as an observation or derived quantity, not as a delay
leaf.

# Value support

Derived from the components, not hardcoded: a `Difference` of two
integer-lattice discrete distributions is itself `Discrete`, with a
two-sided integer support, and its density/CDF are computed by an exact
fold over the integer lattice instead of quadrature (see
[`is_exact`](@ref)). Otherwise it is `Continuous`, as before.

A `Difference` with exactly one integer-lattice discrete side (`x` or
`y`, not both) also evaluates exactly, folding the other side's
density/CDF over the discrete component's own lattice window (#115);
the two argument orders reflect differently since subtraction is not
commutative (see the mixed fold in `src/Difference.jl`).

# Independence

The construction assumes `X` and `Y` are independent. The density, CDF,
mean and variance below all rely on this; they are not correct for
dependent components.

# Density and CDF computation

The density is the cross-correlation of the two component densities:

```math
f_Z(z) = \\int f_X(z + y)\\, f_Y(y)\\, \\mathrm{d}y
```

and the CDF integrates `X`'s CDF against `Y`'s density:

```math
F_Z(z) = \\int F_X(z + y)\\, f_Y(y)\\, \\mathrm{d}y .
```

For a `Normal`-`Normal` pair the closed form
``\\mathrm{Normal}(\\mu_X - \\mu_Y, \\sqrt{\\sigma_X^2 + \\sigma_Y^2})`` is
used directly unless a [`NumericSolver`](@ref) method is set. All other
`Continuous`-typed cases use AD-safe fixed-node Gauss-Legendre quadrature
(`gl_integrate`), the same construction [`Convolved`](@ref) uses: the
integral is mapped from the fixed reference domain ``(-1, 1)`` onto the
integration bounds inside the integrand and reduced as a bare weighted
dot product, so every AD backend specialises on the integrand's own type
and component `Dual`s and tangents propagate. A `Discrete`-typed
`Difference` never reaches quadrature at all — see \"Value support\"
above.

The `method` field selects the backend: an [`AnalyticalSolver`](@ref) (the
default) uses the analytic difference where one exists and falls back to
the numeric path otherwise, while a [`NumericSolver`](@ref) forces that
numeric path even for a `Normal`-`Normal` pair (useful for validation).
For a `Continuous`-typed `Difference` the numeric path is quadrature;
for a `Discrete`-typed one it is the exact integer-lattice fold, never
quadrature — `NumericSolver` means \"skip the closed form\", not \"run
Gauss-Legendre\".

# See also
- [`difference`](@ref): Constructor function
- [`Convolved`](@ref): The dual sum ``X + Y``
"
struct Difference{X <: UnivariateDistribution, Y <: UnivariateDistribution,
    M <: AbstractSolverMethod, S <: Distributions.ValueSupport} <:
       AbstractConvolvedDistribution{Distributions.Univariate, S}
    "The minuend component (the `X` in `Z = X - Y`)."
    x::X
    "The subtrahend component (the `Y` in `Z = X - Y`)."
    y::Y
    "Solver method choosing the analytic vs numeric quadrature backend."
    method::M

    function Difference(x::X, y::Y;
            method::AbstractSolverMethod = AnalyticalSolver()) where {
            X <: UnivariateDistribution, Y <: UnivariateDistribution}
        S = _components_support((x, y))
        new{X, Y, typeof(method), S}(x, y, method)
    end
end

# Discrete-typed alias: matches only when both `x` and `y` are
# integer-lattice discrete distributions (see `_components_support` in
# `src/interface.jl`). Used to dispatch to the exact lattice fold.
const _DiscreteDifference = Difference{
    <:UnivariateDistribution, <:UnivariateDistribution,
    <:AbstractSolverMethod, Discrete}

# Continuous-typed alias (#115): matches every `Difference` with no
# closed form, both the genuinely mixed pairs (one integer-lattice
# discrete side) and the ordinary all-continuous pairs. `_mixed_slot`
# (interface.jl) narrows further, by dispatch, on the component types
# themselves; a both-continuous pair resolves to `nothing` there and
# falls straight back to the existing quadrature path.
const _MixedableDifference = Difference{
    <:UnivariateDistribution, <:UnivariateDistribution,
    <:AbstractSolverMethod, Continuous}

# `_has_mixed_fold` (interface.jl): true exactly when one of `x`/`y` is
# integer-lattice discrete and the other is not. `Difference` always has
# exactly two components (unlike `Convolved`), so no arity guard is
# needed.
function _has_mixed_fold(d::Difference)
    return _mixed_slot(_component_support(typeof(d.x)),
        _component_support(typeof(d.y))) !== nothing
end

@doc "

Create the distribution of a difference of two independent variables.

Returns a [`Difference`](@ref) representing ``Z = X - Y``. This is the dual
of [`convolved`](@ref): a convolution forms the sum of two
delays, a difference the signed gap between two events. The support of `Z`
can be negative, so `Z` is an observation or derived quantity rather than a
non-negative delay leaf (see [`Difference`](@ref)).

`X` and `Y` are assumed independent.

# Arguments
- `x`: The minuend distribution (the `X` in `Z = X - Y`), a
  `UnivariateDistribution`.
- `y`: The subtrahend distribution (the `Y` in `Z = X - Y`), a
  `UnivariateDistribution`.

# Keyword Arguments
- `method`: The solver method, an [`AnalyticalSolver`](@ref) (the default)
  or [`NumericSolver`](@ref). `NumericSolver` forces numeric quadrature
  even for a `Normal`-`Normal` pair, mirroring `convolved`.
- `strict`: When `true`, error (naming the component families) rather
  than silently return an object whose density/CDF would fall back to
  quadrature. `false` by default. See [`evaluation_path`](@ref) to check
  the route after construction instead of asserting it up front.

# Returns
- A [`Difference`](@ref) distribution of the signed gap `Z = X - Y`.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Difference of two delays; mean is the difference of the means (≈ 3)
d = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))
mean(d)
```

# See also
- [`Difference`](@ref): The distribution type
- [`convolved`](@ref): The dual sum ``X + Y``
- [`evaluation_path`](@ref): Check the route without asserting it.
"
function difference(x::UnivariateDistribution, y::UnivariateDistribution;
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false)
    return _check_strict(Difference(x, y; method = method), strict)
end

# The component-family names for a `strict = true` construction error
# (see `_check_strict` in interface.jl).
_family_names(d::Difference) = (nameof(typeof(d.x)), nameof(typeof(d.y)))

# ---------------------------------------------------------------------------
# Interface: params / support / sampling
# ---------------------------------------------------------------------------

params(d::Difference) = (params(d.x), params(d.y))

# The element type of the DIFFERENCE, not a bare `promote_type` of the
# components: for `Bernoulli`-`Bernoulli` (`eltype == Bool` each),
# `promote_type(Bool, Bool) == Bool`, too narrow for a difference that
# reaches -1 and throws `InexactError` from `rand`. `Base.promote_op(-,
# ...)` infers the type `-` actually produces (`Int64` for two `Bool`s).
function Base.eltype(::Type{<:Difference{X, Y}}) where {X, Y}
    return Base.promote_op(-, eltype(X), eltype(Y))
end

# Reflecting Y is what gives the two-sided support: the largest difference
# pairs the largest X with the smallest Y, the smallest the reverse.
minimum(d::Difference) = minimum(d.x) - maximum(d.y)
maximum(d::Difference) = maximum(d.x) - minimum(d.y)

function insupport(d::Difference, z::Real)
    return _on_lattice(d, z) && minimum(d) <= z <= maximum(d)
end

function Base.rand(rng::AbstractRNG, d::Difference)
    return rand(rng, d.x) - rand(rng, d.y)
end

sampler(d::Difference) = d

# ---------------------------------------------------------------------------
# Moments: exact for independent components
# ---------------------------------------------------------------------------
#
# Z = X - Y with X ⟂ Y, so the mean is the difference of the means and the
# variance the sum of the variances (subtraction flips the sign of the mean
# contribution but not of the variance). Both flow through the component
# parameters via the components' own analytic `mean`/`var`, so the path is
# AD-safe; a component without an analytic moment errors from its own call.

@doc "

Mean of the difference: the difference of the component means,
``\\mathbb{E}[X] - \\mathbb{E}[Y]``.

See also: [`var`](@ref), [`std`](@ref)
"
mean(d::Difference) = mean(d.x) - mean(d.y)

@doc "

Variance of the difference: the sum of the component variances,
``\\mathrm{Var}[X] + \\mathrm{Var}[Y]`` (independence makes the variance
additive even though the means subtract).

See also: [`mean`](@ref), [`std`](@ref)
"
var(d::Difference) = var(d.x) + var(d.y)

@doc "

Standard deviation of the difference, ``\\sqrt{\\mathrm{Var}[Z]}``.

See also: [`var`](@ref), [`mean`](@ref)
"
std(d::Difference) = sqrt(var(d))

# ---------------------------------------------------------------------------
# Analytical fast path for Normal - Normal
# ---------------------------------------------------------------------------

# `_try_difference` returns the analytic difference distribution when a
# closed form exists, otherwise `nothing`. Dispatch (rather than
# `try`/`catch`) selects the analytic pair so the path stays
# differentiable under every AD backend. Only Normal - Normal is enabled:
# the difference of two independent normals is normal with the means
# subtracted and the variances summed.
_try_difference(x::UnivariateDistribution, y::UnivariateDistribution) = nothing

function _try_difference(x::Normal, y::Normal)
    return Normal(mean(x) - mean(y), sqrt(var(x) + var(y)))
end

# The analytic difference to use for `d`, or `nothing` when none exists or
# when `d.method` is a `NumericSolver` requesting the numeric path.
function _maybe_analytic(d::Difference)
    d.method isa NumericSolver && return nothing
    return _try_difference(d.x, d.y)
end

# ---------------------------------------------------------------------------
# Numeric cross-correlation (AD-safe Gauss-Legendre dot product)
# ---------------------------------------------------------------------------

# Composite window quantile for a `Difference` component (issue #45;
# see the `Convolved` method in `src/Convolved.jl`). The minuend
# quantile at `p` minus the subtrahend quantile at the opposing tail
# bounds the difference quantile on either side by a union bound,
# trimming at most `2 * _CONVOLVED_TAIL` of mass. Mirrors the exact
# inversion's starting guess in the Optimization extension.
@noinline function _window_quantile(d::Difference, p::Real)
    return _window_quantile(d.x, p) - _window_quantile(d.y, 1 - p)
end

# Integration window over Y. Both the density and CDF integrands carry the
# factor f_Y(y), negligible outside Y's effective support, so an infinite
# endpoint is clamped to an extreme quantile of Y on AD-stripped params
# (`_window_quantile`, shared with Convolved) so the window stays a
# non-differentiated constant across every AD backend. `float(...)` on
# the finite branch matches `_window_quantile`'s own `float(...)` wrap:
# `minimum`/`maximum` of a discrete `Y` is often `Int` while
# `_window_quantile` always returns `Float64`, and without matching
# types here the ternary would infer a `Union{Int, Float64}` result —
# the same class of union `_min2`/`_max2` guard against, and one Enzyme
# rejects outright on the exact discrete lattice fold.
function _difference_window(d::Difference)
    ymin = minimum(d.y)
    ymax = maximum(d.y)
    lo = isfinite(ymin) ? float(ymin) : _window_quantile(d.y, _CONVOLVED_TAIL)
    hi = isfinite(ymax) ? float(ymax) :
         _window_quantile(d.y, 1 - _CONVOLVED_TAIL)
    return lo, hi
end

# Numeric difference density:
#   f_Z(z) = ∫ f_X(z + y) f_Y(y) dy   over y ∈ support(Y).
# The quadrature is quantile-panelled on Y (`_panel_integrate`, shared
# with Convolved) so a heavy-tailed Y cannot stretch the window away
# from the integrand's mass (issue #49).
function _difference_numeric_pdf(d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))

    lower, upper = _difference_window(d)
    upper <= lower && return zero(float(typeof(z)))

    result = _solver_integrate(d,
        y -> pdf_ad_safe(d.x, z + y) * pdf_ad_safe(d.y, y),
        lower, upper, d.y)
    return max(result, zero(result))
end

# Numeric difference CDF:
#   F_Z(z) = P(X - Y ≤ z) = ∫ F_X(z + y) f_Y(y) dy   over y ∈ support(Y),
# quantile-panelled on Y like the density above (issue #49).
function _difference_numeric_cdf(d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))

    lower, upper = _difference_window(d)
    upper <= lower && return zero(float(typeof(z)))

    result = _solver_integrate(d,
        y -> cdf_ad_safe(d.x, z + y) * pdf_ad_safe(d.y, y),
        lower, upper, d.y)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# Exact discrete lattice cross-correlation (#85, #89)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_DiscreteDifference` (both `x` and `y`
# integer-lattice discrete). Exact fold over the SAME `_difference_window`
# the quadrature uses (Y's support, infinite ends clamped at the
# `_CONVOLVED_TAIL` quantiles — exact when Y is bounded, tail-clamped at
# ~1e-8 when Y is unbounded, e.g. `difference(Poisson, Poisson)`, which
# does not affect `is_exact`; see its docstring).

# f_Z(z) = Σ_{y ∈ lattice ∩ window} f_X(z + y) f_Y(y).
function _difference_lattice_pdf(d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    insupport(d, z) || return zero(float(typeof(z)))

    lo, hi = _difference_window(d)
    t0, t1 = _lattice_range(lo, hi)
    t1 < t0 && return zero(float(typeof(z)))

    return _lattice_sum(
        y -> pdf_ad_safe(d.x, z + y) * pdf_ad_safe(d.y, y), t0, t1)
end

# F_Z(z) = Σ_{y ∈ lattice ∩ window} F_X(z + y) f_Y(y).
function _difference_lattice_cdf(d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z < minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))

    lo, hi = _difference_window(d)
    t0, t1 = _lattice_range(lo, hi)
    t1 < t0 && return zero(float(typeof(z)))

    result = _lattice_sum(
        y -> cdf_ad_safe(d.x, z + y) * pdf_ad_safe(d.y, y), t0, t1)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# Mixed discrete/continuous fold (#115)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_MixedableDifference` whose `_mixed_slot`
# resolves to `Val(1)`/`Val(2)` (exactly one of `x`/`y` is
# integer-lattice discrete; see `_has_mixed_fold` above). Unlike
# `Convolved`, subtraction is not commutative, so the two argument
# orders reflect differently:
#
# - discrete MINUEND (`x = D`, slot 1): `Z = D - C`, so
#   `P(Z <= z) = P(C >= D - z) = Σ_k P(D=k) P(C >= k - z)`, the
#   complementary form `ccdf_C(k - z)`;
# - discrete SUBTRAHEND (`y = D`, slot 2): `Z = C - D`, so
#   `P(Z <= z) = P(C <= z + D) = Σ_k P(D=k) P(C <= z + k)`, the direct
#   form `cdf_C(z + k)`.
#
# Both densities are `Σ_k P(D=k) f_C(k - z)` (slot 1) /
# `Σ_k P(D=k) f_C(z + k)` (slot 2) -- the derivative of each cdf form
# above. The sum runs over D's own effective window
# (`_mixed_discrete_window`, shared with `Convolved`), so this is exact
# in the same sense the all-discrete fold is (see `is_exact`).

function _difference_mixed_pdf(::Val{1}, d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))
    D = d.x
    t0, t1 = _lattice_range(_mixed_discrete_window(D)...)
    t1 < t0 && return zero(float(typeof(z)))
    return _lattice_sum(
        k -> pdf_ad_safe(D, k) * pdf_ad_safe(d.y, k - z), t0, t1)
end
function _difference_mixed_pdf(::Val{2}, d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))
    D = d.y
    t0, t1 = _lattice_range(_mixed_discrete_window(D)...)
    t1 < t0 && return zero(float(typeof(z)))
    return _lattice_sum(
        k -> pdf_ad_safe(D, k) * pdf_ad_safe(d.x, z + k), t0, t1)
end
function _difference_mixed_pdf(::Nothing, d::Difference, z::Real)
    return _difference_numeric_pdf(d, z)
end

function _difference_mixed_cdf(::Val{1}, d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))
    D = d.x
    t0, t1 = _lattice_range(_mixed_discrete_window(D)...)
    t1 < t0 && return zero(float(typeof(z)))
    result = _lattice_sum(
        k -> pdf_ad_safe(D, k) * ccdf_ad_safe(d.y, k - z), t0, t1)
    return clamp(result, zero(result), one(result))
end
function _difference_mixed_cdf(::Val{2}, d::Difference, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))
    D = d.y
    t0, t1 = _lattice_range(_mixed_discrete_window(D)...)
    t1 < t0 && return zero(float(typeof(z)))
    result = _lattice_sum(
        k -> pdf_ad_safe(D, k) * cdf_ad_safe(d.x, z + k), t0, t1)
    return clamp(result, zero(result), one(result))
end
function _difference_mixed_cdf(::Nothing, d::Difference, z::Real)
    return _difference_numeric_cdf(d, z)
end

# Dispatch on the `Discrete` type parameter selects the exact lattice
# fold; `is_exact` (`src/interface.jl`) keys off the same
# `_exact_discrete_route` predicate, so reported and executed exactness
# cannot drift.
_difference_pdf_route(d::Difference, z::Real) = _difference_numeric_pdf(d, z)
_difference_pdf_route(d::_DiscreteDifference, z::Real) = _difference_lattice_pdf(d, z)
_difference_cdf_route(d::Difference, z::Real) = _difference_numeric_cdf(d, z)
_difference_cdf_route(d::_DiscreteDifference, z::Real) = _difference_lattice_cdf(d, z)

# Mixed route (#115): more specific than the bare `Difference` method
# above, so it wins for any `Continuous`-typed pair.
function _difference_pdf_route(d::_MixedableDifference, z::Real)
    return _difference_mixed_pdf(
        _mixed_slot(_component_support(typeof(d.x)),
            _component_support(typeof(d.y))), d, z)
end
function _difference_cdf_route(d::_MixedableDifference, z::Real)
    return _difference_mixed_cdf(
        _mixed_slot(_component_support(typeof(d.x)),
            _component_support(typeof(d.y))), d, z)
end

# ---------------------------------------------------------------------------
# CDF / logcdf / pdf / logpdf
# ---------------------------------------------------------------------------

@doc "

Compute the cumulative distribution function.

Uses the analytic `Normal`-`Normal` difference where it applies, otherwise
AD-safe numeric quadrature of ``\\int F_X(z + y) f_Y(y)\\,\\mathrm{d}y``.

See also: [`logcdf`](@ref)
"
function cdf(d::Difference, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return cdf(analytic, z)
    end
    return _difference_cdf_route(d, z)
end

@doc "

Compute the log cumulative distribution function.

See also: [`cdf`](@ref)
"
function logcdf(d::Difference, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logcdf(analytic, z)
    end
    c = _difference_cdf_route(d, z)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

function ccdf(d::Difference, z::Real)
    return 1 - cdf(d, z)
end

function logccdf(d::Difference, z::Real)
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

Uses the exact analytic `Normal`-`Normal` density where it applies,
otherwise the AD-safe numeric cross-correlation
``f_Z(z) = \\int f_X(z + y) f_Y(y)\\,\\mathrm{d}y``.

See also: [`logpdf`](@ref)
"
function pdf(d::Difference, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return pdf(analytic, z)
    end
    return _difference_pdf_route(d, z)
end

@doc "

Compute the log probability density function.

See also: [`pdf`](@ref), [`logcdf`](@ref)
"
function logpdf(d::Difference, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logpdf(analytic, z)
    end
    if !insupport(d, z)
        return oftype(float(z), -Inf)
    end
    p = _difference_pdf_route(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end

@doc "

Compute the quantile (inverse CDF) of the difference.

For a `Discrete`-typed difference, returns an exact integer lattice
point, with `p == 0`/`p == 1` always returning the bounds exactly.
Any other case needs the `ConvolvedDistributionsOptimizationExt`
extension loaded.

See also: [`cdf`](@ref)
"
function quantile(d::_DiscreteDifference, p::Real)
    boundary = p == 0 || p == 1
    (boundary || isfinite(minimum(d))) && return _lattice_quantile(d, p)
    return invoke(quantile, Tuple{Difference, Real}, d, p)
end
