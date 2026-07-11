# Timeseries convolution: a numeric series pushed through a delay PMF on
# the unit lag grid (`convolve_series`). A continuous delay is discretised
# explicitly with `discretise_pmf` — the Gamma delay hits the AD-safe
# `_gamma_cdf` discretisation, the Convolved delay the numeric quadrature
# CDF, so the PMF construction dominates. A discrete delay (Poisson) is
# read straight off its own PMF.

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

    SUITE["Timeseries"]["Gamma delay"] = @benchmarkable convolve_series(
        discretise_pmf($gamma_delay, $maxlag), $series)
    SUITE["Timeseries"]["Convolved delay"] = @benchmarkable convolve_series(
        discretise_pmf($convolved_delay, $maxlag), $series)
    SUITE["Timeseries"]["Poisson delay"] = @benchmarkable convolve_series(
        $poisson_delay, $series)
end
