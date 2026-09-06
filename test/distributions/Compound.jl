# Brute-force reference for the random-sum pmf, independent of the
# package's recursions: the mixture `Σ_n P(N = n) f^{*n}(z)` with the
# n-fold pmfs built by iterated discrete convolution, truncated at a
# generous `nmax` (far past where the count's mass is negligible).
@testsnippet CompoundBrute begin
    using Distributions

    function brute_pmf(count, summand, zmax::Int; nmax::Int = 300)
        f = [pdf(summand, j) for j in 0:zmax]
        g = zeros(zmax + 1)
        g[1] += pdf(count, 0)
        cur = copy(f)
        for n in 1:nmax
            g .+= pdf(count, n) .* cur
            cur = [
                sum(f[j + 1] * cur[z - j + 1] for j in 0:z)
                    for z in 0:zmax
            ]
        end
        return g
    end
end

@testitem "Compound constructor and fields" begin
    using Distributions

    d = compound(Poisson(3.0), Poisson(2.0))
    @test d isa Compound
    @test d.count == Poisson(3.0)
    @test d.summand == Poisson(2.0)
    @test d.method isa AnalyticalSolver

    dn = compound(Poisson(2.0), Bernoulli(0.3); method = NumericSolver())
    @test dn.method isa NumericSolver

    # Value support is derived from the summand alone: a lattice summand
    # gives a `Discrete`-typed compound, a `Gamma` summand a `Continuous`
    # one, whatever the count.
    @test Distributions.value_support(typeof(d)) === Discrete
    @test d isa DiscreteUnivariateDistribution
    dc = compound(Poisson(3.0), Gamma(2.0, 1.0))
    @test Distributions.value_support(typeof(dc)) === Continuous
    @test dc isa ContinuousUnivariateDistribution
end

@testitem "Compound rejects an invalid count or summand" begin
    using Distributions

    # The count must be integer-lattice discrete on the non-negative
    # integers.
    err = @test_throws ArgumentError compound(Gamma(2.0, 1.0), Poisson(2.0))
    @test occursin("Gamma", err.value.msg)
    @test occursin("non-negative integers", err.value.msg)
    @test_throws ArgumentError compound(DiscreteUniform(-1, 3), Poisson(2.0))
    @test_throws ArgumentError compound(
        DiscreteNonParametric([0.5, 1.5], [0.5, 0.5]), Poisson(2.0)
    )

    # The summand must have non-negative support.
    err2 = @test_throws ArgumentError compound(Poisson(3.0), Normal(0.0, 1.0))
    @test occursin("Normal", err2.value.msg)
    @test occursin("future work", err2.value.msg)
    @test_throws ArgumentError compound(Poisson(3.0), DiscreteUniform(-2, 2))

    # A continuous summand needs a registered `convolve_power` closed form.
    err3 = @test_throws ArgumentError compound(
        Poisson(3.0), LogNormal(0.0, 1.0)
    )
    @test occursin("LogNormal", err3.value.msg)
    @test occursin("convolve_power", err3.value.msg)
    @test_throws ArgumentError compound(Poisson(3.0), Weibull(1.5, 1.0))
    @test_throws ArgumentError compound(Poisson(3.0), Uniform(0.0, 1.0))
    @test compound(Poisson(3.0), Exponential(2.0)) isa Compound
    @test compound(Binomial(5, 0.4), Gamma(2.0, 1.0)) isa Compound

    # A Number is not a distribution, on either side.
    @test_throws ArgumentError compound(3, Poisson(2.0))
    @test_throws ArgumentError compound(Poisson(3.0), 2.0)
end

@testitem "Compound accepts duck-typed components that satisfy the rules" begin
    using Distributions, Random

    # A duck-typed count on the lattice: must declare an Integer eltype.
    struct DuckCount end
    Distributions.pdf(::DuckCount, k::Real) = pdf(Poisson(3.0), k)
    Distributions.logpdf(::DuckCount, k::Real) = logpdf(Poisson(3.0), k)
    Distributions.cdf(::DuckCount, k::Real) = cdf(Poisson(3.0), k)
    Distributions.quantile(::DuckCount, p::Real) = quantile(Poisson(3.0), p)
    Distributions.params(::DuckCount) = ()
    Distributions.mean(::DuckCount) = 3.0
    Distributions.var(::DuckCount) = 3.0
    Base.minimum(::DuckCount) = 0
    Base.maximum(::DuckCount) = Inf
    Base.eltype(::Type{DuckCount}) = Int
    Base.rand(rng::AbstractRNG, ::DuckCount) = rand(rng, Poisson(3.0))

    # A duck-typed lattice summand, likewise.
    struct DuckSummand end
    Distributions.pdf(::DuckSummand, k::Real) = pdf(Poisson(2.0), k)
    Distributions.logpdf(::DuckSummand, k::Real) = logpdf(Poisson(2.0), k)
    Distributions.quantile(::DuckSummand, p::Real) = quantile(Poisson(2.0), p)
    Distributions.params(::DuckSummand) = ()
    Distributions.mean(::DuckSummand) = 2.0
    Distributions.var(::DuckSummand) = 2.0
    Base.minimum(::DuckSummand) = 0
    Base.maximum(::DuckSummand) = Inf
    Base.eltype(::Type{DuckSummand}) = Int
    Base.rand(rng::AbstractRNG, ::DuckSummand) = rand(rng, Poisson(2.0))

    # A duck-typed count has no `(a, b, 0)` form, so it takes the direct
    # mixture route; a duck-typed summand under a Poisson count takes
    # the Panjer route (its masses are all the recursion reads).
    ref = compound(Poisson(3.0), Poisson(2.0))
    dcount = compound(DuckCount(), Poisson(2.0))
    dsummand = compound(Poisson(3.0), DuckSummand())
    @test Distributions.value_support(typeof(dcount)) === Discrete
    @test Distributions.value_support(typeof(dsummand)) === Discrete
    for k in 0:20
        @test pdf(dcount, k) ≈ pdf(ref, k) atol = 1.0e-10
        @test pdf(dsummand, k) ≈ pdf(ref, k) atol = 1.0e-12
        @test cdf(dcount, k) ≈ cdf(ref, k) atol = 1.0e-10
    end
    @test mean(dcount) == mean(ref)
    @test rand(MersenneTwister(1), dsummand) isa Int

    # A duck-typed count without an Integer eltype reads as continuous
    # and is rejected as a count.
    struct NoEltypeCount end
    Base.minimum(::NoEltypeCount) = 0
    @test_throws ArgumentError compound(NoEltypeCount(), Poisson(2.0))
end

@testitem "Compound params, eltype, sampler and rand" begin
    using Distributions, Random

    d = compound(Poisson(3.0), Poisson(2.0))
    @test params(d) == ((3.0,), (2.0,))
    @test eltype(d) == Int
    @test sampler(d) === d
    rng = MersenneTwister(1)
    @test rand(rng, d) isa Int
    @test all(x -> x >= 0, rand(rng, d, 50))

    # A Bernoulli summand has eltype Bool, but the SUM of Bernoullis is
    # an Int: `rand(d, n)` must not allocate a Bool container.
    db = compound(Poisson(2.0), Bernoulli(0.3))
    @test eltype(db) == Int
    draws = rand(rng, db, 200)
    @test eltype(draws) == Int
    @test maximum(draws) >= 2

    dc = compound(Poisson(3.0), Gamma(2.0, 1.0))
    @test eltype(dc) == Float64
    @test rand(rng, dc) isa Float64
    # A zero count gives exactly zero.
    d0 = compound(Dirac(0), Gamma(2.0, 1.0))
    @test rand(rng, d0) === 0.0
end

@testitem "Compound support and insupport" begin
    using Distributions

    d = compound(Poisson(3.0), Poisson(2.0))
    @test minimum(d) == 0
    @test maximum(d) == Inf
    @test insupport(d, 0)
    @test insupport(d, 7)
    @test !insupport(d, 2.5)
    @test !insupport(d, -1)

    # Bounded count and bounded summand: the ends multiply.
    db = compound(Binomial(4, 0.5), Bernoulli(0.3))
    @test minimum(db) == 0
    @test maximum(db) == 4
    @test !insupport(db, 5)

    # A zero-free count lifts the minimum.
    dz = compound(DiscreteNonParametric([2, 3], [0.5, 0.5]), Poisson(2.0))
    @test minimum(dz) == 0
    dz2 = compound(DiscreteNonParametric([2, 3], [0.5, 0.5]), Dirac(3))
    @test minimum(dz2) == 6
    @test maximum(dz2) == 9

    # Continuous: `0 * Inf` guarded, half-line support.
    dc = compound(Poisson(3.0), Gamma(2.0, 1.0))
    @test minimum(dc) == 0.0
    @test maximum(dc) == Inf
    @test insupport(dc, 0.0)
    @test insupport(dc, 2.5)
    @test !insupport(dc, -0.1)
    d0 = compound(Dirac(0), Gamma(2.0, 1.0))
    @test maximum(d0) == 0.0
end

@testitem "Compound moments match total variance and Monte Carlo" begin
    using Distributions, Random, Statistics

    cases = (
        compound(Poisson(3.0), Poisson(2.0)),
        compound(NegativeBinomial(4.0, 0.4), Geometric(0.3)),
        compound(Poisson(3.0), Gamma(2.0, 1.5)),
        compound(Binomial(10, 0.3), Exponential(2.0)),
    )
    rng = MersenneTwister(42)
    for d in cases
        μn, vn = mean(d.count), var(d.count)
        μx, vx = mean(d.summand), var(d.summand)
        @test mean(d) ≈ μn * μx
        @test var(d) ≈ μn * vx + vn * μx^2
        @test std(d) ≈ sqrt(var(d))

        draws = rand(rng, d, 400_000)
        @test mean(draws) ≈ mean(d) rtol = 2.0e-2
        @test var(draws) ≈ var(d) rtol = 4.0e-2
    end
end

@testitem "Compound Panjer vs brute force" setup = [CompoundBrute] begin
    using ConvolvedDistributions: evaluation_path, is_exact
    using ConvolvedDistributions.TestUtils: test_discrete_pmf
    using Distributions

    # Every (a, b, 0) count against a summand with mass at zero (Poisson)
    # and one bounded away from zero (a shifted Geometric on 1, 2, ...).
    shifted = DiscreteNonParametric(
        1:8, pdf.(Geometric(0.4), 0:7) ./
            sum(pdf.(Geometric(0.4), 0:7))
    )
    counts = (
        Poisson(3.0), Binomial(12, 0.35), NegativeBinomial(3.0, 0.45),
        Geometric(0.3),
    )
    summands = (Poisson(2.0), shifted)
    zmax = 40
    for count in counts, summand in summands
        d = compound(count, summand)
        g = brute_pmf(count, summand, zmax)
        for z in 0:zmax
            @test pdf(d, z) ≈ g[z + 1] atol = 1.0e-12
            @test cdf(d, z) ≈ sum(g[1:(z + 1)]) atol = 1.0e-12
        end
        @test evaluation_path(d) === :numeric
        @test is_exact(d)
        # Wide enough for the heavy-tailed Geometric count, whose
        # compound keeps more than the verifier's 1e-8 beyond 120.
        test_discrete_pmf(d; support = 0:400)
    end
end

@testitem "Compound generic count vs brute force" setup = [CompoundBrute] begin
    using ConvolvedDistributions: is_exact
    using ConvolvedDistributions.TestUtils: test_discrete_pmf
    using Distributions

    # A count outside the (a, b, 0) class takes the direct mixture.
    dnp = DiscreteNonParametric([0, 1, 2, 4, 7], [0.1, 0.3, 0.3, 0.2, 0.1])
    for summand in (Poisson(2.0), DiscreteNonParametric(1:3, [0.5, 0.3, 0.2]))
        d = compound(dnp, summand)
        g = brute_pmf(dnp, summand, 40)
        for z in 0:40
            @test pdf(d, z) ≈ g[z + 1] atol = 1.0e-12
            @test cdf(d, z) ≈ sum(g[1:(z + 1)]) atol = 1.0e-12
        end
        @test is_exact(d)
        test_discrete_pmf(d; support = 0:80)
    end

    # A nested Compound count: the outer mixture reads the inner's exact
    # pmf, and the inner is itself checked against brute force.
    inner = compound(Poisson(2.0), Poisson(1.0))
    outer = compound(inner, Poisson(1.5))
    g_outer = brute_pmf(inner, Poisson(1.5), 30; nmax = 120)
    for z in 0:30
        @test pdf(outer, z) ≈ g_outer[z + 1] atol = 1.0e-10
    end
    test_discrete_pmf(outer; support = 0:100)
end

@testitem "Compound nested summand vs brute force" setup = [CompoundBrute] begin
    using Distributions

    # The inner compound is a Discrete summand of the outer: the outer's
    # Panjer recursion calls `pdf(inner, j)` for its masses.
    inner = compound(Poisson(2.0), Poisson(1.0))
    outer = compound(Poisson(3.0), inner)
    g = brute_pmf(Poisson(3.0), inner, 30; nmax = 60)
    for z in 0:30
        @test pdf(outer, z) ≈ g[z + 1] atol = 1.0e-10
        @test cdf(outer, z) ≈ sum(g[1:(z + 1)]) atol = 1.0e-10
    end
    @test mean(outer) ≈ 3.0 * mean(inner)
end

@testitem "Compound thinning vs recursion" setup = [CompoundBrute] begin
    using ConvolvedDistributions: evaluation_path, _maybe_analytic
    using ConvolvedDistributions.TestUtils: test_analytic_skips_quadrature
    using Distributions

    pairs = (
        (Poisson(2.0), Bernoulli(0.3)) => Poisson(0.6),
        (Binomial(10, 0.4), Bernoulli(0.5)) => Binomial(10, 0.2),
        (NegativeBinomial(3.0, 0.4), Bernoulli(0.6)) =>
            NegativeBinomial(3.0, 0.4 / (1 - 0.6 * 0.4)),
        (Geometric(0.3), Bernoulli(0.5)) => Geometric(0.3 / (1 - 0.7 * 0.5)),
    )
    for ((count, summand), ref) in pairs
        d = compound(count, summand)
        @test evaluation_path(d) === :analytic
        @test _maybe_analytic(d) == ref
        test_analytic_skips_quadrature(d; x = 1)

        # The forced recursion agrees with the closed form, and both with
        # an independent brute-force mixture.
        dn = compound(count, summand; method = NumericSolver())
        @test evaluation_path(dn) === :numeric
        @test _maybe_analytic(dn) === nothing
        g = brute_pmf(count, summand, 25)
        for k in 0:25
            @test pdf(dn, k) ≈ pdf(ref, k) atol = 1.0e-12
            @test pdf(dn, k) ≈ g[k + 1] atol = 1.0e-12
            @test cdf(dn, k) ≈ cdf(ref, k) atol = 1.0e-12
            @test logpdf(d, k) == logpdf(ref, k)
        end
    end
end

@testitem "Compound continuous route is the exact n-fold mixture" begin
    using ConvolvedDistributions: evaluation_path, is_exact
    using Distributions, Random, Statistics

    count = Poisson(3.0)
    summand = Gamma(2.0, 1.0)
    d = compound(count, summand)
    @test evaluation_path(d) === :numeric
    @test is_exact(d)

    # The atom at zero: carried by the CDF, returned by `pdf` at zero.
    p0 = pdf(count, 0)
    @test pdf(d, 0.0) == p0
    @test logpdf(d, 0.0) == log(p0)
    @test cdf(d, 0.0) == p0
    @test cdf(d, -1.0) == 0.0
    @test pdf(d, -1.0) == 0.0

    # Term-by-term against the mixture written out by hand.
    for z in (0.5, 2.0, 5.0, 12.0)
        f = sum(pdf(count, n) * pdf(Gamma(2.0 * n, 1.0), z) for n in 1:80)
        F = p0 + sum(pdf(count, n) * cdf(Gamma(2.0 * n, 1.0), z) for n in 1:80)
        @test pdf(d, z) ≈ f atol = 1.0e-12
        @test cdf(d, z) ≈ F atol = 1.0e-12
    end

    # Density plus atom integrates to one (midpoint rule on a fine grid).
    dz = 0.01
    grid = (dz / 2):dz:80.0
    @test sum(pdf(d, z) for z in grid) * dz + p0 ≈ 1.0 atol = 1.0e-5

    # CDF against a Monte Carlo ECDF.
    rng = MersenneTwister(7)
    draws = rand(rng, d, 400_000)
    @test mean(iszero, draws) ≈ p0 atol = 2.0e-3
    for z in (0.5, 2.0, 5.0, 12.0)
        @test cdf(d, z) ≈ mean(draws .<= z) atol = 5.0e-3
    end

    # An Exponential summand folds to a Gamma too.
    de = compound(Poisson(2.0), Exponential(1.5))
    @test pdf(de, 1.0) ≈
        sum(pdf(Poisson(2.0), n) * pdf(Gamma(n, 1.5), 1.0) for n in 1:60)
end

@testitem "Compound log methods are mutually consistent" begin
    using Distributions

    dd = compound(Poisson(3.0), Poisson(2.0))
    dc = compound(Poisson(3.0), Gamma(2.0, 1.0))
    da = compound(Poisson(2.0), Bernoulli(0.3))
    for (d, zs) in (
            (dd, 0:12), (dc, (0.0, 0.5, 2.0, 6.0)), (da, 0:5),
        )
        for z in zs
            @test logpdf(d, z) ≈ log(pdf(d, z)) atol = 1.0e-10
            @test logcdf(d, z) ≈ log(cdf(d, z)) atol = 1.0e-10
            @test ccdf(d, z) ≈ 1 - cdf(d, z) atol = 1.0e-10
            @test logccdf(d, z) ≈ log1p(-cdf(d, z)) atol = 1.0e-8
        end
    end

    # Off the lattice a discrete compound carries no mass; the CDF is a
    # step function.
    @test pdf(dd, 2.5) == 0.0
    @test logpdf(dd, 2.5) == -Inf
    @test cdf(dd, 2.5) == cdf(dd, 2)
    @test logccdf(dd, -1) == 0.0
    @test logcdf(dd, -1) == -Inf

    # Far tails stay finite and saturate: the lattice route answers one
    # exactly beyond its cap, the mixture route to within the count's
    # tail clamp (the terms past `n_max` are the missing mass).
    @test cdf(dd, 1.0e10) == 1.0
    @test pdf(dd, 1.0e10) == 0.0
    @test cdf(dc, 1.0e10) ≈ 1.0 atol = 1.0e-7
    @test pdf(dc, 1.0e10) == 0.0
    @test cdf(dd, Inf) == 1.0
    @test cdf(dc, Inf) == 1.0
end

@testitem "Compound scalar methods value-correct and inferrable" begin
    using Distributions, Test

    analytic = compound(Poisson(2.0), Bernoulli(0.3))
    lattice = compound(Poisson(3.0), Poisson(2.0))
    mixture = compound(Poisson(3.0), Gamma(2.0, 1.0))
    for (d, z) in ((analytic, 1), (lattice, 4), (mixture, 2.0))
        for f in (cdf, logcdf, pdf, logpdf, ccdf, logccdf)
            @test f(d, z) isa Float64
        end
        @test (@inferred(cdf(d, z)); true)
        @test (@inferred(pdf(d, z)); true)
        @test (@inferred(logpdf(d, z)); true)
    end
end

@testitem "Compound discrete quantile is exact" begin
    # No `using Optimization, OptimizationOptimJL`: the exact lattice
    # route needs neither.
    using Distributions

    for d in (
            compound(Poisson(3.0), Poisson(2.0)),
            compound(Poisson(2.0), Bernoulli(0.3)),
            compound(NegativeBinomial(3.0, 0.4), Geometric(0.3)),
        )
        @test quantile(d, 0.0) === minimum(d)
        @test quantile(d, 1.0) === maximum(d)
        for p in (0.1, 0.3, 0.5, 0.7, 0.9, 0.99)
            q = quantile(d, p)
            @test q isa Int
            @test cdf(d, q - 1) < p <= cdf(d, q)
        end
    end

    # The thinning pair's lattice quantile is the closed form's own.
    da = compound(Poisson(2.0), Bernoulli(0.3))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        @test quantile(da, p) == quantile(Poisson(0.6), p)
    end

    @test_throws ArgumentError quantile(da, -0.1)
    @test_throws ArgumentError quantile(da, 1.1)
    @test_throws ArgumentError quantile(da, NaN)
end

@testitem "Compound continuous quantile inverts cdf" begin
    using ConvolvedDistributions: quantile_initial_guess
    using Distributions, Optimization, OptimizationOptimJL

    d = compound(Poisson(3.0), Gamma(2.0, 1.0))
    p0 = pdf(Poisson(3.0), 0)
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(d, p)
        @test cdf(d, q) ≈ p atol = 1.0e-3
    end
    @test quantile(d, 0.0) == 0.0
    @test quantile(d, 1.0) == Inf

    # The atom: every p up to P(N = 0) sits at exactly zero.
    @test quantile(d, p0 / 2) == 0.0
    @test quantile(d, p0) == 0.0

    # The Normal-approximation guess, clamped onto the support.
    for p in (0.01, 0.5, 0.9)
        expected = max(mean(d) + std(d) * quantile(Normal(), p), 0.0)
        @test quantile_initial_guess(d, p) == [expected]
    end
    dd = compound(Poisson(3.0), Poisson(2.0))
    @test quantile_initial_guess(dd, 0.5) == [round(mean(dd))]
    @test_throws ArgumentError quantile_initial_guess(d, 1.5)

    # rand on a truncated Compound routes through the base quantile.
    td = truncated(d, 1.0, 8.0)
    q = quantile(td, 0.5)
    @test cdf(td, q) ≈ 0.5 atol = 1.0e-3
    @test rand(td) isa Real
end

@testitem "Compound pgf composes count and summand" begin
    using ConvolvedDistributions: pgf
    using Distributions

    d = compound(Poisson(3.0), Poisson(2.0))
    for s in (-0.5, 0.0, 0.5, 1.0)
        @test pgf(d, s) ≈ pgf(Poisson(3.0), pgf(Poisson(2.0), s))
    end
    dn = compound(NegativeBinomial(3.0, 0.4), Geometric(0.3))
    @test pgf(dn, 0.5) ≈
        pgf(NegativeBinomial(3.0, 0.4), pgf(Geometric(0.3), 0.5))

    # The thinning identity through the pgf.
    dt = compound(Poisson(2.0), Bernoulli(0.3))
    @test pgf(dt, 0.5) ≈ pgf(Poisson(0.6), 0.5)

    # A nested compound composes again.
    outer = compound(Poisson(1.5), d)
    @test pgf(outer, 0.7) ≈ pgf(Poisson(1.5), pgf(d, 0.7))

    # A continuous summand has no pgf.
    err = @test_throws ArgumentError pgf(
        compound(Poisson(3.0), Gamma(2.0, 1.0)), 0.5
    )
    @test occursin("Gamma", err.value.msg)
end

@testitem "Compound nested in another combination" setup = [CompoundBrute] begin
    using Distributions, Random, Statistics

    # A Discrete compound inside the exact lattice fold of a Convolved:
    # compare with the brute-force pmf convolved once more by hand.
    inner = compound(Poisson(3.0), Poisson(2.0))
    d = convolved(inner, Poisson(1.0))
    @test Distributions.value_support(typeof(d)) === Discrete
    g = brute_pmf(Poisson(3.0), Poisson(2.0), 40)
    for z in 0:25
        ref = sum(g[j + 1] * pdf(Poisson(1.0), z - j) for j in 0:z)
        @test pdf(d, z) ≈ ref atol = 1.0e-10
    end
    # And as the discrete side of a mixed fold.
    dm = convolved(inner, Normal(0.0, 1.0))
    @test isfinite(cdf(dm, 3.0))
    ref_cdf = sum(g[j + 1] * cdf(Normal(0.0, 1.0), 3.0 - j) for j in 0:40)
    @test cdf(dm, 3.0) ≈ ref_cdf atol = 1.0e-6

    # A Continuous compound carrying the atom cannot be the integration
    # component of an outer quadrature: it throws, naming the situation.
    bad = convolved(Normal(0.0, 1.0), compound(Poisson(3.0), Gamma(2.0, 1.0)))
    err = try
        cdf(bad, 2.0)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("Gamma", err.msg)
    @test occursin("Poisson", err.msg)
    @test occursin("mass at zero", err.msg)

    # A Continuous compound with a zero-free count nests, and matches a
    # Monte Carlo estimate of the outer sum.
    zero_free = DiscreteNonParametric([1, 2, 3], [0.3, 0.4, 0.3])
    cz = compound(zero_free, Gamma(2.0, 1.0))
    ok = convolved(Normal(0.0, 1.0), cz)
    rng = MersenneTwister(3)
    draws = [rand(rng, Normal(0.0, 1.0)) + rand(rng, cz) for _ in 1:400_000]
    for z in (1.0, 3.0, 6.0)
        @test cdf(ok, z) ≈ mean(draws .<= z) atol = 5.0e-3
    end
end

@testitem "Compound strict construction" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    # Every Compound has an exact route, so `strict = true` never
    # rejects one: the closed form, the lattice recursion, and the
    # n-fold mixture all qualify, with or without a forced NumericSolver.
    @test evaluation_path(
        compound(Poisson(2.0), Bernoulli(0.3); strict = true)
    ) === :analytic
    @test compound(Poisson(3.0), Poisson(2.0); strict = true) isa Compound
    @test compound(Poisson(3.0), Gamma(2.0, 1.0); strict = true) isa Compound
    @test compound(
        Poisson(2.0), Bernoulli(0.3); method = NumericSolver(), strict = true
    ) isa Compound
end

@testitem "Compound helpers for duck-typed and power-free summands" begin
    using ConvolvedDistributions: _summand_power, _family_names,
        _window_quantile, is_exact
    using Distributions

    # A duck-typed summand with no registered `convolve_power` reads as
    # "no n-fold closed form", not as a MethodError.
    struct NoPowerSummand end
    Base.minimum(::NoPowerSummand) = 0
    Base.maximum(::NoPowerSummand) = Inf
    Base.eltype(::Type{NoPowerSummand}) = Int
    @test _summand_power(NoPowerSummand(), 2) === nothing

    # One that registers a closed form is asked through it.
    struct PowerSummand end
    function ConvolvedDistributions.convolve_power(::PowerSummand, n::Integer)
        return Gamma(2.0 * n, 1.0)
    end
    try
        @test _summand_power(PowerSummand(), 3) == Gamma(6.0, 1.0)
    finally
        # The method lives on the shared generic in ConvolvedDistributions,
        # so it outlives this testitem's module unless removed.
        Base.delete_method(
            only(
                methods(
                    ConvolvedDistributions.convolve_power,
                    Tuple{PowerSummand, Integer}
                )
            )
        )
    end

    # Both routes are exact, and the strict-construction error names the
    # component families in count-then-summand order.
    continuous = compound(Poisson(3.0), Gamma(2.0, 1.0))
    @test is_exact(continuous)
    @test is_exact(compound(Poisson(3.0), Poisson(2.0)))
    @test _family_names(continuous) == (:Poisson, :Gamma)

    # The composite window quantile of a lattice compound whose summand
    # has no `convolve_power` form falls back to `n` times the summand's
    # own window quantile, `n` the count's; a count that puts the window
    # below one summand returns zero.
    atoms = DiscreteNonParametric([1, 2], [0.5, 0.5])
    d = compound(Poisson(3.0), atoms)
    n = round(Int, _window_quantile(Poisson(3.0), 0.9))
    @test n >= 1
    @test _window_quantile(d, 0.9) == n * _window_quantile(atoms, 0.9)
    @test _window_quantile(compound(Poisson(1.0e-3), atoms), 0.5) == 0.0
end
