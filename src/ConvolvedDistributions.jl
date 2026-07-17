"""
    ConvolvedDistributions

Raw-distribution convolution and the shared numeric quadrature machinery for
the EpiAware distribution-operations stack. Provides [`Convolved`](@ref) (the
sum of independent components), [`Difference`](@ref) (the `X - Y` dual),
[`Product`](@ref) (the `X * Y` Mellin convolution for non-negative
components), the pluggable Gauss-Legendre `integrate`/`gl_integrate` layer,
and the solver-method types `AnalyticalSolver`/`NumericSolver` selecting the
analytic-vs-numeric backend. Operates on any
`Distributions.UnivariateDistribution`; no censoring.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Sum of two independent delays
d = convolved(Gamma(2.0, 1.0), LogNormal(1.5, 0.5))
cdf(d, 5.0)

# Signed gap between two events
z = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))
mean(z)

# A delay scaled by an independent multiplicative factor
w = product(Gamma(3.0, 1.0), LogNormal(0.0, 0.3))
mean(w)
```
"""
module ConvolvedDistributions

using Random: AbstractRNG

# Functions extended with new methods.
import Distributions: params, components, insupport, pdf, logpdf, cdf, logcdf,
                      ccdf, logccdf, mean, var, std, sampler
import Base: minimum, maximum

# Types, constructors, and helpers used without method extension.
using Distributions: Distributions, UnivariateDistribution,
                     ContinuousUnivariateDistribution,
                     DiscreteUnivariateDistribution, Continuous,
                     Exponential, Gamma, LogNormal, Normal, scale, quantile

using LogExpFunctions: log1mexp

# The shared EpiAware AD-safety layer: the tape-strip pair keeps quadrature
# hyperparameters (window endpoints, panel breaks) off the AD path, and the
# AD-safe evaluation hooks are the sanctioned extension points wrapper
# packages overload for their own component types (their Gamma methods carry
# the analytic gamma-CDF derivative rules on every supported backend).
using EpiAwareADTools: primal, primal_distribution, pdf_ad_safe,
                       cdf_ad_safe, ccdf_ad_safe

import FastGaussQuadrature  # Gauss-Legendre nodes for the default solver

# DocStringExtensions symbols for the @template conventions registered by
# src/docstrings.jl (all module-scope using/import live in this file,
# kit #105).
using DocStringExtensions: @template, DOCSTRING, EXPORTS, IMPORTS, TYPEDEF,
                           TYPEDFIELDS, TYPEDSIGNATURES

# Register the standard EpiAware docstring conventions before any docstrings
# are defined (see src/docstrings.jl).
include("docstrings.jl")

# Public convolution constructor, its dual difference constructor, and the
# multiplicative product constructor (`Product` itself is public, not
# exported, to avoid clashing with Distributions' deprecated `Product`).
export convolved, convolve_series, Difference, difference, product

# The build-once discretised delay PMF constructor (`DelayPMF` itself is
# public, not exported, mirroring `Convolved`).
export discretise_pmf

# Solver methods for choosing the analytic-vs-numeric backend.
export AnalyticalSolver, NumericSolver

include("integration.jl")
include("solvers.jl")
# The abstract family supertype `Convolved`/`Difference` subtype, carrying
# the documented interface contract (verified by `TestUtils`).
include("interface.jl")
include("Convolved.jl")
# Difference (Z = X - Y), the dual of Convolved. After Convolved.jl since it
# reuses `_window_quantile` / `_CONVOLVED_TAIL` for the quadrature window clamp.
include("Difference.jl")
# Product (Z = X * Y), the Mellin-convolution member for non-negative
# components. Also after Convolved.jl for `_window_quantile` /
# `_CONVOLVED_TAIL` / `_max2` / `_min2`.
include("Product.jl")
# The timeseries form `convolve_series`: a numeric series convolved with
# a delay PMF on the unit lag grid — direct for a discrete delay, via a
# caller-supplied / `discretise_pmf` PMF for a continuous one (#6, #31).
include("convolve_with_vector.jl")

# `quantile` (inverse CDF) for Convolved/Difference lives in the
# ConvolvedDistributionsOptimizationExt extension, loaded when both
# Optimization.jl and OptimizationOptimJL.jl are present, so the core
# package carries no solver dependency.

# Interface-contract verifiers, shipped so downstream family members can
# self-verify (mirrors CensoredDistributions.TestUtils).
include("TestUtils.jl")

# Public API (not exported) - Julia 1.11+.
@static if VERSION >= v"1.11"
    include("public.jl")
end

end # module ConvolvedDistributions
