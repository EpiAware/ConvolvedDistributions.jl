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
the univariate members keep their `UnivariateDistribution{Continuous}`
supertype and existing dispatch is unchanged.

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
# Queryable evaluation path (#92): no silent numeric fallback
# ---------------------------------------------------------------------------
#
# `evaluation_path` and `has_closed_form` both delegate directly to
# `_maybe_analytic` (defined per concrete type in Convolved.jl/
# Difference.jl/Product.jl), the SAME function `pdf`/`logpdf`/`cdf`/... call
# to decide their own analytic-vs-numeric branch. There is deliberately no
# separate "does this have a closed form" computation here: querying and
# evaluating share one source of truth, so the reported route cannot drift
# from the executed one. Recursion through nesting falls out for free —
# `_maybe_analytic`'s pairwise analytic-conversion dispatch (`_try_convolve`
# etc.) only matches concrete leaf-distribution types, so a nested
# `Convolved`/`Difference`/`Product` component (analytic or not) never
# matches an analytic-pair rule and the outer combination reports
# `:numeric`, exactly mirroring what evaluation actually does.

@doc "

Report which route `d` will take for its density and CDF, without
evaluating either: `:analytic` for the exact closed form, `:numeric` for
Gauss-Legendre quadrature.

Recurses through nesting: a combination with any non-analytic component
(including a nested [`Convolved`](@ref)/[`Difference`](@ref)/[`Product`](@ref)
using [`NumericSolver`](@ref), or one with no matching closed form)
reports `:numeric`, since evaluating it does fall back to quadrature
somewhere in the recursion.

The internal `pdf`/`logpdf`/`cdf`/... methods branch on the exact same
underlying check this function reports, so the answer cannot drift from
what evaluation actually does.

# See also
- [`has_closed_form`](@ref): the boolean convenience form.
"
evaluation_path(d::AbstractConvolvedDistribution) = _maybe_analytic(d) === nothing ?
                                                    :numeric : :analytic

@doc "

Whether `d` has an exact closed form for its density and CDF —
`evaluation_path(d) === :analytic`.

# See also
- [`evaluation_path`](@ref): the full `:analytic`/`:numeric` predicate.
"
has_closed_form(d::AbstractConvolvedDistribution) = evaluation_path(d) === :analytic

# The component-family names named in a `strict = true` construction
# error, one method per concrete type (each knows its own fields):
# `_family_names(d::Convolved)` in Convolved.jl, `_family_names(d::Difference)`
# in Difference.jl, `_family_names(d::Product)` in Product.jl.

# Shared strict-construction check: called by each type's outer
# constructor function (`convolved`/`difference`/`product`) after
# building `d`. Errors, naming the component families, rather than
# silently returning an object that would fall back to quadrature —
# `strict = true` promises an exact route (#92), so a forced numeric
# route (whether from a mismatched family pair or an explicit
# `NumericSolver`) breaks that promise equally.
function _check_strict(d::AbstractConvolvedDistribution, strict::Bool)
    strict || return d
    evaluation_path(d) === :analytic && return d
    throw(ArgumentError(
        "$(nameof(typeof(d)))(...; strict = true) requires an exact " *
        "closed form, but no analytic route exists for components " *
        "$(_family_names(d)); pass strict = false to allow quadrature"))
end
