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
    # component is allowed for the recursive rebuild paths) and any
    # non-UnivariateDistribution component.
    @test_throws ArgumentError ConvolvedDistributions.Convolved(())
    @test_throws ArgumentError ConvolvedDistributions.Convolved(
        (Gamma(2.0, 1.0), 1.0))
    @test ConvolvedDistributions.Convolved((Gamma(2.0, 1.0),)) isa
          ConvolvedDistributions.Convolved
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
        @test cdf(d, x) ≈ cdf(ref, x) atol=1e-10
        @test pdf(d, x) ≈ pdf(ref, x) atol=1e-10
        @test logpdf(d, x) ≈ logpdf(ref, x) atol=1e-8
    end

    # Equal-scale Gamma + Gamma (shapes add)
    g1 = Gamma(2.0, 1.5)
    g2 = Gamma(3.0, 1.5)
    dg = convolved(g1, g2)
    refg = convolve(g1, g2)
    for x in 0.5:1.0:12.0
        @test cdf(dg, x) ≈ cdf(refg, x) atol=1e-10
        @test pdf(dg, x) ≈ pdf(refg, x) atol=1e-10
    end

    # Three Normals fold pairwise analytically
    c = Normal(0.5, 1.0)
    d3 = convolved(a, b, c)
    ref3 = convolve(convolve(a, b), c)
    for x in -5.0:1.0:8.0
        @test cdf(d3, x) ≈ cdf(ref3, x) atol=1e-10
    end

    # Equal-rate Exponentials convolve to a Gamma analytically
    e1 = Exponential(1.5)
    de = convolved(e1, Exponential(1.5))
    refe = convolve(e1, Exponential(1.5))
    for x in 0.5:1.0:10.0
        @test cdf(de, x) ≈ cdf(refe, x) atol=1e-10
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
        (Exponential(1.5), Exponential(1.5), 0.3, 8.0)
    ]
    for (a, b, lo, hi) in cases
        dn = convolved(a, b; method = NumericSolver())
        ref = convolve(a, b)

        # NumericSolver must actually bypass the analytic specialisation.
        @test ConvolvedDistributions._maybe_analytic(dn) === nothing
        @test ConvolvedDistributions._maybe_analytic(
            convolved(a, b)) !== nothing

        xs = collect(range(lo, hi; length = 10))
        for x in xs
            @test cdf(dn, x) ≈ cdf(ref, x) atol=1e-6
            @test pdf(dn, x) ≈ pdf(ref, x) atol=1e-6
        end

        # Batched numeric vs analytic ground truth (looser shared-window
        # tolerance for the wide range; compared elementwise).
        cb = cdf(dn, xs)
        pb = pdf(dn, xs)
        @test maximum(abs.(cb .- [cdf(ref, x) for x in xs])) < 2e-4
        @test maximum(abs.(pb .- [pdf(ref, x) for x in xs])) < 6e-3
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
    sg = [rand(rng, Gamma(2.0, 1.0)) + rand(rng, Gamma(3.0, 2.0))
          for _ in 1:200_000]
    @test cdf(dg, 8.0) ≈ mean(sg .<= 8.0) atol=5e-3

    de = convolved(Exponential(1.0), Exponential(2.0))
    @test 0.0 <= cdf(de, 3.0) <= 1.0
    se = [rand(rng, Exponential(1.0)) + rand(rng, Exponential(2.0))
          for _ in 1:200_000]
    @test cdf(de, 3.0) ≈ mean(se .<= 3.0) atol=5e-3
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
        @test cdf(d, q) ≈ emp atol=5e-3
    end

    @test pdf(d, 3.0) > 0
    @test logpdf(d, 3.0) ≈ log(pdf(d, 3.0)) atol=1e-8
    @test mean(samples) ≈ mean(a) + mean(b) atol=2e-2
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
        @test c ≈ mean(samples .<= q) atol=5e-3
    end

    # Scalar and batched paths agree for the unbounded-below component.
    xs = [-1.0, 0.5, 2.0, 4.0]
    @test cdf(d, xs) ≈ [cdf(d, x) for x in xs] rtol=1e-9
    @test pdf(d, xs) ≈ [pdf(d, x) for x in xs] rtol=1e-9
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
        @test cdf(d, x) ≈ cdf(ref, x) atol=1e-5
        @test pdf(d, x) ≈ pdf(ref, x) atol=1e-5
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
        @test pdf(d, x) ≈ pdf(ref, x) atol=1e-10
        @test logpdf(d, x) ≈ logpdf(ref, x) atol=1e-8
    end

    g1 = Gamma(2.0, 1.5)
    g2 = Gamma(3.0, 1.5)
    dg = convolved(g1, g2)
    refg = convolve(g1, g2)
    for x in 0.5:0.5:12.0
        @test pdf(dg, x) ≈ pdf(refg, x) atol=1e-10
    end

    # Non-analytic pair: density convolution integral vs Monte-Carlo
    # histogram density, and total mass ~1.
    rng = MersenneTwister(123)
    dn = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    n = 4_000_000
    s = [rand(rng, Gamma(2.0, 1.0)) + rand(rng, LogNormal(0.5, 0.4))
         for _ in 1:n]
    hw = 0.05
    for x in (2.0, 3.0, 5.0)
        emp = mean((s .> x - hw) .& (s .<= x + hw)) / (2hw)
        @test pdf(dn, x) ≈ emp rtol=2e-2
    end

    grid = collect(0.05:0.1:30.0)
    @test sum(pdf(dn, grid)) * 0.1 ≈ 1.0 atol=2e-3

    # Bounded components: triangular-style density, exact midpoint value
    # and unit mass.
    du = convolved(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test pdf(du, 2.5) ≈ 1 / 3 atol=1e-6
    gu = collect(0.005:0.01:5.0)
    @test sum(pdf(du, gu)) * 0.01 ≈ 1.0 atol=1e-3
end

@testitem "Convolved rand sums components" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(1)
    d = convolved(Gamma(2.0, 1.0), Normal(3.0, 0.5))
    s = [rand(rng, d) for _ in 1:200_000]
    @test mean(s) ≈ 2.0 + 3.0 atol=5e-2
    @test var(s) ≈ var(Gamma(2.0, 1.0)) + 0.25 atol=1e-1
end

@testitem "Convolved batched cdf/logpdf match scalar" begin
    using Distributions

    # Numeric path
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    xs = [1.0, 2.0, 3.5, 5.0, 7.0]

    cdf_batch = cdf(d, xs)
    cdf_scalar = [cdf(d, x) for x in xs]
    @test cdf_batch ≈ cdf_scalar rtol=1e-9

    pdf_batch = pdf(d, xs)
    pdf_scalar = [pdf(d, x) for x in xs]
    @test pdf_batch ≈ pdf_scalar rtol=1e-9

    lp_batch = logpdf(d, xs)
    lp_scalar = [logpdf(d, x) for x in xs]
    @test lp_batch ≈ lp_scalar rtol=1e-9

    # Analytic path
    da = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
    @test cdf(da, xs) ≈ [cdf(da, x) for x in xs] atol=1e-10
    @test pdf(da, xs) ≈ [pdf(da, x) for x in xs] atol=1e-10
    @test logpdf(da, xs) ≈ [logpdf(da, x) for x in xs] atol=1e-10
end

@testitem "Convolved batched cdf does a single solve" begin
    using Distributions

    # This batch deliberately spans a wide range (16x), the hardest case
    # for a shared quadrature grid: the batched path must match the scalar
    # per-point windows even here.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    xs = collect(0.5:0.25:8.0)
    @test cdf(d, xs) ≈ [cdf(d, x) for x in xs] rtol=1e-9
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
    @test logpdf(d, xs) ≈ [logpdf(d, x) for x in xs] atol=1e-9

    # Wide batches (16x and 40x spans), the old worst case.
    for xs in (collect(0.5:0.25:8.0), collect(0.5:0.5:20.0))
        lp = logpdf(d, xs)
        ls = [logpdf(d, x) for x in xs]
        @test maximum(abs.(lp .- ls)) < 1e-8
        @test cdf(d, xs) ≈ [cdf(d, x) for x in xs] atol=1e-9
        @test pdf(d, xs) ≈ [pdf(d, x) for x in xs] rtol=1e-8
    end

    # Three components: the recursive numeric kernel takes the same
    # per-point-window batched path.
    d3 = convolved(Gamma(2.0, 1.0), Gamma(1.5, 2.0), LogNormal(0.5, 0.4))
    xs3 = [2.0, 4.0, 6.0, 10.0, 15.0]
    @test logpdf(d3, xs3) ≈ [logpdf(d3, x) for x in xs3] atol=1e-8
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

    # The scalar path is the trusted reference. The batched gradient is
    # the exact derivative of the batched primal (matches finite
    # differences of it to ~1e-11); the residual gap to the scalar path
    # is the parameter-sensitivity of the shared-panel quadrature error
    # (measured ~2e-7 relative for this batch, ~2e-6 with the component
    # order swapped), so the tolerance is looser than the ~1e-14
    # eval-point agreement below.
    for f in (pdf, logpdf, cdf)
        g_batch = ForwardDiff.gradient(θ -> sum(f(d(θ), obs)), θ₀)
        g_scalar = ForwardDiff.gradient(
            θ -> sum(x -> f(d(θ), x), obs), θ₀)
        @test g_batch ≈ g_scalar rtol=1e-5
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
            x -> sum(xi -> f(d, xi), x), obs)
        @test g_batch ≈ g_scalar rtol=1e-8
    end
end

@testitem "Convolved logcdf/ccdf/logccdf branches" begin
    using Distributions

    # Analytic path: logcdf/ccdf agree with the convolved reference.
    da = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
    refa = convolve(Normal(0.0, 1.0), Normal(1.0, 2.0))
    @test logcdf(da, 2.0) ≈ logcdf(refa, 2.0) atol=1e-10
    @test ccdf(da, 2.0) ≈ ccdf(refa, 2.0) atol=1e-10
    @test logccdf(da, 2.0) ≈ logccdf(refa, 2.0) atol=1e-8

    # Numeric path: logcdf matches log of cdf and ccdf = 1 - cdf.
    dn = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test logcdf(dn, 3.0) ≈ log(cdf(dn, 3.0)) atol=1e-10
    @test ccdf(dn, 3.0) ≈ 1 - cdf(dn, 3.0) atol=1e-10
    @test logccdf(dn, 3.0) ≈ log1p(-cdf(dn, 3.0)) atol=1e-6

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
    @test cb ≈ [cdf(d, x) for x in xs] rtol=1e-9

    lp = logpdf(d, xs)
    @test lp[1] == -Inf
    @test lp[end] == -Inf
    @test isfinite(lp[3])

    pb = pdf(d, xs)
    @test pb[1] == 0.0
    @test pb[end] == 0.0
    @test pb[3] > 0
    @test pb ≈ [pdf(d, x) for x in xs] rtol=1e-9

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
        Gamma(2.0, 1.5), LogNormal(1.0, 0.4), Normal(-0.5, 0.8))
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

    @test cdf(d, 3.0) ≈ 0.455300951911572 atol=1e-9
    @test cdf(d, 10.0) ≈ 0.912194823510679 atol=1e-9
    @test pdf(d, 3.0) ≈ 0.180646198535104 atol=1e-9
    @test pdf(d, 10.0) ≈ 0.0147490090653485 atol=1e-9

    # The batched composite path shares its panel grid across points, so
    # it needs mass-following panels for the same reason.
    refs_cdf = [0.455300951911572, 0.912194823510679]
    refs_pdf = [0.180646198535104, 0.0147490090653485]
    @test cdf(d, [3.0, 10.0]) ≈ refs_cdf atol=1e-8
    @test pdf(d, [3.0, 10.0]) ≈ refs_pdf atol=1e-8
end

# The AD-safety of the Convolved moments and densities (gradients flowing
# through the component parameters) is covered by the multi-backend AD suite in
# `test/ADFixtures`, which has the AD backends as dependencies; the main test
# env does not.
