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
"
has_closed_form(d::AbstractConvolvedDistribution, quantities = (
    pdf, cdf)) = evaluation_path(d, quantities) === :analytic

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
