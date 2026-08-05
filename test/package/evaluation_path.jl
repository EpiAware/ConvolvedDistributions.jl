# Queryable evaluation path, strict construction, and solver-payload
# validation (#92): a caller can ask which route a combination will take
# for its density/CDF without evaluating either, construction can demand
# an exact route up front, and a solver payload the built-in quadrature
# paths do not consult is rejected rather than silently ignored.

@testitem "evaluation_path/has_closed_form report route, no eval" begin
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
    @test evaluation_path(ratio(Normal(0.0, 1.0), Normal(0.0, 1.0))) ===
          :analytic
    @test evaluation_path(ratio(Gamma(2.0, 1.5), Gamma(3.0, 0.5))) === :analytic
    @test evaluation_path(ratio(Chisq(4), Chisq(6))) === :analytic
    @test has_closed_form(convolved(Normal(1.0, 2.0), Normal(-0.5, 1.5)))

    # No matching closed form.
    @test evaluation_path(convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))) ===
          :numeric
    @test evaluation_path(difference(Gamma(3.0, 1.0), Gamma(2.0, 1.0))) ===
          :numeric
    @test evaluation_path(product(Gamma(2.0, 1.0), Weibull(1.5, 1.0))) ===
          :numeric
    @test evaluation_path(ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))) ===
          :numeric
    @test evaluation_path(ratio(Normal(1.0, 2.0), Normal(0.0, 0.5))) ===
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
    forced_numeric = convolved(
        Normal(0.0, 1.0), Normal(1.0, 2.0); method = NumericSolver())
    @test evaluation_path(forced_numeric) === :numeric
    @test evaluation_path(
        ratio(Normal(0.0, 1.0), Normal(0.0, 1.0); method = NumericSolver())) ===
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
    @test evaluation_path(convolved(numeric_inner, Normal(0.0, 1.0))) ===
          :numeric
    @test evaluation_path(convolved(analytic_inner, Normal(0.0, 1.0))) ===
          :numeric
    @test evaluation_path(difference(numeric_inner, Gamma(1.0, 1.0))) ===
          :numeric
    @test evaluation_path(
        product(convolved(Gamma(2.0, 1.0), Exponential(1.0)),
        Weibull(1.5, 1.0))) === :numeric
    @test evaluation_path(ratio(numeric_inner, Gamma(1.0, 1.0))) === :numeric
    @test evaluation_path(ratio(analytic_inner, Gamma(1.0, 1.0))) === :numeric
end

@testitem "strict construction errors naming the component families" begin
    using ConvolvedDistributions: evaluation_path
    using Distributions

    # Analytic pairs succeed under strict = true.
    @test evaluation_path(
        convolved(Normal(1.0, 1.0), Normal(2.0, 1.0); strict = true)) ===
          :analytic
    @test evaluation_path(
        difference(Normal(1.0, 1.0), Normal(0.0, 1.0); strict = true)) ===
          :analytic
    @test evaluation_path(
        product(LogNormal(0.0, 0.3), LogNormal(0.2, 0.5); strict = true)) ===
          :analytic
    @test evaluation_path(
        ratio(Normal(0.0, 1.0), Normal(0.0, 1.0); strict = true)) === :analytic

    # No closed form: errors, naming the families.
    err = @test_throws ArgumentError convolved(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4); strict = true)
    @test occursin("Gamma", err.value.msg)
    @test occursin("LogNormal", err.value.msg)

    @test_throws ArgumentError difference(
        Gamma(3.0, 1.0), Gamma(2.0, 1.0); strict = true)
    @test_throws ArgumentError product(
        Gamma(2.0, 1.0), Weibull(1.5, 1.0); strict = true)
    @test_throws ArgumentError ratio(
        Gamma(3.0, 1.0), LogNormal(0.5, 0.4); strict = true)

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
    test_analytic_skips_quadrature(
        ratio(Normal(0.0, 1.0), Normal(0.0, 1.0)); x = 0.5)

    # A no-op (nothing asserted, no failure) for a numeric-only case.
    test_analytic_skips_quadrature(
        convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)); x = 3.0)
    test_analytic_skips_quadrature(
        ratio(Gamma(3.0, 1.0), LogNormal(0.5, 0.4)); x = 1.0)
end

@testitem "is_exact: orthogonal to evaluation_path (#85, #89)" begin
    using ConvolvedDistributions: evaluation_path, has_closed_form, is_exact
    using Distributions

    # A closed form is always exact.
    da = convolved(Normal(1.0, 2.0), Normal(-0.5, 1.5))
    @test evaluation_path(da) === :analytic
    @test is_exact(da)

    # An all-discrete-integer pair with no closed form reports :numeric
    # (evaluation_path keeps its two-valued contract — no `:lattice`
    # value, #92), but IS exact via the discrete fold.
    dl = convolved(Poisson(1.0), Geometric(0.3))
    @test evaluation_path(dl) === :numeric
    @test !has_closed_form(dl)
    @test is_exact(dl)

    # :numeric stays unchanged for a mixed pair with no closed form
    # (evaluation_path's two-valued contract, #92), but a TWO-component
    # mixed pair (exactly one integer-lattice discrete side) IS exact
    # via its own fold (#115) — the same discrete-vs-continuous
    # orthogonality `dl` demonstrates above, extended to the mixed case.
    dmixed = convolved(Poisson(1.0), Normal(0.0, 1.0))
    @test evaluation_path(dmixed) === :numeric
    @test !has_closed_form(dmixed)
    @test is_exact(dmixed)

    # A genuinely all-continuous pair with no closed form stays
    # :numeric and inexact.
    dnum = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test evaluation_path(dnum) === :numeric
    @test !is_exact(dnum)

    # NumericSolver on an analytic discrete pair still reports :numeric
    # and is still exact (the discrete fold, not quadrature — J5).
    dforced = convolved(Poisson(1.0), Poisson(2.0); method = NumericSolver())
    @test evaluation_path(dforced) === :numeric
    @test is_exact(dforced)

    # `strict = true` accepts the exact discrete route (no closed form,
    # but no quadrature either), unlike a genuinely inexact pair.
    @test convolved(Poisson(1.0), Geometric(0.3); strict = true) isa
          ConvolvedDistributions.Convolved
    @test_throws ArgumentError convolved(
        Gamma(2.0, 1.0), LogNormal(0.5, 0.4); strict = true)

    # Route-vs-execution guard: whenever `is_exact` reports true via the
    # discrete or mixed route (no closed form), `pdf` actually took that
    # route — for a representative discrete, mixed and continuous case.
    @test is_exact(dl) && !has_closed_form(dl)
    @test pdf(dl, 2) === ConvolvedDistributions._convolved_lattice_pdf(dl, 2)
    @test is_exact(dmixed) && !has_closed_form(dmixed)
    @test pdf(dmixed, 2.0) ===
          ConvolvedDistributions._convolved_mixed_pdf(Val(1), dmixed, 2.0)
    @test !is_exact(dnum)
end

@testitem "evaluation_path does not drift from cdf/pdf routing (#92)" begin
    using ConvolvedDistributions: evaluation_path, has_closed_form
    using Distributions

    # Gamma+Uniform has a closed-form cdf and pdf (the uniform-window
    # forms), so both must report :analytic per quantity -- the report
    # this predicate makes must match what cdf/pdf actually do.
    d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    @test evaluation_path(d, cdf) === :analytic
    @test evaluation_path(d, pdf) === :analytic
    @test has_closed_form(d, cdf)
    @test has_closed_form(d, pdf)

    # The fix, not a regression: strict = true now accepts this pair.
    d_strict = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0); strict = true)
    @test d_strict isa ConvolvedDistributions.Convolved
end
