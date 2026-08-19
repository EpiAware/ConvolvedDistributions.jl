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
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol = 1.0e-9
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol = 1.0e-6
            @test pdf(d_analytic, x) ≈ pdf(d_numeric, x) atol = 1.0e-6 rtol = 1.0e-3
            @test logpdf(d_analytic, x) ≈ logpdf(d_numeric, x) atol = 1.0e-4
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
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol = 1.0e-9
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol = 1.0e-6
            @test pdf(d_analytic, x) ≈ pdf(d_numeric, x) atol = 1.0e-6 rtol = 1.0e-3
            @test logpdf(d_analytic, x) ≈ logpdf(d_numeric, x) atol = 1.0e-3
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
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol = 1.0e-6
            # `k = 0.7`'s density is near-singular at 0, so `NumericSolver`'s
            # own fixed-panel pdf quadrature (not the closed form, which
            # matches a finite difference of the cdf above to ~1e-9) is
            # only accurate to ~0.5% there -- rtol reflects that reference
            # limit, not the closed form's own accuracy. Since `logcdf`
            # now routes through the same closed form as `cdf` rather
            # than a fresh quadrature, its agreement with the numeric
            # arm's `logcdf` inherits the same ~0.5% ceiling.
            @test pdf(d_analytic, x) ≈ pdf(d_numeric, x) atol = 1.0e-6 rtol = 1.0e-2
            @test logpdf(d_analytic, x) ≈ logpdf(d_numeric, x) atol = 1.0e-2
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol = 1.0e-4
        end
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "Weibull partial_expectation guard: non-positive input" begin
    using ConvolvedDistributions: partial_expectation
    using Distributions

    # `partial_expectation(component::Weibull)` guards `t <= 0` and
    # returns exactly zero there rather than evaluating the closed
    # form; this is unreachable from `uniform_window_cdf` itself, so
    # exercise the closure directly at and below the boundary.
    for (k, lambda) in ((2.0, 1.5), (1.5, 2.0), (0.7, 3.0))
        M = partial_expectation(Weibull(k, lambda))
        @test M(0.0) == 0.0
        @test M(-1.0) == 0.0
        @test M(-1.0e-12) == 0.0
    end
end

@testitem "Gamma partial_expectation/upper_partial_expectation survive extreme shape" begin
    # `Γ(k+1)` overflows to `Inf` for an extreme shape (e.g. k ~ 1e32),
    # and `y^k` also overflows for `y = t/θ` not tiny, so the remainder
    # term computed as `y^k * exp(-y) / Γ(k+1)` would be an `Inf * 0`
    # indeterminate returning `NaN`, even though the term is genuinely
    # negligible there. The log-space form must underflow to `0`
    # correctly instead. Both components below have `θ = 1`, so `y = t`
    # is never tiny for the tested `t` and the overflow is genuinely
    # exercised (a large `θ` alongside a large `k` keeps `y` small enough
    # that `y^k` underflows cleanly on its own, without needing the fix).
    using ConvolvedDistributions: partial_expectation, upper_partial_expectation
    using Distributions

    for component in (
            Gamma(1.0097410503568854e32, 1.0),
            Gamma(5.363748528908569e195, 1.0),
        )
        pe = partial_expectation(component)
        upe = upper_partial_expectation(component)
        for t in (1.0, 4.0, 100.0)
            @test !isnan(pe(t))
            @test !isnan(upe(t))
            # Both terms are negligible in the extreme left tail of a
            # distribution centred at an astronomically large mean, so
            # the lower partial expectation is ~0 and the upper one is
            # ~the whole mean.
            @test pe(t) ≈ 0.0 atol = 1.0e-6
            @test upe(t) ≈ mean(component) rtol = 1.0e-6
        end
    end

    # Ordinary shapes must still round-trip: pe(t) + upe(t) == mean.
    for component in (Gamma(2.0, 1.5), Gamma(0.5, 3.0), Gamma(10.0, 0.2))
        pe = partial_expectation(component)
        upe = upper_partial_expectation(component)
        for t in (0.5, 2.0, 8.0)
            @test pe(t) + upe(t) ≈ mean(component) rtol = 1.0e-10
        end
    end
end

@testitem "Weibull upper_partial_expectation guard: non-positive input" begin
    using ConvolvedDistributions: upper_partial_expectation
    using Distributions

    # `upper_partial_expectation(component::Weibull)` guards `t <= 0`
    # and returns exactly `mean(component)` there rather than
    # evaluating the closed form; this is unreachable from
    # `uniform_window_ccdf` itself, so exercise the closure directly
    # at and below the boundary.
    for (k, lambda) in ((2.0, 1.5), (1.5, 2.0), (0.7, 3.0))
        component = Weibull(k, lambda)
        N = upper_partial_expectation(component)
        m = mean(component)
        @test N(0.0) == m
        @test N(-1.0) == m
        @test N(-1.0e-12) == m
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

    h = 1.0e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        @test gc[i] ≈ (fc(θp) - fc(θm)) / (2h) atol = 1.0e-6
        @test glc[i] ≈ (flc(θp) - flc(θm)) / (2h) atol = 1.0e-6
    end

    # Batched cdf differentiates too, and matches the pointwise gradient.
    fb = θ -> sum(
        cdf(convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), [1.0, 3.0])
    )
    gb = ForwardDiff.gradient(fb, θ)
    @test all(isfinite, gb)
end

@testitem "LogNormal + Uniform pair cdf/logcdf ForwardDiff gradient" begin
    using Distributions, ForwardDiff

    fc = θ -> cdf(convolved(LogNormal(θ[1], θ[2]), Uniform(0.0, 3.0)), 4.0)
    flc = θ -> logcdf(
        convolved(LogNormal(θ[1], θ[2]), Uniform(0.0, 3.0)), 4.0
    )
    θ = [1.5, 0.5]

    gc = ForwardDiff.gradient(fc, θ)
    glc = ForwardDiff.gradient(flc, θ)
    @test all(isfinite, gc)
    @test all(isfinite, glc)

    h = 1.0e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        @test gc[i] ≈ (fc(θp) - fc(θm)) / (2h) atol = 1.0e-6
        @test glc[i] ≈ (flc(θp) - flc(θm)) / (2h) atol = 1.0e-6
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

    h = 1.0e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        @test gc[i] ≈ (fc(θp) - fc(θm)) / (2h) atol = 1.0e-6
        @test glc[i] ≈ (flc(θp) - flc(θm)) / (2h) atol = 1.0e-6
    end
end

@testitem "Uniform-window logcdf/ccdf/logccdf are analytic, both orders" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    pairs = (
        (Gamma(2.0, 1.5), Uniform(0.0, 2.0)),
        (LogNormal(1.5, 0.5), Uniform(0.0, 3.0)),
        (Weibull(1.5, 2.0), Uniform(0.0, 1.5)),
    )
    for (component, window) in pairs
        for d in (convolved(component, window), convolved(window, component))
            @test evaluation_path(d, logcdf) === :analytic
            @test evaluation_path(d, ccdf) === :analytic
            @test evaluation_path(d, logccdf) === :analytic

            lo = minimum(d)
            hi = isfinite(lo) ? lo + 20.0 : 20.0
            grid = range(lo - 1.0, hi; length = 40)
            for x in grid
                cdf_val = cdf(d, x)
                logcdf_val = logcdf(d, x)
                if cdf_val > 0
                    @test logcdf_val == log(cdf_val)
                else
                    @test logcdf_val == -Inf
                end

                ccdf_val = ccdf(d, x)
                logccdf_val = logccdf(d, x)
                if ccdf_val > 0
                    @test logccdf_val == log(ccdf_val)
                else
                    @test logccdf_val == -Inf
                end

                @test cdf_val + ccdf_val ≈ 1.0 atol = 1.0e-12
                @test 0.0 <= ccdf_val <= 1.0
            end
            @test issorted(-[ccdf(d, x) for x in grid])
        end
    end
end

@testitem "Uniform-window ccdf stays accurate where 1 - cdf cancels" begin
    using ConvolvedDistributions: integrate, GaussLegendre
    using Distributions

    reference(component, window, x) = integrate(
        GaussLegendre(; n = 256), t -> ccdf(component, t),
        x - maximum(window), x - minimum(window)
    ) /
        (maximum(window) - minimum(window))

    d = convolved(LogNormal(1.0, 0.5), Uniform(0.5, 1.5))
    component, window = LogNormal(1.0, 0.5), Uniform(0.5, 1.5)
    for x in (50.0, 100.0, 200.0)
        @test ccdf(d, x) ≈ reference(component, window, x) rtol = 1.0e-10
    end
    @test 1 - cdf(d, 200.0) == 0.0
    @test ccdf(d, 200.0) > 0.0

    dg = convolved(Gamma(2.0, 1.5), Uniform(0.0, 1.0))
    cg, wg = Gamma(2.0, 1.5), Uniform(0.0, 1.0)
    @test ccdf(dg, 20.0) ≈ reference(cg, wg, 20.0) rtol = 1.0e-10
    @test ccdf(dg, 30.0) ≈ reference(cg, wg, 30.0) rtol = 1.0e-6

    dw = convolved(Weibull(1.5, 2.0), Uniform(0.0, 0.5))
    cw, ww = Weibull(1.5, 2.0), Uniform(0.0, 0.5)
    @test ccdf(dw, 20.0) ≈ reference(cw, ww, 20.0) rtol = 1.0e-2
end

@testitem "Gamma uniform-window ccdf matches naive 1-cdf deep in the tail" begin
    using Distributions

    # `Gamma`'s dedicated survival form should stay no worse than the
    # naive `1 - cdf` anywhere, matching the pattern for LogNormal/
    # Weibull uniform-window pairs, where the dedicated form is orders
    # of magnitude MORE accurate than `1 - cdf` in the far tail.
    dist = Gamma(2.0, 3.0)
    primary = Uniform(0.0, 1.0)
    d = convolved(primary, dist)
    for k in 8:12
        x = maximum(primary) + quantile(dist, 1 - 10.0^(-k))
        naive = 1 - cdf(d, x)
        dedicated = ccdf(d, x)
        @test dedicated ≈ naive rtol = 1.0e-2
    end
end

@testitem "Uniform-window Gamma pair survives extreme shape on the analytic path" begin
    # Gamma + Uniform is a registered analytic pair, so `convolved`'s
    # default `AnalyticalSolver` routes through `partial_expectation`/
    # `upper_partial_expectation(::Gamma)` directly, rather than through
    # `_window_quantile`'s numeric quadrature path (which the same
    # extreme-shape class of parameter also affects, for a component
    # with no registered analytic pair).
    using Distributions

    for shape_param in (
            1.0097410503568854e32, 5.363748528908569e195,
        )
        d = convolved(Uniform(0.0, 1.0), Gamma(shape_param, 1.0))
        for x in (0.5, 1.0, 5.0, 100.0)
            @test !isnan(cdf(d, x))
            @test !isnan(pdf(d, x))
            @test !isnan(logpdf(d, x))
        end
    end
end

@testitem "Uniform-window cdf/ccdf are probabilities at the extremes" begin
    using Distributions

    pairs = (
        (Gamma(2.0, 1.5), Uniform(0.0, 2.0)),
        (LogNormal(1.5, 0.5), Uniform(0.0, 3.0)),
        (Weibull(1.5, 2.0), Uniform(0.0, 1.5)),
    )
    for (component, window) in pairs
        d = convolved(component, window)
        @test cdf(d, Inf) == 1.0
        @test logcdf(d, Inf) == 0.0
        @test ccdf(d, Inf) == 0.0
        @test logccdf(d, Inf) == -Inf

        @test cdf(d, -Inf) == 0.0
        @test ccdf(d, -Inf) == 1.0

        @test isnan(cdf(d, NaN))
        @test isnan(logcdf(d, NaN))
        @test isnan(ccdf(d, NaN))
        @test isnan(logccdf(d, NaN))
    end

    narrow = convolved(Gamma(2.0, 1.0), Uniform(0.0, 1.0e-6))
    @test cdf(narrow, 25.0) <= 1.0
    @test logcdf(narrow, 25.0) <= 0.0
end

@testitem "Uniform-window ccdf/logccdf ForwardDiff gradient" begin
    using Distributions, ForwardDiff

    cases = (
        (
            θ -> convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), [2.0, 1.5],
            3.0,
        ),
        (
            θ -> convolved(LogNormal(θ[1], θ[2]), Uniform(0.0, 3.0)), [1.5, 0.5],
            4.0,
        ),
        (
            θ -> convolved(Weibull(θ[1], θ[2]), Uniform(0.0, 1.5)), [1.5, 2.0],
            2.5,
        ),
    )
    for (build, θ, x) in cases
        fq = θ -> ccdf(build(θ), x)
        flq = θ -> logccdf(build(θ), x)

        gq = ForwardDiff.gradient(fq, θ)
        glq = ForwardDiff.gradient(flq, θ)
        @test all(isfinite, gq)
        @test all(isfinite, glq)

        h = 1.0e-6
        for i in eachindex(θ)
            θp = copy(θ)
            θm = copy(θ)
            θp[i] += h
            θm[i] -= h
            @test gq[i] ≈ (fq(θp) - fq(θm)) / (2h) atol = 1.0e-6
            @test glq[i] ≈ (flq(θp) - flq(θm)) / (2h) atol = 1.0e-6
        end
    end
end

@testitem "solver dispatch scoping: NumericSolver bypass" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    d = convolved(
        Gamma(2.0, 1.5), Uniform(0.0, 2.0); method = NumericSolver()
    )
    @test evaluation_path(d, cdf) === :numeric
    @test evaluation_path(d, pdf) === :numeric

    # The scalar/batched cdf and pdf therefore differ from the analytic
    # pair's exact values (they run quadrature instead).
    da = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    @test cdf(d, 3.0) ≈ cdf(da, 3.0) atol = 1.0e-9
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

    for d in (
            convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0)),
            convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        )
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
        Exponential(2.0) => Uniform(0.0, 2.0),
    ]

    for (delay, primary) in cases
        d = convolved(delay, primary)
        dn = convolved(delay, primary; method = NumericSolver())
        for x in (-5.0, -1.0, 0.5, 1.0, 3.0, 6.0, 15.0)
            @test pdf(d, x) ≈ pdf(dn, x) atol = 1.0e-6 rtol = 1.0e-3
            @test logpdf(d, x) ≈ logpdf(dn, x) atol = 1.0e-4 rtol = 1.0e-4
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
    for w in (1.0e-1, 1.0e-2, 1.0e-3, 1.0e-4, 1.0e-5, 1.0e-6)
        d = convolved(delay, Uniform(0.0, w))
        dn = convolved(delay, Uniform(0.0, w); method = NumericSolver())
        for x in (0.1, 3.0, 10.0)
            p = pdf(d, x)
            @test isfinite(p)
            @test p >= 0.0
            @test p ≈ pdf(dn, x) rtol = 1.0e-3
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
        Exponential(2.0) => 800.0,
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
            @test lp ≈ lpn rtol = 1.0e-2
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
        Weibull(1.5, 2.0) => Uniform(0.0, 1.5),
    ]
    n = 20_000
    for (delay, primary) in cases
        d = convolved(delay, primary)
        samples = rand(d, n)
        m, s = mean(d), std(d)
        for x in (m - s, m, m + s)
            empirical = mean(y -> y <= x, samples)
            @test empirical ≈ cdf(d, x) atol = 0.02
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

@testitem "Uniform + Uniform tie-break for pdf/logpdf" begin
    using Distributions

    # `convolved_pdf`/`convolved_logpdf` mirror the (delay, primary) order
    # for every `UnivariateDistribution` delay, including `Uniform`
    # itself -- the resulting method collision at (Uniform, Uniform) is
    # resolved by a dedicated tie-break method (S1.5). Checked against
    # NumericSolver since the density is exact and symmetric either way.
    d = convolved(Uniform(0.0, 1.0), Uniform(0.5, 1.5))
    dn = convolved(
        Uniform(0.0, 1.0), Uniform(0.5, 1.5); method = NumericSolver()
    )
    for x in (0.2, 0.75, 1.2, 1.6)
        @test pdf(d, x) ≈ pdf(dn, x) atol = 1.0e-9
        @test logpdf(d, x) ≈ logpdf(dn, x) atol = 1.0e-6
    end
end

@testitem "vector-x pdf/logpdf agree with scalar, both component orders" begin
    using Distributions

    # Only `cdf`'s vector form is checked against its scalar counterpart
    # elsewhere in this file; `pdf`/`logpdf` have their own vector-`x`
    # skeleton methods (S1.4), mirrored the same way as the scalar ones,
    # so exercise all four combinations: (delay, primary) and
    # (primary, delay) order, `pdf` and `logpdf`.
    xs = [0.5, 1.0, 2.0, 3.0]

    forward = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    reversed = convolved(Uniform(0.0, 2.0), Gamma(2.0, 1.5))
    for d in (forward, reversed)
        @test pdf(d, xs) == [pdf(d, x) for x in xs]
        @test logpdf(d, xs) == [logpdf(d, x) for x in xs]
    end

    # The (Uniform, Uniform) tie-break also has its own vector-`x` method.
    du = convolved(Uniform(0.0, 1.0), Uniform(0.5, 1.5))
    @test pdf(du, xs) == [pdf(du, x) for x in xs]
    @test logpdf(du, xs) == [logpdf(du, x) for x in xs]

    # And the mirrored vector-`x` cdf, not just the forward order checked
    # above.
    @test cdf(reversed, xs) == [cdf(reversed, x) for x in xs]
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
        (Weibull(1.5, 2.0), "Weibull"),
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
