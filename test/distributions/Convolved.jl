@testitem "Convolved constructor and validation" begin
    using Distributions

    d = convolved(Gamma(2.0, 1.0), LogNormal(1.5, 0.5))
    @test d isa ConvolvedDistributions.Convolved
    @test length(d.components) == 2

    # Vector constructor
    dv = convolved([Gamma(2.0, 1.0), Gamma(1.0, 1.0), Normal(0.0, 1.0)])
    @test length(dv.components) == 3

    # Tuple constructor
    dt = convolved((Gamma(2.0, 1.0), Normal(0.0, 1.0)))
    @test length(dt.components) == 2

    # Errors
    @test_throws ArgumentError convolved([Gamma(2.0, 1.0)])
    @test_throws ArgumentError convolved((Gamma(2.0, 1.0),))

    # Inner-constructor guards, only reachable via direct construction:
    # the type itself rejects an empty tuple (the degenerate single
    # component is allowed for the recursive rebuild paths) and a
    # `Number` component.
    @test_throws ArgumentError ConvolvedDistributions.Convolved(())
    @test_throws ArgumentError ConvolvedDistributions.Convolved(
        (Gamma(2.0, 1.0), 1.0)
    )
    @test ConvolvedDistributions.Convolved((Gamma(2.0, 1.0),)) isa
        ConvolvedDistributions.Convolved
end

@testitem "single-component Convolved under NumericSolver evaluates (regression)" begin
    using Distributions

    # `convolved(...)` always builds two or more components, but
    # `Convolved` itself is public and its inner constructor permits one.
    # Under the default `AnalyticalSolver` this already worked (the
    # single component short-circuits `_maybe_analytic`); under
    # `NumericSolver` it used to throw from `Convolved(())` inside
    # `_rest_distribution` (a pre-existing bug, reachable directly
    # through the public `Convolved` type without the deferred `power`
    # keyword — see #89).
    x = Normal(1.0, 2.0)
    d = ConvolvedDistributions.Convolved((x,); method = NumericSolver())
    @test ConvolvedDistributions._maybe_analytic(d) === nothing

    # pdf/cdf route directly through the fixed component's own pdf/cdf
    # (bit-identical); logpdf/logcdf on the generic numeric path
    # recompute via `log(pdf(...))`/`log(cdf(...))` rather than
    # delegating to the component's own (more precise) logpdf/logcdf, so
    # they agree only to floating-point precision, not bit-for-bit —
    # true of the numeric path in general, not specific to this fix.
    for z in (-1.0, 1.0, 3.0)
        @test pdf(d, z) == pdf(x, z)
        @test cdf(d, z) == cdf(x, z)
        @test logpdf(d, z) ≈ logpdf(x, z) atol = 1.0e-12
        @test logcdf(d, z) ≈ logcdf(x, z) atol = 1.0e-12
    end

    zs = [-1.0, 1.0, 3.0]
    @test pdf(d, zs) == pdf.(Ref(x), zs)
    @test cdf(d, zs) == cdf.(Ref(x), zs)
    @test logpdf(d, zs) ≈ logpdf.(Ref(x), zs) atol = 1.0e-12

    # Same fix on the discrete lattice route.
    p = Poisson(2.0)
    dp = ConvolvedDistributions.Convolved((p,); method = NumericSolver())
    @test Distributions.value_support(typeof(dp)) === Discrete
    for k in 0:5
        @test pdf(dp, k) == pdf(p, k)
        @test cdf(dp, k) == cdf(p, k)
    end
end

@testitem "Convolved support and params" begin
    using Distributions

    d = convolved(Gamma(2.0, 1.0), Normal(0.0, 1.0))
    # Gamma support [0, Inf), Normal support (-Inf, Inf)
    @test minimum(d) == -Inf
    @test maximum(d) == Inf

    d2 = convolved(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test minimum(d2) == 0.0
    @test maximum(d2) == 3.0

    # Negative support component
    d3 = convolved(Normal(-2.0, 1.0), Uniform(0.0, 1.0))
    @test minimum(d3) == -Inf
    @test maximum(d3) == Inf

    p = params(d2)
    @test p == ((0.0, 1.0), (0.0, 2.0))

    # `components` is the public accessor for peeling a Convolved apart, and it
    # extends `Distributions.components` (same function, no clash under
    # `using Distributions`).
    @test components === Distributions.components
    @test components(d2) === d2.components
    @test components(d2) == (Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test components(d2) isa Tuple
end

@testitem "Convolved analytic agreement with Distributions.convolve" begin
    using Distributions

    # Normal + Normal
    a = Normal(1.0, 2.0)
    b = Normal(-0.5, 1.5)
    d = convolved(a, b)
    ref = convolve(a, b)
    xs = -5.0:1.0:8.0
    for x in xs
        @test cdf(d, x) ≈ cdf(ref, x) atol = 1.0e-10
        @test pdf(d, x) ≈ pdf(ref, x) atol = 1.0e-10
        @test logpdf(d, x) ≈ logpdf(ref, x) atol = 1.0e-8
    end

    # Equal-scale Gamma + Gamma (shapes add)
    g1 = Gamma(2.0, 1.5)
    g2 = Gamma(3.0, 1.5)
    dg = convolved(g1, g2)
    refg = convolve(g1, g2)
    for x in 0.5:1.0:12.0
        @test cdf(dg, x) ≈ cdf(refg, x) atol = 1.0e-10
        @test pdf(dg, x) ≈ pdf(refg, x) atol = 1.0e-10
    end

    # Three Normals fold pairwise analytically
    c = Normal(0.5, 1.0)
    d3 = convolved(a, b, c)
    ref3 = convolve(convolve(a, b), c)
    for x in -5.0:1.0:8.0
        @test cdf(d3, x) ≈ cdf(ref3, x) atol = 1.0e-10
    end

    # Equal-rate Exponentials convolve to a Gamma analytically
    e1 = Exponential(1.5)
    de = convolved(e1, Exponential(1.5))
    refe = convolve(e1, Exponential(1.5))
    for x in 0.5:1.0:10.0
        @test cdf(de, x) ≈ cdf(refe, x) atol = 1.0e-10
    end
end

@testitem "Convolved NumericSolver matches analytic ground truth" begin
    using Distributions

    # For pairs that HAVE a closed form, force the numeric quadrature path
    # and check it reproduces the exact analytic cdf AND pdf. The scalar path
    # uses each point's tight window and matches to ~1e-7; the batched path
    # shares one window across points and is looser on wide ranges.
    cases = [
        (Normal(1.0, 2.0), Normal(-0.5, 1.5), -3.0, 8.0),
        (Gamma(2.0, 1.5), Gamma(3.0, 1.5), 0.5, 12.0),
        (Exponential(1.5), Exponential(1.5), 0.3, 8.0),
    ]
    for (a, b, lo, hi) in cases
        dn = convolved(a, b; method = NumericSolver())
        ref = convolve(a, b)

        # NumericSolver must actually bypass the analytic specialisation.
        @test ConvolvedDistributions._maybe_analytic(dn) === nothing
        @test ConvolvedDistributions._maybe_analytic(
            convolved(a, b)
        ) !== nothing

        xs = collect(range(lo, hi; length = 10))
        for x in xs
            @test cdf(dn, x) ≈ cdf(ref, x) atol = 1.0e-6
            @test pdf(dn, x) ≈ pdf(ref, x) atol = 1.0e-6
        end

        # Batched numeric vs analytic ground truth (looser shared-window
        # tolerance for the wide range; compared elementwise).
        cb = cdf(dn, xs)
        pb = pdf(dn, xs)
        @test maximum(abs.(cb .- [cdf(ref, x) for x in xs])) < 2.0e-4
        @test maximum(abs.(pb .- [pdf(ref, x) for x in xs])) < 6.0e-3
    end
end

@testitem "Convolved unsupported analytic pairs use numeric path" begin
    using Distributions, Random, Statistics

    # Different-scale Gamma and different-rate Exponential have no
    # closed-form convolution; these must fall back to numeric quadrature
    # rather than throwing from Distributions.convolve.
    rng = MersenneTwister(7)

    dg = convolved(Gamma(2.0, 1.0), Gamma(3.0, 2.0))
    @test 0.0 <= cdf(dg, 5.0) <= 1.0
    sg = [
        rand(rng, Gamma(2.0, 1.0)) + rand(rng, Gamma(3.0, 2.0))
            for _ in 1:200_000
    ]
    @test cdf(dg, 8.0) ≈ mean(sg .<= 8.0) atol = 5.0e-3

    de = convolved(Exponential(1.0), Exponential(2.0))
    @test 0.0 <= cdf(de, 3.0) <= 1.0
    se = [
        rand(rng, Exponential(1.0)) + rand(rng, Exponential(2.0))
            for _ in 1:200_000
    ]
    @test cdf(de, 3.0) ≈ mean(se .<= 3.0) atol = 5.0e-3
end

@testitem "Convolved numeric path matches Monte Carlo" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(42)
    # Gamma + LogNormal has no analytical convolve -> numeric path
    a = Gamma(2.0, 1.0)
    b = LogNormal(0.5, 0.4)
    d = convolved(a, b)

    n = 400_000
    samples = [rand(rng, a) + rand(rng, b) for _ in 1:n]

    for q in (1.5, 2.5, 4.0, 6.0)
        emp = mean(samples .<= q)
        @test cdf(d, q) ≈ emp atol = 5.0e-3
    end

    @test pdf(d, 3.0) > 0
    @test logpdf(d, 3.0) ≈ log(pdf(d, 3.0)) atol = 1.0e-8
    @test mean(samples) ≈ mean(a) + mean(b) atol = 2.0e-2
end

@testitem "Convolved numeric path with unbounded-below component" begin
    using Distributions, Random, Statistics

    # Gamma + Normal has an unbounded-below integration component, so the
    # numeric quadrature window starts at -Inf and must be clamped to a
    # finite quantile (the `_CONVOLVED_TAIL` window) before the
    # Gauss-Legendre mapping.
    rng = MersenneTwister(91)
    a = Gamma(2.0, 1.0)
    b = Normal(0.0, 1.0)
    d = convolved(a, b)

    @test minimum(d) == -Inf
    @test maximum(d) == Inf

    n = 400_000
    samples = [rand(rng, a) + rand(rng, b) for _ in 1:n]

    for q in (-1.0, 1.0, 3.0, 5.0)
        c = cdf(d, q)
        p = pdf(d, q)
        @test isfinite(c)
        @test isfinite(p)
        @test 0.0 <= c <= 1.0
        @test p >= 0.0
        @test insupport(d, q)
        @test c ≈ mean(samples .<= q) atol = 5.0e-3
    end

    # Scalar and batched paths agree for the unbounded-below component.
    xs = [-1.0, 0.5, 2.0, 4.0]
    @test cdf(d, xs) ≈ [cdf(d, x) for x in xs] rtol = 1.0e-9
    @test pdf(d, xs) ≈ [pdf(d, x) for x in xs] rtol = 1.0e-9
end

@testitem "Convolved nested unbounded component window (#45)" begin
    using Distributions

    # A nested `Convolved` as the integration (last) component with
    # unbounded support routes the window clamp through
    # `_window_quantile(::Convolved, p)`; the primal rebuild threw a
    # `primal(::Tuple)` MethodError on the nested parameter tuples
    # (issue #45). Normal components give an exact reference.
    inner = convolved(Normal(1.0, 2.0), Normal(0.5, 1.5))
    d = convolved(Normal(0.0, 1.0), inner; method = NumericSolver())
    ref = Normal(1.5, sqrt(1.0 + 4.0 + 2.25))

    for x in (-2.0, 0.0, 1.5, 4.0)
        @test cdf(d, x) ≈ cdf(ref, x) atol = 1.0e-5
        @test pdf(d, x) ≈ pdf(ref, x) atol = 1.0e-5
    end
end

@testitem "_window_quantile falls back to a finite sentinel on DomainError, both tail directions" begin
    # An extreme parameter (e.g. a Gamma shape of `1e32`, the kind a
    # sampler can propose during warm-up before it has found the typical
    # set) makes `quantile` throw a `DomainError` deep inside
    # `SpecialFunctions`/`StatsFuns`, for `p` on either side of 0.5.
    using ConvolvedDistributions: _window_quantile
    using Distributions

    comp = Gamma(1.0097410503568854e32, 1.009741050356885e32)
    @test_throws DomainError quantile(comp, 0.3)
    @test_throws DomainError quantile(comp, 0.7)

    @test _window_quantile(comp, 0.3) == -1.0e100
    @test _window_quantile(comp, 0.7) == 1.0e100

    # A non-`DomainError` failure is not silently converted to a
    # sentinel; it propagates.
    @test_throws ArgumentError _window_quantile(Gamma(2.0, 1.5), NaN)
end

@testitem "Convolved numeric path survives extreme component parameters" begin
    using Distributions

    for comp in (
            Gamma(1.0097410503568854e32, 1.009741050356885e32),
            Gamma(5.363748528908569e195, 1.0),
        )
        d = convolved(Uniform(0.0, 1.0), comp; method = NumericSolver())
        for x in (0.5, 1.0, 5.0, 100.0, 1.0e10)
            # `pdf`/`cdf` at these `x` are legitimately (near-)zero, deep
            # in the component's extreme left tail, so `logpdf` is `-Inf`
            # there -- exactly the "sampler can reject" contract this
            # test wants. `!isnan`, not `isfinite`, is the right pin.
            @test !isnan(cdf(d, x))
            @test !isnan(pdf(d, x))
            @test !isnan(logpdf(d, x))
        end
    end
end

@testitem "Convolved pdf matches analytic and Monte Carlo" begin
    using Distributions, Random, Statistics

    # Analytic pairs: numeric-free exact density via Distributions.convolve.
    a = Normal(1.0, 2.0)
    b = Normal(-0.5, 1.5)
    d = convolved(a, b)
    ref = convolve(a, b)
    for x in -4.0:0.5:6.0
        @test pdf(d, x) ≈ pdf(ref, x) atol = 1.0e-10
        @test logpdf(d, x) ≈ logpdf(ref, x) atol = 1.0e-8
    end

    g1 = Gamma(2.0, 1.5)
    g2 = Gamma(3.0, 1.5)
    dg = convolved(g1, g2)
    refg = convolve(g1, g2)
    for x in 0.5:0.5:12.0
        @test pdf(dg, x) ≈ pdf(refg, x) atol = 1.0e-10
    end

    # Non-analytic pair: density convolution integral vs Monte-Carlo
    # histogram density, and total mass ~1.
    rng = MersenneTwister(123)
    dn = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    n = 4_000_000
    s = [
        rand(rng, Gamma(2.0, 1.0)) + rand(rng, LogNormal(0.5, 0.4))
            for _ in 1:n
    ]
    hw = 0.05
    for x in (2.0, 3.0, 5.0)
        emp = mean((s .> x - hw) .& (s .<= x + hw)) / (2hw)
        @test pdf(dn, x) ≈ emp rtol = 2.0e-2
    end

    grid = collect(0.05:0.1:30.0)
    @test sum(pdf(dn, grid)) * 0.1 ≈ 1.0 atol = 2.0e-3

    # Bounded components: triangular-style density, exact midpoint value
    # and unit mass.
    du = convolved(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test pdf(du, 2.5) ≈ 1 / 3 atol = 1.0e-6
    gu = collect(0.005:0.01:5.0)
    @test sum(pdf(du, gu)) * 0.01 ≈ 1.0 atol = 1.0e-3
end

@testitem "Convolved rand sums components" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(1)
    d = convolved(Gamma(2.0, 1.0), Normal(3.0, 0.5))
    s = [rand(rng, d) for _ in 1:200_000]
    @test mean(s) ≈ 2.0 + 3.0 atol = 5.0e-2
    @test var(s) ≈ var(Gamma(2.0, 1.0)) + 0.25 atol = 1.0e-1
end

@testitem "Convolved batched cdf/logpdf match scalar" begin
    using Distributions

    # Numeric path
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    xs = [1.0, 2.0, 3.5, 5.0, 7.0]

    cdf_batch = cdf(d, xs)
    cdf_scalar = [cdf(d, x) for x in xs]
    @test cdf_batch ≈ cdf_scalar rtol = 1.0e-9

    pdf_batch = pdf(d, xs)
    pdf_scalar = [pdf(d, x) for x in xs]
    @test pdf_batch ≈ pdf_scalar rtol = 1.0e-9

    lp_batch = logpdf(d, xs)
    lp_scalar = [logpdf(d, x) for x in xs]
    @test lp_batch ≈ lp_scalar rtol = 1.0e-9

    # Analytic path
    da = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
    @test cdf(da, xs) ≈ [cdf(da, x) for x in xs] atol = 1.0e-10
    @test pdf(da, xs) ≈ [pdf(da, x) for x in xs] atol = 1.0e-10
    @test logpdf(da, xs) ≈ [logpdf(da, x) for x in xs] atol = 1.0e-10
end

@testitem "Convolved batched cdf does a single solve" begin
    using Distributions

    # This batch deliberately spans a wide range (16x), the hardest case
    # for a shared quadrature grid: the batched path must match the scalar
    # per-point windows even here.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    xs = collect(0.5:0.25:8.0)
    @test cdf(d, xs) ≈ [cdf(d, x) for x in xs] rtol = 1.0e-9
end

@testitem "Convolved batched quadrature matches scalar windows (#29)" begin
    using Distributions

    # The batched numeric path integrates every point over its own
    # scalar-path window (shared composite panels + per-point end
    # corrections), so batched and scalar log densities agree far inside
    # the documented ~1e-8 bound even for wide batches, where the old
    # single shared window drifted to ~2e-3 in the tails.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

    # The issue #29 example batch.
    xs = [1.0, 2.0, 3.0, 5.0]
    @test logpdf(d, xs) ≈ [logpdf(d, x) for x in xs] atol = 1.0e-9

    # Wide batches (16x and 40x spans), the old worst case.
    for xs in (collect(0.5:0.25:8.0), collect(0.5:0.5:20.0))
        lp = logpdf(d, xs)
        ls = [logpdf(d, x) for x in xs]
        @test maximum(abs.(lp .- ls)) < 1.0e-8
        @test cdf(d, xs) ≈ [cdf(d, x) for x in xs] atol = 1.0e-9
        @test pdf(d, xs) ≈ [pdf(d, x) for x in xs] rtol = 1.0e-8
    end

    # Three components: the recursive numeric kernel takes the same
    # per-point-window batched path.
    d3 = convolved(Gamma(2.0, 1.0), Gamma(1.5, 2.0), LogNormal(0.5, 0.4))
    xs3 = [2.0, 4.0, 6.0, 10.0, 15.0]
    @test logpdf(d3, xs3) ≈ [logpdf(d3, x) for x in xs3] atol = 1.0e-8
end

@testitem "Convolved batched AD wrt parameters (#43)" begin
    using Distributions, ForwardDiff

    # Issue #43 MWE: the batched vector methods must accept components
    # whose parameters carry Dual tracers. `eltype(d)` stays `Float64`
    # for a Dual-parameterised Convolved, so the final clamp/convert
    # must promote with the quadrature result element type rather than
    # truncate it.
    obs = [1.0, 2.0, 3.0]
    θ₀ = [2.0, 1.0]
    d(θ) = convolved(Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4))

    # The scalar path is the trusted reference. Batched and scalar
    # parameter gradients agree to machine precision here (previously
    # documented as ~2e-7 relative on this batch, ~2e-6 with the
    # component order swapped; see the wide-batch test below for why
    # that gap is gone).
    for f in (pdf, logpdf, cdf)
        g_batch = ForwardDiff.gradient(θ -> sum(f(d(θ), obs)), θ₀)
        g_scalar = ForwardDiff.gradient(
            θ -> sum(x -> f(d(θ), x), obs), θ₀
        )
        @test g_batch ≈ g_scalar rtol = 1.0e-10
    end

    # Component order swapped: same check.
    dswap(θ) = convolved(LogNormal(0.5, 0.4), Gamma(θ[1], θ[2]))
    for f in (pdf, logpdf, cdf)
        g_batch = ForwardDiff.gradient(θ -> sum(f(dswap(θ), obs)), θ₀)
        g_scalar = ForwardDiff.gradient(
            θ -> sum(x -> f(dswap(θ), x), obs), θ₀
        )
        @test g_batch ≈ g_scalar rtol = 1.0e-10
    end
end

@testitem "Convolved batched AD wrt parameters on a wide batch (#50)" begin
    using Distributions, ForwardDiff

    # Issue #50 reported up to ~4e-4 relative gradient drift between the
    # batched and scalar paths on this exact wide batch, dominated by
    # the smallest point (x = 0.5), with primal values unaffected
    # (already agreeing to ~1e-13). Direct reproduction against the code
    # #50 was filed against found no drift: pdf/logpdf/cdf gradients
    # here, and every individual point, agree with the scalar path to
    # ~1e-15, machine precision. The batched composite grid's equal
    # panel spacing was replaced by quantile-panelled spacing a few
    # hours after #50 was filed (fix for #49, commit c09d3f4), and that
    # fix's own commit message records the batched/scalar agreement
    # tightening "from ~7e-11 to machine precision" on the shared grid —
    # #50 was an incidental casualty of #49's fix, not a separate bug.
    # This test locks in that agreement so a future regression on this
    # path shows up here rather than silently reappearing.
    obs = collect(0.5:0.5:8.0)
    θ₀ = [2.0, 1.0]
    d(θ) = convolved(Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4))

    for f in (pdf, logpdf, cdf)
        g_batch = ForwardDiff.gradient(θ -> sum(f(d(θ), obs)), θ₀)
        g_scalar = ForwardDiff.gradient(
            θ -> sum(x -> f(d(θ), x), obs), θ₀
        )
        @test g_batch ≈ g_scalar rtol = 1.0e-10
    end
end

@testitem "Convolved batched AD wrt evaluation points (#44)" begin
    using Distributions, ForwardDiff

    # Batched and scalar eval-point gradients agree tightly: each point
    # keeps its own scalar-path window, so gradient flow through the
    # window bounds matches the scalar path.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    obs = [1.0, 2.0, 3.0, 5.0]

    for f in (pdf, logpdf, cdf)
        g_batch = ForwardDiff.gradient(x -> sum(f(d, x)), obs)
        g_scalar = ForwardDiff.gradient(
            x -> sum(xi -> f(d, xi), x), obs
        )
        @test g_batch ≈ g_scalar rtol = 1.0e-8
    end
end

@testitem "Convolved logcdf/ccdf/logccdf branches" begin
    using Distributions

    # Analytic path: logcdf/ccdf agree with the convolved reference.
    da = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
    refa = convolve(Normal(0.0, 1.0), Normal(1.0, 2.0))
    @test logcdf(da, 2.0) ≈ logcdf(refa, 2.0) atol = 1.0e-10
    @test ccdf(da, 2.0) ≈ ccdf(refa, 2.0) atol = 1.0e-10
    @test logccdf(da, 2.0) ≈ logccdf(refa, 2.0) atol = 1.0e-8

    # Numeric path: logcdf matches log of cdf and ccdf = 1 - cdf.
    dn = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test logcdf(dn, 3.0) ≈ log(cdf(dn, 3.0)) atol = 1.0e-10
    @test ccdf(dn, 3.0) ≈ 1 - cdf(dn, 3.0) atol = 1.0e-10
    @test logccdf(dn, 3.0) ≈ log1p(-cdf(dn, 3.0)) atol = 1.0e-6

    # logccdf edge cases via a bounded numeric-path distribution.
    db = convolved(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test logccdf(db, -1.0) == 0.0   # CDF = 0 -> logccdf = 0
    @test logccdf(db, 6.0) == -Inf   # CDF = 1 -> logccdf = -Inf
end

@testitem "Convolved logpdf outside support on numeric path" begin
    using Distributions

    dn = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test logpdf(dn, -1.0) == -Inf
    @test pdf(dn, -1.0) == 0.0
    @test !insupport(dn, -1.0)
end

@testitem "Convolved batched bounded-support clamps and fallback" begin
    using Distributions

    d = convolved(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test minimum(d) == 0.0
    @test maximum(d) == 5.0
    xs = [-1.0, 1.0, 2.5, 4.0, 6.0]
    cb = cdf(d, xs)
    @test cb[1] == 0.0
    @test cb[end] == 1.0
    @test all(0.0 .<= cb .<= 1.0)
    @test cb ≈ [cdf(d, x) for x in xs] rtol = 1.0e-9

    lp = logpdf(d, xs)
    @test lp[1] == -Inf
    @test lp[end] == -Inf
    @test isfinite(lp[3])

    pb = pdf(d, xs)
    @test pb[1] == 0.0
    @test pb[end] == 0.0
    @test pb[3] > 0
    @test pb ≈ [pdf(d, x) for x in xs] rtol = 1.0e-9

    # All-below-support batches collapse the shared window, hitting the
    # per-point scalar fallback (every entry is 0).
    @test all(cdf(d, [-3.0, -2.0, -1.0]) .== 0.0)
    @test all(pdf(d, [-3.0, -2.0, -1.0]) .== 0.0)
end

@testitem "Convolved eltype and sampler" begin
    using Distributions, Random

    d = convolved(Gamma(2.0, 1.0), Normal(0.0, 1.0))
    @test eltype(d) == Float64
    @test sampler(d) === d
    rng = MersenneTwister(3)
    @test rand(rng, d) isa Real
end

@testitem "Convolved scalar methods value-correct and inferrable" begin
    using Distributions, Test

    analytic = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
    numeric = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    for d in (analytic, numeric)
        for f in (cdf, logcdf, pdf, logpdf, ccdf, logccdf)
            @test f(d, 3.0) isa Float64
        end
        @test (@inferred(cdf(d, 3.0)); true)
        @test (@inferred(pdf(d, 3.0)); true)
    end
end

@testitem "Convolved mean/var/std equal the component sums" begin
    using Distributions

    d = convolved(
        Gamma(2.0, 1.5), LogNormal(1.0, 0.4), Normal(-0.5, 0.8)
    )
    @test mean(d) ≈ sum(mean.(d.components))
    @test var(d) ≈ sum(var.(d.components))
    @test std(d) ≈ sqrt(sum(var.(d.components)))

    du = convolved(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test mean(du) ≈ 0.5 + 1.0
    @test var(du) ≈ var(Uniform(0.0, 1.0)) + var(Uniform(0.0, 2.0))

    # Nested Convolved recurses through the component sum.
    dn = convolved(d, Exponential(2.0))
    @test mean(dn) ≈ mean(d) + mean(Exponential(2.0))
    @test var(dn) ≈ var(d) + var(Exponential(2.0))
end

@testitem "Convolved composes with truncated" begin
    using Distributions

    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    td = truncated(d, 1.0, 8.0)

    @test cdf(td, 0.5) == 0.0
    @test cdf(td, 9.0) == 1.0
    @test 0.0 < cdf(td, 4.0) < 1.0
    @test pdf(td, 4.0) > 0
end

@testitem "Convolved composes with censored (#72)" begin
    using Distributions

    # Distributions.jl's generic `censored` wrapper needs only the
    # standard UnivariateDistribution interface (cdf/pdf/logpdf), which
    # Convolved already implements — this package adds no bespoke
    # censoring machinery of its own (that stays CensoredDistributions.jl's
    # job).
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    cd = censored(d, 1.0, 8.0)

    @test cdf(cd, 0.5) == 0.0
    @test cdf(cd, 8.0) == 1.0
    # Unlike truncated, censored does not renormalise the kept region: the
    # interior CDF matches the unclamped distribution exactly.
    @test cdf(cd, 4.0) ≈ cdf(d, 4.0)
    # The clamp points carry the trimmed tail mass as point masses.
    @test pdf(cd, 1.0) ≈ cdf(d, 1.0)
    @test pdf(cd, 8.0) ≈ ccdf(d, 8.0)
    @test pdf(cd, 4.0) ≈ pdf(d, 4.0)
end

@testitem "Convolved moments cross-check against sampling" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(2024)
    d = convolved(Gamma(2.0, 1.5), LogNormal(1.0, 0.4))
    xs = rand(rng, d, 2_000_000)
    @test isapprox(mean(xs), mean(d); rtol = 0.01)
    @test isapprox(var(xs), var(d); rtol = 0.02)
end

@testitem "Convolved heavy-tailed integration component (#49)" begin
    using Distributions

    # A heavy-tailed integration component stretches the quadrature
    # window to its 1 - 1e-8 quantile (~4.5e3 for LogNormal(0, 1.5))
    # while the integrand's mass sits near O(1), so a single fixed-node
    # window starves the transition region of nodes (issue #49).
    # References computed once with adaptive quadrature (QuadGK via
    # Integrals.jl, reltol = 1e-13) of
    #   F_S(s) = ∫_0^s F_X(s - t) f_Y(t) dt,
    #   f_S(s) = ∫_0^s f_X(s - t) f_Y(t) dt
    # for X = Gamma(2, 1), Y = LogNormal(0, 1.5), and hard-coded.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.0, 1.5))

    @test cdf(d, 3.0) ≈ 0.455300951911572 atol = 1.0e-9
    @test cdf(d, 10.0) ≈ 0.912194823510679 atol = 1.0e-9
    @test pdf(d, 3.0) ≈ 0.180646198535104 atol = 1.0e-9
    @test pdf(d, 10.0) ≈ 0.0147490090653485 atol = 1.0e-9

    # The batched composite path shares its panel grid across points, so
    # it needs mass-following panels for the same reason.
    refs_cdf = [0.455300951911572, 0.912194823510679]
    refs_pdf = [0.180646198535104, 0.0147490090653485]
    @test cdf(d, [3.0, 10.0]) ≈ refs_cdf atol = 1.0e-8
    @test pdf(d, [3.0, 10.0]) ≈ refs_pdf atol = 1.0e-8
end

@testitem "registered discrete analytic pairs (#85, #89)" begin
    using ConvolvedDistributions.TestUtils: test_analytic_skips_quadrature
    using Distributions

    # Poisson + Poisson, equal-p Binomial, and equal-p NegativeBinomial
    # are registered as analytic pairs; each reports :analytic and its
    # density is === the reference (not merely ≈).
    dpp = convolved(Poisson(3.0), Poisson(2.0))
    @test ConvolvedDistributions.evaluation_path(dpp) === :analytic
    test_analytic_skips_quadrature(dpp; x = 4)
    @test pdf(dpp, 4) == pdf(Poisson(5.0), 4)

    dbb = convolved(Binomial(4, 0.3), Binomial(5, 0.3))
    @test ConvolvedDistributions.evaluation_path(dbb) === :analytic
    test_analytic_skips_quadrature(dbb; x = 3)

    dnn = convolved(NegativeBinomial(5, 0.5), NegativeBinomial(3, 0.5))
    @test ConvolvedDistributions.evaluation_path(dnn) === :analytic
    test_analytic_skips_quadrature(dnn; x = 4)

    # A mismatched-p pair has no analytic form: :numeric, but still
    # exact (the lattice fold), and still agrees with brute force.
    dmismatch = convolved(Binomial(4, 0.3), Binomial(5, 0.4))
    @test ConvolvedDistributions.evaluation_path(dmismatch) === :numeric
    @test ConvolvedDistributions.is_exact(dmismatch)
    bf = sum(
        pdf(Binomial(4, 0.3), k) * pdf(Binomial(5, 0.4), 6 - k)
            for k in 0:6
    )
    @test pdf(dmismatch, 6) ≈ bf

    # The analytic and lattice routes agree tightly on an equal-p pair
    # evaluated both ways (NumericSolver forces the lattice route, J5).
    da = convolved(Binomial(4, 0.3), Binomial(5, 0.3))
    dn = convolved(Binomial(4, 0.3), Binomial(5, 0.3); method = NumericSolver())
    @test ConvolvedDistributions.evaluation_path(dn) === :numeric
    @test ConvolvedDistributions.is_exact(dn)
    for k in 0:9
        @test pdf(da, k) ≈ pdf(dn, k) atol = 1.0e-12
        @test cdf(da, k) ≈ cdf(dn, k) atol = 1.0e-12
    end
end

@testitem "convolved(d, k) matches the explicit n-ary form" begin
    using Distributions

    d = LogNormal(0.5, 0.4)
    dk = convolved(d, 3)
    explicit = convolved(d, d, d)
    @test dk isa ConvolvedDistributions.Convolved
    @test length(dk.components) == 3
    for x in (0.5, 1.0, 2.0, 4.0)
        @test pdf(dk, x) ≈ pdf(explicit, x)
        @test cdf(dk, x) ≈ cdf(explicit, x)
    end

    dkv = convolved(d, Val(3))
    for x in (0.5, 1.0, 2.0, 4.0)
        @test pdf(dkv, x) ≈ pdf(explicit, x)
        @test cdf(dkv, x) ≈ cdf(explicit, x)
    end
end

@testitem "convolved(d, k) analytic families collapse exactly" begin
    using Distributions

    @test convolved(Gamma(2.0, 1.5), 5) == Gamma(10.0, 1.5)
    @test convolved(Poisson(1.5), 4) == Poisson(6.0)
    @test convolved(Exponential(2.0), 3) == Gamma(3, 2.0)
    @test convolved(Normal(1.0, 2.0), 3) == Normal(3.0, sqrt(3) * 2.0)
    @test convolved(Binomial(5, 0.3), 4) == Binomial(20, 0.3)
    @test convolved(NegativeBinomial(3, 0.4), 2) ==
        NegativeBinomial(6.0, 0.4)

    # Val path gives the same closed form.
    @test convolved(Gamma(2.0, 1.5), Val(5)) == Gamma(10.0, 1.5)
end

@testitem "convolved(d, k) analytic families skip tuple-building" begin
    using Distributions

    d = Gamma(2.0, 1.5)
    convolved(d, 1_000_000)  # compile
    bytes = @allocated convolved(d, 1_000_000)
    @test bytes < 1000
    @test convolved(d, 1_000_000) == Gamma(2_000_000.0, 1.5)
end

@testitem "convolved(d, k) edge cases" begin
    using Distributions

    d = LogNormal(0.5, 0.4)
    @test convolved(d, 1) === d
    @test convolved(d, Val(1)) === d

    @test_throws ArgumentError convolved(d, 0)
    @test_throws ArgumentError convolved(d, -3)
    @test_throws ArgumentError convolved(d, Val(0))
end

@testitem "convolved(d, k) inference" begin
    using Distributions, Test

    # A closed-form family: stable even for a runtime Integer k, since
    # the result type depends only on d's type, not k's value.
    @inferred convolved(Gamma(2.0, 1.5), 5)

    # A family with no closed form: the Val path is the inferable one;
    # a runtime Integer k is not (the component count is part of the
    # `Convolved` type), verified explicitly rather than merely noted.
    @inferred convolved(LogNormal(0.5, 0.4), Val(3))
    @test_throws ErrorException @inferred convolved(LogNormal(0.5, 0.4), 3)
end

@testitem "convolved accepts a duck-typed component" begin
    using Distributions, Random

    # Implements exactly what this testitem exercises, without subtyping
    # `UnivariateDistribution`. The CDF quantities, `params` and
    # `quantile` are what the quadrature's integration slot needs on top
    # of the densities and moments.
    struct DuckUniform
        a::Float64
        b::Float64
    end
    Distributions.logpdf(d::DuckUniform, x::Real) =
        d.a <= x <= d.b ? -log(d.b - d.a) : -Inf
    Distributions.pdf(d::DuckUniform, x::Real) =
        d.a <= x <= d.b ? 1 / (d.b - d.a) : 0.0
    Distributions.cdf(d::DuckUniform, x::Real) =
        clamp((x - d.a) / (d.b - d.a), 0.0, 1.0)
    Distributions.ccdf(d::DuckUniform, x::Real) = 1 - cdf(d, x)
    Distributions.logcdf(d::DuckUniform, x::Real) = log(cdf(d, x))
    Distributions.logccdf(d::DuckUniform, x::Real) = log(ccdf(d, x))
    Distributions.quantile(d::DuckUniform, p::Real) = d.a + p * (d.b - d.a)
    Distributions.params(d::DuckUniform) = (d.a, d.b)
    Distributions.minimum(d::DuckUniform) = d.a
    Distributions.maximum(d::DuckUniform) = d.b
    Distributions.mean(d::DuckUniform) = (d.a + d.b) / 2
    Distributions.var(d::DuckUniform) = (d.b - d.a)^2 / 12
    Base.rand(rng::AbstractRNG, d::DuckUniform) = d.a + rand(rng) * (d.b - d.a)
    Base.eltype(::Type{DuckUniform}) = Float64

    # Implements `logpdf` only: constructs, since construction checks no
    # method list, and fails on the first call that needs more.
    struct LogpdfOnlyDuck end
    Distributions.logpdf(::LogpdfOnlyDuck, x::Real) =
        logpdf(Normal(0.0, 1.0), x)

    duck = DuckUniform(0.0, 1.0)
    g = Gamma(2.0, 1.0)

    # Uses `Any[...]` rather than a narrower inferred element type: a
    # mixed duck/`UnivariateDistribution` vector infers as `Vector{Any}`.
    d_vec = convolved(Any[duck, g])
    @test d_vec isa ConvolvedDistributions.Convolved
    d_pos = convolved(duck, g)
    @test d_pos isa ConvolvedDistributions.Convolved

    @test mean(d_vec) == mean(duck) + mean(g)
    @test var(d_vec) == var(duck) + var(g)
    @test minimum(d_vec) == minimum(duck) + minimum(g)
    @test maximum(d_vec) == maximum(duck) + maximum(g)

    rng = MersenneTwister(1)
    @test rand(rng, d_vec) isa Real

    # `pdf` reaches the duck component's own `pdf` when it is not the
    # fold's last (integration-variable) component.
    @test pdf(d_pos, 3.0) > 0

    # A `Number` is rejected at construction. Base and Statistics define
    # `minimum`/`maximum`/`mean` on numbers, so a scalar passed by
    # mistake would otherwise fold silently and return a wrong answer
    # rather than throwing.
    @test_throws ArgumentError convolved(duck, 1.0)
    @test_throws ArgumentError convolved(g, 2.0)

    # An `Integer` second argument is the power form, not a component, so
    # the `Number` guard must not catch it.
    @test convolved(g, 2) == Gamma(4.0, 1.0)

    # Anything else constructs unchecked and fails on the call that needs
    # the missing method, rather than against a fixed list up front.
    d_thin = convolved(LogpdfOnlyDuck(), g)
    @test d_thin isa ConvolvedDistributions.Convolved
    @test_throws MethodError pdf(d_thin, 1.0)

    # The opt-in verifier is where a downstream author checks a leaf.
    # `DuckUniform` implements everything, so it passes in strict mode,
    # both as an ordinary component and in the integration slot.
    ConvolvedDistributions.TestUtils.test_component_interface(
        duck; x = 0.5, integration_slot = true, strict = true
    )
    ConvolvedDistributions.TestUtils.test_component_interface(duck; x = 0.5)

    # A duck-typed component works in any position, including the last
    # (the quadrature's integration variable, which routes through
    # `primal_distribution`). The reference is the same convolution with
    # a real `Uniform`, forced onto the numeric route so both sides
    # integrate rather than one taking the registered analytic pair.
    ref = convolved(
        Uniform(0.0, 1.0), g; method = ConvolvedDistributions.NumericSolver()
    )
    d_last = convolved(g, duck)
    @test d_last isa ConvolvedDistributions.Convolved
    @test pdf(d_last, 3.0) ≈ pdf(ref, 3.0) rtol = 1.0e-6
    @test cdf(d_last, 3.0) ≈ cdf(ref, 3.0) rtol = 1.0e-6

    # The CDF quantities reach the duck component too, in the leading
    # position as well as the integration slot.
    @test cdf(d_pos, 3.0) ≈ cdf(ref, 3.0) rtol = 1.0e-6
    @test ccdf(d_pos, 3.0) ≈ ccdf(ref, 3.0) rtol = 1.0e-6
    @test logcdf(d_pos, 3.0) ≈ logcdf(ref, 3.0) rtol = 1.0e-6
    @test logccdf(d_pos, 3.0) ≈ logccdf(ref, 3.0) rtol = 1.0e-6
end

@testitem "test_component_interface separates required from optional" begin
    using Distributions, Random, Test
    using ConvolvedDistributions.TestUtils: test_component_interface

    # Implements the required tier only: no `mean`, `var`, `rand`,
    # `quantile`, `params` or `eltype`. Usable until a quantity asks for
    # one, and continuous by default without `eltype`.
    struct BareDuck end
    Distributions.logpdf(::BareDuck, x::Real) = 0.0 <= x <= 1.0 ? 0.0 : -Inf
    Distributions.pdf(::BareDuck, x::Real) = 0.0 <= x <= 1.0 ? 1.0 : 0.0
    Distributions.minimum(::BareDuck) = 0.0
    Distributions.maximum(::BareDuck) = 1.0

    # The optional tier warns rather than failing, so the testset still
    # passes while naming what is missing. `strict = true` would promote
    # these to failures, which is covered by the passing case in the
    # duck-typed testitem rather than here, since a deliberate failure
    # cannot be asserted without failing the suite.
    res = @test_logs(
        (:warn,), (:warn,), (:warn,), (:warn,), (:warn,), (:warn,),
        match_mode = :any,
        test_component_interface(BareDuck(); x = 0.5)
    )
    @test res isa Test.AbstractTestSet
end

@testitem "a duck-typed component's support comes from Base.eltype" begin
    using Distributions
    const CD = ConvolvedDistributions

    # Two identical Poisson leaves, differing only in whether they
    # declare `Base.eltype`.
    struct SilentDuckPoisson end
    Distributions.logpdf(::SilentDuckPoisson, x::Real) =
        logpdf(Poisson(3.0), x)
    Distributions.pdf(::SilentDuckPoisson, x::Real) = pdf(Poisson(3.0), x)
    Distributions.minimum(::SilentDuckPoisson) = 0
    Distributions.maximum(::SilentDuckPoisson) = Inf

    struct LatticeDuckPoisson end
    Distributions.logpdf(::LatticeDuckPoisson, x::Real) =
        logpdf(Poisson(3.0), x)
    Distributions.pdf(::LatticeDuckPoisson, x::Real) = pdf(Poisson(3.0), x)
    Distributions.minimum(::LatticeDuckPoisson) = 0
    Distributions.maximum(::LatticeDuckPoisson) = Inf
    Base.eltype(::Type{LatticeDuckPoisson}) = Int

    # Base's `eltype` fallback is `Any`, which reads as continuous.
    @test Base.eltype(SilentDuckPoisson) === Any
    @test CD._component_support(SilentDuckPoisson) === Continuous
    @test CD._component_support(LatticeDuckPoisson) === Discrete

    # The declared leaf types the combination `Discrete` and takes the
    # exact lattice fold, matching the closed-form Poisson sum.
    d = convolved(LatticeDuckPoisson(), Poisson(2.0))
    @test Distributions.value_support(typeof(d)) === Discrete
    @test CD.is_exact(d)
    for k in 0:8
        @test pdf(d, k) ≈ pdf(Poisson(5.0), k) rtol = 1.0e-10
    end

    # The silent leaf types `Continuous` and is integrated by
    # quadrature, which cannot see a comb of point masses.
    d_silent = convolved(SilentDuckPoisson(), Poisson(2.0))
    @test Distributions.value_support(typeof(d_silent)) === Continuous

    # The verifier names the gap rather than leaving it to be found in
    # the answers.
    @test_logs(
        (:warn, r"Base.eltype"), match_mode = :any,
        CD.TestUtils.test_component_interface(SilentDuckPoisson(); x = 3.0)
    )
end

# The AD-safety of the Convolved moments and densities (gradients flowing
# through the component parameters) is covered by the multi-backend AD suite in
# `test/ADFixtures`, which has the AD backends as dependencies; the main test
# env does not.
