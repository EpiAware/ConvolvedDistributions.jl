@testitem "Ratio constructor and fields" begin
    using Distributions

    d = ratio(Normal(0.0, 1.0), Normal(0.0, 1.0))
    @test d isa ConvolvedDistributions.Ratio
    @test d.x == Normal(0.0, 1.0)
    @test d.y == Normal(0.0, 1.0)
    @test d.method isa AnalyticalSolver

    dn = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4); method = NumericSolver())
    @test dn.method isa NumericSolver
end

@testitem "Ratio params and eltype" begin
    using Distributions

    d = ratio(Uniform(0.0, 1.0), Uniform(1.0, 2.0))
    @test params(d) == ((0.0, 1.0), (1.0, 2.0))

    d2 = ratio(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test eltype(d2) == Float64
end

@testitem "Ratio support is the interval quotient" begin
    using Distributions

    d1 = ratio(Gamma(3.0, 1.0), Gamma(2.0, 1.0))
    @test minimum(d1) == 0.0
    @test maximum(d1) == Inf

    d2 = ratio(Uniform(1.0, 2.0), Uniform(1.0, 2.0))
    @test minimum(d2) ≈ 0.5
    @test maximum(d2) ≈ 2.0

    d3 = ratio(Uniform(1.0, 2.0), Uniform(-2.0, -1.0))
    @test minimum(d3) ≈ -2.0
    @test maximum(d3) ≈ -0.5

    d4 = ratio(Normal(0.0, 1.0), Normal(0.0, 1.0))
    @test minimum(d4) == -Inf
    @test maximum(d4) == Inf

    d5 = ratio(Uniform(1.0, 2.0), Uniform(0.0, 1.0))
    @test minimum(d5) ≈ 1.0
    @test maximum(d5) == Inf
end

@testitem "Ratio eltype and sampler" begin
    using Distributions, Random

    d = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test eltype(d) == Float64
    @test sampler(d) === d
    rng = MersenneTwister(1)
    @test rand(rng, d) isa Real
end

@testitem "Ratio Normal/Normal matches Cauchy" begin
    using Distributions

    x = Normal(0.0, 2.0)
    y = Normal(0.0, 0.5)
    d = ratio(x, y)
    ref = Cauchy(0.0, 4.0)

    for z in (-10.0, -1.0, 0.0, 1.0, 5.0)
        @test cdf(d, z) ≈ cdf(ref, z) atol=1e-10
        @test pdf(d, z) ≈ pdf(ref, z) atol=1e-10
        @test logpdf(d, z) ≈ logpdf(ref, z) atol=1e-8
        @test logcdf(d, z) ≈ logcdf(ref, z) atol=1e-8
        @test ccdf(d, z) ≈ ccdf(ref, z) atol=1e-10
    end
end

@testitem "Ratio Gamma/Gamma matches the scaled beta prime" begin
    using Distributions

    x = Gamma(2.0, 1.5)
    y = Gamma(3.0, 0.5)
    d = ratio(x, y)
    ref = 3.0 * BetaPrime(2.0, 3.0)

    for z in (0.1, 1.0, 5.0, 10.0)
        @test cdf(d, z) ≈ cdf(ref, z) atol=1e-10
        @test pdf(d, z) ≈ pdf(ref, z) atol=1e-10
        @test logpdf(d, z) ≈ logpdf(ref, z) atol=1e-8
        @test logcdf(d, z) ≈ logcdf(ref, z) atol=1e-8
        @test ccdf(d, z) ≈ ccdf(ref, z) atol=1e-10
    end
end

@testitem "Ratio Chisq/Chisq matches the scaled F" begin
    using Distributions

    x = Chisq(4)
    y = Chisq(6)
    d = ratio(x, y)
    ref = (4 / 6) * FDist(4, 6)

    for z in (0.1, 1.0, 3.0, 8.0)
        @test cdf(d, z) ≈ cdf(ref, z) atol=1e-10
        @test pdf(d, z) ≈ pdf(ref, z) atol=1e-10
        @test logpdf(d, z) ≈ logpdf(ref, z) atol=1e-8
        @test logcdf(d, z) ≈ logcdf(ref, z) atol=1e-8
        @test ccdf(d, z) ≈ ccdf(ref, z) atol=1e-10
    end
end

@testitem "Ratio Normal/Normal with non-zero means stays numeric" begin
    using Distributions

    d = ratio(Normal(1.0, 2.0), Normal(0.0, 0.5))
    @test ConvolvedDistributions._maybe_analytic(d) === nothing
end

@testitem "Ratio numeric path matches Monte Carlo" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(42)
    x = Gamma(3.0, 1.0)
    y = LogNormal(0.5, 0.4)
    d = ratio(x, y)

    n = 400_000
    samples = [rand(rng, x) / rand(rng, y) for _ in 1:n]

    for z in (0.5, 1.0, 3.0, 10.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol=5e-3
    end

    @test pdf(d, 2.0) > 0
    @test logpdf(d, 2.0) ≈ log(pdf(d, 2.0)) atol=1e-8
end

@testitem "Ratio NumericSolver reproduces the Gamma/Gamma closed form" begin
    using Distributions

    x = Gamma(2.0, 1.5)
    y = Gamma(3.0, 0.5)
    dn = ratio(x, y; method = NumericSolver())
    ref = 3.0 * BetaPrime(2.0, 3.0)

    @test ConvolvedDistributions._maybe_analytic(dn) === nothing
    for z in (0.5, 1.0, 3.0, 8.0)
        @test cdf(dn, z) ≈ cdf(ref, z) atol=1e-6
        @test pdf(dn, z) ≈ pdf(ref, z) atol=1e-6
    end
end

@testitem "Ratio pdf integrates to one" begin
    using Distributions

    dn = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    grid = collect(0.01:0.02:40.0)
    @test sum(pdf(dn, z) for z in grid) * 0.02 ≈ 1.0 atol=5e-3
end

@testitem "Ratio cdf is monotone and in [0, 1]" begin
    using Distributions

    dn = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    zs = collect(0.0:0.5:40.0)
    cs = [cdf(dn, z) for z in zs]
    @test all(0.0 .<= cs .<= 1.0)
    @test all(diff(cs) .>= -1e-10)

    @test cdf(dn, 0.0) == 0.0
    @test cdf(dn, -1.0) == 0.0
    @test cdf(dn, 1e4) ≈ 1.0 atol=1e-6
end

@testitem "Ratio logpdf outside support is -Inf" begin
    using Distributions

    d = ratio(Uniform(1.0, 2.0), Uniform(3.0, 4.0))
    @test insupport(d, 0.3)
    @test !insupport(d, 0.2)
    @test !insupport(d, 0.7)
    @test logpdf(d, 0.2) == -Inf
    @test pdf(d, 0.2) == 0.0
    @test logpdf(d, 0.7) == -Inf

    dg = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test pdf(dg, 0.0) == 0.0
    @test pdf(dg, -1.0) == 0.0
    @test logpdf(dg, 0.0) == -Inf
    @test cdf(dg, 0.0) == 0.0
end

@testitem "Ratio logcdf/ccdf/logccdf branches" begin
    using Distributions

    da = ratio(Normal(0.0, 2.0), Normal(0.0, 0.5))
    refa = Cauchy(0.0, 4.0)
    @test logcdf(da, 2.0) ≈ logcdf(refa, 2.0) atol=1e-10
    @test ccdf(da, 2.0) ≈ ccdf(refa, 2.0) atol=1e-10
    @test logccdf(da, 2.0) ≈ logccdf(refa, 2.0) atol=1e-8

    dn = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test logcdf(dn, 3.0) ≈ log(cdf(dn, 3.0)) atol=1e-10
    @test ccdf(dn, 3.0) ≈ 1 - cdf(dn, 3.0) atol=1e-10
    @test logccdf(dn, 3.0) ≈ log1p(-cdf(dn, 3.0)) atol=1e-6

    db = ratio(Uniform(1.0, 2.0), Uniform(3.0, 4.0))
    @test logccdf(db, 0.2) == 0.0
    @test logccdf(db, 0.7) == -Inf
end

@testitem "Ratio scalar methods value-correct and inferrable" begin
    using Distributions, Test

    analytic = ratio(Normal(0.0, 2.0), Normal(0.0, 0.5))
    numeric = ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    for d in (analytic, numeric)
        for f in (cdf, logcdf, pdf, logpdf, ccdf, logccdf)
            @test f(d, 2.0) isa Float64
        end
        @test (@inferred(cdf(d, 2.0)); true)
        @test (@inferred(pdf(d, 2.0)); true)
    end
end

@testitem "Ratio numeric path handles a sign-crossing denominator" begin
    using Distributions

    d = ratio(Normal(0.0, 2.0), Normal(0.0, 0.5); method = NumericSolver())
    ref = Cauchy(0.0, 4.0)
    for z in (-20.0, -5.0, -1.0, 0.0, 1.0, 5.0, 20.0)
        @test cdf(d, z) ≈ cdf(ref, z) atol=1e-6
        @test pdf(d, z) ≈ pdf(ref, z) atol=1e-6
    end
end

@testitem "Ratio numeric path handles a denominator touching zero" begin
    using Distributions, Random, Statistics

    x = LogNormal(0.5, 0.4)
    y = Uniform(0.0, 2.0)
    d = ratio(x, y)

    rng = MersenneTwister(7)
    n = 400_000
    samples = [rand(rng, x) / rand(rng, y) for _ in 1:n]
    for z in (0.5, 1.0, 3.0, 10.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol=5e-3
    end
end

@testitem "Ratio numeric path handles a singular denominator density" begin
    using Distributions, Random, Statistics

    x = Normal(1.0, 1.0)
    rng = MersenneTwister(11)
    for shape in (0.5, 0.3)
        y = Gamma(shape, 1.0)
        d = ratio(x, y)
        samples = [rand(rng, x) / rand(rng, y) for _ in 1:400_000]
        for z in (-2.0, 0.5, 2.0, 5.0)
            @test cdf(d, z) ≈ mean(samples .<= z) atol=5e-3
        end
    end
end

@testitem "Ratio far-tail accuracy" begin
    using Distributions

    d = ratio(Gamma(2.0, 1.0), Gamma(3.0, 1.0); method = NumericSolver())
    ref = BetaPrime(2.0, 3.0)
    for z in (1e-3, 1e-2, 1e2, 1e3)
        @test cdf(d, z) ≈ cdf(ref, z) atol=1e-6
    end
end

@testitem "Ratio rejects a denominator with mass at zero" begin
    using Distributions

    @test_throws ArgumentError ratio(Normal(0.0, 1.0), Poisson(2.0))
    @test_throws ArgumentError ratio(Normal(0.0, 1.0), Dirac(0.0))
    @test_throws ArgumentError ratio(
        Normal(0.0, 1.0), DiscreteUniform(-1, 1))
    err = try
        ratio(Normal(0.0, 1.0), Poisson(2.0))
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("Poisson", err.msg)
end

@testitem "Ratio moments error without a closed form" begin
    using Distributions

    err = try
        mean(ratio(Gamma(3.0, 1.0), LogNormal(0.0, 1.0)))
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("Gamma", err.msg)
    @test occursin("LogNormal", err.msg)

    ref = 3.0 * BetaPrime(2.0, 3.0)
    dexact = ratio(Gamma(2.0, 1.5), Gamma(3.0, 0.5))
    @test mean(dexact) ≈ mean(ref)
    @test var(dexact) ≈ var(ref)
    @test std(dexact) ≈ std(ref)

    dcauchy = ratio(Normal(0.0, 1.0), Normal(0.0, 1.0))
    @test isnan(mean(dcauchy))
end

@testitem "Ratio nested in another combination" begin
    using Distributions

    # A well-behaved (non-negative numerator, strictly positive
    # denominator -- `Gamma`'s own minimum is 0, not strictly positive,
    # so a bounded-away-from-zero denominator such as `Uniform(1, 2)` is
    # needed here) Ratio as the trailing (integration) component of an
    # outer Convolved evaluates fine: its own `_window_quantile` never
    # falls into the throwing branch.
    ok = convolved(Normal(0.0, 1.0), ratio(Gamma(2.0, 1.0), Uniform(1.0, 2.0)))
    @test isfinite(cdf(ok, 2.0))

    # `_window_quantile(::Ratio, p)` is only reached when the Ratio is
    # the outer combination's trailing (integration) component: that is
    # the component whose infinite window ends get clamped via
    # `_window_quantile` (see `_finite_window` in Convolved.jl). A
    # sign-crossing Ratio in that position has no cheap effective-support
    # bound and throws, naming its components.
    bad = convolved(
        Normal(0.0, 1.0), ratio(Normal(0.0, 1.0), Normal(0.0, 1.0)))
    err = try
        cdf(bad, 2.0)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("Normal", err.msg)
end
