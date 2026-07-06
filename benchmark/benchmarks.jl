# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# Benchmark suite definition. Build a BenchmarkTools `BenchmarkGroup` named
# `SUITE`; the managed `run.jl` / `compare.jl` consume it.
#
# The suite benchmarks the package's real hot paths: `Convolved` and
# `Difference` densities and CDFs on both the analytic and the numeric
# Gauss-Legendre quadrature backends (scalar broadcast vs the batched
# vector methods that share quadrature nodes across evaluation points),
# the timeseries convolution, and `quantile` via the Optimization
# extension. Groups follow the CensoredDistributions.jl convention:
# `SUITE[<group>][<variant>][<operation>]`.

using BenchmarkTools
using ConvolvedDistributions
using Distributions
# Loading Optimization + OptimizationOptimJL activates the
# ConvolvedDistributionsOptimizationExt extension, which provides
# `quantile` for `Convolved`/`Difference` (see src/quantile.jl).
using Optimization
using OptimizationOptimJL

const SUITE = BenchmarkGroup()

# Shared evaluation data. `TEST_XS` spans the bulk of the positive-sum
# distributions, `TEST_ZS` the signed `Difference` support, `TEST_PS` the
# quantile probabilities.
const TEST_XS = collect(range(0.5, 12.0, length = 100))
const TEST_ZS = collect(range(-4.0, 6.0, length = 100))
const TEST_PS = collect(range(0.05, 0.95, length = 20))

# Include benchmark definitions.
include("src/baseline.jl")
include("src/convolved.jl")
include("src/difference.jl")
include("src/timeseries.jl")
include("src/quantile.jl")
include("src/ad_gradients.jl")
