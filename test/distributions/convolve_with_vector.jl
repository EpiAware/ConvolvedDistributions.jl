# Tests for the timeseries form `convolve_series(delay, series)`:
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
    out = convolve_series(leaf, series)
    @test out isa AbstractVector
    @test length(out) == length(series)
    @test out ≈ reference_convolution(leaf, series)

    # A Convolved total delay: the same discretise-then-convolve contract.
    total = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test convolve_series(total, series) ≈
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

    out = convolve_series(Exponential(1.0), series)
    @test out[1] ≈ p1 * 1.0
    @test out[2] ≈ p1 * 2.0 + p2 * 1.0
    @test out[3] ≈ p1 * 3.0 + p2 * 2.0 + p3 * 1.0
end

@testitem "a near-point-mass delay shifts the series" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]

    # All mass in [0, 1): lag 0, identity up to a negligible tail.
    zero_lag = LogNormal(log(0.5), 0.01)
    @test convolve_series(zero_lag, series) ≈ series atol=1e-8

    # All mass in [2, 3): the series shifted forward by two steps.
    two_lag = Normal(2.5, 0.01)
    shifted = convolve_series(two_lag, series)
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
    out = convolve_series(delay, series)
    expected = sum(series[i] * cdf(delay, n - i + 1) for i in 1:n)
    @test sum(out) ≈ expected
    @test sum(out) <= sum(series)
end

@testitem "timeseries method does not disturb distribution dispatch" begin
    using Distributions

    # The numeric-vector second argument selects the timeseries method,
    # including for integer series (promoted to float output).
    @test convolve_series(Gamma(2.0, 1.0), [0.0, 1.0, 2.0]) isa
          AbstractVector{Float64}
    @test convolve_series(Gamma(2.0, 1.0), [0, 1, 2]) isa
          AbstractVector{Float64}

    # The distribution-args forms still build a Convolved unambiguously.
    two = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test two isa ConvolvedDistributions.Convolved

    vec = convolved([Gamma(2.0, 1.0), LogNormal(0.5, 0.4)])
    @test vec isa ConvolvedDistributions.Convolved

    tup = convolved((Gamma(2.0, 1.0), LogNormal(0.5, 0.4)))
    @test tup isa ConvolvedDistributions.Convolved
end

@testitem "PMF-vector convolve_series matches a hand computation" begin
    # Caller-supplied masses are used exactly as given (no renormalise).
    pmf = [0.5, 0.3, 0.2]
    series = [1.0, 2.0, 3.0, 4.0]
    out = convolve_series(pmf, series)
    @test out ≈ [0.5, 0.5 * 2 + 0.3, 0.5 * 3 + 0.3 * 2 + 0.2,
        0.5 * 4 + 0.3 * 3 + 0.2 * 2]

    # Sub-normalised masses stay sub-normalised: no silent rescale.
    half = [0.25, 0.25]
    @test convolve_series(half, series) ≈ [0.25, 0.75, 1.25, 1.75]

    # A PMF longer than the series is truncated to the series window.
    long = [0.5, 0.3, 0.1, 0.05, 0.05]
    @test convolve_series(long, [1.0, 2.0]) ≈ [0.5, 1.3]

    # Integer series with float masses promotes the output.
    @test convolve_series(pmf, [1, 2, 3, 4]) isa AbstractVector{Float64}

    # The vector method agrees with the delay method when handed the
    # same discretised masses (caller-owned discretisation).
    using Distributions
    delay = Gamma(2.0, 1.0)
    n = length(series)
    masses = [cdf(delay, k + 1.0) - cdf(delay, Float64(k))
              for k in 0:(n - 1)]
    @test convolve_series(masses, series) ≈ convolve_series(delay, series)
end

@testitem "discretise_pmf builds a reusable DelayPMF" begin
    using Distributions
    delay = Gamma(2.0, 1.0)
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    pmf = discretise_pmf(delay, maxlag)
    @test pmf isa ConvolvedDistributions.DelayPMF
    @test length(pmf) == maxlag + 1
    @test pmf.interval == 1.0

    # Build-once reuse is numerically identical to the rebuild path.
    @test convolve_series(pmf, series) == convolve_series(delay, series)

    # `pdf` reads the raw interval masses at integer lags.
    @test pdf(pmf, 0) ≈ cdf(delay, 1.0) - cdf(delay, 0.0)
    @test pdf(pmf, 3) ≈ cdf(delay, 4.0) - cdf(delay, 3.0)

    # Lags outside 0..maxlag carry no mass.
    @test pdf(pmf, -1) == 0.0
    @test pdf(pmf, maxlag + 1) == 0.0

    # Vector lag lookup maps the scalar read.
    @test pdf(pmf, 0:2) ≈ [pdf(pmf, k) for k in 0:2]

    # A Convolved total delay discretises the same way.
    total = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test convolve_series(discretise_pmf(total, maxlag), series) ==
          convolve_series(total, series)
end

@testitem "DelayPMF validates its inputs" begin
    using Distributions
    delay = Gamma(2.0, 1.0)

    @test_throws ArgumentError discretise_pmf(delay, -1)
    @test_throws ArgumentError ConvolvedDistributions.DelayPMF(
        Float64[], 1.0)
    @test_throws ArgumentError ConvolvedDistributions.DelayPMF(
        [1.0], 0.0)

    # A non-unit grid builds (for lag lookups) but is rejected by the
    # series convolution, mirroring the delay-method interval guard.
    pmf_half = discretise_pmf(delay, 5; interval = 0.5)
    @test pmf_half.interval == 0.5
    @test pdf(pmf_half, 0) ≈ cdf(delay, 0.5)
    @test_throws ArgumentError convolve_series(pmf_half, [1.0, 2.0])
end

@testitem "gradients flow through discretise_pmf masses" begin
    using Distributions, ForwardDiff

    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1
    rebuild(θ) = sum(convolve_series(Gamma(θ[1], θ[2]), series))
    function prebuilt(θ)
        pmf = discretise_pmf(Gamma(θ[1], θ[2]), maxlag)
        return sum(convolve_series(pmf, series))
    end
    lookup(θ) = sum(pdf(discretise_pmf(Gamma(θ[1], θ[2]), maxlag),
        0:maxlag))

    θ = [2.0, 1.0]
    g_prebuilt = ForwardDiff.gradient(prebuilt, θ)
    @test g_prebuilt ≈ ForwardDiff.gradient(rebuild, θ)
    @test !all(iszero, g_prebuilt)
    @test !all(iszero, ForwardDiff.gradient(lookup, θ))
end

@testitem "interval != 1 is rejected to avoid grid/series-step conflation" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0]
    leaf = Gamma(2.0, 1.0)

    # The causal convolution shifts by integer SERIES steps (unit-spaced),
    # so a PMF grid step other than 1 conflates the discretisation width
    # with the series time-step. Reject it rather than silently
    # mis-aligning.
    @test_throws ArgumentError convolve_series(leaf, series;
        interval = 0.5)
    @test_throws ArgumentError convolve_series(leaf, series;
        interval = 2.0)

    # The unit-spaced default is unchanged.
    @test convolve_series(leaf, series; interval = 1) ≈
          convolve_series(leaf, series)
end
