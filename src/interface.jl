# ============================================================================
# Abstract type hierarchy: the multi-base algebraic-combination family
# ============================================================================
#
# Mirrors the CensoredDistributions.jl family model: related concrete types
# share one supertype, and the documented interface contract plus any shared
# behaviour hang off the abstract. This package has a single family — the
# algebraic combinations `Convolved`, `Difference`, and `Product` — so one
# abstract type carries the contract that a future member (e.g. a min/max
# order statistic) implements and `TestUtils.test_convolved_interface`
# verifies.

@doc "

Supertype of the distributions of `X op Y` for independent components —
the generalised convolutions. [`Convolved`](@ref) is the classical sum,
[`Difference`](@ref) the reflected form (`Z = X - Y`), and
[`Product`](@ref) the Mellin form (`Z = X * Y`); further operations
(order statistics) fit the same family.

Parametric on variate form and value support (`Distribution{F, S}`), so
the univariate members stay `UnivariateDistribution`s and existing
dispatch is unchanged. `S` is DERIVED from a member's own components via
`ConvolvedDistributions._components_support`: `Discrete` when every
component is an integer-lattice discrete distribution (discrete with
`eltype <: Integer`), `Continuous` otherwise — never hardcoded. A member
typed `Discrete` MUST provide an exact route for its density and CDF,
because [`is_exact`](@ref) reports exactness from the `S` type parameter
alone; a `Discrete`-typed member with no exact route makes that report a
lie.

Required of a concrete subtype:

- `params(d)`;
- `logpdf(d, x)` finite on its support;
- `Base.show(io, d)`.

Verify a subtype with
`ConvolvedDistributions.TestUtils.test_convolved_interface`, and family
membership with `ConvolvedDistributions.TestUtils.test_abstract_membership`.

# See also
- [`Convolved`](@ref), [`Difference`](@ref),
  [`Product`](@ref): the concrete members.
- `ConvolvedDistributions.TestUtils`: the interface verifiers for a new
  subtype.
"
abstract type AbstractConvolvedDistribution{F <: Distributions.VariateForm,
    S <: Distributions.ValueSupport} <: Distributions.Distribution{F, S} end

# ---------------------------------------------------------------------------
# Derived value support (#85)
# ---------------------------------------------------------------------------
#
# A member's `S` type parameter is DERIVED from its components rather than
# hardcoded: `Discrete` only when every component is discrete AND
# integer-supported (`eltype <: Integer`), `Continuous` otherwise. A
# discrete component on a non-integer grid (e.g. a `DiscreteNonParametric`
# on halves) reports `Continuous`: the exact discrete routes below scan the
# integer lattice, and typing a combination `Discrete` with no route that
# can actually evaluate it is exactly what #85 was about (a discrete⊛discrete
# combination mistyped `Continuous` and silently zeroed under quadrature —
# the inverse failure mode). See #117 for extending the exact route to a
# non-integer grid. Dispatch (not a runtime `if`) computes this so
# it folds to a compile-time constant inside each inner constructor; see
# Risk 1 in the PR description for why that matters (`@code_warntype`/JET).

function _component_support(::Type{D}) where {D <: UnivariateDistribution}
    return _component_support(
        Distributions.value_support(D), Base.eltype(D))
end
_component_support(::Type{Discrete}, ::Type{<:Integer}) = Discrete
_component_support(::Type{<:Distributions.ValueSupport}, ::Type) = Continuous

# Any continuous (or non-integer-lattice discrete) component makes the
# combination continuous.
_combine_support(::Type{Discrete}, ::Type{Discrete}) = Discrete
function _combine_support(
        ::Type{<:Distributions.ValueSupport}, ::Type{<:Distributions.ValueSupport})
    return Continuous
end

_components_support(c::Tuple{Any}) = _component_support(typeof(c[1]))
function _components_support(c::Tuple)
    return _combine_support(_component_support(typeof(c[1])),
        _components_support(Base.tail(c)))
end

# Whether the exact discrete route (the additive lattice fold in
# `src/lattice.jl`, or the `Product` divisor fold) is available for `d`:
# exactly when `d`'s value-support parameter is `Discrete`, which (by
# `_component_support` above) means every component is an integer-lattice
# discrete distribution. This is the SAME predicate `is_exact` reads below
# and the route functions (`_convolved_pdf_route` and its `Difference`/
# `Product` counterparts) dispatch on, so a reported exactness can never
# drift from the route actually executed.
_exact_discrete_route(::AbstractConvolvedDistribution) = false
function _exact_discrete_route(
        ::AbstractConvolvedDistribution{<:Distributions.VariateForm, Discrete})
    return true
end

# Off-lattice points carry no mass on a discrete combination; the concrete
# `insupport` methods gate on this before the range check, so (for example)
# `insupport(convolved(Poisson(2.0), Poisson(3.0)), 2.5)` is `false`.
_on_lattice(::AbstractConvolvedDistribution, ::Real) = true
function _on_lattice(
        ::AbstractConvolvedDistribution{<:Distributions.VariateForm, Discrete},
        x::Real)
    return isinteger(x)
end

# ---------------------------------------------------------------------------
# Queryable evaluation path (#92): no silent numeric fallback
# ---------------------------------------------------------------------------
#
# `evaluation_path`/`has_closed_form` answer per quantity without
# evaluating it. For a two-component `Convolved` this is method lookup
# (`_has_analytic_route`, solver_dispatch.jl) plus the same
# `_try_convolve` check the `AnalyticalSolver` generic itself runs
# (S2.3/S4.1) -- checking whether the analytic distribution can be built
# is not evaluating the quantity. Every other case (three or more
# components, `Difference`, `Product`) answers via `_maybe_analytic`,
# unchanged from before this file's rewrite. Recursion through nesting
# falls out for free: a nested combination only matches a component-typed
# analytic method when it names a leaf distribution, so a nested
# `Convolved`/`Difference`/`Product` component falls through to
# `:numeric`, exactly mirroring what evaluation does.

# Whether `d` has an exact route for quantity function `f`, without
# evaluating `f`. The generic fallback (three-or-more components,
# `Difference`, `Product`) reuses each type's own `_maybe_analytic`; the
# `Convolved` two-component method lives in solver_dispatch.jl, after
# `Convolved`'s struct definition.
function _is_analytic(d::AbstractConvolvedDistribution, f)
    return _maybe_analytic(d) !== nothing
end

@doc "

Report which route `d` will take for `quantities`, without evaluating
any of them: `:analytic` when every quantity in `quantities` has an
exact closed form, `:numeric` otherwise. `quantities` is a single
Distributions.jl generic (e.g. `cdf`) or a tuple of them, defaulting to
`(pdf, cdf)` — density and CDF both exact, the route `strict = true`
demands.

`:numeric` covers two different underlying routes: Gauss-Legendre
quadrature for a continuous combination, and the exact discrete fold
(`src/lattice.jl`, or the `Product` divisor fold) for an all-discrete
integer-lattice combination. `evaluation_path` does not distinguish
them — widening its two-valued contract would break downstream code
that branches on it (#92) — so use [`is_exact`](@ref) when the
distinction matters (whether evaluating `d` carries any quadrature
error at all).

Recurses through nesting: a combination with any non-analytic component
(including a nested [`Convolved`](@ref)/[`Difference`](@ref)/[`Product`](@ref)
using [`NumericSolver`](@ref), or one with no matching closed form)
reports `:numeric`, since evaluating it falls back to quadrature
somewhere in the recursion.

# Arguments
- `d`: The combination to report the route for.
- `quantities`: A quantity (e.g. `cdf`) or tuple of them; default
  `(pdf, cdf)`.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Normal + Normal has an analytic convolution
d = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
ConvolvedDistributions.evaluation_path(d)

# Gamma + Uniform has an exact cdf and pdf but no analytic convolution
dg = convolved(Gamma(2.0, 1.0), Uniform(0.0, 2.0))
ConvolvedDistributions.evaluation_path(dg, cdf)

# Gamma + LogNormal has no closed form for either quantity
dn = convolved(Gamma(2.0, 1.0), LogNormal(1.5, 0.5))
ConvolvedDistributions.evaluation_path(dn)
```

# See also
- [`has_closed_form`](@ref): the boolean convenience form.
- [`is_exact`](@ref): whether evaluation carries any quadrature error.
"
function evaluation_path(d::AbstractConvolvedDistribution,
        quantities = (pdf, cdf))
    qs = quantities isa Tuple ? quantities : (quantities,)
    return all(f -> _is_analytic(d, f), qs) ? :analytic : :numeric
end

@doc "

Whether `d` has an exact closed form for `quantities` —
`evaluation_path(d, quantities) === :analytic`. `quantities` defaults
to `(pdf, cdf)`, as for [`evaluation_path`](@ref).

# Arguments
- `d`: The combination to report the route for.
- `quantities`: A quantity (e.g. `cdf`) or tuple of them; default
  `(pdf, cdf)`.

# Examples
```@example
using ConvolvedDistributions, Distributions

d = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
ConvolvedDistributions.has_closed_form(d)
```

# See also
- [`evaluation_path`](@ref): the full `:analytic`/`:numeric` predicate.
- [`is_exact`](@ref): true for a closed form OR an exact discrete fold.
"
has_closed_form(d::AbstractConvolvedDistribution, quantities = (
    pdf, cdf)) = evaluation_path(d, quantities) === :analytic

@doc "

Whether evaluating `d`'s density and CDF carries no quadrature error.

`evaluation_path` and `is_exact` answer orthogonal questions — which
route, and whether that route is exact — so together they form a 2x2:

| | exact | inexact |
|---|---|---|
| `:analytic` | closed form | — |
| `:numeric` | discrete fold | Gauss-Legendre |

`is_exact(d) = has_closed_form(d) || ` [exact discrete route], where the
exact-discrete-route predicate is the SAME one the `Convolved`/
`Difference`/`Product` route functions dispatch on (`d`'s value-support
type parameter is `Discrete`), so the reported exactness cannot drift
from what evaluation actually does — the same no-drift discipline
[`evaluation_path`](@ref) keeps.

Tail clamping does not count as inexact. When a component is unbounded
(e.g. a `Difference` of two count distributions, unbounded below), the
discrete fold's window is clamped at the `_CONVOLVED_TAIL` quantile,
trimming roughly `1e-8` of mass — identical to the clamp the continuous
quadrature paths already apply. `is_exact` means \"no quadrature error\",
not \"no approximation whatsoever\"; window clamping is a separate,
documented approximation that applies equally on both routes, so it does
not flip `is_exact` to `false`.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Closed form: exact.
is_exact(convolved(Normal(0.0, 1.0), Normal(1.0, 2.0)))

# No closed form, but both components are integer-lattice discrete: the
# exact lattice fold replaces quadrature, so this is exact too.
is_exact(convolved(Poisson(1.0), Geometric(0.3)))

# No closed form and a continuous component: Gauss-Legendre, inexact.
is_exact(convolved(Gamma(2.0, 1.0), LogNormal(1.5, 0.5)))
```

# See also
- [`evaluation_path`](@ref): which route (`:analytic`/`:numeric`).
- [`has_closed_form`](@ref): the closed-form-only predicate.
"
function is_exact(d::AbstractConvolvedDistribution)
    return has_closed_form(d) || _exact_discrete_route(d)
end

# The component-family names named in a `strict = true` construction
# error, one method per concrete type (each knows its own fields):
# `_family_names(d::Convolved)` in Convolved.jl, `_family_names(d::Difference)`
# in Difference.jl, `_family_names(d::Product)` in Product.jl.

# Shared strict-construction check: called by each type's outer
# constructor function (`convolved`/`difference`/`product`) after
# building `d`. Errors, naming the component families, rather than
# silently returning an object that would fall back to quadrature —
# `strict = true` promises an exact route (#92), and gates on
# `is_exact`, NOT `evaluation_path`, so the exact discrete fold (which
# reports `:numeric`) is accepted rather than wrongly rejected.
function _check_strict(d::AbstractConvolvedDistribution, strict::Bool)
    strict || return d
    is_exact(d) && return d
    throw(ArgumentError(
        "$(nameof(typeof(d)))(...; strict = true) requires an exact " *
        "route (a closed form or the exact discrete fold), but no exact " *
        "route exists for components $(_family_names(d)); pass strict " *
        "= false to allow quadrature"))
end
