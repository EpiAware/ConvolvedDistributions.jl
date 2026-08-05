@doc "

Distribution of a ratio of two independent random variables.

`Ratio` represents ``Z = X / Y`` where `X` (the numerator) and `Y` (the
denominator) are independent univariate distributions. It is the
quotient member of the family: where [`Convolved`](@ref) sums two
delays, [`Difference`](@ref) takes their signed gap, and [`Product`](@ref)
scales one by the other, a ratio divides one by the other, as when a
rate, a proportion, or a normalised measurement is formed from two
independent uncertain quantities.

`Y` may not carry probability mass at zero: the constructor throws an
`ArgumentError` naming the denominator's family otherwise. Subject to
that, either component may have two-sided support — unlike
[`Product`](@ref), a `Ratio` accepts a sign-crossing numerator or
denominator directly, splitting the quadrature at zero rather than
rejecting it (see *Density and CDF computation* below). The support of
`Z` is the interval quotient of the component supports (division by an
interval straddling zero gives all of ``\\mathbb{R}``).

Value support is `Continuous` unconditionally, including when both
components are discrete: the ratio of two integer-valued variables is
supported on the rationals, which is not a lattice, so a `Discrete`
declaration could not honour the `pdf`-as-probability-mass contract.

# Independence

The construction assumes `X` and `Y` are independent. The density, CDF,
mean and variance below all rely on this; they are not correct for
dependent components.

# Density and CDF computation

Conditioning on `Y = y` and differentiating gives

```math
f_Z(z) = \\int |y|\\, f_X(z y)\\, f_Y(y)\\, \\mathrm{d}y ,
\\qquad
F_Z(z) = \\int_{y > 0} F_X(z y)\\, f_Y(y)\\, \\mathrm{d}y +
         \\int_{y < 0} \\bar{F}_X(z y)\\, f_Y(y)\\, \\mathrm{d}y .
```

Unlike [`Product`](@ref)'s Mellin form, there is no `1/y` factor: the
`|y|` weight suppresses mass near `y = 0` instead of amplifying it, so
the density stays bounded even when `Y`'s own density diverges there
(`Gamma`/`Weibull` shape below one). The `y`-integration splits at zero
because `|y|` has a kink there and the map `y \\mapsto z y` flips
orientation across it. The density window is intersected with the
*effective* (quantile-clamped) support of `X`, since the integrand's
mass sits near `y \\approx (\\text{mass of } X) / z` and shrinks like
`1/z` as `z` grows — a window tied only to `Y`'s own mass would miss it
in the tails. The CDF uses a saturated constant plus a transition
integral (as [`Convolved`](@ref) does), with a control variate anchored
at the window endpoint nearest zero; this is exact algebra, applied
unconditionally, and is what keeps the CDF accurate when `Y`'s density
diverges at zero and `F_X(0) > 0`.

Three pairs have closed forms: `Normal(0, \\sigma_X)` /
`Normal(0, \\sigma_Y)` gives `Cauchy(0, \\sigma_X / \\sigma_Y)` (zero
means only — the general case has no elementary form); `Gamma` /
`Gamma` gives a scaled `BetaPrime`; `Chisq` / `Chisq` gives a scaled
`FDist`. All other cases use the same AD-safe fixed-node Gauss-Legendre
quadrature (`gl_integrate`) the rest of the package uses.

Differentiating the `Normal`/`Normal` pair exactly at zero means omits
the `\\partial/\\partial\\mu` term (the true density does depend on
`\\mu` there; the branch only checks `iszero(\\mu)`), the same hazard the
package's equal-scale `Gamma`+`Gamma` convolution already has. Pass
`method = NumericSolver()` to differentiate through a mean at zero.

The `method` field selects the backend: an [`AnalyticalSolver`](@ref)
(the default) uses the analytic ratio where one exists and falls back
to quadrature otherwise, while a [`NumericSolver`](@ref) forces the
numeric path even for an analytic pair (useful for validation).

# Nesting

A `Ratio` can be a component of another combination's numeric
quadrature only when both the numerator and the denominator are
non-negative (this includes the `Gamma`/`Gamma` and `Chisq`/`Chisq`
analytic pairs and any non-negative numeric pair, but not the two-sided
`Normal`/`Normal` pair). Outside that regime the ratio's tails are
Cauchy-like, so no cheap effective-support bound is conservative and
nesting throws an `ArgumentError` naming the offending component,
rather than silently narrowing the outer window. Used as the outermost
distribution, a `Ratio` has no such restriction.

# See also
- [`ratio`](@ref): Constructor function
- [`Convolved`](@ref): The sum ``X + Y``
- [`Difference`](@ref): The signed gap ``X - Y``
- [`Product`](@ref): The product ``X Y``
"
struct Ratio{X <: UnivariateDistribution, Y <: UnivariateDistribution,
    M <: AbstractSolverMethod} <:
       AbstractConvolvedDistribution{Distributions.Univariate, Continuous}
    "The numerator component (the `X` in `Z = X / Y`)."
    x::X
    "The denominator component (the `Y` in `Z = X / Y`)."
    y::Y
    "Solver method choosing the analytic vs numeric quadrature backend."
    method::M

    function Ratio(x::X, y::Y;
            method::AbstractSolverMethod = AnalyticalSolver()) where {
            X <: UnivariateDistribution, Y <: UnivariateDistribution}
        _check_denominator(y)
        new{X, Y, typeof(method)}(x, y, method)
    end
end

# Reject a denominator with probability mass at zero: an atom of a
# discrete distribution, or a degenerate point mass at zero (any
# distribution with minimum == maximum == 0). Z = X / Y is undefined on
# that event, so this is checked at construction (called from the inner
# constructor, so `Ratio(...)` cannot bypass it), matching `Product`'s
# construction-time rejection of sign-crossing supports.
function _check_denominator(y::UnivariateDistribution)
    atom = y isa DiscreteUnivariateDistribution && insupport(y, 0) &&
           pdf(y, 0) > 0
    degenerate = iszero(minimum(y)) && iszero(maximum(y))
    (atom || degenerate) && throw(ArgumentError(
        "ratio requires a denominator with no probability mass at " *
        "zero, but $(nameof(typeof(y))) puts mass there; Z = X / Y " *
        "is undefined on that event"))
    return nothing
end

@doc "

Create the distribution of a ratio of two independent variables.

Returns a [`Ratio`](@ref) representing ``Z = X / Y``, the quotient
member of the family: where [`convolved`](@ref) sums two delays,
[`difference`](@ref) takes their signed gap, and [`product`](@ref)
scales one by the other, a ratio divides one by the other. `Y` must not
carry probability mass at zero (`ArgumentError`, naming the family,
otherwise); either component may otherwise have two-sided support.

`X` and `Y` are assumed independent.

# Arguments
- `x`: The numerator distribution (the `X` in `Z = X / Y`), a
  `UnivariateDistribution`.
- `y`: The denominator distribution (the `Y` in `Z = X / Y`), a
  `UnivariateDistribution` with no probability mass at zero.

# Keyword Arguments
- `method`: The solver method, an [`AnalyticalSolver`](@ref) (the
  default) or [`NumericSolver`](@ref). `NumericSolver` forces numeric
  quadrature even for an analytic pair, mirroring `convolved`.
- `strict`: When `true`, error (naming the component families) rather
  than silently return an object whose density/CDF would fall back to
  quadrature. `false` by default. See [`evaluation_path`](@ref) to check
  the route after construction instead of asserting it up front.

# Returns
- A [`Ratio`](@ref) distribution of the quotient `Z = X / Y`.

# Examples
```@example
using ConvolvedDistributions, Distributions

# A rate: an independent count divided by an independent exposure time.
d = ratio(Gamma(3.0, 1.0), Gamma(2.0, 1.0))
mean(d)
```

# See also
- [`Ratio`](@ref): The distribution type
- [`convolved`](@ref): The sum ``X + Y``
- [`difference`](@ref): The signed gap ``X - Y``
- [`product`](@ref): The product ``X Y``
- [`evaluation_path`](@ref): Check the route without asserting it.
"
function ratio(x::UnivariateDistribution, y::UnivariateDistribution;
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false)
    return _check_strict(Ratio(x, y; method = method), strict)
end

# The component-family names for a `strict = true` construction error
# (see `_check_strict` in interface.jl).
_family_names(d::Ratio) = (nameof(typeof(d.x)), nameof(typeof(d.y)))

# ---------------------------------------------------------------------------
# Interface: params / support / sampling
# ---------------------------------------------------------------------------

params(d::Ratio) = (params(d.x), params(d.y))

# Wraps `float` (unlike `Product`'s `eltype`): the value support is
# Continuous even for two integer-valued components, and an `Int` eltype
# would make `rand(rng, d, n)` allocate a container that cannot hold the
# quotient.
function Base.eltype(::Type{<:Ratio{X, Y}}) where {X, Y}
    return float(promote_type(eltype(X), eltype(Y)))
end

# Guard the indeterminate 0 * Inf = NaN, exactly as `maximum(d::Product)`
# does: a zero endpoint paired with an unbounded one gives 0, not NaN.
_ratio_bound(u, v) = (iszero(u) || iszero(v)) ? zero(u) * zero(v) : u * v

# The reciprocal interval 1/Y, by cases on where the denominator's
# support sits relative to zero (`_check_denominator` has already ruled
# out a denominator confined to {0}). An end straddling zero maps to an
# infinite reciprocal end.
function _ratio_reciprocal_interval(ymin, ymax)
    if ymin > 0 || ymax < 0
        return 1 / ymax, 1 / ymin
    elseif iszero(ymin) && ymax > 0
        return 1 / ymax, oftype(1 / ymax, Inf)
    elseif iszero(ymax) && ymin < 0
        return oftype(1 / ymin, -Inf), 1 / ymin
    else
        return oftype(1 / ymin, -Inf), oftype(1 / ymax, Inf)
    end
end

# The support of Z = X / Y is the min/max of the four corner products of
# X's support with the reciprocal interval of Y's support (interval
# division, reciprocal first): monotone in each factor once the
# reciprocal interval is known, so the extremes of Z occur at some
# combination of the extremes of X and of 1/Y.
function _ratio_corners(d::Ratio)
    xmin, xmax = minimum(d.x), maximum(d.x)
    rlo, rhi = _ratio_reciprocal_interval(minimum(d.y), maximum(d.y))
    return _ratio_bound(xmin, rlo), _ratio_bound(xmin, rhi),
    _ratio_bound(xmax, rlo), _ratio_bound(xmax, rhi)
end

function minimum(d::Ratio)
    c1, c2, c3, c4 = _ratio_corners(d)
    return _min2(_min2(c1, c2), _min2(c3, c4))
end

function maximum(d::Ratio)
    c1, c2, c3, c4 = _ratio_corners(d)
    return _max2(_max2(c1, c2), _max2(c3, c4))
end

function insupport(d::Ratio, z::Real)
    return minimum(d) <= z <= maximum(d)
end

function Base.rand(rng::AbstractRNG, d::Ratio)
    return rand(rng, d.x) / rand(rng, d.y)
end

sampler(d::Ratio) = d

# ---------------------------------------------------------------------------
# Moments: no honest exact algebra in general
# ---------------------------------------------------------------------------
#
# E[X / Y] = E[X] E[1/Y] under independence, but the inverse moment of the
# denominator is not generally available and need not exist (it diverges
# whenever f_Y(0) > 0), so there is nothing to copy from Product's exact
# independent-moment algebra. Delegation is keyed on `_try_ratio(d.x, d.y)`,
# not `_maybe_analytic(d)`: NumericSolver selects the density/CDF route and
# says nothing about whether a moment exists.

# The analytic ratio distribution to delegate `mean`/`var`/`std` to, or an
# error naming the component families when none exists.
function _ratio_moment_source(d::Ratio)
    analytic = _try_ratio(d.x, d.y)
    analytic === nothing && throw(ArgumentError(
        "mean(Ratio) has no closed form for components " *
        "$(_family_names(d)): E[X / Y] = E[X] E[1/Y] needs an inverse " *
        "moment of the denominator, which this package does not " *
        "compute and which need not exist; the analytic pairs " *
        "(zero-mean Normal/Normal, Gamma/Gamma, Chisq/Chisq) delegate " *
        "to their closed form instead"))
    return analytic
end

@doc "

Mean of the ratio, delegating to the analytic ratio distribution's own
mean (`NaN` for the zero-mean `Normal`/`Normal` pair, since its ratio is
`Cauchy`). Throws an `ArgumentError` naming the component families when
no analytic ratio exists: `E[X / Y] = E[X] E[1/Y]` needs an inverse
moment of the denominator, which is not generally available.

See also: [`var`](@ref), [`std`](@ref)
"
mean(d::Ratio) = mean(_ratio_moment_source(d))

@doc "

Variance of the ratio, delegating to the analytic ratio distribution's
own variance. See [`mean`](@ref) for when this throws.

See also: [`mean`](@ref), [`std`](@ref)
"
var(d::Ratio) = var(_ratio_moment_source(d))

@doc "

Standard deviation of the ratio, delegating to the analytic ratio
distribution's own standard deviation. See [`mean`](@ref) for when this
throws.

See also: [`var`](@ref), [`mean`](@ref)
"
std(d::Ratio) = std(_ratio_moment_source(d))

# ---------------------------------------------------------------------------
# Analytical fast paths
# ---------------------------------------------------------------------------

# `_try_ratio` returns the analytic ratio distribution when a closed form
# exists, otherwise `nothing`. Dispatch (rather than `try`/`catch`)
# selects the analytic pair so the path stays differentiable under every
# AD backend.
_try_ratio(x::UnivariateDistribution, y::UnivariateDistribution) = nothing

# Normal(0, σx) / Normal(0, σy) ~ Cauchy(0, σx / σy). Only the zero-mean
# case is analytic: the general Marsaglia-Hinkley density has no
# elementary closed form and no `Distributions.jl` type, so non-zero
# means stay on the numeric path. Branching on `iszero(μ)` is
# parameter-value dependent; see the `Ratio` docstring for the resulting
# AD hazard exactly at zero means.
function _try_ratio(x::Normal, y::Normal)
    μx, σx = params(x)
    μy, σy = params(y)
    (iszero(μx) && iszero(μy)) || return nothing
    return Cauchy(zero(σx / σy), σx / σy)
end

# Gamma(αx, θx) / Gamma(αy, θy) ~ (θx / θy) * BetaPrime(αx, αy). Unequal
# scales are supported (unlike `_try_convolve(::Gamma, ::Gamma)`, which
# needs equal scales) since the scale ratio simply factors out. The
# affine wrapper is returned even when θx == θy so the return type stays
# value-independent.
function _try_ratio(x::Gamma, y::Gamma)
    αx, θx = params(x)
    αy, θy = params(y)
    return (θx / θy) * BetaPrime(αx, αy)
end

# Chisq(ν1) / Chisq(ν2) ~ (ν1 / ν2) * FDist(ν1, ν2). Registered
# separately from the Gamma rule because Chisq is its own Distributions.jl
# type; equivalent to it since Chisq(ν) == Gamma(ν / 2, 2) and the scales
# cancel in the Gamma rule above.
function _try_ratio(x::Chisq, y::Chisq)
    νx, = params(x)
    νy, = params(y)
    return (νx / νy) * FDist(νx, νy)
end

# The analytic ratio to use for `d`, or `nothing` when none exists or
# when `d.method` is a `NumericSolver` requesting the numeric path.
function _maybe_analytic(d::Ratio)
    d.method isa NumericSolver && return nothing
    return _try_ratio(d.x, d.y)
end

# ---------------------------------------------------------------------------
# Numeric quadrature: windows
# ---------------------------------------------------------------------------

# Effective (quantile-clamped, AD-stripped) support of the numerator. An
# infinite end is replaced by an extreme quantile of X, trimming at most
# `_CONVOLVED_TAIL` of X's mass per side, exactly as `_finite_window` does
# for the integration component in `Convolved`. The integrand's mass sits
# at y ~ (mass of X) / z, which moves with z and shrinks like 1/z, so
# narrowing against X (not just Y) is what keeps the far-tail CDF/PDF
# accurate (§4.2 of the design note; the central numerical difference
# from `Product`).
function _ratio_x_window(d::Ratio)
    xmin = minimum(d.x)
    xmax = maximum(d.x)
    lo = isfinite(xmin) ? xmin : _window_quantile(d.x, _CONVOLVED_TAIL)
    hi = isfinite(xmax) ? xmax : _window_quantile(d.x, 1 - _CONVOLVED_TAIL)
    return lo, hi
end

# Effective support of the denominator, split at zero into the negative
# and positive branches (a branch with `hi <= lo` is empty). Unlike
# `_product_mass_window` a zero endpoint is NOT nudged: the `|y|` factor
# in the density (and the boundedness of F_X/ccdf_X in the CDF) leaves
# the integrand bounded there, so there is no singularity to avoid.
function _ratio_y_branches(d::Ratio)
    ymin = minimum(d.y)
    ymax = maximum(d.y)
    lo = isfinite(ymin) ? ymin : _window_quantile(d.y, _CONVOLVED_TAIL)
    hi = isfinite(ymax) ? ymax : _window_quantile(d.y, 1 - _CONVOLVED_TAIL)
    neg = (lo, _min2(hi, zero(hi)))
    pos = (_max2(lo, zero(lo)), hi)
    return neg, pos
end

# Density integration window for one branch `(a, b)` of constant sign:
# the branch intersected with the range where z * y lands in the
# numerator's effective support `[xlo, xhi]`.
function _ratio_pdf_window(a, b, z::Real, xlo, xhi)
    b <= a && return (a, a)
    if iszero(z)
        # z * y = 0 for every y on the branch: the numerator factor is
        # constant, so the window is either the whole branch or empty.
        return (xlo <= 0 <= xhi) ? (a, b) : (a, a)
    end
    l = xlo / z
    h = xhi / z
    lower = _max2(a, _min2(l, h))     # min/max: z < 0 flips the interval
    upper = _min2(b, _max2(l, h))
    upper <= lower && return (lower, lower)
    return (lower, upper)
end

# CDF window for one branch: the transition bounds `(lower, upper)` where
# the kernel (`F_X` on the y > 0 branch, `ccdf_X` on y < 0) is neither
# saturated nor zero, and `(sat_lo, sat_hi)`, the sub-interval of the
# branch where the kernel is exactly 1 (the saturated mass, added as a
# closed-form constant). `l, h = minmax(xlo / z, xhi / z)` are the
# y-values where z * y crosses the numerator's effective support ends;
# which side saturates depends on whether the branch sign matches the
# sign of z (see the design note's table).
function _ratio_cdf_window(is_pos::Bool, a, b, z::Real, xlo, xhi)
    l, h = minmax(xlo / z, xhi / z)
    lower = _max2(a, l)
    upper = _min2(b, h)
    if is_pos == (z > 0)
        sat_lo, sat_hi = _max2(a, h), b
    else
        sat_lo, sat_hi = a, _min2(b, l)
    end
    return lower, upper, sat_lo, sat_hi
end

# ---------------------------------------------------------------------------
# Numeric quadrature: integration
# ---------------------------------------------------------------------------

# Integrate one branch, returning a typed zero when the window is empty.
# Deliberately `zero(lower)`, NOT `zero(f(lower))`: an empty branch's
# `lower` is always the y = 0 boundary (Y has no mass on that side), and
# calling the integrand there evaluates a differentiated component's
# density (`pdf_ad_safe(d.x, ...)` or `pdf_ad_safe(d.y, 0)`) exactly at
# its own support edge. The density value is a clean 0 there (checked:
# shape > 1 Gamma numerator/denominator), but reverse-mode backends
# (ReverseDiff) cache a local partial for the underlying `x^(shape - 1)`
# term that involves `log(0) = -Inf`, and `0 * -Inf = NaN` survives the
# outer `zero(...)` wrapping even though `zero(::Dual)` (ForwardDiff)
# discards it cleanly -- confirmed by direct comparison, not asserted.
# `lower` itself never touches that computation (it is a window bound
# built from `_window_quantile`-stripped or literal-support values), so
# seeding from it side-steps the hazard while still carrying a live
# `Dual`/tracked type on the rare window whose bound is itself a
# differentiated parameter (e.g. a `Uniform` denominator's own bound).
function _ratio_branch(f::F, lower, upper, comp) where {F}
    upper <= lower && return zero(lower)
    return _panel_integrate(f, lower, upper, comp)
end

# Numeric ratio density:
#   f_Z(z) = ∫ |y| f_X(z y) f_Y(y) dy   split into the y > 0 / y < 0
# branches of the denominator, each windowed against the numerator's
# effective support (`_ratio_pdf_window`).
function _ratio_numeric_pdf(d::Ratio, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    (z <= minimum(d) || z >= maximum(d)) && return zero(float(typeof(z)))
    xlo, xhi = _ratio_x_window(d)
    neg, pos = _ratio_y_branches(d)
    integrand = y -> abs(y) * pdf_ad_safe(d.x, z * y) *
                     pdf_ad_safe(d.y, y)
    nl, nu = _ratio_pdf_window(neg[1], neg[2], z, xlo, xhi)
    pl, pu = _ratio_pdf_window(pos[1], pos[2], z, xlo, xhi)
    result = _ratio_branch(integrand, nl, nu, d.y) +
             _ratio_branch(integrand, pl, pu, d.y)
    return max(result, zero(result))
end

# Integrate one branch of the CDF: a saturated constant term (the mass
# of Y where the kernel is exactly 1) plus the transition integral with
# the control variate anchored at the transition window's endpoint
# nearest zero (`c = kernel(z * y_near)`):
#   c * (F_Y(upper) - F_Y(lower)) + ∫_lower^upper (kernel(z y) - c) f_Y(y) dy
# This is exact algebra, applied unconditionally so there is one code
# path; it matters when Y's density diverges at y = 0 and F_X(0) > 0,
# where the raw integrand has an integrable singularity a fixed-node
# rule cannot resolve, but subtracting the constant `c` leaves a
# resolvable O(|y|^{1-a}) integrand.
function _ratio_branch_cdf(d::Ratio, is_pos::Bool, a, b, z::Real, xlo, xhi)
    T = float(promote_type(typeof(z), typeof(a), typeof(b)))
    b <= a && return zero(T)

    lower, upper, sat_lo, sat_hi = _ratio_cdf_window(is_pos, a, b, z, xlo, xhi)
    sat = sat_hi > sat_lo ?
          cdf_ad_safe(d.y, sat_hi) - cdf_ad_safe(d.y, sat_lo) : zero(T)

    upper <= lower && return sat

    kernel = is_pos ? (y -> cdf_ad_safe(d.x, z * y)) :
             (y -> ccdf_ad_safe(d.x, z * y))
    y_near = abs(lower) <= abs(upper) ? lower : upper
    c = kernel(y_near)
    base = c * (cdf_ad_safe(d.y, upper) - cdf_ad_safe(d.y, lower))
    cv = _ratio_branch(
        y -> (kernel(y) - c) * pdf_ad_safe(d.y, y), lower, upper, d.y)
    return sat + base + cv
end

# Numeric ratio CDF, split into the y > 0 (kernel F_X) and y < 0 (kernel
# ccdf_X) branches. `z = 0` is special-cased before any division (the
# window arithmetic above divides by z): the kernel is constant on each
# branch there, so F_Z(0) = F_X(0) P(Y > 0) + ccdf_X(0) P(Y < 0) exactly,
# no quadrature needed.
function _ratio_numeric_cdf(d::Ratio, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z <= minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))

    neg, pos = _ratio_y_branches(d)

    if iszero(z)
        fx0 = cdf_ad_safe(d.x, zero(z))
        gx0 = ccdf_ad_safe(d.x, zero(z))
        pos_mass = pos[2] > pos[1] ?
                   cdf_ad_safe(d.y, pos[2]) - cdf_ad_safe(d.y, pos[1]) :
                   zero(fx0)
        neg_mass = neg[2] > neg[1] ?
                   cdf_ad_safe(d.y, neg[2]) - cdf_ad_safe(d.y, neg[1]) :
                   zero(fx0)
        result = fx0 * pos_mass + gx0 * neg_mass
        return clamp(result, zero(result), one(result))
    end

    xlo, xhi = _ratio_x_window(d)
    result = _ratio_branch_cdf(d, true, pos[1], pos[2], z, xlo, xhi) +
             _ratio_branch_cdf(d, false, neg[1], neg[2], z, xlo, xhi)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# Nesting: composite window quantile (issue #45 style)
# ---------------------------------------------------------------------------

# `Ratio` with a numerator confined to `[0, Inf)` and a denominator
# confined to `[0, Inf)` is monotone (increasing in X, decreasing in Y),
# so pairing `p` in the numerator with `1 - p` in the denominator bounds
# the ratio quantile by a union bound, trimming at most
# `2 * _CONVOLVED_TAIL` — the multiplicative analogue of
# `_window_quantile(::Difference, p)` (subtraction pairs opposing tails;
# division does the same). The denominator's infimum may be exactly
# zero (e.g. `Gamma`, `Chisq`): `_check_denominator` already forbids any
# probability mass sitting at zero, so `_window_quantile(d.y, 1 - p)`
# for `p` bounded away from `1` is finite and strictly positive, and the
# union bound still holds (it is only wider than the strictly-positive
# case, never wrong). Outside `minimum(d.x) >= 0 && minimum(d.y) >= 0`
# the tails are Cauchy-like and no cheap quantile bound is conservative,
# so this throws rather than silently corrupting an outer combination's
# window (only relevant when `d` is nested as a component of another
# combination's numeric quadrature; used as the outermost distribution
# it is unaffected).
@noinline function _window_quantile(d::Ratio, p::Real)
    (minimum(d.x) >= 0 && minimum(d.y) >= 0) || _throw_ratio_window(d)
    return _window_quantile(d.x, p) / _window_quantile(d.y, 1 - p)
end

function _throw_ratio_window(d::Ratio)
    throw(ArgumentError(
        "a Ratio with numerator $(nameof(typeof(d.x))) reaching below " *
        "zero, or denominator $(nameof(typeof(d.y))) reaching below " *
        "zero, has no cheap effective-support bound, so it cannot be a " *
        "component of another combination's numeric quadrature; use a " *
        "non-negative numerator with a non-negative denominator, or " *
        "place the ratio outermost"))
end

# ---------------------------------------------------------------------------
# CDF / logcdf / pdf / logpdf
# ---------------------------------------------------------------------------

@doc "

Compute the cumulative distribution function.

Uses the analytic ratio where one applies, otherwise AD-safe numeric
quadrature split into the `Y > 0` / `Y < 0` branches (see the `Ratio`
docstring's *Density and CDF computation* section).

See also: [`logcdf`](@ref)
"
function cdf(d::Ratio, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return cdf(analytic, z)
    end
    return _ratio_numeric_cdf(d, z)
end

@doc "

Compute the log cumulative distribution function.

See also: [`cdf`](@ref)
"
function logcdf(d::Ratio, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logcdf(analytic, z)
    end
    c = _ratio_numeric_cdf(d, z)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

function ccdf(d::Ratio, z::Real)
    return 1 - cdf(d, z)
end

function logccdf(d::Ratio, z::Real)
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

Uses the exact analytic ratio density where one applies, otherwise the
AD-safe numeric quadrature ``f_Z(z) = \\int |y| f_X(z y) f_Y(y)
\\,\\mathrm{d}y``.

See also: [`logpdf`](@ref)
"
function pdf(d::Ratio, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return pdf(analytic, z)
    end
    return _ratio_numeric_pdf(d, z)
end

@doc "

Compute the log probability density function.

See also: [`pdf`](@ref), [`logcdf`](@ref)
"
function logpdf(d::Ratio, z::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logpdf(analytic, z)
    end
    if !insupport(d, z)
        return oftype(float(z), -Inf)
    end
    p = _ratio_numeric_pdf(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end
