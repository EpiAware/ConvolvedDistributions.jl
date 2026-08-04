# Tests for the solver-method dispatch mechanism itself (#77/#92), not
# the specific analytic pairs it hosts (see uniform_window.jl). Mirrors
# CensoredDistributions' `test/censoring/primarycensored_cdf.jl`; its
# "Solver is actually used" testset (proving a custom solver payload
# reaches quadrature) has no equivalent here, since `NumericSolver`
# rejects any non-default payload at construction (S4.5) rather than
# threading one through -- "Force numerical method" below is the
# closest analogue, proving the numeric path is reached and differs
# from the analytic sentinel value.

@testitem "Convolved cdf dispatch" begin
    using ConvolvedDistributions: convolved_cdf, Convolved, AnalyticalSolver,
                                  NumericSolver, AbstractSolverMethod
    using Distributions

    struct DispatchTestDelay <: ContinuousUnivariateDistribution end
    Base.minimum(::DispatchTestDelay) = 0.0
    Base.maximum(::DispatchTestDelay) = Inf
    Distributions.cdf(::DispatchTestDelay, x::Real) = 1 - exp(-x)
    Distributions.pdf(::DispatchTestDelay, x::Real) = exp(-x)

    analytic_called = Ref(false)
    function ConvolvedDistributions.convolved_cdf(
            ::Convolved, ::DispatchTestDelay, ::Uniform, x::Real,
            ::AnalyticalSolver)
        analytic_called[] = true
        return 0.12345
    end
    # Mirrored order (S1.5): dispatch never swaps arguments itself, so a
    # downstream method for one order needs its mirror defined too.
    function ConvolvedDistributions.convolved_cdf(
            d::Convolved, primary::Uniform, delay::DispatchTestDelay,
            x::Real, m::AnalyticalSolver)
        return ConvolvedDistributions.convolved_cdf(d, delay, primary, x, m)
    end

    @testset "Dispatch to analytical method" begin
        analytic_called[] = false
        d = convolved(DispatchTestDelay(), Uniform(0.0, 1.0))
        @test cdf(d, 2.0) == 0.12345
        @test analytic_called[]
    end

    @testset "Force numerical method" begin
        analytic_called[] = false
        d = convolved(
            DispatchTestDelay(), Uniform(0.0, 1.0); method = NumericSolver())
        result = cdf(d, 2.0)
        @test !analytic_called[]
        @test result != 0.12345
        @test 0 < result < 1
    end

    @testset "Fallback for unsupported distributions" begin
        # No `convolved_cdf` method for Exponential + Exponential (unequal
        # rate), so this falls through method 2 to quadrature.
        d = convolved(Exponential(2.0), Exponential(3.0))
        result = cdf(d, 2.0)
        @test 0 < result < 1
    end

    @testset "Unknown solver type errors" begin
        struct BrokenMethod <: AbstractSolverMethod end
        d = Convolved((Gamma(2.0, 1.0), Uniform(0.0, 1.0));
            method = BrokenMethod())
        @test_throws ErrorException convolved_cdf(
            d, Gamma(2.0, 1.0), Uniform(0.0, 1.0), 1.0, BrokenMethod())
    end

    @testset "Reversed component order" begin
        # Resolved by the mirrored method above, at compile time --
        # no runtime route lookup.
        forward = convolved(DispatchTestDelay(), Uniform(0.0, 1.0))
        reversed = convolved(Uniform(0.0, 1.0), DispatchTestDelay())
        @test cdf(reversed, 2.0) == cdf(forward, 2.0) == 0.12345
    end
end

@testitem "Unknown solver type errors for every convolved_* generic" begin
    # "Convolved cdf dispatch" above pins this for the scalar cdf arm only.
    # Every convolved_* generic shares the same method-1 skeleton (a plain
    # `error` for a solver type that is neither `AnalyticalSolver` nor
    # `NumericSolver`), including the scalar/vector-`x` pairs and the two
    # quantities with no evaluation point (`quantile`, `minimum`) -- this
    # exercises all of them so the shared skeleton shape stays proven for
    # every quantity, not just `cdf`.
    using ConvolvedDistributions: convolved_cdf, convolved_logcdf,
                                  convolved_ccdf, convolved_logccdf,
                                  convolved_pdf, convolved_logpdf,
                                  convolved_quantile, convolved_minimum,
                                  Convolved, AbstractSolverMethod
    using Distributions

    struct BrokenMethod <: AbstractSolverMethod end

    d1, d2 = Gamma(2.0, 1.0), Uniform(0.0, 1.0)
    d = Convolved((d1, d2); method = BrokenMethod())
    xs = [1.0, 2.0]

    @test_throws ErrorException convolved_cdf(d, d1, d2, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_cdf(d, d1, d2, xs, BrokenMethod())
    @test_throws ErrorException convolved_logcdf(
        d, d1, d2, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_ccdf(d, d1, d2, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_logccdf(
        d, d1, d2, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_pdf(d, d1, d2, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_pdf(d, d1, d2, xs, BrokenMethod())
    @test_throws ErrorException convolved_logpdf(
        d, d1, d2, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_logpdf(
        d, d1, d2, xs, BrokenMethod())
    @test_throws ErrorException convolved_quantile(
        d, d1, d2, 0.5, BrokenMethod())
    @test_throws ErrorException convolved_minimum(d, d1, d2, BrokenMethod())
end

@testitem "evaluation_path covers every quantity's route check" begin
    # #92's per-quantity route check (`_is_analytic`/`_convolved_route`)
    # is only ever exercised through `evaluation_path`'s default
    # `(pdf, cdf)` or an explicit `cdf`/`pdf` elsewhere in the suite, so
    # the `_convolved_generic` entries for `logcdf`/`ccdf`/`logccdf`/
    # `logpdf` -- and the `_has_analytic_route` specialisation each one
    # drives -- go untouched without this.
    #
    # The uniform-window pair (Gamma + Uniform) only registers a
    # pair-specific closed form for `cdf`/`pdf`/`logpdf` (S1); `logcdf`/
    # `ccdf`/`logccdf` fall back to `NumericSolver` quadrature even for
    # this pair (they are derived from `cdf` only on the `NumericSolver`
    # arm, not the analytic one), so `:numeric` is the correct answer for
    # those three, not a gap in the route check.
    using ConvolvedDistributions: evaluation_path
    using Distributions

    analytic = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    numeric = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

    @test evaluation_path(analytic, logpdf) === :analytic
    for f in (logcdf, ccdf, logccdf, logpdf)
        @test evaluation_path(numeric, f) === :numeric
    end
    for f in (logcdf, ccdf, logccdf)
        @test evaluation_path(analytic, f) === :numeric
    end
end

@testitem "Convolved quantile dispatch: analytic without Optimization.jl" begin
    using ConvolvedDistributions
    using Distributions

    # #92/S2.4 regression: this must not require Optimization.jl to be
    # loaded, and must not run a Nelder-Mead solve, for a pair whose sum
    # names a distribution. `==` (not `≈`) is the load-bearing check: a
    # Nelder-Mead solve would not land on the exact bit pattern.
    # TestItemRunner can share a worker process across files, so another
    # testitem may already have loaded Optimization.jl by the time this
    # one runs; this test only asserts what holds regardless of load
    # order, not that the extension is absent.

    d = convolved(Normal(1.0, 2.0), Normal(3.0, 4.0))
    ref = Normal(4.0, sqrt(20.0))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        @test quantile(d, p) == quantile(ref, p)
    end

    dg = convolved(Gamma(2.0, 1.5), Gamma(3.0, 1.5))
    refg = convolve(Gamma(2.0, 1.5), Gamma(3.0, 1.5))
    @test quantile(dg, 0.5) == quantile(refg, 0.5)

    de = convolved(Exponential(2.0), Exponential(2.0))
    refe = convolve(Exponential(2.0), Exponential(2.0))
    @test quantile(de, 0.5) == quantile(refe, 0.5)
end
