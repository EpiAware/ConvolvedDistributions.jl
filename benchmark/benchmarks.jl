# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# Benchmark suite definition. Build a BenchmarkTools `BenchmarkGroup` named
# `SUITE`; the managed `run.jl` / `compare.jl` consume it.
#
# The suite benchmarks the package's real hot paths: `Convolved`,
# `Difference`, `Product`, and `Ratio` densities and CDFs on both the
# analytic and the numeric Gauss-Legendre quadrature backends (scalar
# broadcast vs the batched vector methods that share quadrature nodes
# across evaluation points), the timeseries convolution, and `quantile`
# via the Optimization extension. Groups follow the
# CensoredDistributions.jl convention: `SUITE[<group>][<variant>][<operation>]`.

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
#
# `benchmark-history` replays THIS suite against older commits, where a
# member or verb the suite exercises may not exist yet. Loading such a
# file raises at include time and would abort the whole run, losing every
# other group's numbers along with it. Skip the group instead and carry
# on, so the history keeps reporting for everything that does exist at
# that commit -- the same trade-off the AD group already makes when its
# scenarios cannot be constructed.
function _include_group(path)
    try
        include(path)
    catch err
        @warn "Skipping benchmark group: it needs an API this commit " *
            "does not have" path err
    end
    return nothing
end

for group in (
        "src/baseline.jl", "src/convolved.jl", "src/difference.jl",
        "src/product.jl", "src/ratio.jl", "src/timeseries.jl",
        "src/quantile.jl", "src/ad_gradients.jl",
    )
    _include_group(group)
end
