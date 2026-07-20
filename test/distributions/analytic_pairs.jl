# Tests for the analytic-pair registry (#77): the load-order-safe
# registration mechanism itself, plus the three Distributions.jl-native
# closed forms it hosts (Gamma/LogNormal/Weibull + Uniform).

@testitem "register_analytic_pair! load order and override semantics" begin
    using ConvolvedDistributions
    using ConvolvedDistributions: register_analytic_pair!, _ANALYTIC_PAIR_REGISTRY,
                                  _registered_analytic_pair
    using Distributions

    # A synthetic pair the package does not ship, registered exactly as an
    # extension's __init__ would: after the package has already loaded.
    struct _TestDelay <: ContinuousUnivariateDistribution end
    struct _TestPrimary <: ContinuousUnivariateDistribution end
    Distributions.minimum(::_TestDelay) = 0.0
    Distributions.maximum(::_TestDelay) = 1.0
    Distributions.minimum(::_TestPrimary) = 0.0
    Distributions.maximum(::_TestPrimary) = 1.0
    Distributions.cdf(::_TestDelay, x::Real) = clamp(x, 0.0, 1.0)
    Distributions.pdf(::_TestDelay, x::Real) = 0.0 <= x <= 1.0 ? 1.0 : 0.0
    Distributions.cdf(::_TestPrimary, x::Real) = clamp(x, 0.0, 1.0)
    Distributions.pdf(::_TestPrimary, x::Real) = 0.0 <= x <= 1.0 ? 1.0 : 0.0
    Distributions.params(::_TestDelay) = ()
    Distributions.params(::_TestPrimary) = ()
    Distributions.quantile(::_TestDelay, p::Real) = clamp(p, 0.0, 1.0)
    Distributions.quantile(::_TestPrimary, p::Real) = clamp(p, 0.0, 1.0)

    n_before = length(_ANALYTIC_PAIR_REGISTRY)
    @test _registered_analytic_pair(_TestDelay, _TestPrimary) === nothing

    # A closed form deliberately wrong (a constant) so a numeric-vs-analytic
    # comparison unambiguously shows whether the registry was consulted.
    sentinel_value = 0.987654321
    register_analytic_pair!(_TestDelay, _TestPrimary, (d, p, x) -> sentinel_value)
    @test length(_ANALYTIC_PAIR_REGISTRY) == n_before + 1

    entry = _registered_analytic_pair(_TestDelay, _TestPrimary)
    @test entry !== nothing
    @test entry.cdf_fn(_TestDelay(), _TestPrimary(), 0.5) == sentinel_value

    d = convolved(_TestDelay(), _TestPrimary())
    @test cdf(d, 0.5) == sentinel_value
    @test logcdf(d, 0.5) ≈ log(sentinel_value)
    @test cdf(d, [0.3, 0.5]) == [sentinel_value, sentinel_value]

    # NumericSolver bypasses the registry entirely.
    dn = convolved(_TestDelay(), _TestPrimary(); method = NumericSolver())
    @test cdf(dn, 0.5) != sentinel_value

    # Re-registering the same pair replaces, not duplicates, the entry.
    register_analytic_pair!(_TestDelay, _TestPrimary, (d, p, x) -> sentinel_value + 1)
    @test length(_ANALYTIC_PAIR_REGISTRY) == n_before + 1
    @test cdf(d, 0.5) == sentinel_value + 1

    # A 3-component convolution never consults the registry (scoped to
    # exactly two components), even when the first two match a registered
    # pair.
    d3 = convolved(_TestDelay(), _TestPrimary(), Normal(0.0, 1.0))
    @test cdf(d3, 0.5) != sentinel_value + 1
end

@testitem "Gamma + Uniform analytic pair matches numeric quadrature" begin
    using Distributions

    for (shape, scale, pmin, pwidth) in ((2.0, 1.5, 0.0, 2.0), (0.5, 3.0, 1.0, 1.0), (
        5.0, 0.8, 0.0, 4.0))
        delay = Gamma(shape, scale)
        primary = Uniform(pmin, pmin + pwidth)
        d_analytic = convolved(delay, primary)
        d_numeric = convolved(delay, primary; method = NumericSolver())
        for x in (0.1, 0.5, 1.0, 2.0, 3.0, 6.0, 15.0)
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol=1e-9
            @test logcdf(d_analytic, x) ≈ logcdf(d_numeric, x) atol=1e-6
        end
        # Below the primary's minimum the CDF is exactly zero.
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "LogNormal + Uniform analytic pair matches numeric quadrature" begin
    using Distributions

    for (mu, sigma, pmin, pwidth) in ((1.5, 0.5, 0.0, 3.0), (0.0, 1.0, 0.0, 1.0), (
        2.0, 0.3, 1.0, 2.0))
        delay = LogNormal(mu, sigma)
        primary = Uniform(pmin, pmin + pwidth)
        d_analytic = convolved(delay, primary)
        d_numeric = convolved(delay, primary; method = NumericSolver())
        for x in (0.1, 0.5, 1.0, 2.0, 3.0, 6.0, 15.0)
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol=1e-9
        end
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "Weibull + Uniform analytic pair matches numeric quadrature" begin
    using Distributions

    for (k, lambda, pmin, pwidth) in ((1.5, 2.0, 0.0, 1.5), (0.7, 1.0, 0.0, 2.0), (
        3.0, 4.0, 1.0, 1.0))
        delay = Weibull(k, lambda)
        primary = Uniform(pmin, pmin + pwidth)
        d_analytic = convolved(delay, primary)
        d_numeric = convolved(delay, primary; method = NumericSolver())
        for x in (0.1, 0.5, 1.0, 2.0, 3.0, 6.0, 15.0)
            @test cdf(d_analytic, x) ≈ cdf(d_numeric, x) atol=1e-6
        end
        @test cdf(d_analytic, pmin - 1.0) == 0.0
    end
end

@testitem "Native analytic pairs are picked up by AnalyticalSolver by default" begin
    using ConvolvedDistributions
    using ConvolvedDistributions: _analytic_pair_entry
    using Distributions

    d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
    @test d.method isa AnalyticalSolver
    @test _analytic_pair_entry(d) !== nothing

    # Batched and scalar CDF agree exactly (both route through the same
    # registered closed form, no quadrature panel-grid drift possible).
    xs = [0.5, 1.0, 2.0, 3.0]
    @test cdf(d, xs) == [cdf(d, x) for x in xs]
end
