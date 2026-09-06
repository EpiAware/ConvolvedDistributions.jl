@testitem "Difference constructor and fields" begin
    using Distributions

    d = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))
    @test d isa ConvolvedDistributions.Difference
    @test d.x == Normal(5.0, 1.0)
    @test d.y == Normal(2.0, 1.0)
    @test d.method isa AnalyticalSolver

    dn = difference(Gamma(2.0, 1.0), LogNormal(0.5, 0.4); method = NumericSolver())
    @test dn.method isa NumericSolver
end

@testitem "Difference support is two-sided and can be negative" begin
    using Distributions

    # Gamma - Gamma: support is (min(X) - max(Y)) .. (max(X) - min(Y)).
    d = difference(Gamma(3.0, 1.0), Gamma(2.0, 1.0))
    @test minimum(d) == -Inf      # 0 - Inf
    @test maximum(d) == Inf       # Inf - 0

    # Bounded components give a finite, possibly negative, two-sided support.
    du = difference(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test minimum(du) == -2.0     # 0 - 2
    @test maximum(du) == 1.0      # 1 - 0
    @test minimum(du) < 0.0

    # Normal - Normal is unbounded both ways.
    dnn = difference(Normal(0.0, 1.0), Normal(0.0, 1.0))
    @test minimum(dnn) == -Inf
    @test maximum(dnn) == Inf
end

@testitem "Difference params and eltype" begin
    using Distributions

    d = difference(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test params(d) == ((0.0, 1.0), (0.0, 2.0))

    d2 = difference(Gamma(2.0, 1.0), Normal(0.0, 1.0))
    @test eltype(d2) == Float64
end

@testitem "Difference Normal-Normal matches the closed form" begin
    using Distributions

    # Z = X - Y for independent normals is Normal(μx - μy, sqrt(σx² + σy²)).
    x = Normal(5.0, 1.5)
    y = Normal(2.0, 2.0)
    d = difference(x, y)
    ref = Normal(5.0 - 2.0, sqrt(1.5^2 + 2.0^2))

    @test mean(d) ≈ mean(ref)
    @test var(d) ≈ var(ref)
    @test std(d) ≈ std(ref)

    for z in -6.0:1.0:10.0
        @test cdf(d, z) ≈ cdf(ref, z) atol = 1.0e-10
        @test pdf(d, z) ≈ pdf(ref, z) atol = 1.0e-10
        @test logpdf(d, z) ≈ logpdf(ref, z) atol = 1.0e-8
        @test logcdf(d, z) ≈ logcdf(ref, z) atol = 1.0e-8
        @test ccdf(d, z) ≈ ccdf(ref, z) atol = 1.0e-10
    end
end

@testitem "Difference NumericSolver matches Normal-Normal closed form" begin
    using Distributions

    x = Normal(5.0, 1.5)
    y = Normal(2.0, 2.0)
    dn = difference(x, y; method = NumericSolver())
    ref = Normal(3.0, sqrt(1.5^2 + 2.0^2))

    @test ConvolvedDistributions._maybe_analytic(dn) === nothing
    @test ConvolvedDistributions._maybe_analytic(difference(x, y)) !== nothing

    for z in range(-4.0, 10.0; length = 12)
        @test cdf(dn, z) ≈ cdf(ref, z) atol = 1.0e-6
        @test pdf(dn, z) ≈ pdf(ref, z) atol = 1.0e-6
    end
end

@testitem "Difference numeric path matches Monte Carlo" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(42)
    # Gamma - LogNormal has no closed form -> numeric cross-correlation.
    x = Gamma(3.0, 1.0)
    y = LogNormal(0.5, 0.4)
    d = difference(x, y)

    n = 400_000
    samples = [rand(rng, x) - rand(rng, y) for _ in 1:n]

    for z in (-1.0, 0.5, 2.0, 4.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol = 5.0e-3
    end

    @test pdf(d, 2.0) > 0
    @test logpdf(d, 2.0) ≈ log(pdf(d, 2.0)) atol = 1.0e-8

    @test mean(samples) ≈ mean(x) - mean(y) atol = 2.0e-2
    @test var(samples) ≈ var(x) + var(y) atol = 1.0e-1
end

@testitem "Difference of Convolved components matches Monte Carlo" begin
    using Distributions, ForwardDiff, Random, Statistics

    # Issue #45: a `Convolved` component routes the quadrature window
    # clamp through `_window_quantile(::Convolved, p)`, whose primal
    # rebuild was handed the component's nested parameter tuples and
    # threw a `primal(::Tuple)` MethodError for a plain Float64
    # argument as soon as an AD extension (here ForwardDiff) was loaded.
    x = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    y = convolved(Gamma(1.5, 1.0), Gamma(1.0, 2.0))
    d = difference(x, y)

    @test mean(d) ≈ mean(x) - mean(y)
    @test var(d) ≈ var(x) + var(y)

    rng = MersenneTwister(45)
    n = 400_000
    samples = [rand(rng, x) - rand(rng, y) for _ in 1:n]
    for z in (-2.0, 0.0, 1.5, 4.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol = 5.0e-3
    end
    @test pdf(d, 0.0) > 0
    @test logcdf(d, 0.0) ≈ log(cdf(d, 0.0)) atol = 1.0e-10
end

@testitem "Difference with Difference subtrahend matches Monte Carlo" begin
    using Distributions, Random, Statistics

    # A `Difference` subtrahend is unbounded on both sides, so both
    # window endpoints route through `_window_quantile(::Difference, p)`
    # (the same composite path as issue #45).
    x = Gamma(2.0, 1.0)
    w = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    d = difference(x, w)

    rng = MersenneTwister(46)
    n = 400_000
    samples = [rand(rng, x) - rand(rng, w) for _ in 1:n]
    for z in (-3.0, -1.0, 0.5, 2.0)
        @test cdf(d, z) ≈ mean(samples .<= z) atol = 5.0e-3
    end
    @test pdf(d, 0.0) > 0
end

@testitem "Difference of Convolved cdf ForwardDiff gradient" begin
    using Distributions, ForwardDiff

    # Gradient of the cdf w.r.t. the minuend's Gamma parameters through
    # the previously-throwing nested-Convolved window path (issue #45),
    # checked against central finite differences.
    f = θ -> cdf(
        difference(
            convolved(Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4)),
            convolved(Gamma(1.5, 1.0), Gamma(1.0, 2.0))
        ),
        0.0
    )
    θ = [2.0, 1.0]
    g = ForwardDiff.gradient(f, θ)
    @test all(isfinite, g)

    h = 1.0e-6
    for i in eachindex(θ)
        θp = copy(θ)
        θm = copy(θ)
        θp[i] += h
        θm[i] -= h
        fd = (f(θp) - f(θm)) / (2h)
        @test g[i] ≈ fd atol = 1.0e-6
    end
end

@testitem "Difference pdf integrates to one" begin
    using Distributions

    du = difference(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    grid = collect(-3.0:0.01:2.0)
    @test sum(pdf(du, z) for z in grid) * 0.01 ≈ 1.0 atol = 2.0e-3

    dn = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    g = collect(-8.0:0.02:12.0)
    @test sum(pdf(dn, z) for z in g) * 0.02 ≈ 1.0 atol = 3.0e-3
end

@testitem "Difference cdf is monotone and in [0, 1]" begin
    using Distributions

    dn = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    zs = collect(-6.0:0.5:10.0)
    cs = [cdf(dn, z) for z in zs]
    @test all(0.0 .<= cs .<= 1.0)
    @test all(diff(cs) .>= -1.0e-10)        # non-decreasing

    @test cdf(dn, -1.0e3) == 0.0
    @test cdf(dn, 1.0e3) ≈ 1.0 atol = 1.0e-6
end

@testitem "Difference symmetry: X-Y is the reflection of Y-X" begin
    using Distributions

    # If Z = X - Y and W = Y - X then W = -Z, so
    # F_Z(z) = P(Z <= z) = P(W >= -z) = ccdf(W, -z) and f_Z(z) = f_W(-z).
    x = Gamma(3.0, 1.0)
    y = LogNormal(0.5, 0.4)
    dxy = difference(x, y)
    dyx = difference(y, x)

    for z in (-2.0, -0.5, 1.0, 3.0)
        @test cdf(dxy, z) ≈ ccdf(dyx, -z) atol = 1.0e-5
        @test pdf(dxy, z) ≈ pdf(dyx, -z) atol = 1.0e-5
    end

    @test minimum(dxy) == -maximum(dyx)
    @test maximum(dxy) == -minimum(dyx)
end

@testitem "Difference rand mean/var match the analytic moments" begin
    using Distributions, Random, Statistics

    rng = MersenneTwister(1)
    d = difference(Gamma(3.0, 1.0), Normal(2.0, 0.5))
    s = [rand(rng, d) for _ in 1:200_000]
    @test mean(s) ≈ (3.0 - 2.0) atol = 5.0e-2
    @test var(s) ≈ (var(Gamma(3.0, 1.0)) + 0.25) atol = 1.0e-1
    @test mean(s) ≈ mean(d) atol = 5.0e-2
    @test var(s) ≈ var(d) atol = 1.0e-1
end

@testitem "Difference logcdf/ccdf/logccdf branches" begin
    using Distributions

    # Analytic path agrees with the reference Normal difference.
    da = difference(Normal(1.0, 2.0), Normal(0.0, 1.0))
    refa = Normal(1.0, sqrt(4.0 + 1.0))
    @test logcdf(da, 2.0) ≈ logcdf(refa, 2.0) atol = 1.0e-10
    @test ccdf(da, 2.0) ≈ ccdf(refa, 2.0) atol = 1.0e-10
    @test logccdf(da, 2.0) ≈ logccdf(refa, 2.0) atol = 1.0e-8

    # Numeric path: logcdf matches log(cdf) and ccdf = 1 - cdf.
    dn = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    @test logcdf(dn, 1.0) ≈ log(cdf(dn, 1.0)) atol = 1.0e-10
    @test ccdf(dn, 1.0) ≈ 1 - cdf(dn, 1.0) atol = 1.0e-10
    @test logccdf(dn, 1.0) ≈ log1p(-cdf(dn, 1.0)) atol = 1.0e-6

    db = difference(Uniform(0.0, 2.0), Uniform(0.0, 3.0))
    @test logccdf(db, -3.0) == 0.0   # CDF = 0 -> logccdf = 0
    @test logccdf(db, 2.0) == -Inf   # CDF = 1 -> logccdf = -Inf
end

@testitem "Difference logpdf outside support is -Inf" begin
    using Distributions

    d = difference(Uniform(0.0, 1.0), Uniform(0.0, 2.0))
    @test logpdf(d, -3.0) == -Inf
    @test pdf(d, -3.0) == 0.0
    @test logpdf(d, 2.0) == -Inf
    @test pdf(d, 2.0) == 0.0
    @test !insupport(d, -3.0)
    @test insupport(d, -0.5)
end

@testitem "Difference scalar methods value-correct and inferrable" begin
    using Distributions, Test

    analytic = difference(Normal(1.0, 2.0), Normal(0.0, 1.0))
    numeric = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    for d in (analytic, numeric)
        for f in (cdf, logcdf, pdf, logpdf, ccdf, logccdf)
            @test f(d, 1.0) isa Float64
        end
        @test (@inferred(cdf(d, 1.0)); true)
        @test (@inferred(pdf(d, 1.0)); true)
    end
end

@testitem "Difference eltype and sampler" begin
    using Distributions, Random

    d = difference(Gamma(2.0, 1.0), Normal(0.0, 1.0))
    @test eltype(d) == Float64
    @test sampler(d) === d
    rng = MersenneTwister(3)
    @test rand(rng, d) isa Real
end

@testitem "Difference composes with truncated" begin
    using Distributions

    # truncated composes over a Difference (negative bounds allowed).
    d = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    td = truncated(d, -2.0, 5.0)

    @test cdf(td, -3.0) == 0.0
    @test cdf(td, 6.0) == 1.0
    @test 0.0 < cdf(td, 1.0) < 1.0
    @test pdf(td, 1.0) > 0
end

@testitem "Difference composes with censored (#72)" begin
    using Distributions

    d = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
    cd = censored(d, -2.0, 5.0)

    @test cdf(cd, -3.0) == 0.0
    @test cdf(cd, 5.0) == 1.0
    @test cdf(cd, 1.0) ≈ cdf(d, 1.0)
    @test pdf(cd, -2.0) ≈ cdf(d, -2.0)
    @test pdf(cd, 5.0) ≈ ccdf(d, 5.0)
    @test pdf(cd, 1.0) ≈ pdf(d, 1.0)
end

@testitem "Difference heavy-tailed subtrahend accuracy (#49)" begin
    using Distributions

    # A heavy-tailed subtrahend stretches the Y integration window to
    # its 1 - 1e-8 quantile (~4.5e3 for LogNormal(0, 1.5)) while the
    # integrand's mass sits near O(1), so a single fixed-node window
    # starves the mass region of nodes (issue #49). References computed
    # once with adaptive quadrature (QuadGK via Integrals.jl,
    # reltol = 1e-13) of
    #   F_D(z) = ∫_0^∞ F_X(z + y) f_Y(y) dy,
    #   f_D(z) = ∫_0^∞ f_X(z + y) f_Y(y) dy
    # for X = Gamma(2, 1), Y = LogNormal(0, 1.5), and hard-coded. As a
    # cross-check, F_D(0) equals the Product reference F_Z(1) exactly:
    # LogNormal(0, σ) is invariant under y ↦ 1/y, so P(X ≤ Y) = P(XY ≤ 1).
    # The CDF tolerance sits just above the 1e-8 window truncation (the
    # clamp trims that much of Y's upper tail, where F_X(z + y) ≈ 1).
    d = difference(Gamma(2.0, 1.0), LogNormal(0.0, 1.5))

    @test cdf(d, 0.0) ≈ 0.39674977955541 atol = 5.0e-8
    @test cdf(d, 1.0) ≈ 0.631761989136144 atol = 5.0e-8
    @test pdf(d, 0.0) ≈ 0.205525747410054 atol = 1.0e-9
    @test pdf(d, 1.0) ≈ 0.221923353983705 atol = 1.0e-9
end

@testitem "Difference of two discrete components is Discrete and exact (#85, #89)" begin
    using Distributions

    d = difference(Poisson(2.0), Poisson(3.0))
    @test Distributions.value_support(typeof(d)) === Discrete
    @test ConvolvedDistributions.is_exact(d)

    # Two-sided integer support.
    @test minimum(d) == -Inf
    @test maximum(d) == Inf

    # Agreement with brute force over a truncated Y range.
    for z in -5:5
        bf = sum(
            pdf(Poisson(2.0), z + y) * pdf(Poisson(3.0), y)
                for y in 0:200
        )
        @test pdf(d, z) ≈ bf atol = 1.0e-8
    end

    masses = [pdf(d, k) for k in -100:100]
    @test all(m -> m >= 0, masses)
    @test isapprox(sum(masses), 1; atol = 1.0e-6)

    @test pdf(d, 2.5) == 0
    @test logpdf(d, 2.5) == -Inf
    @test !insupport(d, 2.5)

    running_sums = cumsum(masses)
    for (k, running) in zip(-100:100, running_sums)
        @test cdf(d, k) ≈ running atol = 1.0e-6
    end

    # A mixed pair stays Continuous (`_components_support` only reports
    # `Discrete` when EVERY component is), but is exact via its own
    # mixed fold rather than falling into quadrature (#115); see
    # test/distributions/mixed.jl for the full mixed-fold coverage.
    dmix = difference(Poisson(2.0), Normal(0.0, 1.0))
    @test Distributions.value_support(typeof(dmix)) === Continuous
    @test pdf(dmix, 1.0) > 0
    @test ConvolvedDistributions.is_exact(dmix)
end

# The AD-safety of Difference (gradients flowing through both the minuend X and
# the subtrahend Y parameters, on the numeric cross-correlation path) is covered
# by the multi-backend AD suite in `test/ADFixtures`, which has the AD backends
# as dependencies; the main test env does not.

@testitem "difference accepts a duck-typed component" begin
    using Distributions, Random, Test

    # Implements exactly what this testitem exercises, without subtyping
    # `UnivariateDistribution`, mirroring the duck-typed `Convolved`
    # testitem.
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

    duck = DuckUniform(1.0, 2.0)
    g = Gamma(2.0, 1.0)

    d = difference(duck, g)
    @test d isa ConvolvedDistributions.Difference

    @test mean(d) ≈ mean(duck) - mean(g)
    @test var(d) ≈ var(duck) + var(g)
    @test minimum(d) == minimum(duck) - maximum(g)
    @test maximum(d) == maximum(duck) - minimum(g)

    rng = MersenneTwister(1)
    @test rand(rng, d) isa Real

    # A `Number` is rejected at construction, exactly as for
    # `Convolved` (see `src/interface.jl`).
    @test_throws ArgumentError difference(duck, 1.0)
    @test_throws ArgumentError difference(g, 2.0)

    # The opt-in verifier passes in strict mode, both as a leading
    # component and in the integration slot (`difference` integrates
    # over the subtrahend `y`).
    ConvolvedDistributions.TestUtils.test_component_interface(
        duck; x = 1.5, integration_slot = true, strict = true
    )
    # The non-strict mode also passes (warn tier unchecked).
    ConvolvedDistributions.TestUtils.test_component_interface(duck; x = 1.5)

    # The duck-typed difference agrees with the real-`Uniform`
    # reference, both on the numeric route.
    ref = difference(
        Uniform(1.0, 2.0), g; method = ConvolvedDistributions.NumericSolver()
    )
    @test pdf(d, 1.0) ≈ pdf(ref, 1.0) rtol = 1.0e-6
    @test cdf(d, 1.0) ≈ cdf(ref, 1.0) rtol = 1.0e-6
    @test ccdf(d, 1.0) ≈ ccdf(ref, 1.0) rtol = 1.0e-6
    @test logcdf(d, 1.0) ≈ logcdf(ref, 1.0) rtol = 1.0e-6
    @test logccdf(d, 1.0) ≈ logccdf(ref, 1.0) rtol = 1.0e-6

    # A duck in the integration slot (the subtrahend `y`, which the
    # quadrature integrates over): agrees with the real-`Uniform` there
    # too.
    d_y = difference(g, duck)
    ref_y = difference(
        g, Uniform(1.0, 2.0); method = ConvolvedDistributions.NumericSolver()
    )
    @test pdf(d_y, 1.0) ≈ pdf(ref_y, 1.0) rtol = 1.0e-6
    @test cdf(d_y, 1.0) ≈ cdf(ref_y, 1.0) rtol = 1.0e-6

    # A thin leaf (logpdf only) constructs unchecked and fails on the
    # call that needs more, exactly as for `Convolved`.
    struct LogpdfOnlyDuck end
    Distributions.logpdf(::LogpdfOnlyDuck, x::Real) =
        logpdf(Normal(0.0, 1.0), x)
    d_thin = difference(LogpdfOnlyDuck(), g)
    @test d_thin isa ConvolvedDistributions.Difference
    @test_throws MethodError pdf(d_thin, 1.0)
end

@testitem "a duck-typed difference's support comes from Base.eltype" begin
    using Distributions, Test
    const CD = ConvolvedDistributions

    # A discrete duck leaf types the combination `Discrete` and takes
    # the exact lattice fold, matching a real `Poisson`-`Poisson`
    # difference (no closed form; both use the same fold).
    struct LatticeDuckPoisson end
    Distributions.logpdf(::LatticeDuckPoisson, x::Real) =
        logpdf(Poisson(3.0), x)
    Distributions.pdf(::LatticeDuckPoisson, x::Real) = pdf(Poisson(3.0), x)
    Distributions.minimum(::LatticeDuckPoisson) = 0
    Distributions.maximum(::LatticeDuckPoisson) = Inf
    Base.eltype(::Type{LatticeDuckPoisson}) = Int

    d = difference(LatticeDuckPoisson(), Poisson(2.0))
    @test Distributions.value_support(typeof(d)) === Discrete
    @test CD.is_exact(d)
    ref = difference(Poisson(3.0), Poisson(2.0))
    for k in -5:8
        @test pdf(d, k) ≈ pdf(ref, k) rtol = 1.0e-10
    end

    # A duck-typed discrete + continuous pair stays `Continuous` and
    # routes through quadrature (the mixed fold is restricted to
    # `UnivariateDistribution` components, mirroring `Convolved`), so
    # `is_exact` and the executed route cannot drift. Quadrature cannot
    # see an integer lattice of point masses, so evaluating the density
    # returns ~0 -- the same silent-lattice caveat documented for
    # `Convolved` -- but evaluating it at all proves the route executes.
    dmix = difference(LatticeDuckPoisson(), Gamma(2.0, 1.0))
    @test Distributions.value_support(typeof(dmix)) === Continuous
    @test !CD.is_exact(dmix)
    @test isfinite(pdf(dmix, 1.0))
end
