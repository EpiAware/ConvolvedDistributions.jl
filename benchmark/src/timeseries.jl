# Timeseries convolution: a numeric series pushed through the
# discretised delay PMF (`convolve_distributions(delay, series)`). The
# Gamma delay hits the AD-safe `_gamma_cdf` discretisation; the
# Convolved delay discretises through the numeric quadrature CDF, so the
# PMF construction dominates.

SUITE["Timeseries"] = BenchmarkGroup()

let
    series = vcat(
        collect(range(0.0, 10.0, length = 15)),
        collect(range(10.0, 1.0, length = 15)))
    gamma_delay = Gamma(2.0, 1.0)
    convolved_delay = convolve_distributions(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

    SUITE["Timeseries"]["Gamma delay"] = @benchmarkable convolve_distributions(
        $gamma_delay, $series)
    SUITE["Timeseries"]["Convolved delay"] = @benchmarkable convolve_distributions(
        $convolved_delay, $series)
end
