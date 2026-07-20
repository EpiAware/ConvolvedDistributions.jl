# Tests for the timeseries form `convolve_series`: convolve a numeric
# series with a delay PMF on the unit lag grid. A discrete delay reads its
# own PMF directly (`convolve_series(delay, series)`); a continuous delay
# is discretised elsewhere (e.g. by CensoredDistributions.jl) and the
# resulting PMF fed to the PMF-vector method (issues #6, #31, #68).

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
    # discretised, and discretisation is an explicit modelling choice this
    # package does not make, so the method throws and names the route out.
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
        @test occursin("CensoredDistributions", err.msg)
        @test occursin("DiscreteNonParametric", err.msg)
    end
end

@testitem "discretised delay matches a hand-computed small case" begin
    using Distributions

    # Exponential(1) interval masses over the unit grid are
    # p[k+1] = e^{-k} - e^{-(k+1)}. Discretisation lives outside this
    # package now (#68); the caller builds the masses however it likes
    # and hands them to convolve_series as a plain vector.
    p1 = 1 - exp(-1.0)
    p2 = exp(-1.0) - exp(-2.0)
    p3 = exp(-2.0) - exp(-3.0)
    series = [1.0, 2.0, 3.0]

    out = convolve_series([p1, p2, p3], series)
    @test out[1] ≈ p1 * 1.0
    @test out[2] ≈ p1 * 2.0 + p2 * 1.0
    @test out[3] ≈ p1 * 3.0 + p2 * 2.0 + p3 * 1.0
end

@testitem "a near-point-mass delay shifts the series" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    # Caller-owned CDF-difference masses (the interval-censored-secondary
    # scheme with an exact primary), built here only to exercise
    # convolve_series on a caller-supplied vector — not package machinery.
    masses(delay) = [cdf(delay, k + 1.0) - cdf(delay, Float64(k))
                     for k in 0:maxlag]

    # All mass in [0, 1): lag 0, identity up to a negligible tail.
    zero_lag = masses(LogNormal(log(0.5), 0.01))
    @test convolve_series(zero_lag, series) ≈ series atol=1e-8

    # All mass in [2, 3): the series shifted forward by two steps.
    two_lag = masses(Normal(2.5, 0.01))
    shifted = convolve_series(two_lag, series)
    @test shifted[1:2] ≈ zeros(2) atol=1e-8
    @test shifted[3:end] ≈ series[1:(end - 2)] atol=1e-8
end

@testitem "mass is conserved up to the truncated tail" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    n = length(series)
    delay = Gamma(2.0, 1.0)
    masses = [cdf(delay, k + 1.0) - cdf(delay, Float64(k)) for k in 0:(n - 1)]

    # By linearity, each series entry contributes its value times the
    # delay mass that lands inside the window; the remainder is the
    # truncated tail beyond the series end.
    out = convolve_series(masses, series)
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

    # Sub-normalised masses stay sub-normalised: no silent rescale. The
    # normalisation check would warn here, so opt out — this test is about
    # the convolution arithmetic, not the check.
    half = [0.25, 0.25]
    @test convolve_series(half, series; check_normalisation = false) ≈
          [0.25, 0.75, 1.25, 1.75]

    # A PMF longer than the series is truncated to the series window.
    long = [0.5, 0.3, 0.1, 0.05, 0.05]
    @test convolve_series(long, [1.0, 2.0]) ≈ [0.5, 1.3]

    # Integer series with float masses promotes the output.
    @test convolve_series(pmf, [1, 2, 3, 4]) isa AbstractVector{Float64}
end

@testitem "DiscreteNonParametric delay convolves on its own regular grid" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]

    # Unit grid starting at zero: the masses convolve exactly as the plain
    # vector of the same masses.
    ps = [0.5, 0.3, 0.2]
    dnp = DiscreteNonParametric([0, 1, 2], ps)
    @test convolve_series(dnp, series) ≈ convolve_series(ps, series)

    # A non-unit grid (weekly, say) carries its masses onto consecutive lags
    # 0, 1, 2 — the grid step is the series' own sampling interval and does
    # not enter the arithmetic, so it matches the plain-vector convolution.
    weekly = DiscreteNonParametric([0.0, 7.0, 14.0], ps)
    @test convolve_series(weekly, series) ≈ convolve_series(ps, series)

    # A support starting above zero is a forward shift: leading lags carry no
    # mass, so mass at support 2, 3 lands at lags 2, 3 (a two-step shift).
    shifted = DiscreteNonParametric([2, 3], [0.6, 0.4])
    @test convolve_series(shifted, series) ≈
          convolve_series([0.0, 0.0, 0.6, 0.4], series)

    # A single-point support is a unit-grid point mass at its (integer) lag.
    point = DiscreteNonParametric([2], [1.0])
    @test convolve_series(point, series) ≈
          convolve_series([0.0, 0.0, 1.0], series)
end

@testitem "DiscreteNonParametric grid is validated" begin
    using Distributions
    series = [1.0, 2.0, 3.0, 4.0]

    # An irregular support (unequal spacing) has no single lag grid.
    @test_throws ArgumentError convolve_series(
        DiscreteNonParametric([0, 1, 3], [0.3, 0.3, 0.4]), series)

    # A support off a zero-aligned grid (not whole multiples of the step)
    # cannot map to integer lags.
    @test_throws ArgumentError convolve_series(
        DiscreteNonParametric([0.5, 1.5, 2.5], [0.3, 0.3, 0.4]), series)

    # Negative lags cannot enter a causal convolution.
    @test_throws ArgumentError convolve_series(
        DiscreteNonParametric([-1, 0, 1], [0.2, 0.5, 0.3]), series)
end

@testitem "convolve_series warns on a mis-normalised PMF vector" begin
    using Distributions
    series = [1.0, 2.0, 3.0, 4.0]

    # The pure predicate: masses near one pass, grossly-off masses fail, and
    # ordinary finite-grid tail truncation (a few % short) still passes.
    @test ConvolvedDistributions._pmf_normalisation_ok([0.5, 0.3, 0.2])
    @test ConvolvedDistributions._pmf_normalisation_ok([0.5, 0.3, 0.17])
    @test !ConvolvedDistributions._pmf_normalisation_ok([0.25, 0.25])
    @test !ConvolvedDistributions._pmf_normalisation_ok([0.6, 0.6])

    # The default path warns on gross mis-normalisation but still convolves
    # the masses unchanged (no rescaling).
    subnorm = [0.25, 0.25]
    out = @test_logs (:warn,) match_mode = :any convolve_series(subnorm, series)
    @test out ≈ convolve_series(subnorm, series; check_normalisation = false)

    # A normalised PMF does not warn, and the opt-out silences the check for
    # a deliberately truncated PMF.
    @test_logs convolve_series([0.5, 0.3, 0.2], series)
    @test_logs convolve_series(subnorm, series; check_normalisation = false)
end

@testitem "gradients flow through a caller-supplied PMF and the discrete PMF" begin
    using Distributions, ForwardDiff

    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    # Continuous delay: differentiate through caller-owned CDF-difference
    # masses (standing in for a CensoredDistributions.jl-built PMF) fed
    # as a plain vector into convolve_series. `cdf_ad_safe` carries the
    # analytic gamma-CDF derivative rule Gamma needs for this to
    # differentiate at all (plain `cdf` has no Dual method here).
    cdf_ad_safe = ConvolvedDistributions.cdf_ad_safe
    masses(θ) = [cdf_ad_safe(Gamma(θ[1], θ[2]), k + 1.0) -
                 cdf_ad_safe(Gamma(θ[1], θ[2]), Float64(k))
                 for k in 0:maxlag]
    discretised(θ) = sum(convolve_series(masses(θ), series))

    θ = [2.0, 1.0]
    g = ForwardDiff.gradient(discretised, θ)
    @test !all(iszero, g)
    # Central finite differences confirm the autodiff gradient. With
    # step 1e-6 the truncation plus round-off error of the central
    # difference is ~1e-8 relative, so rtol = 1e-4 (here and for the
    # Poisson check below) is dominated by neither and flags any wrong
    # derivative rule outright.
    ε = 1e-6
    fd = [(discretised(θ + ε * e) - discretised(θ - ε * e)) / (2ε)
          for e in ([1.0, 0.0], [0.0, 1.0])]
    @test g ≈ fd rtol=1e-4

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

    # An empty PMF is a construction bug, not a zero signal: reject it
    # rather than silently returning an all-zero series.
    @test_throws ArgumentError convolve_series(Float64[], series)
end
