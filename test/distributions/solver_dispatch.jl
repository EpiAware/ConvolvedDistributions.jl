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
