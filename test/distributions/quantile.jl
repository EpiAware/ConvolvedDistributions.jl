# Quantile (inverse CDF) for Convolved/Difference is provided by the
# ConvolvedDistributionsOptimizationExt extension, so every testitem here
# loads Optimization + OptimizationOptimJL to trigger it.

@testitem "Convolved quantile inverts cdf" begin
    using Distributions, Optimization, OptimizationOptimJL

    # Numeric path: quantile is the cdf inverse.
    # The optimiser minimises (cdf - p)^2, so cdf accuracy is ~1e-4.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(d, p)
        @test cdf(d, q) ≈ p atol=1e-3
    end
    @test quantile(d, 0.0) == minimum(d)
    @test quantile(d, 1.0) == maximum(d)

    # Analytic path agrees with the convolved reference quantile.
    a = Normal(1.0, 2.0)
    b = Normal(-0.5, 1.5)
    da = convolved(a, b)
    ref = convolve(a, b)
    for p in (0.05, 0.2, 0.5, 0.8, 0.95)
        @test quantile(da, p) ≈ quantile(ref, p) atol=1e-2
    end

    # NumericSolver forced on an analytic pair still inverts to the same
    # quantile as the closed form.
    dn = convolved(a, b; method = NumericSolver())
    for p in (0.2, 0.5, 0.8)
        @test quantile(dn, p) ≈ quantile(ref, p) atol=1e-2
    end
end

@testitem "Difference quantile inverts cdf" begin
    using Distributions, Optimization, OptimizationOptimJL

    # Analytic path: Normal - Normal has the closed form
    # Normal(μx - μy, sqrt(σx² + σy²)).
    x = Normal(5.0, 1.5)
    y = Normal(2.0, 2.0)
    d = difference(x, y)
    ref = Normal(3.0, sqrt(1.5^2 + 2.0^2))
    for p in (0.05, 0.2, 0.5, 0.8, 0.95)
        @test quantile(d, p) ≈ quantile(ref, p) atol=1e-2
    end

    # Median of a symmetric difference is 0 (analytic and numeric paths).
    dsym = difference(Normal(1.0, 1.0), Normal(1.0, 1.0))
    @test quantile(dsym, 0.5) ≈ 0.0 atol=1e-6
    dsymn = difference(Gamma(2.0, 1.5), Gamma(2.0, 1.5))
    @test quantile(dsymn, 0.5) ≈ 0.0 atol=1e-3

    # Numeric path: quantile round-trips through the quadrature cdf.
    dn = difference(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(dn, p)
        @test cdf(dn, q) ≈ p atol=1e-3
    end
end

@testitem "Product quantile inverts cdf" begin
    using Distributions, Optimization, OptimizationOptimJL

    # Analytic path: LogNormal * LogNormal has the closed form
    # LogNormal(μx + μy, sqrt(σx² + σy²)).
    x = LogNormal(0.5, 0.4)
    y = LogNormal(1.0, 0.3)
    d = product(x, y)
    ref = LogNormal(1.5, sqrt(0.4^2 + 0.3^2))
    for p in (0.05, 0.2, 0.5, 0.8, 0.95)
        @test quantile(d, p) ≈ quantile(ref, p) atol=1e-2
    end

    # Numeric path: quantile round-trips through the quadrature cdf.
    dn = product(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(dn, p)
        @test cdf(dn, q) ≈ p atol=1e-3
    end

    # Singular multiplier density (Gamma shape < 1): a biased cdf would
    # self-consistently pass a round-trip, so check the median against
    # fixed-seed Monte Carlo (SE ~ 1.4e-3; the pre-survival-form cdf
    # bias of ~1e-2 shifted the median by ~1.9e-2 and fails 8e-3).
    using Random, Statistics
    rng = MersenneTwister(2024)
    xs = LogNormal(0.5, 0.4)
    ys = Gamma(0.5, 1.0)
    ds = product(xs, ys)
    samples = [rand(rng, xs) * rand(rng, ys) for _ in 1:400_000]
    @test quantile(ds, 0.5) ≈ Statistics.quantile(samples, 0.5) atol=8e-3
    for p in (0.25, 0.5, 0.75)
        @test cdf(ds, quantile(ds, p)) ≈ p atol=1e-3
    end

    # Bounded supports: p = 0 / 1 return the support ends exactly.
    dp = product(Uniform(1.0, 2.0), Uniform(3.0, 4.0))
    @test quantile(dp, 0.0) == 3.0
    @test quantile(dp, 1.0) == 8.0
    for p in (0.25, 0.5, 0.75)
        @test cdf(dp, quantile(dp, p)) ≈ p atol=1e-3
    end
    @test_throws ArgumentError quantile(dp, -0.1)
    @test_throws ArgumentError quantile(dp, 1.1)
end

@testitem "Quantile is accurate in far tails" begin
    using Distributions, Optimization, OptimizationOptimJL

    # A squared cdf residual is nearly flat in q in the far tails, so a
    # probability-space tolerance can be met while q is far off (#48).
    # These checks pin q itself against closed forms.

    # Analytic path: LogNormal * LogNormal has the closed form
    # LogNormal(μx + μy, sqrt(σx² + σy²)).
    x = LogNormal(0.5, 0.4)
    y = LogNormal(1.0, 0.3)
    dp = product(x, y)
    refp = LogNormal(1.5, sqrt(0.4^2 + 0.3^2))
    for p in (0.001, 0.01, 0.99, 0.999)
        @test quantile(dp, p) ≈ quantile(refp, p) rtol=1e-3
    end

    # Numeric path: an analytic Normal pair forced through NumericSolver
    # against the closed-form convolution. The quadrature cdf tail error
    # is ~1e-8, so rtol 1e-3 in q is honest.
    a = Normal(1.0, 2.0)
    b = Normal(-0.5, 1.5)
    dn = convolved(a, b; method = NumericSolver())
    refn = convolve(a, b)
    for p in (0.001, 0.01, 0.99, 0.999)
        @test quantile(dn, p) ≈ quantile(refn, p) rtol=1e-3
    end

    # Difference support is all of R, so the lower tail sits at negative
    # q; Normal - Normal has the closed form
    # Normal(μx - μy, sqrt(σx² + σy²)).
    dd = difference(Normal(5.0, 1.5), Normal(2.0, 2.0))
    refd = Normal(3.0, sqrt(1.5^2 + 2.0^2))
    for p in (0.001, 0.01, 0.99, 0.999)
        @test quantile(dd, p) ≈ quantile(refd, p) rtol=1e-3
    end
end

@testitem "Quantile boundary and argument validation" begin
    using Distributions, Optimization, OptimizationOptimJL

    # Bounded supports: p = 0 / 1 return the support ends exactly.
    du = convolved(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test quantile(du, 0.0) == 0.0
    @test quantile(du, 1.0) == 3.0

    dd = difference(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test quantile(dd, 0.0) == -2.0
    @test quantile(dd, 1.0) == 1.0

    # Interior quantiles of the bounded cases round-trip too.
    for p in (0.25, 0.5, 0.75)
        @test cdf(du, quantile(du, p)) ≈ p atol=1e-3
        @test cdf(dd, quantile(dd, p)) ≈ p atol=1e-3
    end

    # Out-of-range probabilities throw for both distributions.
    for d in (du, dd)
        @test_throws ArgumentError quantile(d, -0.1)
        @test_throws ArgumentError quantile(d, 1.1)
        @test_throws ArgumentError quantile(d, NaN)
    end
end

@testitem "Truncated Convolved/Difference sample via quantile" begin
    using Distributions, Optimization, OptimizationOptimJL
    using Random, Statistics

    rng = MersenneTwister(8675309)

    # `truncated` derives its quantile and inverse-CDF sampler from the base
    # `quantile`, so this exercises the rand path that routes through it.
    dn = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    tn = truncated(dn, 1.0, 8.0)
    for p in (0.25, 0.5, 0.75)
        q = quantile(tn, p)
        @test cdf(tn, q) ≈ p atol=1e-3
    end

    samples = rand(rng, tn, 50_000)
    @test all(1.0 .<= samples .<= 8.0)
    for x in (2.0, 4.0, 6.0)
        @test mean(samples .<= x) ≈ cdf(tn, x) atol=1e-2
    end
    @test median(samples) ≈ quantile(tn, 0.5) atol=0.05

    # Same for a truncated Difference on the numeric path.
    dz = difference(Gamma(3.0, 1.0), Gamma(2.0, 1.0))
    tz = truncated(dz, -2.0, 5.0)
    zs = rand(rng, tz, 50_000)
    @test all(-2.0 .<= zs .<= 5.0)
    @test median(zs) ≈ quantile(tz, 0.5) atol=0.05
end
