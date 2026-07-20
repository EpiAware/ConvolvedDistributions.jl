# Timeseries convolution: a numeric series pushed through a delay PMF on
# the unit lag grid (`convolve_series`). This package no longer discretises
# continuous delays itself (#68 — CensoredDistributions.jl owns that), so
# the Gamma/Convolved PMFs below are built once outside the benchmark (raw
# CDF-difference masses, standing in for a caller-supplied PMF) and only
# the convolution itself is timed. A discrete delay (Poisson) is read
# straight off its own PMF.

SUITE["Timeseries"] = BenchmarkGroup()

let
    series = vcat(
        collect(range(0.0, 10.0, length = 15)),
        collect(range(10.0, 1.0, length = 15)))
    maxlag = length(series) - 1
    gamma_delay = Gamma(2.0, 1.0)
    convolved_delay = convolved(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    poisson_delay = Poisson(2.0)
    gamma_pmf = [cdf(gamma_delay, k + 1.0) - cdf(gamma_delay, Float64(k))
                 for k in 0:maxlag]
    convolved_pmf = [cdf(convolved_delay, k + 1.0) -
                     cdf(convolved_delay, Float64(k)) for k in 0:maxlag]

    SUITE["Timeseries"]["Gamma delay"] = @benchmarkable convolve_series(
        $gamma_pmf, $series)
    SUITE["Timeseries"]["Convolved delay"] = @benchmarkable convolve_series(
        $convolved_pmf, $series)
    SUITE["Timeseries"]["Poisson delay"] = @benchmarkable convolve_series(
        $poisson_delay, $series)
end
