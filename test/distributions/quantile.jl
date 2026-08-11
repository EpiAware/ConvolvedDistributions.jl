# Quantile (inverse CDF) for a continuous Convolved/Difference/Product is
# provided by the ConvolvedDistributionsOptimizationExt extension, so
# every testitem for that case loads Optimization + OptimizationOptimJL
# to trigger it. A `Discrete`-typed combination instead has an exact
# lattice quantile in core, needing no such extension -- see the
# "discrete quantile is exact" testitems below.

@testitem "Convolved quantile inverts cdf" begin
    using Distributions, Optimization, OptimizationOptimJL

    # Numeric path: quantile is the cdf inverse.
    # The optimiser minimises the squared logit-cdf residual (#48).
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(d, p)
        @test cdf(d, q) ≈ p atol = 1.0e-3
    end
    @test quantile(d, 0.0) == minimum(d)
    @test quantile(d, 1.0) == maximum(d)

    # Analytic path agrees with the convolved reference quantile. The
    # Nelder-Mead solve converges on the probability residual (reltol
    # 1e-8), so the quantile-scale error is far below the 1e-2 asserted
    # here and in the analytic checks below; the loose bound stays
    # insensitive to solver settings while still catching an inversion
    # that lands on the wrong quantile.
    a = Normal(1.0, 2.0)
    b = Normal(-0.5, 1.5)
    da = convolved(a, b)
    ref = convolve(a, b)
    for p in (0.05, 0.2, 0.5, 0.8, 0.95)
        @test quantile(da, p) ≈ quantile(ref, p) atol = 1.0e-2
    end

    # NumericSolver forced on an analytic pair still inverts to the same
    # quantile as the closed form.
    dn = convolved(a, b; method = NumericSolver())
    for p in (0.2, 0.5, 0.8)
        @test quantile(dn, p) ≈ quantile(ref, p) atol = 1.0e-2
    end
end

@testitem "Convolved discrete quantile is exact" begin
    # No `using Optimization, OptimizationOptimJL`: the exact lattice
    # route needs neither.
    using Distributions

    d = convolved(Poisson(3.0), Geometric(0.4))
    @test quantile(d, 0.0) === minimum(d)
    @test quantile(d, 0.0) isa Int
    # Unbounded above (known limit): p = 1 returns the bound itself,
    # `Inf`, matching the Optimization extension's own p = 1 shortcut
    # for the continuous case.
    @test quantile(d, 1.0) === maximum(d)

    for p in (0.05, 0.1, 0.3, 0.5, 0.7, 0.9, 0.99)
        q = quantile(d, p)
        @test q isa Int
        # Brute-force cumulative-sum check: q is the smallest lattice
        # point whose cdf reaches p.
        @test cdf(d, q - 1) < p <= cdf(d, q)
    end

    # Bounded discrete case: p = 1 lands exactly on the finite maximum.
    db = convolved(Binomial(5, 0.3), Binomial(4, 0.6))
    @test quantile(db, 0.0) === minimum(db)
    @test quantile(db, 1.0) === maximum(db)
    for p in (0.1, 0.5, 0.9)
        q = quantile(db, p)
        @test q isa Int
        @test cdf(db, q - 1) < p <= cdf(db, q)
    end

    @test_throws ArgumentError quantile(d, -0.1)
    @test_throws ArgumentError quantile(d, 1.1)
    @test_throws ArgumentError quantile(d, NaN)
end

@testitem "Convolved discrete quantile matches old numeric quantile" begin
    using Distributions, Optimization, OptimizationOptimJL
    using ConvolvedDistributions: Convolved

    # Regression check: switching to the lattice route changed the type
    # and the exactness, not the answer. `invoke` reaches the
    # less-specific `quantile(d::Convolved, p)` method above, which
    # `d`'s `_DiscreteConvolved` method now shadows, so this is the same
    # Nelder-Mead inversion `quantile(d, p)` used by that method.
    d = convolved(Poisson(3.0), Geometric(0.4))
    for p in (0.1, 0.3, 0.5, 0.7, 0.9)
        q_lattice = quantile(d, p)
        q_nm = invoke(quantile, Tuple{Convolved, Real}, d, p)
        @test abs(q_lattice - q_nm) <= 1
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
        @test quantile(d, p) ≈ quantile(ref, p) atol = 1.0e-2
    end

    # Median of a symmetric difference is 0. The analytic path inverts a
    # closed-form cdf, so only solver precision remains (1e-6); the
    # numeric path stacks quadrature error on the inversion, hence the
    # looser 1e-3.
    dsym = difference(Normal(1.0, 1.0), Normal(1.0, 1.0))
    @test quantile(dsym, 0.5) ≈ 0.0 atol = 1.0e-6
    dsymn = difference(Gamma(2.0, 1.5), Gamma(2.0, 1.5))
    @test quantile(dsymn, 0.5) ≈ 0.0 atol = 1.0e-3

    # Numeric path: quantile round-trips through the quadrature cdf.
    dn = difference(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(dn, p)
        @test cdf(dn, q) ≈ p atol = 1.0e-3
    end
end

@testitem "Difference discrete quantile is exact" begin
    # No `using Optimization, OptimizationOptimJL`: the exact lattice
    # route needs neither.
    using Distributions

    dd = difference(DiscreteUniform(1, 5), DiscreteUniform(0, 3))
    @test quantile(dd, 0.0) === minimum(dd)
    @test quantile(dd, 1.0) === maximum(dd)
    for p in (0.1, 0.3, 0.5, 0.7, 0.9)
        q = quantile(dd, p)
        @test q isa Int
        @test cdf(dd, q - 1) < p <= cdf(dd, q)
    end

    # Unbounded-below case: the subtrahend is unbounded above, so
    # `minimum(dd)` is `-Inf` and an interior `p` has no lattice point
    # to start an upward scan from. `p = 0`/`p = 1` stay exact either
    # way -- only `p = 0` exercises the non-finite return here since
    # `maximum` is finite for this pair.
    du = difference(Binomial(10, 0.5), Poisson(5.0))
    @test isinf(minimum(du))
    @test quantile(du, 0.0) === minimum(du)
    @test quantile(du, 1.0) === maximum(du)
    @test quantile(du, 1.0) isa Int

    @test_throws ArgumentError quantile(dd, -0.1)
    @test_throws ArgumentError quantile(dd, 1.1)
    @test_throws ArgumentError quantile(dd, NaN)
end

@testitem "Difference discrete quantile matches old numeric quantile" begin
    using Distributions, Optimization, OptimizationOptimJL
    using ConvolvedDistributions: Difference

    # Regression check: switching to the lattice route changed the type
    # and the exactness, not the answer. `invoke` reaches the
    # less-specific `Distributions.quantile(d::Difference, p)` method
    # from `ConvolvedDistributionsOptimizationExt`, which `d`'s
    # `_DiscreteDifference` method now shadows.
    dd = difference(Binomial(20, 0.5), Binomial(15, 0.4))
    for p in (0.1, 0.3, 0.5, 0.7, 0.9)
        q_lattice = quantile(dd, p)
        q_nm = invoke(quantile, Tuple{Difference, Real}, dd, p)
        @test abs(q_lattice - q_nm) <= 1
    end

    # Unbounded-below fallback: an interior p on a `Difference` with
    # `-Inf` minimum still returns a value, via the extension's numeric
    # route, instead of erroring. Not checked for accuracy here: the
    # Nelder-Mead solve's own imprecision on a discrete cdf is a known
    # limitation that this fallback intentionally leaves in place.
    du = difference(Binomial(10, 0.5), Poisson(5.0))
    q = quantile(du, 0.5)
    @test q isa Real
    @test isfinite(q)
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
        @test quantile(d, p) ≈ quantile(ref, p) atol = 1.0e-2
    end

    # Numeric path: quantile round-trips through the quadrature cdf.
    dn = product(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(dn, p)
        @test cdf(dn, q) ≈ p atol = 1.0e-3
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
    @test quantile(ds, 0.5) ≈ Statistics.quantile(samples, 0.5) atol = 8.0e-3
    for p in (0.25, 0.5, 0.75)
        @test cdf(ds, quantile(ds, p)) ≈ p atol = 1.0e-3
    end

    # Bounded supports: p = 0 / 1 return the support ends exactly.
    dp = product(Uniform(1.0, 2.0), Uniform(3.0, 4.0))
    @test quantile(dp, 0.0) == 3.0
    @test quantile(dp, 1.0) == 8.0
    for p in (0.25, 0.5, 0.75)
        @test cdf(dp, quantile(dp, p)) ≈ p atol = 1.0e-3
    end
    @test_throws ArgumentError quantile(dp, -0.1)
    @test_throws ArgumentError quantile(dp, 1.1)
end

@testitem "Product discrete quantile is exact" begin
    # No `using Optimization, OptimizationOptimJL`: the exact lattice
    # route needs neither.
    using Distributions

    dp = product(DiscreteUniform(1, 3), DiscreteUniform(1, 4))
    @test quantile(dp, 0.0) === minimum(dp)
    @test quantile(dp, 1.0) === maximum(dp)
    for p in (0.1, 0.3, 0.5, 0.7, 0.9)
        q = quantile(dp, p)
        @test q isa Int
        @test cdf(dp, q - 1) < p <= cdf(dp, q)
    end

    @test_throws ArgumentError quantile(dp, -0.1)
    @test_throws ArgumentError quantile(dp, 1.1)
    @test_throws ArgumentError quantile(dp, NaN)
end

@testitem "Product discrete quantile matches old numeric quantile" begin
    using Distributions, Optimization, OptimizationOptimJL
    using ConvolvedDistributions: Product

    # Regression check: switching to the lattice route changed the type
    # and the exactness, not the answer. `invoke` reaches the
    # less-specific `Distributions.quantile(d::Product, p)` method from
    # `ConvolvedDistributionsOptimizationExt`, which `d`'s
    # `_DiscreteProduct` method now shadows.
    #
    # Restricted to p in [0.3, 0.5]: `_product_quantile_guess`'s own
    # docstring notes it overshoots in the tails, and Nelder-Mead's
    # simplex does not always move off an already-integer guess, so the
    # numeric answer is unreliable there.
    dp = product(Binomial(20, 0.4), Binomial(15, 0.6))
    for p in (0.3, 0.4, 0.5)
        q_lattice = quantile(dp, p)
        q_nm = invoke(quantile, Tuple{Product, Real}, dp, p)
        @test abs(q_lattice - q_nm) <= 2
    end
end

@testitem "Ratio quantile inverts cdf" begin
    using Distributions, Optimization, OptimizationOptimJL

    # Analytic path: Gamma / Gamma has the closed form
    # (θx / θy) * BetaPrime(αx, αy).
    x = Gamma(2.0, 1.5)
    y = Gamma(3.0, 0.5)
    d = ratio(x, y)
    ref = 3.0 * BetaPrime(2.0, 3.0)
    for p in (0.1, 0.5, 0.9)
        @test quantile(d, p) ≈ quantile(ref, p) atol = 1.0e-2
    end

    # Numeric path: quantile round-trips through the quadrature cdf.
    dn = ratio(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        q = quantile(dn, p)
        @test cdf(dn, q) ≈ p atol = 1.0e-3
    end

    # Sign-crossing denominator: the opposing-tail guess is not finite
    # (quantile(y, 1 - p) can be 0 or negative), exercising the median
    # fallback in `quantile_initial_guess(::Ratio, p)`.
    dc = ratio(Normal(0.0, 2.0), Normal(0.0, 0.5))
    refc = Cauchy(0.0, 4.0)
    for p in (0.1, 0.5, 0.9)
        @test quantile(dc, p) ≈ quantile(refc, p) atol = 1.0e-2
    end

    # rand on a truncated Ratio routes through the base quantile.
    td = truncated(dn, 1.0, 8.0)
    q = quantile(td, 0.5)
    @test cdf(td, q) ≈ 0.5 atol = 1.0e-3
    @test rand(td) isa Real
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
        @test quantile(dp, p) ≈ quantile(refp, p) rtol = 1.0e-3
    end

    # Numeric path: an analytic Normal pair forced through NumericSolver
    # against the closed-form convolution. The quadrature cdf tail error
    # is ~1e-8, so rtol 1e-3 in q is honest.
    a = Normal(1.0, 2.0)
    b = Normal(-0.5, 1.5)
    dn = convolved(a, b; method = NumericSolver())
    refn = convolve(a, b)
    for p in (0.001, 0.01, 0.99, 0.999)
        @test quantile(dn, p) ≈ quantile(refn, p) rtol = 1.0e-3
    end

    # Difference support is all of R, so the lower tail sits at negative
    # q; Normal - Normal has the closed form
    # Normal(μx - μy, sqrt(σx² + σy²)).
    dd = difference(Normal(5.0, 1.5), Normal(2.0, 2.0))
    refd = Normal(3.0, sqrt(1.5^2 + 2.0^2))
    for p in (0.001, 0.01, 0.99, 0.999)
        @test quantile(dd, p) ≈ quantile(refd, p) rtol = 1.0e-3
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
        @test cdf(du, quantile(du, p)) ≈ p atol = 1.0e-3
        @test cdf(dd, quantile(dd, p)) ≈ p atol = 1.0e-3
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
        @test cdf(tn, q) ≈ p atol = 1.0e-3
    end

    # MC tolerances: at n = 50_000 the empirical-cdf standard error is
    # at most ~2.2e-3 and the sample median's is ~1e-2, so 1e-2 / 0.05
    # sit at ~5 standard errors here and in the Difference check below.
    samples = rand(rng, tn, 50_000)
    @test all(1.0 .<= samples .<= 8.0)
    for x in (2.0, 4.0, 6.0)
        @test mean(samples .<= x) ≈ cdf(tn, x) atol = 1.0e-2
    end
    @test median(samples) ≈ quantile(tn, 0.5) atol = 0.05

    # Same for a truncated Difference on the numeric path.
    dz = difference(Gamma(3.0, 1.0), Gamma(2.0, 1.0))
    tz = truncated(dz, -2.0, 5.0)
    zs = rand(rng, tz, 50_000)
    @test all(-2.0 .<= zs .<= 5.0)
    @test median(zs) ≈ quantile(tz, 0.5) atol = 0.05
end

@testitem "quantile_by_optimization public API" begin
    using ConvolvedDistributions: quantile_by_optimization
    using Distributions, Optimization, OptimizationOptimJL

    # Works directly on any UnivariateDistribution, not only the
    # Convolved/Difference/Product family -- this is the shared entry
    # point other EpiAware packages reuse instead of their own copy of
    # the same solve (#112).
    d = Normal(2.0, 1.5)
    for p in (0.1, 0.5, 0.9)
        q = quantile_by_optimization(d, p, [2.0])
        @test q ≈ quantile(d, p) atol = 1.0e-4
    end

    # Boundary shortcuts return the support ends exactly.
    du = Uniform(1.0, 2.0)
    @test quantile_by_optimization(du, 0.0, [1.5]) == 1.0
    @test quantile_by_optimization(du, 1.0, [1.5]) == 2.0

    # `postprocess` is applied to the solved value before it is
    # returned, e.g. to snap it onto a discrete grid.
    q_raw = quantile_by_optimization(d, 0.5, [2.0])
    q_rounded = quantile_by_optimization(
        d, 0.5, [2.0]; postprocess = x -> round(x; digits = 1)
    )
    @test q_rounded == round(q_raw; digits = 1)

    # Out-of-range p throws, naming the offending value.
    err = try
        quantile_by_optimization(d, 1.5, [2.0])
        nothing
    catch caught
        caught
    end
    @test err isa ArgumentError
    @test occursin("1.5", err.msg)

    # NaN p is rejected by default (check_nan = true).
    @test_throws ArgumentError quantile_by_optimization(d, NaN, [2.0])

    # check_nan = false leaves ordinary p values unaffected; it only
    # widens what the NaN-specific check above rejects.
    @test quantile_by_optimization(d, 0.5, [2.0]; check_nan = false) ≈
        quantile(d, 0.5) atol = 1.0e-4

    # check_nan = false with an actual NaN p skips validation, but the
    # solve has no meaningful objective and must error at the
    # convergence check rather than return a value.
    @test_throws ErrorException quantile_by_optimization(
        d, NaN, [2.0]; check_nan = false
    )
end

@testitem "quantile_initial_guess public hook" begin
    using ConvolvedDistributions: ConvolvedDistributions, Convolved,
        quantile_initial_guess
    using Distributions, Optimization, OptimizationOptimJL

    p = 0.3

    # Matches the historical formula for each type.
    dcv = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test quantile_initial_guess(dcv, p) ==
        [sum(c -> float(quantile(c, p)), dcv.components)]

    ddf = difference(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    @test quantile_initial_guess(ddf, p) ==
        [float(quantile(ddf.x, p)) - float(quantile(ddf.y, 1 - p))]

    dpr = product(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    @test quantile_initial_guess(dpr, p) ==
        [float(quantile(dpr.x, p)) * float(quantile(dpr.y, p))]

    drt = ratio(Gamma(3.0, 1.0), LogNormal(0.2, 0.3))
    @test quantile_initial_guess(drt, p) ==
        [float(quantile(drt.x, p)) / float(quantile(drt.y, 1 - p))]

    # A downstream override is load-bearing: `quantile(d, p)` picks up a
    # specialised guess method instead of the default. The override
    # must use the concrete parametrised component type and
    # annotate `p::Real`: a bare `Convolved{Tuple{Gamma, Uniform}}`
    # does not match a real `Convolved{Tuple{Gamma{Float64},
    # Uniform{Float64}}}` (struct type parameters are invariant), and
    # an untyped `p` is ambiguous with the generic `Convolved`
    # fallback's `p::Real`. A `called` spy proves the override
    # actually dispatches rather than inferring it from the converged
    # value -- Nelder-Mead reaches the same answer from many
    # reasonable starting points regardless of which method supplied
    # the guess, so a plausible-looking numeric result alone would not
    # prove this.
    #
    # The override is added to the shared `quantile_initial_guess`
    # method table, so it is removed again in `finally`:
    # TestItemRunner runs every testitem in one process, and a
    # permanent method on this widely-used
    # `Convolved{Tuple{Gamma{Float64}, Uniform{Float64}}}` type would
    # leak into other testitems (e.g.
    # test/consistency/log_methods_consistency.jl constructs the same
    # type combination).
    d42 = convolved(Gamma(2.0, 1.0), Uniform(0.0, 1.0))
    called = Ref(false)
    ConvolvedDistributions.quantile_initial_guess(
        d::Convolved{Tuple{Gamma{Float64}, Uniform{Float64}}},
        p::Real
    ) = (called[] = true; [3.0])
    override = which(
        ConvolvedDistributions.quantile_initial_guess,
        Tuple{typeof(d42), Float64}
    )
    try
        q = quantile(d42, 0.5)
        @test called[]
        @test cdf(d42, q) ≈ 0.5 atol = 1.0e-3
    finally
        Base.delete_method(override)
    end
end

@testitem "quantile_by_optimization solver and solve_kwargs" begin
    using ConvolvedDistributions: quantile_by_optimization
    using Distributions, Optimization, OptimizationOptimJL
    using OptimizationOptimJL: Optim

    d = Normal(2.0, 1.5)
    p = 0.3

    # `solve_kwargs` pass through to `solve`, merged over the defaults so
    # an explicit value overrides only the matching default.
    q = quantile_by_optimization(
        d, p, [2.0]; maxiters = 500, reltol = 1.0e-6, abstol = 1.0e-6
    )
    @test q ≈ quantile(d, p) atol = 1.0e-4

    # A non-default `solver` is used for the solve: NelderMead with fixed
    # (rather than adaptive) step parameters still converges.
    fixed_nm = NelderMead(parameters = Optim.FixedParameters())
    q_solver = quantile_by_optimization(d, p, [2.0]; solver = fixed_nm)
    @test q_solver ≈ quantile(d, p) atol = 1.0e-4
end
