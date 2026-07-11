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

Supertype of the multi-base algebraic combinations: [`Convolved`](@ref)
(the sum of independent components), [`Difference`](@ref) (`Z = X - Y`),
and [`Product`](@ref) (`Z = X * Y`). These combine two or more base
distributions by an algebraic operation.

Every member is a convolution in the generalised sense — the
distribution of `X op Y` for independent components is the pushforward
of the product measure under `op`, which for `+` is the classical
convolution, for `-` the convolution with the reflected variable, for
`*` the Mellin convolution, and for future members like `max`/`min` the
max-convolution of the Urbanik generalised-convolution family — hence
the family and package name.

Parametric on variate form and value support for symmetry with the wider
EpiAware family model (`Distribution{F, S}`), so the univariate members
keep their `UnivariateDistribution{Continuous}` supertype and existing
dispatch is unchanged.

Required of a concrete subtype:

- `params(d)`;
- `logpdf(d, x)` finite on its support;
- `Base.show(io, d)`.

Verify a subtype with
`ConvolvedDistributions.TestUtils.test_convolved_interface`, and family
membership with `ConvolvedDistributions.TestUtils.test_abstract_membership`.
"
abstract type AbstractConvolvedDistribution{F <: Distributions.VariateForm,
    S <: Distributions.ValueSupport} <: Distributions.Distribution{F, S} end
