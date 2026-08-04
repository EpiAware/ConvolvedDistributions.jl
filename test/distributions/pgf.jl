@testitem "pgf identities: pgf(d, 1) == 1, pgf(d, 0) == pdf(d, 0)" begin
    using ConvolvedDistributions: pgf
    using Distributions

    for d in (Poisson(2.0), Bernoulli(0.3), Binomial(5, 0.3),
        Geometric(0.4), NegativeBinomial(3, 0.2))
        @test pgf(d, 1) ≈ 1
        @test pgf(d, 0) ≈ pdf(d, 0)
    end
end

@testitem "pgf closed forms match the known generating functions" begin
    using ConvolvedDistributions: pgf
    using Distributions

    s = 0.5
    @test pgf(Poisson(2.0), s) ≈ exp(2.0 * (s - 1))
    @test pgf(Bernoulli(0.3), s) ≈ 1 - 0.3 + 0.3 * s
    @test pgf(Binomial(5, 0.3), s) ≈ (1 - 0.3 + 0.3 * s)^5
    @test pgf(Geometric(0.4), s) ≈ 0.4 / (1 - (1 - 0.4) * s)
    @test pgf(NegativeBinomial(3, 0.2), s) ≈ (0.2 / (1 - (1 - 0.2) * s))^3
end

@testitem "pgf domain guard for Geometric/NegativeBinomial" begin
    using ConvolvedDistributions: pgf
    using Distributions

    p = 0.4
    bound = 1 / (1 - p)
    @test_throws DomainError pgf(Geometric(p), bound)
    @test_throws DomainError pgf(Geometric(p), -bound)
    @test isfinite(pgf(Geometric(p), bound - 1.0e-6))

    r, pn = 3.0, 0.2
    boundn = 1 / (1 - pn)
    @test_throws DomainError pgf(NegativeBinomial(r, pn), boundn)
end

@testitem "_pgf_ratio_domain_guard directly, both branches" begin
    # Geometric/NegativeBinomial's closed forms both delegate the
    # |s| < 1/(1-p) check to this shared helper (rather than repeating
    # the guard); test it directly, not only through the two closed
    # forms that call it, so the guard's own contract (both the success
    # return and the throw) is pinned independent of either family.
    using ConvolvedDistributions: _pgf_ratio_domain_guard

    p = 0.4
    bound = 1 / (1 - p)
    @test _pgf_ratio_domain_guard(:Geometric, p, bound - 1.0e-6) === nothing
    @test_throws DomainError _pgf_ratio_domain_guard(:Geometric, p, bound)
    @test_throws DomainError _pgf_ratio_domain_guard(:Geometric, p, -bound)
end

@testitem "pgf fallback matches a hand-derived finite sum" begin
    using ConvolvedDistributions: pgf
    using Distributions

    d = DiscreteUniform(0, 5)
    s = 0.7
    expected = sum(k -> s^k * pdf(d, k), 0:5)
    @test pgf(d, s) ≈ expected
    @test pgf(d, 1) ≈ 1
    @test pgf(d, 0) ≈ pdf(d, 0)
end

@testitem "pgf fallback agrees with a closed form when forced via invoke" begin
    using ConvolvedDistributions: pgf
    using Distributions

    d = Poisson(2.0)
    s = 0.5
    fallback_value = invoke(
        pgf, Tuple{DiscreteUnivariateDistribution, Real}, d, s)
    @test fallback_value ≈ pgf(d, s) atol=1.0e-10
end

@testitem "pgf fallback errors" begin
    using ConvolvedDistributions: pgf
    using Distributions

    # Unbounded below: no starting point for the sum.
    @test_throws ArgumentError pgf(Skellam(2.0, 3.0), 0.5)

    # Unbounded above, |s| > 1, no closed form registered: the tail
    # cannot be bounded.
    @test_throws DomainError invoke(
        pgf, Tuple{DiscreteUnivariateDistribution, Real}, Poisson(2.0), 1.5)

    # Pathologically slow mass convergence: the truncation cannot bound
    # the tail within the term budget, so it raises rather than
    # returning a partial sum.
    @test_throws ErrorException invoke(
        pgf, Tuple{DiscreteUnivariateDistribution, Real},
        Geometric(1.0e-8), 1.0)
end

@testitem "pgf on a continuous distribution has no method" begin
    using ConvolvedDistributions: pgf
    using Distributions

    @test_throws MethodError pgf(Normal(0.0, 1.0), 0.5)
end

@testitem "pgf of a Convolved of discrete components is the product" begin
    using ConvolvedDistributions: pgf
    using Distributions

    d = convolved(Poisson(2.0), Poisson(3.0))
    s = 0.4
    @test pgf(d, s) ≈ pgf(Poisson(2.0), s) * pgf(Poisson(3.0), s)
    @test pgf(d, s) ≈ pgf(Poisson(5.0), s)

    # Recurses through nesting.
    nested = convolved(convolved(Poisson(2.0), Poisson(1.0)), Poisson(3.0))
    @test pgf(nested, s) ≈ pgf(Poisson(6.0), s)
end

@testitem "pgf of a Convolved with a continuous component errors" begin
    using ConvolvedDistributions: pgf
    using Distributions

    d = convolved(Poisson(2.0), Normal(0.0, 1.0))
    err = try
        pgf(d, 0.5)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("Normal", err.msg)
end

@testitem "pgf dual-number propagation through a closed form and the fallback" begin
    using ConvolvedDistributions: pgf
    using Distributions
    using ForwardDiff

    # Closed form: d/dλ exp(λ(s-1)) = (s-1) exp(λ(s-1))
    s = 0.4
    g_closed = ForwardDiff.derivative(λ -> pgf(Poisson(λ), s), 2.0)
    @test g_closed ≈ (s - 1) * exp(2.0 * (s - 1)) atol=1.0e-10

    # Fallback: force NegativeBinomial through the generic series method
    # (bypassing its own closed form) via `invoke`, differentiate wrt
    # `p`, and compare against the closed-form derivative.
    r, sN = 4.0, 0.3
    fallback(p) = invoke(pgf,
        Tuple{DiscreteUnivariateDistribution, Real},
        NegativeBinomial(r, p), sN)
    closed(p) = (p / (1 - (1 - p) * sN))^r
    g_fallback = ForwardDiff.derivative(fallback, 0.6)
    g_analytic = ForwardDiff.derivative(closed, 0.6)
    @test g_fallback ≈ g_analytic rtol=1.0e-8
end
