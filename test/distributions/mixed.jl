# Mixed discrete/continuous fold (#115): a TWO-component combination
# with exactly one integer-lattice discrete component and one
# continuous component no longer silently falls into continuous
# quadrature over a comb of point masses (issue #115's reproduction);
# it evaluates exactly by summing the continuous side's density/CDF
# over the discrete side's own lattice window.

@testsnippet MixedCases begin
    using Distributions
end

@testitem "Convolved mixed fold: the #115 repro" setup = [MixedCases] begin
    d = convolved(Poisson(3.0), Normal(0.0, 1.0))
    @test Distributions.value_support(typeof(d)) === Continuous
    @test pdf(d, 2.0) > 0
    @test ConvolvedDistributions.is_exact(d)
    @test ConvolvedDistributions.evaluation_path(d) === :numeric

    bruteforce = sum(
        pdf(Poisson(3.0), k) * pdf(Normal(0.0, 1.0), 2.0 - k)
            for k in 0:30
    )
    @test pdf(d, 2.0) ≈ bruteforce

    # pdf is positive and integrates to ~1 over a wide grid.
    grid = -20:0.01:30
    total = sum(x -> pdf(d, x), grid) * 0.01
    @test isapprox(total, 1.0; atol = 1.0e-3)

    # cdf is monotone and reaches 1.
    cdfs = [cdf(d, x) for x in -20:1:40]
    @test issorted(cdfs)
    @test isapprox(cdfs[end], 1.0; atol = 1.0e-6)

    # logpdf/logcdf are consistent with pdf/cdf.
    @test logpdf(d, 2.0) ≈ log(pdf(d, 2.0))
    @test logcdf(d, 2.0) ≈ log(cdf(d, 2.0))
end

@testitem "Convolved mixed fold: both argument orders agree" setup = [MixedCases] begin
    d1 = convolved(Poisson(3.0), Normal(0.0, 1.0))
    d2 = convolved(Normal(0.0, 1.0), Poisson(3.0))
    for x in (-3.0, 0.0, 1.5, 2.0, 7.0)
        @test pdf(d1, x) ≈ pdf(d2, x)
        @test cdf(d1, x) ≈ cdf(d2, x)
    end

    # Vector pdf/cdf agree pointwise with the scalar path.
    xs = [-1.0, 0.0, 1.0, 2.0, 5.0]
    pv = pdf(d1, xs)
    cv = cdf(d1, xs)
    for (i, x) in enumerate(xs)
        @test pv[i] ≈ pdf(d1, x)
        @test cv[i] ≈ cdf(d1, x)
    end
end

@testitem "Convolved mixed fold: nested inside a continuous combination" setup = [MixedCases] begin
    inner = convolved(Poisson(3.0), Normal(0.0, 1.0))
    outer = convolved(inner, Gamma(2.0, 1.0))
    @test pdf(outer, 5.0) > 0

    grid = -10:0.05:40
    total = sum(x -> pdf(outer, x), grid) * 0.05
    @test isapprox(total, 1.0; atol = 2.0e-2)
end

@testitem "Difference mixed fold: both argument orders reflect correctly" setup = [MixedCases] begin
    # Discrete minuend (`x`): Z = D - C.
    d1 = difference(Poisson(3.0), Normal(0.0, 1.0))
    @test Distributions.value_support(typeof(d1)) === Continuous
    @test pdf(d1, 1.0) > 0
    @test ConvolvedDistributions.is_exact(d1)
    @test ConvolvedDistributions.evaluation_path(d1) === :numeric

    # Discrete subtrahend (`y`): Z = C - D.
    d2 = difference(Normal(0.0, 1.0), Poisson(3.0))
    @test pdf(d2, -1.0) > 0
    @test ConvolvedDistributions.is_exact(d2)

    # d1(z) at z is the reflection of d2(-z): Poisson - Normal(0,1) has
    # the same law as -(Normal(0,1) - Poisson).
    for z in (-2.0, 0.0, 1.5, 4.0)
        @test pdf(d1, z) ≈ pdf(d2, -z)
    end

    grid = -30:0.01:30
    @test isapprox(sum(x -> pdf(d1, x), grid) * 0.01, 1.0; atol = 1.0e-3)
    @test isapprox(sum(x -> pdf(d2, x), grid) * 0.01, 1.0; atol = 1.0e-3)

    c1 = [cdf(d1, x) for x in -30:1:40]
    c2 = [cdf(d2, x) for x in -30:1:40]
    @test issorted(c1)
    @test issorted(c2)
    @test isapprox(c1[end], 1.0; atol = 1.0e-6)
    @test isapprox(c2[end], 1.0; atol = 1.0e-6)
end

@testitem "Difference mixed fold: Monte Carlo sanity check" setup = [MixedCases] begin
    using Random

    d = difference(Poisson(3.0), Normal(0.0, 1.0))
    Random.seed!(115)
    N = 500_000
    samp = [rand(Poisson(3.0)) - rand(Normal(0.0, 1.0)) for _ in 1:N]
    for z in (-2.0, 0.0, 1.5, 4.0)
        emp = count(<=(z), samp) / N
        @test isapprox(cdf(d, z), emp; atol = 1.0e-2)
    end
end

@testitem "Product mixed fold: atom-at-zero is rejected" setup = [MixedCases] begin
    # Poisson(3.0) has P(0) > 0, so a mixed product with it puts an
    # atom at 0 in Z alongside a continuous density elsewhere.
    @test_throws ArgumentError product(Poisson(3.0), Gamma(2.0, 1.0))
    @test_throws ArgumentError product(Gamma(2.0, 1.0), Poisson(3.0))

    # A discrete factor with no mass at 0 is accepted.
    d = product(DiscreteUniform(1, 5), Gamma(2.0, 1.0))
    @test Distributions.value_support(typeof(d)) === Continuous
    @test ConvolvedDistributions.is_exact(d)

    # An all-discrete pair with mass at 0 is unaffected (its own atom
    # at 0 is already exact via the divisor fold).
    dd = product(Poisson(3.0), Poisson(2.0))
    @test Distributions.value_support(typeof(dd)) === Discrete
    @test pdf(dd, 0) > 0
end

@testitem "Product mixed fold: both argument orders agree" setup = [MixedCases] begin
    d1 = product(DiscreteUniform(1, 5), Gamma(2.0, 1.0))
    d2 = product(Gamma(2.0, 1.0), DiscreteUniform(1, 5))
    for z in (0.5, 3.0, 10.0)
        @test pdf(d1, z) ≈ pdf(d2, z)
        @test cdf(d1, z) ≈ cdf(d2, z)
    end

    grid = 0.001:0.01:60
    @test isapprox(sum(z -> pdf(d1, z), grid) * 0.01, 1.0; atol = 1.0e-2)

    c1 = [cdf(d1, z) for z in 0:1:80]
    @test issorted(c1)
    @test isapprox(c1[end], 1.0; atol = 1.0e-6)
end

@testitem "Product mixed fold: Monte Carlo sanity check" setup = [MixedCases] begin
    using Random

    d = product(DiscreteUniform(1, 5), Gamma(2.0, 1.0))
    Random.seed!(115)
    N = 500_000
    samp = [rand(DiscreteUniform(1, 5)) * rand(Gamma(2.0, 1.0)) for _ in 1:N]
    for z in (0.5, 2.0, 5.0, 10.0)
        emp = count(<=(z), samp) / N
        @test isapprox(cdf(d, z), emp; atol = 1.0e-2)
    end
end

@testitem "Mixed fold: strict=true accepts a mixed pair" setup = [MixedCases] begin
    d = convolved(Poisson(3.0), Normal(0.0, 1.0); strict = true)
    @test d isa ConvolvedDistributions.Convolved
end
