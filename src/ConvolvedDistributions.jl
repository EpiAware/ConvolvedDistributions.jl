"""
    ConvolvedDistributions

Raw-distribution convolution and the shared numeric quadrature machinery for
the EpiAware distribution-operations stack. Provides [`Convolved`](@ref) (the
sum of independent components), [`Difference`](@ref) (the `X - Y` dual),
[`Product`](@ref) (the `X * Y` Mellin convolution for non-negative
components), the pluggable Gauss-Legendre `integrate`/`gl_integrate` layer,
the solver-method types `AnalyticalSolver`/`NumericSolver` selecting the
analytic-vs-numeric backend, and, for discrete distributions, the
probability generating function primitive `pgf`. Operates on any
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
                      ccdf, logccdf, mean, var, std, sampler, quantile
import Base: minimum, maximum

# Types, constructors, and helpers used without method extension.
using Distributions: Distributions, UnivariateDistribution,
                     DiscreteUnivariateDistribution, DiscreteNonParametric,
                     Continuous, Exponential, Gamma, LogNormal, Normal,
                     Uniform, Weibull, scale, shape, meanlogx, stdlogx,
                     support, probs, partype,
                     Poisson, Bernoulli, Binomial, Geometric,
                     NegativeBinomial

using LogExpFunctions: log1mexp, logsubexp

# The shared EpiAware AD-safety layer: the tape-strip pair keeps quadrature
# hyperparameters (window endpoints, panel breaks) off the AD path, and the
# AD-safe evaluation hooks are the sanctioned extension points wrapper
# packages overload for their own component types (their Gamma methods carry
# the analytic gamma-CDF derivative rules on every supported backend).
# `_gamma_cdf` is the AD-safe regularised-lower-incomplete-gamma evaluator
# the native Gamma/Weibull uniform-window closed forms route through
# (src/uniform_window.jl), so their shape-parameter derivatives carry the
# same per-backend rules as the rest of the package.
using EpiAwareADTools: primal, primal_distribution, pdf_ad_safe,
                       cdf_ad_safe, ccdf_ad_safe, logcdf_ad_safe,
                       logccdf_ad_safe, _gamma_cdf

import FastGaussQuadrature  # Gauss-Legendre nodes for the default solver
import SpecialFunctions     # gamma() for the native analytic-pair closed forms

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

# Solver methods for choosing the analytic-vs-numeric backend.
export AnalyticalSolver, NumericSolver

include("integration.jl")
include("solvers.jl")
# The abstract family supertype `Convolved`/`Difference` subtype, carrying
# the documented interface contract (verified by `TestUtils`).
include("interface.jl")
include("Convolved.jl")
# Solver-method dispatch (#77): the per-quantity generics `Convolved`'s
# two-component methods call into, and the native uniform-window forms
# hosted on them. After Convolved.jl, whose numeric quadrature helpers
# and struct the `NumericSolver` arms and both-orders retry reuse.
include("solver_dispatch.jl")
include("uniform_window.jl")
# Difference (Z = X - Y), the dual of Convolved. After Convolved.jl since it
# reuses `_window_quantile` / `_CONVOLVED_TAIL` for the quadrature window clamp.
include("Difference.jl")
# Product (Z = X * Y), the Mellin-convolution member for non-negative
# components. Also after Convolved.jl for `_window_quantile` /
# `_CONVOLVED_TAIL` / `_max2` / `_min2`.
include("Product.jl")
# The probability generating function primitive (#90): closed forms for
# the standard count families, a truncated-series fallback for any other
# `DiscreteUnivariateDistribution`, and the structural `Convolved` product.
# After Convolved.jl since the structural method dispatches on `Convolved`.
include("pgf.jl")
# The timeseries form `convolve_series`: a numeric series convolved with
# a delay PMF on the unit lag grid — direct for a discrete delay, via a
# caller-supplied PMF (e.g. from CensoredDistributions.jl) for a
# continuous one (#6, #31, #68).
include("convolve_with_vector.jl")

# Public stub for the shared numeric quantile inversion (#112); the
# method itself lives in the ConvolvedDistributionsOptimizationExt
# extension, loaded when both Optimization.jl and OptimizationOptimJL.jl
# are present, so the core package carries no solver dependency.
include("quantile.jl")

# `quantile` (inverse CDF) for a two-component analytic `Convolved` pair
# (S2.4) lives in core and needs no solver, built on `convolved_quantile`
# above. Everything else -- the numeric `Convolved` fallback, and
# `Difference`/`Product` `quantile` entirely -- lives in the
# ConvolvedDistributionsOptimizationExt extension, built on
# `quantile_by_optimization` above.

# Interface-contract verifiers, shipped so downstream family members can
# self-verify (mirrors CensoredDistributions.TestUtils).
include("TestUtils.jl")

# Public API (not exported) - Julia 1.11+.
@static if VERSION >= v"1.11"
    include("public.jl")
end

end # module ConvolvedDistributions
