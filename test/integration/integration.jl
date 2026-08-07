# Tests for the pluggable integration interface: the core default
# `GaussLegendre` solver, its numerical equivalence to an Integrals.jl
# GaussLegendre path, and the optional Integrals.jl extension routing.

@testitem "Default GaussLegendre integrate is accurate" begin
    using ConvolvedDistributions: integrate, GaussLegendre, gl_integrate

    solver = GaussLegendre(; n = 64)
    # ∫ x^2 dx over [0, 1] = 1/3
    @test integrate(solver, x -> x^2, 0.0, 1.0) ≈ 1 / 3 atol=1e-13
    # ∫ exp(x) dx over [0, 2] = e^2 - 1
    @test integrate(solver, x -> exp(x), 0.0, 2.0) ≈ exp(2) - 1 atol=1e-12
    # gl_integrate matches integrate through the default solver.
    @test gl_integrate(x -> x^2, 0.0, 1.0,
        ConvolvedDistributions._gl_rule(64)) ≈ integrate(solver, x -> x^2, 0.0, 1.0)
    # Degenerate window returns a typed zero.
    @test integrate(solver, x -> x^2, 1.0, 1.0) == 0.0
end

@testitem "Convolution numeric path reproduces Integrals.jl GaussLegendre" begin
    using Distributions
    using Integrals: Integrals, IntegralProblem, solve

    # Convolution numeric path: compare the package's `convolved`
    # CDF against an independent Integrals.jl GaussLegendre solve of the
    # same convolution integral.
    function reference_conv_cdf(c1, c2, x; n = 192)
        lower = max(minimum(c2), x - maximum(c1))
        upper = min(maximum(c2), x - minimum(c1))
        upper <= lower && return cdf(c2, x - maximum(c1)) > 0 ? 1.0 : 0.0
        cut = x - maximum(c1)
        saturated = cut > minimum(c2) ? cdf(c2, cut) : 0.0
        integrand(t, x) = cdf(c1, x - t) * pdf(c2, t)
        prob = IntegralProblem(integrand, (lower, upper), x)
        val = saturated + solve(prob, Integrals.GaussLegendre(; n = n))[1]
        clamp(val, 0.0, 1.0)
    end

    c1 = Gamma(2.0, 1.0)
    c2 = LogNormal(0.5, 0.4)
    dc = convolved(c1, c2)
    for x in (1.0, 2.0, 3.0, 5.0)
        @test cdf(dc, x) ≈ reference_conv_cdf(c1, c2, x) atol=1e-13
    end
end

@testitem "Integrals.jl extension routes QuadGKJL/HCubatureJL" begin
    using ConvolvedDistributions: integrate, GaussLegendre
    using Integrals: QuadGKJL, HCubatureJL

    default = GaussLegendre(; n = 64)
    for f in (x -> x^2, x -> exp(x), x -> sin(x) + 1)
        ref = integrate(default, f, 0.0, 1.5)
        @test integrate(QuadGKJL(), f, 0.0, 1.5) ≈ ref atol=1e-10
        @test integrate(HCubatureJL(), f, 0.0, 1.5) ≈ ref atol=1e-10
    end
end

@testitem "convolved agrees across integration solvers" begin
    using Distributions
    using Integrals: QuadGKJL, IntegralProblem, solve

    # Smooth, non-analytic pair: the default numeric quadrature and an
    # Integrals.jl QuadGKJL reference agree on the convolution CDF.
    c1 = Gamma(2.0, 1.5)
    c2 = LogNormal(0.5, 0.4)
    d = convolved(c1, c2)

    function quadgk_conv_cdf(c1, c2, x)
        lower = max(minimum(c2), x - maximum(c1))
        upper = min(maximum(c2), x - minimum(c1))
        upper <= lower && return cdf(c2, x - maximum(c1)) > 0 ? 1.0 : 0.0
        cut = x - maximum(c1)
        saturated = cut > minimum(c2) ? cdf(c2, cut) : 0.0
        prob = IntegralProblem((t, xx) -> cdf(c1, xx - t) * pdf(c2, t),
            (lower, upper), x)
        clamp(saturated + solve(prob, QuadGKJL())[1], 0.0, 1.0)
    end
    for x in (1.0, 2.0, 3.0, 5.0)
        @test cdf(d, x) ≈ quadgk_conv_cdf(c1, c2, x) atol=1e-6
    end
end

@testitem "Non-default GaussLegendre payload raises nodal accuracy" begin
    using Distributions
    using ConvolvedDistributions
    using ConvolvedDistributions: GaussLegendre, NumericSolver

    # A non-default payload is honoured: a 256-node GaussLegendre raises
    # the nodal accuracy of the numeric convolution.
    c1 = Gamma(2.0, 1.0)
    c2 = LogNormal(0.5, 0.4)
    d_default = convolved(c1, c2)
    d_custom = convolved(c1, c2;
        method = NumericSolver(GaussLegendre(; n = 256)))

    # The custom 256-node path agrees with the default native quadrature.
    for x in (1.0, 2.0, 3.0, 5.0, 8.0)
        @test cdf(d_custom, x) ≈ cdf(d_default, x) atol=1e-8
    end

    # And the custom payload also drives the vector route correctly.
    xs = [1.0, 2.0, 3.0, 5.0, 8.0]
    @test cdf(d_custom, xs) ≈ cdf(d_default, xs) atol=1e-8
    @test pdf(d_custom, xs) ≈ pdf(d_default, xs) atol=1e-8

    # Far-tail guard: the custom path must stay mass-correct on a huge
    # window (a single fixed rule would collapse to ~0).
    @test cdf(d_custom, 1e6) > 0.999
end

@testitem "Integrals.jl algorithm payloads are honoured via the extension" begin
    using Distributions
    using ConvolvedDistributions
    using ConvolvedDistributions: NumericSolver, AnalyticalSolver
    using Integrals: QuadGKJL, HCubatureJL

    # Loading the extension, an Integrals.jl algorithm payload is honoured:
    # the integration window routes through IntegralProblem/solve, and both
    # a NumericSolver and an AnalyticalSolver payload agree with the default
    # numeric path within a reasonable tolerance.
    c1 = Gamma(2.0, 1.0)
    c2 = LogNormal(0.5, 0.4)
    d_default = convolved(c1, c2)
    d_quad = convolved(c1, c2; method = NumericSolver(QuadGKJL()))
    d_hc = convolved(c1, c2; method = AnalyticalSolver(HCubatureJL()))

    for x in (1.0, 2.0, 3.0, 5.0)
        @test cdf(d_quad, x) ≈ cdf(d_default, x) atol=1e-6
        @test cdf(d_hc, x) ≈ cdf(d_default, x) atol=1e-6
    end

    # Vector routes fall back to per-point scalar solves for custom payloads.
    xs = [1.0, 2.0, 3.0, 5.0]
    @test cdf(d_quad, xs) ≈ cdf(d_default, xs) atol=1e-6
    @test pdf(d_quad, xs) ≈ pdf(d_default, xs) atol=1e-6

    # Far-tail guard: the custom path must not collapse at large x.
    @test cdf(d_quad, 1e6) > 0.999
    @test cdf(d_hc, 1e6) > 0.999
end

@testitem "Custom solver payloads honoured by Difference/Product/Ratio" begin
    using Distributions
    using ConvolvedDistributions
    using ConvolvedDistributions: NumericSolver, GaussLegendre
    using Integrals: QuadGKJL

    # The same custom-payload support applies to the other operators: a
    # non-default GaussLegendre and an Integrals.jl algorithm agree with
    # each operator's default numeric path mid-range, and stay mass-correct
    # at far tails.
    makers = (
        s -> difference(Gamma(2.0, 1.0), Gamma(3.0, 1.0); method = s),
        s -> product(Gamma(2.0, 1.0), LogNormal(0.5, 0.4); method = s),
        s -> ratio(Gamma(2.0, 1.0), LogNormal(0.5, 0.4); method = s)
    )
    xs = [1.0, 2.0, 4.0, 8.0]
    for mk in makers
        d_default = mk(NumericSolver())
        d_gl = mk(NumericSolver(GaussLegendre(; n = 256)))
        d_q = mk(NumericSolver(QuadGKJL()))
        for x in xs
            @test cdf(d_gl, x) ≈ cdf(d_default, x) atol=1e-8
            @test cdf(d_q, x) ≈ cdf(d_default, x) atol=1e-6
        end
        # Far-tail guard: custom path must not collapse.
        @test cdf(d_gl, 1e6) > 0.99
        @test cdf(d_q, 1e6) > 0.99
    end
end
