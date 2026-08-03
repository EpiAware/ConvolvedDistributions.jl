# Tests for the timeseries form `convolve_series`: convolve a numeric
# series with a delay PMF on the unit lag grid. A discrete delay reads its
# own PMF directly (`convolve_series(delay, series)`); a continuous delay
# is discretised elsewhere (e.g. by CensoredDistributions.jl) and the
# resulting PMF fed to the PMF-vector method, either a plain vector on the
# unit grid or a `DiscreteNonParametric` on a coarser regular grid (issues
# #6, #31, #68, #79).

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

@testitem "a continuous delay has no method" begin
    using Distributions
    series = [0.0, 1.0, 3.0, 6.0, 8.0]

    delays = (Gamma(2.0, 1.0), Exponential(1.0), Normal(2.0, 1.0),
        LogNormal(0.5, 0.4),
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)))
    for delay in delays
        @test_throws MethodError convolve_series(delay, series)
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

    # Sub-normalised masses stay sub-normalised: no silent rescale.
    half = [0.25, 0.25]
    @test convolve_series(half, series) ≈ [0.25, 0.75, 1.25, 1.75]

    # A PMF longer than the series is truncated to the series window.
    long = [0.5, 0.3, 0.1, 0.05, 0.05]
    @test convolve_series(long, [1.0, 2.0]) ≈ [0.5, 1.3]

    # Integer series with float masses promotes the output.
    @test convolve_series(pmf, [1, 2, 3, 4]) isa AbstractVector{Float64}

    # The vector method agrees with the same masses wrapped in a
    # DiscreteNonParametric on the unit grid. Unlike the plain-vector form
    # above, DiscreteNonParametric enforces a genuine probability vector
    # (sum ≈ 1) at construction, so `pmf` (which already sums to 1) is
    # reused rather than a window-truncated, sub-normalised PMF.
    using Distributions
    dnp = DiscreteNonParametric(collect(0:2), pmf)
    @test convolve_series(pmf, series) ≈ convolve_series(dnp, series)
end

@testitem "DiscreteNonParametric convolve_series reads support as the lag grid" begin
    using Distributions

    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    maxlag = length(series) - 1

    # A unit-grid DiscreteNonParametric agrees with the plain-vector form.
    # DiscreteNonParametric requires a genuine probability vector, so the
    # window-truncated tail is normalised away purely for this
    # construction check.
    raw = pdf.(NegativeBinomial(5, 0.5), 0:maxlag)
    masses = raw ./ sum(raw)
    unit_grid = DiscreteNonParametric(collect(0:maxlag), masses)
    @test convolve_series(unit_grid, series) ≈ convolve_series(masses, series)

    # A coarser, regularly spaced grid (e.g. weekly bins) convolves the
    # probabilities in support order; the grid width itself does not enter
    # the causal-convolution arithmetic, only the constant-spacing check.
    weekly_masses = [0.6, 0.3, 0.1]
    weekly = DiscreteNonParametric([0.0, 7.0, 14.0], weekly_masses)
    weekly_series = [1.0, 2.0, 3.0]
    @test convolve_series(weekly, weekly_series) ≈
          convolve_series(weekly_masses, weekly_series)
end

@testitem "DiscreteNonParametric convolve_series validates its grid" begin
    using Distributions

    series = [1.0, 2.0, 3.0]

    # The support must start at lag 0: convolve_series has no separate
    # starting-lag argument, so an offset support would silently misalign
    # every mass by one grid step.
    offset = DiscreteNonParametric([1.0, 2.0, 3.0], [0.5, 0.3, 0.2])
    err = try
        convolve_series(offset, series)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("lag 0", err.msg)

    # The support must be regularly spaced: an irregular grid has no
    # single lag width to convolve on.
    irregular = DiscreteNonParametric([0.0, 1.0, 3.0], [0.5, 0.3, 0.2])
    err = try
        convolve_series(irregular, series)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("regularly spaced", err.msg)

    # A single-point support is trivially regular.
    single = DiscreteNonParametric([0.0], [1.0])
    @test convolve_series(single, series) ≈ series
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

@testitem "PMF surfaces guard indexing and emptiness" begin
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

    # An empty PMF is a construction bug, not a zero signal.
    @test_throws ArgumentError convolve_series(Float64[], series)
end

# --- time-varying delays: one delay per time point (#126) -------------------

@testitem "constant time-varying delays reduce to the static form" begin
    using Distributions

    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    n = length(series)
    delay = Poisson(1.5)
    masses = pdf.(delay, 0:(n - 1))
    static = convolve_series(delay, series)

    # The same delay everywhere must reproduce the single-delay result under
    # BOTH conventions: they can only differ when the delay changes.
    delays = fill(delay, n)
    pmf_matrix = repeat(masses, 1, n)
    pmf_vectors = [copy(masses) for _ in 1:n]
    for indexed_by in (:primary, :secondary)
        @test convolve_series(delays, series; indexed_by) ≈ static
        @test convolve_series(pmf_matrix, series; indexed_by) ≈ static
        @test convolve_series(pmf_vectors, series; indexed_by) ≈ static
    end

    # Output shape and element type match the static form, including the
    # integer-series promotion.
    out = convolve_series(delays, series)
    @test out isa AbstractVector{Float64}
    @test length(out) == n
    @test convolve_series(pmf_matrix, [0, 1, 2, 3, 4, 5, 6]) isa
          AbstractVector{Float64}
end

@testitem "primary and secondary indexing convolve the delay they name" begin
    using Distributions

    # Three time points, three deliberately different PMFs, so the two
    # conventions cannot coincide by accident.
    series = [1.0, 2.0, 4.0]
    p1 = [0.5, 0.3, 0.2]      # the delay of/at time 1
    p2 = [0.2, 0.7, 0.1]      # time 2
    p3 = [0.9, 0.05, 0.05]    # time 3
    pmfs = [p1, p2, p3]
    matrix = hcat(p1, p2, p3)

    # :primary — the cohort at time `s` spreads forward through its own PMF:
    # out[i] = Σ_s series[s] * pmf_s[i - s + 1].
    primary = [series[1] * p1[1],
        series[1] * p1[2] + series[2] * p2[1],
        series[1] * p1[3] + series[2] * p2[2] + series[3] * p3[1]]

    # :secondary — everything landing at time `i` is attributed through the
    # PMF of time `i`: out[i] = Σ_k pmf_i[k + 1] * series[i - k].
    secondary = [p1[1] * series[1],
        p2[1] * series[2] + p2[2] * series[1],
        p3[1] * series[3] + p3[2] * series[2] + p3[3] * series[1]]

    @test convolve_series(pmfs, series) ≈ primary                  # default
    @test convolve_series(pmfs, series; indexed_by = :primary) ≈ primary
    @test convolve_series(pmfs, series; indexed_by = :secondary) ≈ secondary
    @test !(primary ≈ secondary)

    # The matrix form reads the same masses, lags down columns.
    @test convolve_series(matrix, series) ≈ primary
    @test convolve_series(matrix, series; indexed_by = :secondary) ≈ secondary

    # A time-by-lag matrix is the transpose, and transposes are matrices too.
    @test convolve_series(transpose(permutedims(matrix)), series) ≈ primary

    # The distribution form agrees with the masses read off its own PMFs.
    delays = [DiscreteUniform(0, 2), Poisson(1.0), Geometric(0.4)]
    dist_masses = [pdf.(d, 0:2) for d in delays]
    @test convolve_series(delays, series) ≈
          convolve_series(dist_masses, series)
    @test convolve_series(delays, series; indexed_by = :secondary) ≈
          convolve_series(dist_masses, series; indexed_by = :secondary)

    # An abstract element type reads the same way: nothing dispatches on
    # the element, so the concrete and abstract vectors agree.
    abstract_eltype = convert(Vector{UnivariateDistribution}, delays)
    for indexed_by in (:primary, :secondary)
        @test convolve_series(abstract_eltype, series; indexed_by) ≈
              convolve_series(delays, series; indexed_by)
    end
end

@testitem "a delay type's own single-delay method defines its kernel" begin
    using Distributions
    import ConvolvedDistributions: convolve_series

    # Stands in for a delay type owned elsewhere (e.g. CensoredDistributions'
    # interval-censored delays, which subtype UnivariateDistribution{
    # ValueSupport} and carry their own convolve_series method). The
    # time-varying form must reach that method rather than needing a new one.
    struct GridDelay <: UnivariateDistribution{Distributions.ValueSupport} end
    masses = [0.6, 0.3, 0.1]
    function convolve_series(::GridDelay, s::AbstractVector{<:Real})
        convolve_series(masses, s)
    end

    series = [1.0, 2.0, 4.0, 3.0]
    static = convolve_series(masses, series)
    for indexed_by in (:primary, :secondary)
        @test convolve_series(fill(GridDelay(), length(series)), series;
            indexed_by) ≈ static
    end

    # Mixed element types are fine: every delay is read through whichever
    # single-delay method it has, so a foreign type and a stock discrete
    # distribution sit side by side in one vector.
    mixed = UnivariateDistribution[GridDelay(), Poisson(1.0),
        GridDelay(), DiscreteUniform(0, 2)]
    mixed_masses = [masses, pdf.(Poisson(1.0), 0:3), masses,
        pdf.(DiscreteUniform(0, 2), 0:3)]
    for indexed_by in (:primary, :secondary)
        @test convolve_series(mixed, series; indexed_by) ≈
              convolve_series(mixed_masses, series; indexed_by)
    end
end

@testitem "repeated delays build their masses once" begin
    using Distributions, ForwardDiff

    # Identical delays share one mass vector however they are arranged —
    # in a stretch, alternating, or rebuilt rather than reused — so each
    # must match a per-time-point build.
    series = collect(range(1.0, 10.0, length = 9))
    d1, d2 = Poisson(1.0), Poisson(3.0)
    arrangements = ([d1, d1, d1, d1, d2, d2, d2, d2, d2],
        [d1, d2, d1, d2, d1, d2, d1, d2, d1],
        [d1, d1, d2, d2, d2, d1, d1, d2, d2],
        [Poisson(1.0) for _ in 1:9])
    for delays in arrangements, indexed_by in (:primary, :secondary)

        per_point = [pdf.(d, 0:(length(series) - 1)) for d in delays]
        @test convolve_series(delays, series; indexed_by) ≈
              convolve_series(per_point, series; indexed_by)
    end

    # Runs are found with `===`, so two duals that agree in value but not in
    # tangent are never merged and both parameters keep their gradient.
    f(θ) = sum(convolve_series(
        [Poisson(θ[1]), Poisson(θ[2]), Poisson(θ[1])], [1.0, 2.0, 3.0]))
    g = ForwardDiff.gradient(f, [2.0, 2.0])
    ε = 1e-6
    fd = [(f([2.0 + ε, 2.0]) - f([2.0 - ε, 2.0])) / (2ε),
        (f([2.0, 2.0 + ε]) - f([2.0, 2.0 - ε])) / (2ε)]
    @test g ≈ fd rtol=1e-4
    @test all(!iszero, g)
end

@testitem "a delay changing less often than the series takes run lengths" begin
    using Distributions

    series = collect(range(1.0, 8.0, length = 7))
    d1, d2 = Poisson(3.0), Poisson(1.0)
    for indexed_by in (:primary, :secondary)
        @test convolve_series([d1 => 3, d2 => 4], series; indexed_by) ≈
              convolve_series([d1, d1, d1, d2, d2, d2, d2], series; indexed_by)
    end

    # Mass vectors take run lengths the same way.
    p1, p2 = [0.5, 0.3, 0.2], [0.9, 0.1]
    @test convolve_series([p1 => 3, p2 => 4], series) ≈
          convolve_series([p1, p1, p1, p2, p2, p2, p2], series)

    # Runs that do not cover the window, or are empty, are a bug.
    err = try
        convolve_series([d1 => 3, d2 => 3], series)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("sum to the series length", err.msg)
    @test_throws ArgumentError convolve_series([d1 => 0, d2 => 7], series)
end

@testitem "primary indexing conserves each cohort's in-window mass" begin
    using Distributions

    # Each cohort spreads its own unit PMF forward, so the only mass lost is
    # what falls past the window end.
    series = [1.0, 2.0, 4.0, 3.0, 5.0]
    n = length(series)
    delays = [Poisson(λ) for λ in range(0.5, 3.0; length = n)]
    out = convolve_series(delays, series)
    in_window = sum(series[s] * cdf(delays[s], n - s) for s in 1:n)
    @test sum(out) ≈ in_window
    @test sum(out) <= sum(series)

    # Point mass at lag 0 is the identity; at lag 1 it shifts by a step.
    identity_delays = fill(DiscreteUniform(0, 0), n)
    @test convolve_series(identity_delays, series) ≈ series
    shift_delays = fill(DiscreteUniform(1, 1), n)
    shifted = convolve_series(shift_delays, series)
    @test shifted[1] ≈ 0.0
    @test shifted[2:end] ≈ series[1:(end - 1)]

    # A delay that switches partway — the case a single PMF cannot express.
    switching = [DiscreteUniform(0, 0), DiscreteUniform(0, 0),
        DiscreteUniform(1, 1), DiscreteUniform(1, 1), DiscreteUniform(1, 1)]
    @test convolve_series(switching, series) ≈
          [series[1], series[2], 0.0, series[3], series[4]]
end

@testitem "time-varying PMFs are used exactly as given" begin
    # No renormalisation, no tail correction: sub-normalised columns stay
    # sub-normalised, and lags past the window end are simply never read.
    series = [1.0, 2.0, 3.0, 4.0]
    half = fill(0.25, 2, 4)
    @test convolve_series(half, series) ≈ [0.25, 0.75, 1.25, 1.75]
    @test convolve_series(half, series; indexed_by = :secondary) ≈
          [0.25, 0.75, 1.25, 1.75]

    # PMFs longer than the window: the overhanging mass is truncated.
    long = repeat([0.5, 0.3, 0.1, 0.05, 0.05], 1, 2)
    @test convolve_series(long, [1.0, 2.0]) ≈ [0.5, 1.3]

    # Ragged PMFs: each time point may carry its own number of lags.
    ragged = [[0.5, 0.3, 0.2], [0.5, 0.5], [1.0], [0.4, 0.4, 0.1, 0.1]]
    padded = [[0.5, 0.3, 0.2, 0.0], [0.5, 0.5, 0.0, 0.0],
        [1.0, 0.0, 0.0, 0.0], [0.4, 0.4, 0.1, 0.1]]
    for indexed_by in (:primary, :secondary)
        @test convolve_series(ragged, series; indexed_by) ≈
              convolve_series(hcat(padded...), series; indexed_by)
    end
end

@testitem "time-varying surfaces validate their inputs" begin
    using Distributions

    series = [1.0, 2.0, 3.0, 4.0]
    n = length(series)

    # A count mismatch is a mis-aligned delay series, so it throws.
    err = try
        convolve_series(fill(Poisson(1.0), n - 1), series)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("one delay PMF per time point", err.msg)
    @test_throws ArgumentError convolve_series(zeros(3, n + 1), series)
    @test_throws ArgumentError convolve_series([[0.5, 0.5] for _ in 1:2],
        series)

    # The convention is a dispatch target, so an unnamed one has no method
    # rather than falling back to the default.
    @test_throws MethodError convolve_series(fill(Poisson(1.0), n), series;
        indexed_by = :target)
    @test_throws MethodError convolve_series(zeros(3, n), series;
        indexed_by = :target)
    @test_throws MethodError convolve_series([[1.0] for _ in 1:n], series;
        indexed_by = :target)

    # Elements are never type-checked here: each kernel is built through the
    # element's own single-delay method, so a continuous element fails there
    # (no method) rather than on a gate in the vector form.
    @test_throws MethodError convolve_series(fill(Gamma(2.0, 1.0), n), series)
    mixed = Any[Poisson(1.0), Gamma(2.0, 1.0), Poisson(1.0), Poisson(1.0)]
    @test_throws MethodError convolve_series(mixed, series)

    # Empty PMFs are a construction bug, not a zero signal.
    @test_throws ArgumentError convolve_series(zeros(0, n), series)
    @test_throws ArgumentError convolve_series([Float64[] for _ in 1:n],
        series)
end

@testitem "time-varying surfaces guard indexing" begin
    # The @inbounds kernels assume 1-based indexing throughout, including
    # the per-time PMF vectors, so offset axes must be rejected loudly.
    struct ZeroBasedTV{T} <: AbstractVector{T}
        v::Vector{T}
    end
    Base.size(z::ZeroBasedTV) = size(z.v)
    function Base.axes(z::ZeroBasedTV)
        (Base.IdentityUnitRange(0:(length(z.v) - 1)),)
    end
    Base.getindex(z::ZeroBasedTV, i::Int) = z.v[i + 1]

    series = [0.0, 1.0, 3.0, 6.0]
    pmfs = [[0.5, 0.5] for _ in 1:4]
    @test_throws ArgumentError convolve_series(pmfs, ZeroBasedTV(series))
    @test_throws ArgumentError convolve_series(ZeroBasedTV(pmfs), series)
    offset_inner = Vector{Any}(pmfs)
    offset_inner[2] = ZeroBasedTV([0.5, 0.5])
    @test_throws ArgumentError convolve_series(
        convert(Vector{AbstractVector{Float64}}, offset_inner), series)
end

@testitem "gradients flow through time-varying delays" begin
    using Distributions, ForwardDiff

    series = [0.0, 1.0, 3.0, 6.0, 8.0]
    n = length(series)

    # Per-time delay parameters: a rate trending over the window, with the
    # whole time-varying convolution differentiated w.r.t. the trend.
    rates(θ) = [θ[1] + θ[2] * (t - 1) for t in 1:n]
    total(θ) = sum(convolve_series([Poisson(λ) for λ in rates(θ)], series))
    θ = [2.0, 0.25]
    g = ForwardDiff.gradient(total, θ)
    @test !all(iszero, g)
    ε = 1e-6
    fd = [(total(θ + ε * e) - total(θ - ε * e)) / (2ε)
          for e in ([1.0, 0.0], [0.0, 1.0])]
    @test g ≈ fd rtol=1e-4

    # Caller-supplied masses: the convolution is linear in the mass matrix,
    # so gradients flow through it under both indexing conventions.
    base = pdf.(Poisson(1.5), 0:(n - 1))
    weighted(θ) = sum(convolve_series(θ[1] .* repeat(base, 1, n), series;
        indexed_by = :secondary))
    gw = ForwardDiff.gradient(weighted, [1.0])
    @test gw[1] ≈ sum(convolve_series(base, series))
end
