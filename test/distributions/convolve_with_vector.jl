# Tests for the timeseries form `convolve_distributions(delay, series)`:
# convolve a numeric series with the discretised delay PMF of a
# distribution (issue #6).

@testsnippet ConvolveVectorRef begin
    using Distributions

    # A hand-written discrete delay-convolution reference: the series
    # convolved with the discretised delay PMF (raw CDF-difference
    # interval masses, no renormalisation), causal and truncated to the
    # series window. Mirrors the method's contract independently.
    function reference_convolution(delay, series; interval = 1)
        n = length(series)
        maxlag = n - 1
        pmf = [cdf(delay, (k + 1) * interval) - cdf(delay, k * interval)
               for k in 0:maxlag]
        out = zeros(Float64, n)
        for i in 1:n
            for k in 1:min(length(pmf), i)
                out[i] += pmf[k] * series[i - k + 1]
            end
        end
        return out
    end
end

@testitem "timeseries convolution matches the discrete reference" setup=[
    ConvolveVectorRef] begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]

    # A plain delay distribution.
    leaf = Gamma(2.0, 1.0)
    out = convolve_distributions(leaf, series)
    @test out isa AbstractVector
    @test length(out) == length(series)
    @test out ≈ reference_convolution(leaf, series)

    # A Convolved total delay: the same discretise-then-convolve contract.
    total = convolve_distributions(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test convolve_distributions(total, series) ≈
          reference_convolution(total, series)
end

@testitem "timeseries convolution matches a hand-computed small case" begin
    using Distributions

    # Exponential(1) interval masses over the unit grid are
    # p[k+1] = e^{-k} - e^{-(k+1)}.
    p1 = 1 - exp(-1.0)
    p2 = exp(-1.0) - exp(-2.0)
    p3 = exp(-2.0) - exp(-3.0)
    series = [1.0, 2.0, 3.0]

    out = convolve_distributions(Exponential(1.0), series)
    @test out[1] ≈ p1 * 1.0
    @test out[2] ≈ p1 * 2.0 + p2 * 1.0
    @test out[3] ≈ p1 * 3.0 + p2 * 2.0 + p3 * 1.0
end

@testitem "a near-point-mass delay shifts the series" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]

    # All mass in [0, 1): lag 0, identity up to a negligible tail.
    zero_lag = LogNormal(log(0.5), 0.01)
    @test convolve_distributions(zero_lag, series) ≈ series atol=1e-8

    # All mass in [2, 3): the series shifted forward by two steps.
    two_lag = Normal(2.5, 0.01)
    shifted = convolve_distributions(two_lag, series)
    @test shifted[1:2] ≈ zeros(2) atol=1e-8
    @test shifted[3:end] ≈ series[1:(end - 2)] atol=1e-8
end

@testitem "mass is conserved up to the truncated tail" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    n = length(series)
    delay = Gamma(2.0, 1.0)

    # By linearity, each series entry contributes its value times the
    # delay mass that lands inside the window; the remainder is the
    # truncated tail beyond the series end.
    out = convolve_distributions(delay, series)
    expected = sum(series[i] * cdf(delay, n - i + 1) for i in 1:n)
    @test sum(out) ≈ expected
    @test sum(out) <= sum(series)
end

@testitem "timeseries method does not disturb distribution dispatch" begin
    using Distributions

    # The numeric-vector second argument selects the timeseries method,
    # including for integer series (promoted to float output).
    @test convolve_distributions(Gamma(2.0, 1.0), [0.0, 1.0, 2.0]) isa
          AbstractVector{Float64}
    @test convolve_distributions(Gamma(2.0, 1.0), [0, 1, 2]) isa
          AbstractVector{Float64}

    # The distribution-args forms still build a Convolved unambiguously.
    two = convolve_distributions(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test two isa ConvolvedDistributions.Convolved

    vec = convolve_distributions([Gamma(2.0, 1.0), LogNormal(0.5, 0.4)])
    @test vec isa ConvolvedDistributions.Convolved

    tup = convolve_distributions((Gamma(2.0, 1.0), LogNormal(0.5, 0.4)))
    @test tup isa ConvolvedDistributions.Convolved
end

@testitem "interval != 1 is rejected to avoid grid/series-step conflation" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0]
    leaf = Gamma(2.0, 1.0)

    # The causal convolution shifts by integer SERIES steps (unit-spaced),
    # so a PMF grid step other than 1 conflates the discretisation width
    # with the series time-step. Reject it rather than silently
    # mis-aligning.
    @test_throws ArgumentError convolve_distributions(leaf, series;
        interval = 0.5)
    @test_throws ArgumentError convolve_distributions(leaf, series;
        interval = 2.0)

    # The unit-spaced default is unchanged.
    @test convolve_distributions(leaf, series; interval = 1) ≈
          convolve_distributions(leaf, series)
end
