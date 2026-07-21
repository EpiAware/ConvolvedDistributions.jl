# Queryable evaluation path, strict construction, and solver-payload
# validation (#92): a caller can ask which route a combination will take
# for its density/CDF without evaluating either, construction can demand
# an exact route up front, and a solver payload the built-in quadrature
# paths do not consult is rejected rather than silently ignored.

@testitem "evaluation_path/has_closed_form report the route without evaluating" begin
    using ConvolvedDistributions: evaluation_path, has_closed_form
    using Distributions

    # Analytic pairs.
    @test evaluation_path(convolved(Normal(1.0, 2.0), Normal(-0.5, 1.5))) ===
          :analytic
    @test evaluation_path(convolved(Exponential(2.0), Exponential(2.0))) ===
          :analytic
    @test evaluation_path(convolved(Gamma(2.0, 1.5), Gamma(3.0, 1.5))) ===
          :analytic
    @test evaluation_path(difference(Normal(5.0, 1.0), Normal(2.0, 1.0))) ===
          :analytic
    @test evaluation_path(product(LogNormal(0.5, 0.4), LogNormal(1.0, 0.3))) ===
          :analytic
    @test has_closed_form(convolved(Normal(1.0, 2.0), Normal(-0.5, 1.5)))

    # No matching closed form.
    @test evaluation_path(convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))) ===
          :numeric
    @test evaluation_path(difference(Gamma(3.0, 1.0), Gamma(2.0, 1.0))) ===
          :numeric
    @test evaluation_path(product(Gamma(2.0, 1.0), Weibull(1.5, 1.0))) ===
          :numeric
    @test !has_closed_form(convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)))

    # An analytic pair mismatched on parameters (unequal-scale Gamma,
    # unequal-rate Exponential) falls through the same way a genuinely
    # non-analytic family pair does.
    @test evaluation_path(convolved(Gamma(2.0, 1.0), Gamma(3.0, 2.0))) ===
          :numeric
    @test evaluation_path(convolved(Exponential(2.0), Exponential(3.0))) ===
          :numeric

    # Forcing NumericSolver on an otherwise-analytic pair reports :numeric.
    @test evaluation_path(
        convolved(Normal(0.0, 1.0), Normal(1.0, 2.0); method = NumericSolver())) ===
          :numeric
end

@testitem "evaluation_path recurses through nested combinations" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    numeric_inner = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    analytic_inner = convolved(Normal(0.0, 1.0), Normal(1.0, 1.0))

    # An outer combination over a numeric inner component reports :numeric,
    # even though the outer's own top-level family pair would otherwise be
    # unrecognised either way (a `Convolved` is never an analytic-pair
    # match), which is exactly the point: nesting anything non-leaf forces
    # the outer numeric, whether or not the inner itself is analytic.
    @test evaluation_path(convolved(numeric_inner, Normal(0.0, 1.0))) === :numeric
    @test evaluation_path(convolved(analytic_inner, Normal(0.0, 1.0))) === :numeric
    @test evaluation_path(difference(numeric_inner, Gamma(1.0, 1.0))) === :numeric
    @test evaluation_path(
        product(convolved(Gamma(2.0, 1.0), Exponential(1.0)),
        Weibull(1.5, 1.0))) === :numeric
end

@testitem "strict construction errors naming the component families" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    # Analytic pairs succeed under strict = true.
    @test evaluation_path(
        convolved(Normal(1.0, 1.0), Normal(2.0, 1.0); strict = true)) === :analytic
    @test evaluation_path(
        difference(Normal(1.0, 1.0), Normal(0.0, 1.0); strict = true)) === :analytic
    @test evaluation_path(
        product(LogNormal(0.0, 0.3), LogNormal(0.2, 0.5); strict = true)) ===
          :analytic

    # No closed form: errors, naming the families.
    err = @test_throws ArgumentError convolved(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4); strict = true)
    @test occursin("Gamma", err.value.msg)
    @test occursin("LogNormal", err.value.msg)

    @test_throws ArgumentError difference(
        Gamma(3.0, 1.0), Gamma(2.0, 1.0); strict = true)
    @test_throws ArgumentError product(
        Gamma(2.0, 1.0), Weibull(1.5, 1.0); strict = true)

    # An explicit NumericSolver breaks the strict = true guarantee just as
    # much as a mismatched family pair does.
    @test_throws ArgumentError convolved(
        Normal(0.0, 1.0), Normal(1.0, 2.0);
        method = NumericSolver(), strict = true)

    # strict = false (the default) never errors for this reason.
    @test convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)) isa
          ConvolvedDistributions.Convolved
end

@testitem "a non-default solver payload is rejected, not silently ignored" begin
    using ConvolvedDistributions: AbstractSolverMethod, GaussLegendre
    using Distributions

    # The default payload (whether implicit or spelled out) is fine.
    @test AnalyticalSolver() isa AbstractSolverMethod
    @test NumericSolver() isa AbstractSolverMethod
    @test NumericSolver(GaussLegendre(; n = 64)) isa AbstractSolverMethod

    # A different node count, or a foreign solver type, is rejected: the
    # built-in quadrature paths do not consult `d.method.solver`, so
    # silently accepting it would misrepresent the precision a caller
    # believes they requested (#92).
    @test_throws ArgumentError NumericSolver(GaussLegendre(; n = 256))
    @test_throws ArgumentError AnalyticalSolver(GaussLegendre(; n = 128))
    @test_throws ArgumentError NumericSolver("not a solver")

    # The rejection fires at construction, before any distribution is built.
    err = @test_throws ArgumentError NumericSolver(GaussLegendre(; n = 1024))
    @test occursin("NumericSolver", err.value.msg)
    @test occursin("#92", err.value.msg)
end

@testitem "analytic path skips quadrature (TestUtils)" begin
    using ConvolvedDistributions.TestUtils: test_analytic_skips_quadrature
    using Distributions

    test_analytic_skips_quadrature(
        convolved(Normal(1.0, 2.0), Normal(-0.5, 1.5)); x = 1.0)
    test_analytic_skips_quadrature(
        convolved(Gamma(2.0, 1.5), Gamma(3.0, 1.5)); x = 4.0)
    test_analytic_skips_quadrature(
        difference(Normal(5.0, 1.0), Normal(2.0, 1.0)); x = 2.0)
    test_analytic_skips_quadrature(
        product(LogNormal(0.5, 0.4), LogNormal(1.0, 0.3)); x = 3.0)

    # A no-op (nothing asserted, no failure) for a numeric-only case.
    test_analytic_skips_quadrature(
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)); x = 3.0)
end
