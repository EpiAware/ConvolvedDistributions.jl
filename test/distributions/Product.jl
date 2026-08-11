@testitem "Product constructor and fields" begin
    using Distributions

    d = product(LogNormal(0.5, 0.4), LogNormal(1.0, 0.3))
    @test d isa ConvolvedDistributions.Product
    @test d.x == LogNormal(0.5, 0.4)
    @test d.y == LogNormal(1.0, 0.3)
    @test d.method isa AnalyticalSolver

    dn = product(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4);
        method = NumericSolver()
    )
    @test dn.method isa NumericSolver
end

@testitem "Product rejects sign-crossing supports" begin
    using Distributions

    # v1 scope: both components must have non-negative support.
    @test_throws ArgumentError product(Normal(0.0, 1.0), Gamma(2.0, 1.0))
    @test_throws ArgumentError product(Gamma(2.0, 1.0), Normal(0.0, 1.0))
    @test_throws ArgumentError product(
        Uniform(-1.0, 1.0), LogNormal(0.5, 0.4)
    )
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
        @test cdf(d, z) ≈ cdf(ref, z) atol = 1.0e-10
        @test pdf(d, z) ≈ pdf(ref, z) atol = 1.0e-10
        @test logpdf(d, z) ≈ logpdf(ref, z) atol = 1.0e-8
        @test logcdf(d, z) ≈ logcdf(ref, z) atol = 1.0e-8
        @test ccdf(d, z) ≈ ccdf(ref, z) atol = 1.0e-10
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
        @test cdf(dn, z) ≈ cdf(ref, z) atol = 1.0e-6
        @test pdf(dn, z) ≈ pdf(ref, z) atol = 1.0e-6
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
        @test cdf(d, z) ≈ mean(samples .<= z) atol = 5.0e-3
    end

    @test pdf(d, 4.0) > 0
    @test logpdf(d, 4.0) ≈ log(pdf(d, 4.0)) atol = 1.0e-8

    # Exact independent-product moments against the samples. Seeded-run
    # MC standard errors at n = 400_000 are ~6e-3 for the mean and ~8e-2
    # for the variance (fourth-moment driven; the product is heavy
    # tailed), so 5e-2 / 5e-1 sit at ~8 and ~6 standard errors.
    @test mean(samples) ≈ mean(x) * mean(y) atol = 5.0e-2
    ex2 = var(x) + mean(x)^2
    ey2 = var(y) + mean(y)^2
    @test var(samples) ≈ ex2 * ey2 - (mean(x) * mean(y))^2 atol = 5.0e-1
    @test mean(d) ≈ mean(samples) atol = 5.0e-2
    @test var(d) ≈ var(samples) atol = 5.0e-1
end

@testitem "Product with Convolved multiplier matches Monte Carlo" begin
    using Distributions, Random, Statistics

    # Issue #45: a `Convolved` multiplier routes both the zero lower
    # endpoint and the infinite upper endpoint of the Mellin windows
    # through `_window_quantile(::Convolved, p)`, whose primal rebuild
    # threw a `primal(::Tuple)` MethodError on the nested parameter
    # tuples.
    x = Gamma(2.0, 1.0)
    y = convolved(Gamma(1.5, 1.0), Gamma(1.0, 2.0))
    d = product(x, y)

    rng = MersenneTwister(45)
    n = 400_000
    samples = [rand(rng, x) * rand(rng, y) for _ in 1:n]
    for z in (1.0, 4.0, 10.0, 20.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol = 5.0e-3
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
    @test sum(pdf(du, z) for z in grid) * 0.01 ≈ 1.0 atol = 5.0e-3

    dn = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    g = collect(0.01:0.02:80.0)
    @test sum(pdf(dn, z) for z in g) * 0.02 ≈ 1.0 atol = 3.0e-3
end

@testitem "Product cdf is monotone and in [0, 1]" begin
    using Distributions

    dn = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    zs = collect(0.0:0.5:30.0)
    cs = [cdf(dn, z) for z in zs]
    @test all(0.0 .<= cs .<= 1.0)
    @test all(diff(cs) .>= -1.0e-10)        # non-decreasing

    @test cdf(dn, 0.0) == 0.0
    @test cdf(dn, -1.0) == 0.0
    @test cdf(dn, 1.0e4) ≈ 1.0 atol = 1.0e-6
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
            @test cdf(d, z) ≈ mean(samples .<= z) atol = 5.0e-3
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
        @test cdf(dxy, z) ≈ cdf(dyx, z) atol = 1.0e-7
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
        @test cdf(dxy, z) ≈ cdf(dyx, z) atol = 1.0e-6
        @test pdf(dxy, z) ≈ pdf(dyx, z) atol = 1.0e-6
    end

    @test minimum(dxy) == minimum(dyx)
    @test maximum(dxy) == maximum(dyx)
end

@testitem "Product rand mean/var match the analytic moments" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(1)
    d = product(Gamma(3.0, 1.0), LogNormal(0.0, 0.3))
    s = [rand(rng, d) for _ in 1:200_000]
    @test mean(s) ≈ mean(d) atol = 5.0e-2
    @test var(s) ≈ var(d) atol = 2.0e-1
end

@testitem "Product logcdf/ccdf/logccdf branches" begin
    using Distributions

    # Analytic path agrees with the reference log-normal product.
    da = product(LogNormal(0.5, 0.4), LogNormal(0.0, 0.3))
    refa = LogNormal(0.5, 0.5)
    @test logcdf(da, 2.0) ≈ logcdf(refa, 2.0) atol = 1.0e-10
    @test ccdf(da, 2.0) ≈ ccdf(refa, 2.0) atol = 1.0e-10
    @test logccdf(da, 2.0) ≈ logccdf(refa, 2.0) atol = 1.0e-8

    # Numeric path: logcdf matches log(cdf) and ccdf = 1 - cdf.
    dn = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test logcdf(dn, 3.0) ≈ log(cdf(dn, 3.0)) atol = 1.0e-10
    @test ccdf(dn, 3.0) ≈ 1 - cdf(dn, 3.0) atol = 1.0e-10
    @test logccdf(dn, 3.0) ≈ log1p(-cdf(dn, 3.0)) atol = 1.0e-6

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

@testitem "Product composes with censored (#72)" begin
    using Distributions

    d = product(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    cd = censored(d, 1.0, 10.0)

    @test cdf(cd, 0.5) == 0.0
    @test cdf(cd, 10.0) == 1.0
    @test cdf(cd, 4.0) ≈ cdf(d, 4.0)
    @test pdf(cd, 1.0) ≈ cdf(d, 1.0)
    @test pdf(cd, 10.0) ≈ ccdf(d, 10.0)
    @test pdf(cd, 4.0) ≈ pdf(d, 4.0)
end

@testitem "Product heavy-tailed multiplier accuracy (#49)" begin
    using Distributions

    # The issue #49 case: a heavy-tailed multiplier stretches the Y
    # integration window to its 1 - 1e-8 quantile (~4.5e3 for
    # LogNormal(0, 1.5)) while the integrand's transition sits near
    # O(1), so a single fixed-node window starved the transition of
    # nodes (measured abs err ~1.4e-2 at z = 1, ~9e-4 at z = 5).
    # References computed once with adaptive quadrature (QuadGK via
    # Integrals.jl, reltol = 1e-13) of
    #   F_Z(z) = ∫_0^∞ F_X(z / y) f_Y(y) dy,
    #   f_Z(z) = ∫_0^∞ f_X(z / y) f_Y(y) / y dy
    # for X = Gamma(2, 1), Y = LogNormal(0, 1.5), and hard-coded.
    d = product(Gamma(2.0, 1.0), LogNormal(0.0, 1.5))

    @test cdf(d, 1.0) ≈ 0.39674977955541 atol = 1.0e-9
    @test cdf(d, 5.0) ≈ 0.756121355787196 atol = 1.0e-9
    @test pdf(d, 1.0) ≈ 0.226346442279101 atol = 1.0e-9
    @test pdf(d, 5.0) ≈ 0.0376154454208233 atol = 1.0e-9
end

@testitem "Product of two discrete components is Discrete and exact (#85, #89)" begin
    using Distributions

    d = product(Poisson(2.0), Poisson(3.0))
    @test Distributions.value_support(typeof(d)) === Discrete
    @test ConvolvedDistributions.is_exact(d)

    px0 = pdf(Poisson(2.0), 0)
    py0 = pdf(Poisson(3.0), 0)
    @test pdf(d, 0) ≈ px0 + py0 - px0 * py0

    for z in 1:24
        bf = sum(
            pdf(Poisson(2.0), x) * pdf(Poisson(3.0), y)
                for x in 1:60, y in 1:60 if x * y == z
        )
        @test pdf(d, z) ≈ bf atol = 1.0e-10
    end

    masses = [pdf(d, k) for k in 0:200]
    @test all(m -> m >= 0, masses)
    @test isapprox(sum(masses), 1; atol = 1.0e-6)

    running_sums = cumsum(masses)
    for (k, running) in zip(0:200, running_sums)
        @test cdf(d, k) ≈ running atol = 1.0e-6
    end

    # A bounded pair matches exhaustive enumeration exactly.
    x = Binomial(3, 0.4)
    y = DiscreteUniform(0, 3)
    db = product(x, y)
    for z in 0:9
        bf = sum(
            (pdf(x, a) * pdf(y, b) for a in 0:3, b in 0:3 if a * b == z);
            init = 0.0
        )
        @test pdf(db, z) ≈ bf atol = 1.0e-12
    end

    # A mixed pair stays Continuous. `Poisson(2.0)` has mass at 0, which
    # would put an atom at 0 in the product alongside a continuous
    # density elsewhere -- rejected at construction (#115); see
    # test/distributions/mixed.jl for the accepted mixed case (a
    # discrete factor with no mass at 0) and the fixed pdf/cdf.
    @test_throws ArgumentError product(Poisson(2.0), LogNormal(0.5, 0.4))
end

@testitem "product(d, k) matches the explicit n-ary form" begin
    using Distributions

    d = Gamma(2.0, 1.0)
    dk = product(d, 3)
    explicit = product(product(d, d), d)
    for z in (0.5, 1.0, 2.0, 4.0)
        @test pdf(dk, z) ≈ pdf(explicit, z)
        @test cdf(dk, z) ≈ cdf(explicit, z)
    end

    dkv = product(d, Val(3))
    for z in (0.5, 1.0, 2.0, 4.0)
        @test pdf(dkv, z) ≈ pdf(explicit, z)
        @test cdf(dkv, z) ≈ cdf(explicit, z)
    end
end

@testitem "product(d, k) analytic LogNormal collapses exactly" begin
    using Distributions

    d = LogNormal(0.1, 0.2)
    @test product(d, 5) == LogNormal(0.5, sqrt(5) * 0.2)
    @test product(d, Val(5)) == LogNormal(0.5, sqrt(5) * 0.2)
end

@testitem "product_power is a public downstream extension point" begin
    # Proves the extension point is genuinely dispatched to, not merely
    # present: a spy records whether the override ran, and the result is
    # checked against the override's own distribution (`===`), not a
    # value that could coincidentally match a fallback path.
    # `ExtProductFactor` is a plain, non-parametric struct so dispatch
    # cannot fall prey to Julia's type-parameter invariance (unlike, say,
    # `LogNormal`, whose concrete type carries an element-type parameter).
    using ConvolvedDistributions: product_power
    using Distributions

    struct ExtProductFactor <: ContinuousUnivariateDistribution end
    Base.minimum(::ExtProductFactor) = 0.0
    Base.maximum(::ExtProductFactor) = Inf
    Distributions.cdf(::ExtProductFactor, x::Real) = 1 - exp(-x)
    Distributions.pdf(::ExtProductFactor, x::Real) = exp(-x)

    called = Ref(false)
    closed = LogNormal(0.0, 3.0)
    function ConvolvedDistributions.product_power(
            ::ExtProductFactor, k::Integer
        )
        called[] = true
        return closed
    end

    try
        result = product(ExtProductFactor(), 4)
        @test called[]
        @test result === closed
    finally
        # Delete the method rather than rely on the throwaway type alone:
        # `ExtProductFactor` is local to this testitem's module, but the
        # method itself lives on the shared `product_power` generic in
        # `ConvolvedDistributions`, which persists for the rest of the
        # test run unless removed.
        Base.delete_method(
            only(
                methods(
                    ConvolvedDistributions.product_power,
                    Tuple{ExtProductFactor, Integer}
                )
            )
        )
    end
end

@testitem "product(d, k) edge cases" begin
    using Distributions

    d = Gamma(2.0, 1.0)
    @test product(d, 1) === d
    @test product(d, Val(1)) === d

    @test_throws ArgumentError product(d, 0)
    @test_throws ArgumentError product(d, -3)
    @test_throws ArgumentError product(d, Val(0))
end

@testitem "product(d, k) inference" begin
    using Distributions, Test

    # A closed-form family: stable even for a runtime Integer k.
    @inferred product(LogNormal(0.1, 0.2), 5)

    # A family with no closed form: the Val path is the inferable one;
    # a runtime Integer k is not (the nesting depth is part of the
    # `Product` type), verified explicitly rather than merely noted.
    @inferred product(Gamma(2.0, 1.0), Val(3))
    @test_throws ErrorException @inferred product(Gamma(2.0, 1.0), 3)
end

# The AD-safety of Product (gradients flowing through both components'
# parameters, on the numeric Mellin quadrature path) is covered by the
# multi-backend AD suite in `test/ADFixtures`, which has the AD backends
# as dependencies; the main test env does not.
