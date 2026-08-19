# ============================================================================
# Abstract type hierarchy: the multi-base algebraic-combination family
# ============================================================================
#
# Mirrors the CensoredDistributions.jl family model: related concrete types
# share one supertype, and the documented interface contract plus any shared
# behaviour hang off the abstract. This package has a single family — the
# algebraic combinations `Convolved`, `Difference`, `Product`, and `Ratio` —
# so one abstract type carries the contract that a future member (e.g. a
# min/max order statistic) implements and `TestUtils.test_convolved_interface`
# verifies.

@doc "

Supertype of the distributions of `X op Y` for independent components —
the generalised convolutions. [`Convolved`](@ref) is the classical sum,
[`Difference`](@ref) the reflected form (`Z = X - Y`), [`Product`](@ref)
the Mellin form (`Z = X * Y`), and [`Ratio`](@ref) the Mellin-quotient
form (`Z = X / Y`); further operations (order statistics) fit the same
family.

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
- [`Convolved`](@ref), [`Difference`](@ref), [`Product`](@ref),
  [`Ratio`](@ref): the concrete members.
- `ConvolvedDistributions.TestUtils`: the interface verifiers for a new
  subtype.
"
abstract type AbstractConvolvedDistribution{
    F <: Distributions.VariateForm,
    S <: Distributions.ValueSupport,
} <: Distributions.Distribution{F, S} end

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
        Distributions.value_support(D), Base.eltype(D)
    )
end
_component_support(::Type{Discrete}, ::Type{<:Integer}) = Discrete
_component_support(::Type{<:Distributions.ValueSupport}, ::Type) = Continuous

# A duck-typed component (implements the interface below `convolved`
# calls on it, without subtyping `UnivariateDistribution`) has no
# `Distributions.value_support` to read. Support is derived from
# `eltype` alone, the same integer-lattice rule the two-argument method
# above applies once a value support is known.
_component_support(::Type{D}) where {D} = _duck_component_support(Base.eltype(D))
_duck_component_support(::Type{<:Integer}) = Discrete
_duck_component_support(::Type) = Continuous

# Any continuous (or non-integer-lattice discrete) component makes the
# combination continuous.
_combine_support(::Type{Discrete}, ::Type{Discrete}) = Discrete
function _combine_support(
        ::Type{<:Distributions.ValueSupport}, ::Type{<:Distributions.ValueSupport}
    )
    return Continuous
end

_components_support(c::Tuple{Any}) = _component_support(typeof(c[1]))
function _components_support(c::Tuple)
    return _combine_support(
        _component_support(typeof(c[1])),
        _components_support(Base.tail(c))
    )
end

# ---------------------------------------------------------------------------
# Mixed discrete/continuous fold trait (#115)
# ---------------------------------------------------------------------------
#
# A two-component combination with exactly one integer-lattice discrete
# component is typed `Continuous` by `_combine_support` above (`Discrete`
# only fires when EVERY component is), so the ordinary
# `_DiscreteConvolved`-style S-parameter alias cannot select it for the
# exact mixed fold. `_mixed_slot` is a Holy-trait companion to
# `_combine_support`: it takes the SAME per-component `_component_support`
# results and, by dispatch (never a runtime `if`/lookup table), reports
# which slot (if any) holds the discrete factor -- `Val(1)`, `Val(2)`, or
# `nothing` when neither side is integer-lattice discrete. The
# both-discrete case also resolves to `nothing`: that pair is typed
# `Discrete` and is already routed to the all-discrete exact fold before
# this trait is ever consulted, so this guard just keeps the trait total
# rather than encoding a reachable third route. Every call site passes
# concrete component types, so this resolves to a compile-time constant
# per specialisation -- no runtime branch survives.
_mixed_slot(::Type{Discrete}, ::Type{Discrete}) = nothing
_mixed_slot(::Type{Discrete}, ::Type{<:Distributions.ValueSupport}) = Val(1)
_mixed_slot(::Type{<:Distributions.ValueSupport}, ::Type{Discrete}) = Val(2)
function _mixed_slot(
        ::Type{<:Distributions.ValueSupport},
        ::Type{<:Distributions.ValueSupport}
    )
    return nothing
end

# The discrete-slot component picked out by `_mixed_slot(...)`, or
# `nothing` when neither `x` nor `y` is the mixed fold's discrete factor.
_mixed_discrete_component(::Val{1}, x, y) = x
_mixed_discrete_component(::Val{2}, x, y) = y
_mixed_discrete_component(::Nothing, x, y) = nothing

# Whether `d` is a two-component combination with exactly one
# integer-lattice discrete side -- the mixed discrete/continuous fold's
# applicability condition (#115). `d`'s own value-support type parameter
# is `Continuous` for this case (see `_mixed_slot` above), so
# `_exact_discrete_route` cannot detect it from that alone; each
# concrete family member below overrides this with its OWN component
# types via the SAME `_mixed_slot` trait the fold's route functions
# dispatch on, so `is_exact`'s report can never drift from what a
# fold-eligible pdf/cdf call actually executes. Defaults to `false` for
# anything that does not implement the mixed fold (a future family
# member, or a `Convolved` with three or more components -- see its own
# docstring).
_has_mixed_fold(::AbstractConvolvedDistribution) = false

# Whether the exact discrete route (the additive lattice fold in
# `src/lattice.jl`, the `Product` divisor fold, or the mixed
# discrete/continuous fold, #115) is available for `d`. `Discrete`-typed
# `d` (every component integer-lattice discrete, by `_component_support`
# above) always has one; `Continuous`-typed `d` has one exactly when
# `_has_mixed_fold(d)` says so (a two-component pair with exactly one
# integer-lattice discrete side). This is the SAME predicate `is_exact`
# reads below and the route functions (`_convolved_pdf_route` and its
# `Difference`/`Product` counterparts) dispatch on, so a reported
# exactness can never drift from the route actually executed.
_exact_discrete_route(::AbstractConvolvedDistribution) = false
function _exact_discrete_route(
        ::AbstractConvolvedDistribution{<:Distributions.VariateForm, Discrete}
    )
    return true
end
function _exact_discrete_route(
        d::AbstractConvolvedDistribution{
            <:Distributions.VariateForm, Continuous,
        }
    )
    return _has_mixed_fold(d)
end

# Off-lattice points carry no mass on a discrete combination; the concrete
# `insupport` methods gate on this before the range check, so (for example)
# `insupport(convolved(Poisson(2.0), Poisson(3.0)), 2.5)` is `false`.
_on_lattice(::AbstractConvolvedDistribution, ::Real) = true
function _on_lattice(
        ::AbstractConvolvedDistribution{<:Distributions.VariateForm, Discrete},
        x::Real
    )
    return isinteger(x)
end

# ---------------------------------------------------------------------------
# Queryable evaluation path (#92): no silent numeric fallback
# ---------------------------------------------------------------------------
#
# `evaluation_path`/`has_closed_form` answer per quantity without
# evaluating it. `Difference`/`Product`/`Ratio` answer through this
# generic default: `_maybe_analytic` either builds the analytic
# distribution or returns `nothing` -- checking whether it can be built
# is not evaluating the quantity, and every quantity is analytic
# together (a genuine `Distributions.jl` object answers all of them), so
# one check covers `pdf`/`cdf`/... alike. `Convolved` overrides this
# with a construction-time-resolved answer instead (solver_dispatch.jl,
# review B on #137): its pair-specific closed forms (e.g. the
# Gamma+Uniform uniform-window forms) are NOT `_maybe_analytic`-visible
# (they compute a quantity directly, with no analytic distribution
# object behind them), so it needs a per-quantity answer this generic
# default cannot give. Recursion through nesting falls out for free
# either way: a nested combination only matches a component-typed
# analytic method when it names a leaf distribution, so a nested
# `Convolved`/`Difference`/`Product`/`Ratio` component falls through to
# `:numeric`, exactly mirroring what evaluation does.

# Whether `d` has an exact route for quantity function `f`, without
# evaluating `f`. Reuses each type's own `_maybe_analytic`.
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
(including a nested
[`Convolved`](@ref)/[`Difference`](@ref)/[`Product`](@ref)/[`Ratio`](@ref)
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
function evaluation_path(
        d::AbstractConvolvedDistribution,
        quantities = (pdf, cdf)
    )
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
has_closed_form(
    d::AbstractConvolvedDistribution, quantities = (
        pdf, cdf,
    )
) = evaluation_path(d, quantities) === :analytic

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
# in Difference.jl, `_family_names(d::Product)` in Product.jl,
# `_family_names(d::Ratio)` in Ratio.jl.

# Shared strict-construction check: called by each type's outer
# constructor function (`convolved`/`difference`/`product`/`ratio`)
# after building `d`. Errors, naming the component families, rather than
# silently returning an object that would fall back to quadrature —
# `strict = true` promises an exact route (#92), and gates on
# `is_exact`, NOT `evaluation_path`, so the exact discrete fold (which
# reports `:numeric`) is accepted rather than wrongly rejected.
function _check_strict(d::AbstractConvolvedDistribution, strict::Bool)
    strict || return d
    is_exact(d) && return d
    throw(
        ArgumentError(
            "$(nameof(typeof(d)))(...; strict = true) requires an exact " *
                "route (a closed form or the exact discrete fold), but no exact " *
                "route exists for components $(_family_names(d)); pass strict " *
                "= false to allow quadrature"
        )
    )
end

# ---------------------------------------------------------------------------
# Shared repeat mechanism: `convolved(d, k)` / `product(d, k)`
# ---------------------------------------------------------------------------

# The repeat count itself, as a plain `Int`-like value, whether it
# arrived as a runtime `Integer` or as a compile-time `Val{K}`.
_repeat_count(k::Integer) = k
_repeat_count(::Val{K}) where {K} = K

@doc "

Validate a repeat count for `convolved(d, k)` / `product(d, k)`: must be
a positive integer, else throw an `ArgumentError`.
"
function _validate_repeat_count(k::Integer)
    k > 0 || throw(
        ArgumentError(
            "repeat count must be a positive integer, got $k"
        )
    )
    return nothing
end

@doc "

Shared mechanism behind `convolved(d, k)` and `product(d, k)`: validate
`k`, return `d` unchanged for `k == 1`, try the closed form for `k` iid
copies of `d` via `analytic(d, k)`, and only when that returns `nothing`
build the k-fold combination via `build(d, k)`. `k` is either a plain
`Integer` or a `Val{K}`; `build` receives it unchanged so it can offer
an inference-stable path for the `Val` case.
"
function _repeat_combination(
        analytic::A, build::B, d::UnivariateDistribution, k
    ) where {A, B}
    kk = _repeat_count(k)
    _validate_repeat_count(kk)
    kk == 1 && return d
    closed = analytic(d, kk)
    closed !== nothing && return closed
    return build(d, k)
end
