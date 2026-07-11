@testitem "Product constructor and fields" begin
    using Distributions

    d = product(LogNormal(0.5, 0.4), LogNormal(1.0, 0.3))
    @test d isa ConvolvedDistributions.Product
    @test d.x == LogNormal(0.5, 0.4)
    @test d.y == LogNormal(1.0, 0.3)
    @test d.method isa AnalyticalSolver

    dn = product(Gamma(2.0, 1.0), LogNormal(0.5, 0.4);
        method = NumericSolver())
    @test dn.method isa NumericSolver
end

@testitem "Product rejects sign-crossing supports" begin
    using Distributions

    # v1 scope: both components must have non-negative support.
    @test_throws ArgumentError product(Normal(0.0, 1.0), Gamma(2.0, 1.0))
    @test_throws ArgumentError product(Gamma(2.0, 1.0), Normal(0.0, 1.0))
    @test_throws ArgumentError product(
        Uniform(-1.0, 1.0), LogNormal(0.5, 0.4))
    err = try
        product(Normal(0.0, 1.0), Normal(0.0, 1.0))
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("non-negative", err.msg)
end

@testitem "Product support is the product of the support ends" begin
    using Distributions

    # Unbounded non-negative components: support is [0, Inf).
    d = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test minimum(d) == 0.0
    @test maximum(d) == Inf

    # Bounded components: min and max are the products of the ends.
    du = product(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test minimum(du) == 0.0
    @test maximum(du) == 6.0

    ds = product(Uniform(1.0, 2.0), Uniform(3.0, 4.0))
    @test minimum(ds) == 3.0
    @test maximum(ds) == 8.0
    @test insupport(ds, 3.0)
    @test insupport(ds, 5.0)
    @test !insupport(ds, 2.9)
    @test !insupport(ds, 8.1)
end

@testitem "Product params and eltype" begin
    using Distributions

    d = product(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test params(d) == ((0.0, 1.0), (0.0, 2.0))

    d2 = product(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test eltype(d2) == Float64
end

@testitem "Product LogNormal-LogNormal matches the closed form" begin
    using Distributions

    # Z = X * Y for independent log-normals is
    # LogNormal(μx + μy, sqrt(σx² + σy²)).
    x = LogNormal(0.5, 0.4)
    y = LogNormal(1.0, 0.3)
    d = product(x, y)
    ref = LogNormal(1.5, sqrt(0.4^2 + 0.3^2))

    @test mean(d) ≈ mean(ref)
    @test var(d) ≈ var(ref)
    @test std(d) ≈ std(ref)

    for z in 0.5:0.5:12.0
        @test cdf(d, z) ≈ cdf(ref, z) atol=1e-10
        @test pdf(d, z) ≈ pdf(ref, z) atol=1e-10
        @test logpdf(d, z) ≈ logpdf(ref, z) atol=1e-8
        @test logcdf(d, z) ≈ logcdf(ref, z) atol=1e-8
        @test ccdf(d, z) ≈ ccdf(ref, z) atol=1e-10
    end
end

@testitem "Product NumericSolver matches LogNormal-LogNormal closed form" begin
    using Distributions

    x = LogNormal(0.5, 0.4)
    y = LogNormal(1.0, 0.3)
    dn = product(x, y; method = NumericSolver())
    ref = LogNormal(1.5, sqrt(0.4^2 + 0.3^2))

    @test ConvolvedDistributions._maybe_analytic(dn) === nothing
    @test ConvolvedDistributions._maybe_analytic(product(x, y)) !== nothing

    for z in range(0.5, 15.0; length = 12)
        @test cdf(dn, z) ≈ cdf(ref, z) atol=1e-6
        @test pdf(dn, z) ≈ pdf(ref, z) atol=1e-6
    end
end

@testitem "Product numeric path matches Monte Carlo" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(42)
    # Gamma * LogNormal has no closed form -> numeric Mellin quadrature.
    x = Gamma(3.0, 1.0)
    y = LogNormal(0.5, 0.4)
    d = product(x, y)

    n = 400_000
    samples = [rand(rng, x) * rand(rng, y) for _ in 1:n]

    for z in (1.0, 3.0, 5.0, 10.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol=5e-3
    end

    @test pdf(d, 4.0) > 0
    @test logpdf(d, 4.0) ≈ log(pdf(d, 4.0)) atol=1e-8

    # Exact independent-product moments against the samples.
    @test mean(samples) ≈ mean(x) * mean(y) atol=5e-2
    ex2 = var(x) + mean(x)^2
    ey2 = var(y) + mean(y)^2
    @test var(samples) ≈ ex2 * ey2 - (mean(x) * mean(y))^2 atol=5e-1
    @test mean(d) ≈ mean(samples) atol=5e-2
    @test var(d) ≈ var(samples) atol=5e-1
end

@testitem "Product with Convolved multiplier matches Monte Carlo" begin
    using Distributions, Random, Statistics

    # Issue #45: a `Convolved` multiplier routes both the zero lower
    # endpoint and the infinite upper endpoint of the Mellin windows
    # through `_window_quantile(::Convolved, p)`, whose primal rebuild
    # threw a `_primal(::Tuple)` MethodError on the nested parameter
    # tuples.
    x = Gamma(2.0, 1.0)
    y = convolved(Gamma(1.5, 1.0), Gamma(1.0, 2.0))
    d = product(x, y)

    rng = MersenneTwister(45)
    n = 400_000
    samples = [rand(rng, x) * rand(rng, y) for _ in 1:n]
    for z in (1.0, 4.0, 10.0, 20.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol=5e-3
    end
    @test pdf(d, 4.0) > 0
end

@testitem "Product moments are the exact independent-product moments" begin
    using Distributions

    # Uniform(0,1) * Uniform(0,2): mean = 1/2 * 1 = 1/2 and
    # var = E[X²]E[Y²] - (E[X]E[Y])² = (1/3)(4/3) - 1/4 = 7/36.
    d = product(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test mean(d) ≈ 0.5
    @test var(d) ≈ 7 / 36
    @test std(d) ≈ sqrt(7 / 36)
end

@testitem "Product pdf integrates to one" begin
    using Distributions

    # Uniform product has a log-singular (but integrable) density at 0;
    # midpoint grid keeps the Riemann sum honest near the edge.
    du = product(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    grid = collect(0.005:0.01:5.995)
    @test sum(pdf(du, z) for z in grid) * 0.01 ≈ 1.0 atol=5e-3

    dn = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    g = collect(0.01:0.02:80.0)
    @test sum(pdf(dn, z) for z in g) * 0.02 ≈ 1.0 atol=3e-3
end

@testitem "Product cdf is monotone and in [0, 1]" begin
    using Distributions

    dn = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    zs = collect(0.0:0.5:30.0)
    cs = [cdf(dn, z) for z in zs]
    @test all(0.0 .<= cs .<= 1.0)
    @test all(diff(cs) .>= -1e-10)        # non-decreasing

    @test cdf(dn, 0.0) == 0.0
    @test cdf(dn, -1.0) == 0.0
    @test cdf(dn, 1e4) ≈ 1.0 atol=1e-6
end

@testitem "Product cdf handles singular multiplier densities" begin
    using Distributions, Random, Statistics

    # A Gamma multiplier with shape < 1 has a density diverging at
    # y = 0. The direct F_X(z / y) f_Y(y) CDF integrand inherits that
    # (integrable) singularity, which fixed-node quadrature cannot
    # resolve: it biased the CDF by ~1e-2 at shape 0.5 and ~7e-2 at
    # shape 0.3. The survival-form evaluation removes the singularity;
    # check against fixed-seed Monte Carlo (SE ~ 8e-4 at n = 400_000,
    # so 5e-3 is honest and the old bias fails it).
    rng = MersenneTwister(2024)
    x = LogNormal(0.5, 0.4)
    for shape in (0.5, 0.3)
        y = Gamma(shape, 1.0)
        d = product(x, y)
        samples = [rand(rng, x) * rand(rng, y) for _ in 1:400_000]
        for z in (0.5, 2.0, 5.0)
            @test cdf(d, z) ≈ mean(samples .<= z) atol=5e-3
        end
    end
end

@testitem "Product cdf is symmetric for a singular-density component" begin
    using Distributions

    # cdf(product(X, Y)) == cdf(product(Y, X)) must hold whichever side
    # carries the singular (shape < 1) density; the direct-form CDF
    # broke this by ~1e-2 when the singular component was the
    # multiplier Y. Both orderings are accurate to ~1e-8 under the
    # survival form.
    x = LogNormal(0.5, 0.4)
    y = Gamma(0.5, 1.0)
    dxy = product(x, y)
    dyx = product(y, x)
    for z in (0.5, 2.0, 5.0)
        @test cdf(dxy, z) ≈ cdf(dyx, z) atol=1e-7
    end
end

@testitem "Product is symmetric in its components" begin
    using Distributions

    # X * Y and Y * X are the same distribution.
    x = Gamma(3.0, 1.0)
    y = LogNormal(0.5, 0.4)
    dxy = product(x, y)
    dyx = product(y, x)

    for z in (0.5, 2.0, 5.0, 10.0)
        @test cdf(dxy, z) ≈ cdf(dyx, z) atol=1e-6
        @test pdf(dxy, z) ≈ pdf(dyx, z) atol=1e-6
    end

    @test minimum(dxy) == minimum(dyx)
    @test maximum(dxy) == maximum(dyx)
end

@testitem "Product rand mean/var match the analytic moments" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(1)
    d = product(Gamma(3.0, 1.0), LogNormal(0.0, 0.3))
    s = [rand(rng, d) for _ in 1:200_000]
    @test mean(s) ≈ mean(d) atol=5e-2
    @test var(s) ≈ var(d) atol=2e-1
end

@testitem "Product logcdf/ccdf/logccdf branches" begin
    using Distributions

    # Analytic path agrees with the reference log-normal product.
    da = product(LogNormal(0.5, 0.4), LogNormal(0.0, 0.3))
    refa = LogNormal(0.5, 0.5)
    @test logcdf(da, 2.0) ≈ logcdf(refa, 2.0) atol=1e-10
    @test ccdf(da, 2.0) ≈ ccdf(refa, 2.0) atol=1e-10
    @test logccdf(da, 2.0) ≈ logccdf(refa, 2.0) atol=1e-8

    # Numeric path: logcdf matches log(cdf) and ccdf = 1 - cdf.
    dn = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test logcdf(dn, 3.0) ≈ log(cdf(dn, 3.0)) atol=1e-10
    @test ccdf(dn, 3.0) ≈ 1 - cdf(dn, 3.0) atol=1e-10
    @test logccdf(dn, 3.0) ≈ log1p(-cdf(dn, 3.0)) atol=1e-6

    db = product(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test logccdf(db, -1.0) == 0.0   # CDF = 0 -> logccdf = 0
    @test logccdf(db, 6.0) == -Inf   # CDF = 1 -> logccdf = -Inf
end

@testitem "Product logpdf outside support is -Inf" begin
    using Distributions

    d = product(Uniform(1.0, 2.0), Uniform(3.0, 4.0))
    @test logpdf(d, 2.0) == -Inf
    @test pdf(d, 2.0) == 0.0
    @test logpdf(d, 9.0) == -Inf
    @test pdf(d, 9.0) == 0.0
    @test logpdf(d, -1.0) == -Inf
    @test !insupport(d, 2.0)
    @test insupport(d, 5.0)

    # z at or below zero is outside the support of an unbounded product.
    dg = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test pdf(dg, 0.0) == 0.0
    @test pdf(dg, -1.0) == 0.0
    @test logpdf(dg, 0.0) == -Inf
    @test cdf(dg, 0.0) == 0.0
end

@testitem "Product scalar methods value-correct and inferrable" begin
    using Distributions, Test

    analytic = product(LogNormal(0.5, 0.4), LogNormal(0.0, 0.3))
    numeric = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    for d in (analytic, numeric)
        for f in (cdf, logcdf, pdf, logpdf, ccdf, logccdf)
            @test f(d, 2.0) isa Float64
        end
        @test (@inferred(cdf(d, 2.0)); true)
        @test (@inferred(pdf(d, 2.0)); true)
    end
end

@testitem "Product eltype and sampler" begin
    using Distributions, Random

    d = product(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test eltype(d) == Float64
    @test sampler(d) === d
    rng = MersenneTwister(3)
    @test rand(rng, d) isa Real
    @test rand(rng, d) >= 0
end

@testitem "Product composes with truncated" begin
    using Distributions

    d = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    td = truncated(d, 1.0, 10.0)

    @test cdf(td, 0.5) == 0.0
    @test cdf(td, 11.0) == 1.0
    @test 0.0 < cdf(td, 4.0) < 1.0
    @test pdf(td, 4.0) > 0
end

# The AD-safety of Product (gradients flowing through both components'
# parameters, on the numeric Mellin quadrature path) is covered by the
# multi-backend AD suite in `test/ADFixtures`, which has the AD backends
# as dependencies; the main test env does not.
