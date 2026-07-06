# ============================================================================
# Abstract type hierarchy: the multi-base algebraic-combination family
# ============================================================================
#
# Mirrors the CensoredDistributions.jl family model: related concrete types
# share one supertype, and the documented interface contract plus any shared
# behaviour hang off the abstract. This package has a single family — the
# algebraic combinations `Convolved` and `Difference` — so one abstract type
# carries the contract that a future member (e.g. a min/max order statistic)
# implements and `TestUtils.test_combined_interface` verifies.

@doc "

Supertype of the multi-base algebraic combinations: [`Convolved`](@ref)
(the sum of independent components) and [`Difference`](@ref) (`Z = X - Y`).
These combine two or more base distributions by an algebraic operation.
Parametric on variate form and value support for symmetry with the wider
EpiAware family model (`Distribution{F, S}`), so the univariate members
keep their `UnivariateDistribution{Continuous}` supertype and existing
dispatch is unchanged.

Required of a concrete subtype:

- `params(d)`;
- `logpdf(d, x)` finite on its support;
- `Base.show(io, d)`.

Verify a subtype with
`ConvolvedDistributions.TestUtils.test_combined_interface`, and family
membership with `ConvolvedDistributions.TestUtils.test_abstract_membership`.
"
abstract type AbstractCombinedDistribution{F <: Distributions.VariateForm,
    S <: Distributions.ValueSupport} <: Distributions.Distribution{F, S} end
