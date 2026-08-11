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

    # A downstream analytic pair is just a method on a two-element tuple
    # TYPE (review A, #80) -- no registration call, plain dispatch picks
    # it up over the generic `Tuple` fallback.
    analytic_called = Ref(false)
    function ConvolvedDistributions.convolved_cdf(
            ::Convolved, ::Tuple{DispatchTestDelay, Uniform}, x::Real,
            ::AnalyticalSolver)
        analytic_called[] = true
        return 0.12345
    end
    # Mirrored order (S1.5): dispatch never swaps arguments itself, so a
    # downstream method for one order needs its mirror defined too.
    function ConvolvedDistributions.convolved_cdf(
            d::Convolved, components::Tuple{Uniform, DispatchTestDelay},
            x::Real, m::AnalyticalSolver)
        return ConvolvedDistributions.convolved_cdf(
            d, reverse(components), x, m)
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
        # rate), so this falls through the `AnalyticalSolver` generic to
        # quadrature.
        d = convolved(Exponential(2.0), Exponential(3.0))
        result = cdf(d, 2.0)
        @test 0 < result < 1
    end

    @testset "Unknown solver type errors" begin
        struct BrokenMethod <: AbstractSolverMethod end
        d = Convolved((Gamma(2.0, 1.0), Uniform(0.0, 1.0));
            method = BrokenMethod())
        @test_throws ErrorException convolved_cdf(
            d, (Gamma(2.0, 1.0), Uniform(0.0, 1.0)), 1.0, BrokenMethod())
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
    # Every convolved_* generic shares the same skeleton (a plain `error`
    # for a solver type that is neither `AnalyticalSolver` nor
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

    components = (Gamma(2.0, 1.0), Uniform(0.0, 1.0))
    d = Convolved(components; method = BrokenMethod())
    xs = [1.0, 2.0]

    @test_throws ErrorException convolved_cdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_cdf(
        d, components, xs, BrokenMethod())
    @test_throws ErrorException convolved_logcdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_ccdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_logccdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_pdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_pdf(
        d, components, xs, BrokenMethod())
    @test_throws ErrorException convolved_logpdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException convolved_logpdf(
        d, components, xs, BrokenMethod())
    @test_throws ErrorException convolved_quantile(
        d, components, 0.5, BrokenMethod())
    @test_throws ErrorException convolved_minimum(
        d, components, BrokenMethod())
end

@testitem "Analytic collapse works for any component count (review A)" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    # Three components, no arm restricted to exactly two: the two
    # equal-scale Gammas are not adjacent, so this exercises the
    # any-pair search, not just a left-to-right adjacent fold.
    d = convolved(Gamma(2.0, 1.5), Normal(0.0, 1.0), Gamma(3.0, 1.5))
    ref_gammas = convolve(Gamma(2.0, 1.5), Gamma(3.0, 1.5))
    ref = convolved(ref_gammas, Normal(0.0, 1.0); method = NumericSolver())
    for x in (0.5, 2.0, 5.0)
        @test cdf(d, x) ≈ cdf(ref, x)
        @test pdf(d, x) ≈ pdf(ref, x)
    end
    # Collapsing to two components (one analytic, one raw) rather than
    # falling straight to three-way quadrature is not fully analytic
    # (the Gamma/Normal pair itself has no closed form), so this reports
    # :numeric, matching the reduced quadrature `cdf` actually runs.
    @test evaluation_path(d) === :numeric

    # Four equal-scale Gammas, scrambled: every pair collapses, so the
    # fold reduces all the way to one distribution regardless of which
    # pair it happens to pick first, and reports :analytic.
    d4 = convolved(
        Gamma(1.0, 1.5), Gamma(3.0, 1.5), Gamma(2.0, 1.5), Gamma(4.0, 1.5))
    @test evaluation_path(d4) === :analytic
end

@testitem "evaluation_path covers every quantity's route check" begin
    # #92's per-quantity route check (`_resolve_closed_form`, resolved
    # once at construction -- review B) is only ever exercised through
    # `evaluation_path`'s default `(pdf, cdf)` or an explicit `cdf`/`pdf`
    # elsewhere in the suite, so the `logcdf`/`ccdf`/`logccdf`/`logpdf`
    # entries go untouched without this.
    #
    # The uniform-window pair (Gamma + Uniform) registers a pair-specific
    # closed form for every quantity -- `pdf`/`logpdf`/`cdf` and also
    # `logcdf`/`ccdf`/`logccdf` -- so `:analytic` is the correct answer
    # across the board for this pair.
    using ConvolvedDistributions: evaluation_path
    using Distributions

    analytic = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    numeric = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

    @test evaluation_path(analytic, logpdf) === :analytic
    for f in (logcdf, ccdf, logccdf, logpdf)
        @test evaluation_path(numeric, f) === :numeric
    end
    for f in (logcdf, ccdf, logccdf)
        @test evaluation_path(analytic, f) === :analytic
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

@testitem "Difference cdf dispatch" begin
    using ConvolvedDistributions: difference_cdf, Difference, AnalyticalSolver,
                                  NumericSolver, AbstractSolverMethod
    using Distributions

    struct DispatchTestDelay <: ContinuousUnivariateDistribution end
    Base.minimum(::DispatchTestDelay) = 0.0
    Base.maximum(::DispatchTestDelay) = Inf
    Distributions.cdf(::DispatchTestDelay, x::Real) = 1 - exp(-x)
    Distributions.pdf(::DispatchTestDelay, x::Real) = exp(-x)

    # A downstream analytic pair is just a method on a two-element tuple
    # TYPE -- no registration call, plain dispatch picks it up over the
    # generic `Tuple` fallback. Difference is not commutative, so unlike
    # Convolved there is no mirrored-order method to add.
    analytic_called = Ref(false)
    function ConvolvedDistributions.difference_cdf(
            ::Difference, ::Tuple{DispatchTestDelay, Uniform}, z::Real,
            ::AnalyticalSolver)
        analytic_called[] = true
        return 0.54321
    end

    @testset "Dispatch to analytical method" begin
        analytic_called[] = false
        d = difference(DispatchTestDelay(), Uniform(0.0, 1.0))
        @test cdf(d, 2.0) == 0.54321
        @test analytic_called[]
    end

    @testset "Force numerical method" begin
        analytic_called[] = false
        d = difference(
            DispatchTestDelay(), Uniform(0.0, 1.0); method = NumericSolver())
        result = cdf(d, 2.0)
        @test !analytic_called[]
        @test result != 0.54321
        @test 0 < result < 1
    end

    @testset "Fallback for unsupported distributions" begin
        # No `difference_cdf` method for Gamma - LogNormal, so this falls
        # through the `AnalyticalSolver` generic to quadrature.
        d = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
        result = cdf(d, 1.0)
        @test 0 < result < 1
    end

    @testset "Unknown solver type errors" begin
        struct BrokenMethod <: AbstractSolverMethod end
        d = Difference(Gamma(2.0, 1.0), Uniform(0.0, 1.0);
            method = BrokenMethod())
        @test_throws ErrorException difference_cdf(
            d, (Gamma(2.0, 1.0), Uniform(0.0, 1.0)), 1.0, BrokenMethod())
    end
end

@testitem "Unknown solver type errors for every difference_* generic" begin
    # "Difference cdf dispatch" above pins this for the scalar cdf arm only.
    # Every difference_* generic shares the same skeleton (a plain `error`
    # for a solver type that is neither `AnalyticalSolver` nor
    # `NumericSolver`), so this exercises all of them, not just `cdf`.
    using ConvolvedDistributions: difference_cdf, difference_logcdf,
                                  difference_ccdf, difference_logccdf,
                                  difference_pdf, difference_logpdf,
                                  difference_quantile, Difference,
                                  AbstractSolverMethod
    using Distributions

    struct BrokenMethod <: AbstractSolverMethod end

    components = (Gamma(2.0, 1.0), Uniform(0.0, 1.0))
    d = Difference(components...; method = BrokenMethod())

    @test_throws ErrorException difference_cdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException difference_logcdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException difference_ccdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException difference_logccdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException difference_pdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException difference_logpdf(
        d, components, 1.0, BrokenMethod())
    @test_throws ErrorException difference_quantile(
        d, components, 0.5, BrokenMethod())
end

@testitem "Difference quantile dispatch: analytic without Optimization.jl" begin
    # Mirrors "Convolved quantile dispatch" above: the `AnalyticalSolver`
    # arm must resolve a Normal-Normal pair without Optimization.jl loaded
    # and without running a Nelder-Mead solve. `==` (not `≈`) is the
    # load-bearing check: a Nelder-Mead solve would not land on the exact
    # bit pattern.
    using ConvolvedDistributions: difference_quantile, AnalyticalSolver
    using Distributions

    d = difference(Normal(1.0, 2.0), Normal(3.0, 4.0))
    ref = Normal(1.0 - 3.0, sqrt(2.0^2 + 4.0^2))
    for p in (0.1, 0.25, 0.5, 0.75, 0.9)
        @test difference_quantile(d, (d.x, d.y), p, AnalyticalSolver()) ==
              quantile(ref, p)
@testitem "convolve_pair is a public downstream extension point" begin
    # Proves the extension point is genuinely dispatched to, not merely
    # present: a spy records whether the override ran (so the assertion
    # does not depend on the numeric outcome matching by coincidence),
    # and the result is checked against the override's own distribution,
    # not the generic collapse-or-quadrature fallback. `ExtPairDelay` is
    # a plain, non-parametric struct (unlike `Gamma`/`Uniform`) so the
    # dispatch cannot fall prey to Julia's type-parameter invariance.
    using ConvolvedDistributions: convolve_pair, evaluation_path
    using Distributions

    struct ExtPairDelay <: ContinuousUnivariateDistribution end
    Base.minimum(::ExtPairDelay) = 0.0
    Base.maximum(::ExtPairDelay) = Inf
    Distributions.cdf(::ExtPairDelay, x::Real) = 1 - exp(-x)
    Distributions.pdf(::ExtPairDelay, x::Real) = exp(-x)

    called = Ref(false)
    override = Exponential(5.0)
    function ConvolvedDistributions.convolve_pair(
            ::ExtPairDelay, ::ExtPairDelay)
        called[] = true
        return override
    end

    try
        d = convolved(ExtPairDelay(), ExtPairDelay())
        @test called[]
        @test evaluation_path(d) === :analytic
        @test cdf(d, 2.0) == cdf(override, 2.0)
    finally
        # Delete the method rather than rely on the throwaway type alone:
        # `ExtPairDelay` is local to this testitem's module, but the
        # method itself lives on the shared `convolve_pair` generic in
        # `ConvolvedDistributions`, which persists for the rest of the
        # test run unless removed.
        Base.delete_method(only(methods(
            ConvolvedDistributions.convolve_pair,
            Tuple{ExtPairDelay, ExtPairDelay})))
    end
end

@testitem "convolve_power is a public downstream extension point" begin
    # Same proof shape as "convolve_pair is a public downstream extension
    # point" above, for the k-fold repeat hook.
    using ConvolvedDistributions: convolve_power
    using Distributions

    struct ExtPowerDelay <: ContinuousUnivariateDistribution end
    Base.minimum(::ExtPowerDelay) = 0.0
    Base.maximum(::ExtPowerDelay) = Inf
    Distributions.cdf(::ExtPowerDelay, x::Real) = 1 - exp(-x)
    Distributions.pdf(::ExtPowerDelay, x::Real) = exp(-x)

    called = Ref(false)
    closed = Exponential(9.0)
    function ConvolvedDistributions.convolve_power(
            ::ExtPowerDelay, k::Integer)
        called[] = true
        return closed
    end

    try
        result = convolved(ExtPowerDelay(), 4)
        @test called[]
        @test result === closed
    finally
        Base.delete_method(only(methods(
            ConvolvedDistributions.convolve_power,
            Tuple{ExtPowerDelay, Integer})))
    end
end
