"""
    ConvolvedDistributions

Raw-distribution convolution and the shared numeric quadrature machinery for
the EpiAware distribution-operations stack. Provides [`Convolved`](@ref) (the
sum of independent components), [`Difference`](@ref) (the `X - Y` dual), the
pluggable Gauss-Legendre `integrate`/`gl_integrate` layer, and the solver-method
types `AnalyticalSolver`/`NumericSolver` selecting the analytic-vs-numeric
backend. Operates on any `Distributions.UnivariateDistribution`; no censoring.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Sum of two independent delays
d = convolve_distributions(Gamma(2.0, 1.0), LogNormal(1.5, 0.5))
cdf(d, 5.0)

# Signed gap between two events
z = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))
mean(z)
```
"""
module ConvolvedDistributions

using Random: AbstractRNG

# Functions extended with new methods.
import Distributions: params, insupport, pdf, logpdf, cdf, logcdf,
                      ccdf, logccdf, mean, var, std, sampler
import Base: minimum, maximum

# Types, constructors, and helpers used without method extension.
using Distributions: Distributions, UnivariateDistribution, Continuous,
                     Exponential, Gamma, Normal, shape, scale, quantile

using LogExpFunctions: log1mexp

using SpecialFunctions: gamma_inc, loggamma, digamma

import FastGaussQuadrature  # Gauss-Legendre nodes for the default solver

# Register the standard EpiAware docstring conventions before any docstrings
# are defined (see src/docstrings.jl).
include("docstrings.jl")

# Public convolution constructor and its dual difference constructor.
export convolve_distributions, Difference, difference

# Solver methods for choosing the analytic-vs-numeric backend.
export AnalyticalSolver, NumericSolver

include("gamma_ad.jl")
include("integration.jl")
include("solvers.jl")
include("Convolved.jl")
# Difference (Z = X - Y), the dual of Convolved. After Convolved.jl since it
# reuses `_window_quantile` / `_CONVOLVED_TAIL` for the quadrature window clamp.
include("Difference.jl")

# `quantile` (inverse CDF) for Convolved/Difference lives in the
# ConvolvedDistributionsOptimizationExt extension, loaded when both
# Optimization.jl and OptimizationOptimJL.jl are present, so the core
# package carries no solver dependency.

# Public API (not exported) - Julia 1.11+.
@static if VERSION >= v"1.11"
    include("public.jl")
end

end # module ConvolvedDistributions
