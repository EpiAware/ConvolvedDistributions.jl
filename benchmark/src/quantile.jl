# `quantile` (inverse CDF) from the ConvolvedDistributionsOptimizationExt
# extension (loaded by the Optimization + OptimizationOptimJL deps in
# benchmark/Project.toml): Nelder-Mead inversion of `cdf`, seeded from
# the component-quantile guess. The numeric variants pay one quadrature
# CDF per optimiser iteration, so these are the slowest rows in the
# suite and the most sensitive to CDF regressions.

SUITE["Quantile"] = BenchmarkGroup()

let
    conv_analytic = convolved(
        Normal(1.0, 0.5), Normal(0.5, 1.0))
    conv_numeric = convolved(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    diff_numeric = difference(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

    SUITE["Quantile"]["Convolved analytic"] = BenchmarkGroup()
    SUITE["Quantile"]["Convolved analytic"]["median"] = @benchmarkable quantile(
        $conv_analytic, 0.5)
    SUITE["Quantile"]["Convolved analytic"]["grid"] = @benchmarkable quantile.(
        $conv_analytic, $TEST_PS)

    SUITE["Quantile"]["Convolved numeric"] = BenchmarkGroup()
    SUITE["Quantile"]["Convolved numeric"]["median"] = @benchmarkable quantile(
        $conv_numeric, 0.5)

    SUITE["Quantile"]["Difference numeric"] = BenchmarkGroup()
    SUITE["Quantile"]["Difference numeric"]["median"] = @benchmarkable quantile(
        $diff_numeric, 0.5)
end
