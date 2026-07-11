# Tests for the timeseries form `convolve_series`: convolve a numeric
# series with a delay PMF on the unit lag grid. A discrete delay reads its
# own PMF directly (`convolve_series(delay, series)`); a continuous delay
# is discretised first (via `discretise_pmf`, or CensoredDistributions.jl)
# and the resulting PMF fed to the PMF-vector method (issues #6, #31).

@testsnippet ConvolveVectorRef begin
    using Distributions

    # A hand-written discrete delay-convolution reference: the series
    # convolved with a delay PMF, causal and truncated to the series
    # window. `masses` is the length `n` PMF over integer lags `0..n-1`.
    function reference_from_masses(masses, series)
        n = length(series)
        out = zeros(Float64, n)
        for i in 1:n
            for k in 1:min(length(masses), i)
                out[i] += masses[k] * series[i - k + 1]
            end
        end
        return out
    end

    # The interval-censored-secondary reference for a discretised
    # continuous delay: raw CDF-difference masses (no renormalisation),
    # matching `discretise_pmf`.
    function reference_convolution(delay, series; interval = 1)
        masses = [cdf(delay, (k + 1) * interval) - cdf(delay, k * interval)
                  for k in 0:(length(series) - 1)]
        return reference_from_masses(masses, series)
    end

    # The direct-PMF reference for a discrete delay: the lag-`k` mass is
    # `pdf(delay, k)`.
    function reference_discrete(delay, series)
        masses = [pdf(delay, k) for k in 0:(length(series) - 1)]
        return reference_from_masses(masses, series)
    end
end

@testitem "discrete delay convolves via its own PMF" setup=[
    ConvolveVectorRef] begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]

    # DiscreteUniform(0, 2): mass 1/3 at lags 0, 1, 2 read straight off the
    # distribution's PMF at the integers.
    d = DiscreteUniform(0, 2)
    out = convolve_series(d, series)
    @test out isa AbstractVector{Float64}
    @test length(out) == length(series)
    @test out ≈ reference_discrete(d, series)

    # Poisson: a spread-out count delay, hand-checked at the first steps.
    p = Poisson(1.5)
    op = convolve_series(p, series)
    @test op[1] ≈ pdf(p, 0) * series[1]
    @test op[2] ≈ pdf(p, 0) * series[2] + pdf(p, 1) * series[1]
    @test op ≈ reference_discrete(p, series)
end

@testitem "discrete delay reads pdf, not a CDF difference (off-by-one)" begin
    using Distributions
    series = [1.0, 2.0, 3.0, 4.0]

    # The lag-`k` mass MUST be `pdf(d, k)`. The CDF-difference scheme would
    # give `F(k + 1) - F(k) = pdf(d, k + 1)` on integer support — an
    # off-by-one. For DiscreteUniform(0, 2) the two disagree: pdf-masses
    # carry 1/3 at lag 2, the CDF differences carry 0 there.
    d = DiscreteUniform(0, 2)
    pdf_masses = [pdf(d, k) for k in 0:3]
    cdf_masses = [cdf(d, k + 1) - cdf(d, k) for k in 0:3]
    @test pdf_masses ≈ [1 / 3, 1 / 3, 1 / 3, 0.0]
    @test cdf_masses ≈ [1 / 3, 1 / 3, 0.0, 0.0]      # = pdf at 1, 2, 3
    @test cdf_masses[1] ≈ pdf(d, 1)                  # the off-by-one trap

    out = convolve_series(d, series)
    right = [sum(pdf_masses[k] * series[i - k + 1] for k in 1:min(4, i))
             for i in 1:4]
    wrong = [sum(cdf_masses[k] * series[i - k + 1] for k in 1:min(4, i))
             for i in 1:4]
    @test out ≈ right
    @test !(out ≈ wrong)
end

@testitem "a continuous delay is rejected with an explicit-scheme message" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0]

    # A continuous delay carries no mass on the integer grid until it is
    # discretised, and discretisation is an explicit modelling choice, so
    # the method throws and names both routes out.
    delays = (Gamma(2.0, 1.0), Exponential(1.0), Normal(2.0, 1.0),
        LogNormal(0.5, 0.4),
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)))
    for delay in delays
        err = try
            convolve_series(delay, series)
        catch e
            e
        end
        @test err isa ArgumentError
        @test occursin("discretise_pmf", err.msg)
        @test occursin("CensoredDistributions", err.msg)
    end
end

@testitem "discretised continuous delay matches the CDF-difference reference" setup=[
    ConvolveVectorRef] begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    # A plain delay distribution, discretised explicitly then convolved.
    leaf = Gamma(2.0, 1.0)
    out = convolve_series(discretise_pmf(leaf, maxlag), series)
    @test out isa AbstractVector
    @test length(out) == length(series)
    @test out ≈ reference_convolution(leaf, series)

    # A Convolved total delay: the same discretise-then-convolve contract.
    total = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test convolve_series(discretise_pmf(total, maxlag), series) ≈
          reference_convolution(total, series)
end

@testitem "discretised delay matches a hand-computed small case" begin
    using Distributions

    # Exponential(1) interval masses over the unit grid are
    # p[k+1] = e^{-k} - e^{-(k+1)}.
    p1 = 1 - exp(-1.0)
    p2 = exp(-1.0) - exp(-2.0)
    p3 = exp(-2.0) - exp(-3.0)
    series = [1.0, 2.0, 3.0]

    out = convolve_series(discretise_pmf(Exponential(1.0), 2), series)
    @test out[1] ≈ p1 * 1.0
    @test out[2] ≈ p1 * 2.0 + p2 * 1.0
    @test out[3] ≈ p1 * 3.0 + p2 * 2.0 + p3 * 1.0
end

@testitem "a near-point-mass delay shifts the series" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    # All mass in [0, 1): lag 0, identity up to a negligible tail.
    zero_lag = discretise_pmf(LogNormal(log(0.5), 0.01), maxlag)
    @test convolve_series(zero_lag, series) ≈ series atol=1e-8

    # All mass in [2, 3): the series shifted forward by two steps.
    two_lag = discretise_pmf(Normal(2.5, 0.01), maxlag)
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
    out = convolve_series(discretise_pmf(delay, n - 1), series)
    expected = sum(series[i] * cdf(delay, n - i + 1) for i in 1:n)
    @test sum(out) ≈ expected
    @test sum(out) <= sum(series)
end

@testitem "timeseries method does not disturb distribution dispatch" begin
    using Distributions

    # The numeric-vector second argument selects the discrete timeseries
    # method, including for integer series (promoted to float output).
    @test convolve_series(Poisson(2.0), [0.0, 1.0, 2.0]) isa
          AbstractVector{Float64}
    @test convolve_series(Poisson(2.0), [0, 1, 2]) isa
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

    # The vector method agrees with a discretised delay when handed the
    # same discretised masses (caller-owned discretisation).
    using Distributions
    delay = Gamma(2.0, 1.0)
    n = length(series)
    masses = [cdf(delay, k + 1.0) - cdf(delay, Float64(k))
              for k in 0:(n - 1)]
    @test convolve_series(masses, series) ≈
          convolve_series(discretise_pmf(delay, n - 1), series)
end

@testitem "discretise_pmf builds a reusable DelayPMF" setup=[
    ConvolveVectorRef] begin
    using Distributions
    delay = Gamma(2.0, 1.0)
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    pmf = discretise_pmf(delay, maxlag)
    @test pmf isa ConvolvedDistributions.DelayPMF
    @test length(pmf) == maxlag + 1
    @test pmf.interval == 1.0

    # The build-once masses match the interval-censored-secondary
    # reference, and reuse is the raw-vector convolution of those masses.
    @test convolve_series(pmf, series) ≈ reference_convolution(delay, series)
    @test convolve_series(pmf, series) == convolve_series(pmf.masses, series)

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
    @test convolve_series(discretise_pmf(total, maxlag), series) ≈
          reference_convolution(total, series)
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
    # series convolution: the causal convolution shifts by integer series
    # steps, so only a unit PMF grid stays aligned with the series step.
    pmf_half = discretise_pmf(delay, 5; interval = 0.5)
    @test pmf_half.interval == 0.5
    @test pdf(pmf_half, 0) ≈ cdf(delay, 0.5)
    @test_throws ArgumentError convolve_series(pmf_half, [1.0, 2.0])
end

@testitem "gradients flow through the discretisation and the discrete PMF" begin
    using Distributions, ForwardDiff

    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    # Continuous delay: differentiate through the explicit discretisation.
    discretised(θ) = sum(convolve_series(
        discretise_pmf(Gamma(θ[1], θ[2]), maxlag), series))
    lookup(θ) = sum(pdf(discretise_pmf(Gamma(θ[1], θ[2]), maxlag),
        0:maxlag))

    θ = [2.0, 1.0]
    g = ForwardDiff.gradient(discretised, θ)
    @test !all(iszero, g)
    # Central finite differences confirm the autodiff gradient.
    ε = 1e-6
    fd = [(discretised(θ + ε * e) - discretised(θ - ε * e)) / (2ε)
          for e in ([1.0, 0.0], [0.0, 1.0])]
    @test g ≈ fd rtol=1e-4
    @test !all(iszero, ForwardDiff.gradient(lookup, θ))

    # Discrete delay: the direct-PMF path differentiates w.r.t. the rate.
    poisson(λ) = sum(convolve_series(Poisson(λ[1]), series))
    gp = ForwardDiff.gradient(poisson, [2.0])
    @test !all(iszero, gp)
    fdp = (poisson([2.0 + ε]) - poisson([2.0 - ε])) / (2ε)
    @test gp[1] ≈ fdp rtol=1e-4
end

@testitem "PMF surfaces guard indexing, emptiness, and broadcast" begin
    using Distributions

    # A minimal zero-based AbstractVector: the @inbounds kernels assume
    # 1-based indexing, so offset axes must be rejected loudly rather
    # than silently shifting masses or reading out of bounds.
    struct ZeroBased{T} <: AbstractVector{T}
        v::Vector{T}
    end
    Base.size(z::ZeroBased) = size(z.v)
    function Base.axes(z::ZeroBased)
        (Base.IdentityUnitRange(0:(length(z.v) - 1)),)
    end
    Base.getindex(z::ZeroBased, i::Int) = z.v[i + 1]

    series = [0.0, 1.0, 3.0, 6.0]
    pmf = [0.5, 0.3, 0.2]
    @test_throws ArgumentError convolve_series(ZeroBased(pmf), series)
    @test_throws ArgumentError convolve_series(pmf, ZeroBased(series))
    @test_throws ArgumentError ConvolvedDistributions.DelayPMF(
        ZeroBased(pmf), 1.0)

    # An empty PMF is a construction bug, not a zero signal: both the
    # raw-vector path and the DelayPMF constructor reject it.
    @test_throws ArgumentError convolve_series(Float64[], series)
    @test_throws ArgumentError ConvolvedDistributions.DelayPMF(
        Float64[], 1.0)

    # discretise_pmf validates the interval up front with its own name,
    # before any CDF work.
    err = try
        discretise_pmf(Gamma(2.0, 1.0), 10; interval = 0.0)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("discretise_pmf", err.msg)

    # `pdf.(pmf, lags)` broadcasts the PMF as a scalar.
    built = discretise_pmf(Gamma(2.0, 1.0), 5)
    @test pdf.(built, 0:3) == [pdf(built, l) for l in 0:3]
end
