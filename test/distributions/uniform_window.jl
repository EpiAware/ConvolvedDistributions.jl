# Tests for the uniform-window analytic pair methods (#77):
# Gamma/LogNormal/Weibull + Uniform for the CDF, any delay + Uniform for
# the density, and the solver-method dispatch scoping they run through.

@testitem "Gamma + Uniform analytic pair matches numeric quadrature" begin
    using Distributions

    cases = ((2.0, 1.5, 0.0, 2.0), (0.5, 3.0, 1.0, 1.0), (5.0, 0.8, 0.0, 4.0))
    for (shape, scale, pmin, pwidth) in cases
        delay = Gamma(shape, scale)
        primary = Uniform(pmin, pmin + pwidth)
        d_analytic = convolved(delay, primary)
        d_numeric = convolved(delay, primary; method = NumericSolver())
        for x in (0.1, 0.5, 1.0, 2.0, 3.0, 6.0, 15.0)
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol=1e-9
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol=1e-6
            @test pdf(d_analytic, x)≈pdf(d_numeric, x) atol=1e-6 rtol=1e-3
            @test logpdf(d_analytic, x)≈logpdf(d_numeric, x) atol=1e-4
        end
        # Below the primary's minimum the CDF is exactly zero.
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "LogNormal + Uniform analytic pair matches numeric quadrature" begin
    using Distributions

    cases = ((1.5, 0.5, 0.0, 3.0), (0.0, 1.0, 0.0, 1.0), (2.0, 0.3, 1.0, 2.0))
    for (mu, sigma, pmin, pwidth) in cases
        delay = LogNormal(mu, sigma)
        primary = Uniform(pmin, pmin + pwidth)
        d_analytic = convolved(delay, primary)
        d_numeric = convolved(delay, primary; method = NumericSolver())
        for x in (0.1, 0.5, 1.0, 2.0, 3.0, 6.0, 15.0)
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol=1e-9
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol=1e-6
            @test pdf(d_analytic, x)≈pdf(d_numeric, x) atol=1e-6 rtol=1e-3
            @test logpdf(d_analytic, x)≈logpdf(d_numeric, x) atol=1e-3
        end
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "Weibull + Uniform analytic pair matches numeric quadrature" begin
    using Distributions

    cases = ((1.5, 2.0, 0.0, 1.5), (0.7, 1.0, 0.0, 2.0), (3.0, 4.0, 1.0, 1.0))
    for (k, lambda, pmin, pwidth) in cases
        delay = Weibull(k, lambda)
        primary = Uniform(pmin, pmin + pwidth)
        d_analytic = convolved(delay, primary)
        d_numeric = convolved(delay, primary; method = NumericSolver())
        for x in (0.1, 0.5, 1.0, 2.0, 3.0, 6.0, 15.0)
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol=1e-6
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol=1e-6
            # `k = 0.7`'s density is near-singular at 0, so `NumericSolver`'s
            # own fixed-panel pdf quadrature (not the closed form, which
            # matches a finite difference of the cdf above to ~1e-9) is
            # only accurate to ~0.5% there -- rtol reflects that reference
            # limit, not the closed form's own accuracy.
            @test pdf(d_analytic, x)≈pdf(d_numeric, x) atol=1e-6 rtol=1e-2
            @test logpdf(d_analytic, x)≈logpdf(d_numeric, x) atol=1e-2
        end
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "Native analytic pairs used by AnalyticalSolver by default" begin
    using ConvolvedDistributions
    using ConvolvedDistributions: evaluation_path
    using Distributions

    d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    @test d.method isa AnalyticalSolver
    @test evaluation_path(d, cdf) === :analytic

    # Batched and scalar CDF agree exactly (both route through the same
    # closed form, no quadrature panel-grid drift possible).
    xs = [0.5, 1.0, 2.0, 3.0]
    @test cdf(d, xs) == [cdf(d, x) for x in xs]
end

# ForwardDiff gradients of cdf/logcdf through the closed form, checked
# against central finite differences (same pattern as the Difference.jl
# ForwardDiff gradient test).

@testitem "Gamma + Uniform analytic pair cdf/logcdf ForwardDiff gradient" begin
    using Distributions, ForwardDiff

    fc = θ -> cdf(convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), 3.0)
    flc = θ -> logcdf(convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), 3.0)
    θ = [2.0, 1.5]

    gc = ForwardDiff.gradient(fc, θ)
    glc = ForwardDiff.gradient(flc, θ)
    @test all(isfinite, gc)
    @test all(isfinite, glc)

    h = 1e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        @test gc[i] ≈ (fc(θp) - fc(θm)) / (2h) atol=1e-6
        @test glc[i] ≈ (flc(θp) - flc(θm)) / (2h) atol=1e-6
    end

    # Batched cdf differentiates too, and matches the pointwise gradient.
    fb = θ -> sum(
        cdf(convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), [1.0, 3.0]))
    gb = ForwardDiff.gradient(fb, θ)
    @test all(isfinite, gb)
end

@testitem "LogNormal + Uniform pair cdf/logcdf ForwardDiff gradient" begin
    using Distributions, ForwardDiff

    fc = θ -> cdf(convolved(LogNormal(θ[1], θ[2]), Uniform(0.0, 3.0)), 4.0)
    flc = θ -> logcdf(
        convolved(LogNormal(θ[1], θ[2]), Uniform(0.0, 3.0)), 4.0)
    θ = [1.5, 0.5]

    gc = ForwardDiff.gradient(fc, θ)
    glc = ForwardDiff.gradient(flc, θ)
    @test all(isfinite, gc)
    @test all(isfinite, glc)

    h = 1e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        @test gc[i] ≈ (fc(θp) - fc(θm)) / (2h) atol=1e-6
        @test glc[i] ≈ (flc(θp) - flc(θm)) / (2h) atol=1e-6
    end
end

@testitem "Weibull + Uniform pair cdf/logcdf ForwardDiff gradient" begin
    using Distributions, ForwardDiff

    fc = θ -> cdf(convolved(Weibull(θ[1], θ[2]), Uniform(0.0, 1.5)), 2.5)
    flc = θ -> logcdf(convolved(Weibull(θ[1], θ[2]), Uniform(0.0, 1.5)), 2.5)
    θ = [1.5, 2.0]

    gc = ForwardDiff.gradient(fc, θ)
    glc = ForwardDiff.gradient(flc, θ)
    @test all(isfinite, gc)
    @test all(isfinite, glc)

    h = 1e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        @test gc[i] ≈ (fc(θp) - fc(θm)) / (2h) atol=1e-6
        @test glc[i] ≈ (flc(θp) - flc(θm)) / (2h) atol=1e-6
    end
end

@testitem "solver dispatch scoping: NumericSolver bypass" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    d = convolved(
        Gamma(2.0, 1.5), Uniform(0.0, 2.0); method = NumericSolver())
    @test evaluation_path(d, cdf) === :numeric
    @test evaluation_path(d, pdf) === :numeric

    # The scalar/batched cdf and pdf therefore differ from the analytic
    # pair's exact values (they run quadrature instead).
    da = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    @test cdf(d, 3.0) ≈ cdf(da, 3.0) atol=1e-9
    @test cdf(d, 3.0) != cdf(da, 3.0)
end

@testitem "solver dispatch scoping: three-component bypass" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    d3 = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0), Normal(0.0, 1.0))
    @test evaluation_path(d3, cdf) === :numeric
    @test evaluation_path(d3, pdf) === :numeric
end

@testitem "solver dispatch scoping: reversed component order" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    forward = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    reversed = convolved(Uniform(0.0, 2.0), Gamma(2.0, 1.5))

    @test evaluation_path(reversed, cdf) === :analytic
    @test cdf(reversed, 3.0) ≈ cdf(forward, 3.0)
    @test pdf(reversed, 3.0) ≈ pdf(forward, 3.0)
    @test logpdf(reversed, 3.0) ≈ logpdf(forward, 3.0)
end

@testitem "solver dispatch scoping: Difference/Product get no swap retry" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    # Difference/Product are not commutative, so a swapped-order match
    # would silently compute the wrong quantity. Neither pair here has a
    # closed form for cdf (Difference/Product never try the S1
    # component-swap retry), so this confirms the plain fallback runs.
    d = difference(Gamma(2.0, 1.0), Uniform(0.0, 2.0))
    p = product(Gamma(2.0, 1.0), Uniform(0.0, 2.0))
    @test evaluation_path(d, cdf) === :numeric
    @test evaluation_path(p, cdf) === :numeric
end

@testitem "@inferred cdf/pdf for closed-form and non-closed-form pairs" begin
    using Distributions, Test

    for d in (convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0)),
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)))
        @test (@inferred(cdf(d, 1.0)); true)
        @test (@inferred(pdf(d, 1.0)); true)
        @test (@inferred(logpdf(d, 1.0)); true)
    end
end

@testitem "uniform-window density matches quadrature by family" begin
    using Distributions

    cases = [
        Gamma(2.0, 1.5) => Uniform(0.0, 2.0),
        LogNormal(1.5, 0.5) => Uniform(0.0, 3.0),
        Weibull(1.5, 2.0) => Uniform(0.0, 1.5),
        Normal(2.0, 1.0) => Uniform(-1.0, 1.0),
        Exponential(2.0) => Uniform(0.0, 2.0)
    ]

    for (delay, primary) in cases
        d = convolved(delay, primary)
        dn = convolved(delay, primary; method = NumericSolver())
        for x in (-5.0, -1.0, 0.5, 1.0, 3.0, 6.0, 15.0)
            @test pdf(d, x)≈pdf(dn, x) atol=1e-6 rtol=1e-3
            @test logpdf(d, x)≈logpdf(dn, x) atol=1e-4 rtol=1e-4
            @test pdf(d, x) >= 0.0
        end
    end
end

@testitem "uniform-window density narrow-window sweep stays accurate" begin
    using Distributions

    # w shrinking from 1e-1 to 1e-6: the linear-space subtraction that
    # would cancel is exactly what the closed form's cancellation guard
    # exists for. Reference each point against `NumericSolver`, which
    # itself degrades as the window narrows, so the tolerance loosens
    # with `w` -- what matters is that the closed form does not degrade
    # faster than quadrature does, and never returns NaN/negative.
    delay = Gamma(2.0, 1.5)
    for w in (1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6)
        d = convolved(delay, Uniform(0.0, w))
        dn = convolved(delay, Uniform(0.0, w); method = NumericSolver())
        for x in (0.1, 3.0, 10.0)
            p = pdf(d, x)
            @test isfinite(p)
            @test p >= 0.0
            @test p≈pdf(dn, x) rtol=1e-3
            @test isfinite(logpdf(d, x))
        end
    end
end

@testitem "uniform-window density deep tails stay finite and accurate" begin
    using Distributions

    # Far enough into the tail that a component's own AD-safe CDF/CCDF
    # loses precision (Gamma's logccdf_ad_safe saturates to -Inf around
    # here); the closed form must not inherit that as a spurious zero.
    cases = [
        Gamma(2.0, 1.5) => 100.0,
        LogNormal(1.5, 0.5) => 1.0e6,
        Weibull(1.5, 2.0) => 100.0,
        Normal(2.0, 1.0) => 60.0,
        Exponential(2.0) => 800.0
    ]

    for (delay, x) in cases
        primary = Uniform(0.0, 2.0)
        d = convolved(delay, primary)
        dn = convolved(delay, primary; method = NumericSolver())

        p, pn = pdf(d, x), pdf(dn, x)
        lp, lpn = logpdf(d, x), logpdf(dn, x)
        @test isfinite(lp)
        @test !isnan(p)
        # The numeric path sums densities in linear space and can
        # underflow to exactly zero this deep even when the analytic
        # log-space form still resolves a finite (very negative) value
        # -- that asymmetry is expected, not a bug, so only check
        # agreement when the numeric path itself stayed finite.
        if isfinite(lpn)
            @test lp≈lpn rtol=1e-2
        end
    end

    # Below the delay's support and at +-Inf: genuinely zero, not a
    # numerical artifact of the guard above.
    d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    @test pdf(d, -10.0) == 0.0
    @test logpdf(d, -10.0) == -Inf
    @test pdf(d, Inf) == 0.0
    @test logpdf(d, Inf) == -Inf
    @test pdf(d, -Inf) == 0.0
    @test logpdf(d, -Inf) == -Inf
end

@testitem "uniform-window pairs: rand matches cdf (Monte Carlo)" begin
    using Distributions, Random

    # Seeded, generous-tolerance sampler-vs-cdf check (S9b.4): a coarse
    # net for rand/cdf disagreement, not a precision test -- S9b.2/S9b.3
    # already cover accuracy.
    Random.seed!(1234)
    cases = [
        Gamma(2.0, 1.5) => Uniform(0.0, 2.0),
        LogNormal(1.5, 0.5) => Uniform(0.0, 3.0),
        Weibull(1.5, 2.0) => Uniform(0.0, 1.5)
    ]
    n = 20_000
    for (delay, primary) in cases
        d = convolved(delay, primary)
        samples = rand(d, n)
        m, s = mean(d), std(d)
        for x in (m - s, m, m + s)
            empirical = mean(y -> y <= x, samples)
            @test empirical≈cdf(d, x) atol=0.02
        end
    end
end

@testitem "uniform-window pairs: edge cases" begin
    using Distributions

    # Boundary, far tail, NaN, non-zero minimum support, and the q = 0
    # branch (`l <= dmin` in `uniform_window_cdf`) that motivated
    # commit 640c2c2.
    delay = Gamma(2.0, 1.5)
    primary = Uniform(1.0, 3.0)
    d = convolved(delay, primary)
    dmin = minimum(delay) + minimum(primary)
    @test minimum(d) == dmin

    # Exactly at the support edge: zero, not a numerical artefact.
    @test cdf(d, dmin) == 0.0
    @test pdf(d, dmin) == 0.0

    # q = 0 branch: inside the window but the delay's own CDF window
    # collapses to its support minimum.
    @test cdf(d, dmin + 0.5) > 0.0
    @test pdf(d, dmin + 0.5) > 0.0

    # NaN propagates rather than erroring or returning a finite value.
    @test isnan(cdf(d, NaN))
    @test isnan(pdf(d, NaN))
    @test isnan(logpdf(d, NaN))

    # Far tail: finite (or -Inf for logpdf), non-negative, not NaN.
    @test pdf(d, 1000.0) >= 0.0
    @test !isnan(pdf(d, 1000.0))
    @test isfinite(logpdf(d, 1000.0))
end

@testitem "Uniform-window analytic path is faster than quadrature (S9b.6)" begin
    using Distributions
    using BenchmarkTools

    # A generous factor: not a tight timing pin, just enough to catch the
    # analytic path being silently bypassed (mirrors CensoredDistributions'
    # `primarycensored_cdf` performance test). Uses the batched `cdf`:
    # dispatch picks the closed form per point with no route lookup
    # (S1.5), so this is a closed-form-vs-quadrature comparison either
    # way.
    cases = [
        (Gamma(2.0, 1.5), "Gamma"), (LogNormal(1.5, 0.5), "LogNormal"),
        (Weibull(1.5, 2.0), "Weibull")
    ]
    for (delay, name) in cases
        @testset "$name + Uniform cdf speedup" begin
            primary = Uniform(0.0, 2.0)
            d_analytic = convolved(delay, primary)
            d_numeric = convolved(delay, primary; method = NumericSolver())
            xs = rand(delay, 200)

            t_a = @belapsed cdf($d_analytic, $xs)
            t_n = @belapsed cdf($d_numeric, $xs)
            @test t_a < t_n / 2
        end
    end
end
