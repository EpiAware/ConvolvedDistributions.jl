# Exact discrete support in the combination algebra (#85, #89, #95): value
# support derived from the components, and an exact integer-lattice fold
# replacing quadrature for an all-discrete-integer combination.

@testitem "the #85 repro: NegativeBinomial + Poisson is Discrete and exact" begin
    using Distributions

    c = convolved(NegativeBinomial(5, 0.5), Poisson(2.0))
    @test Distributions.value_support(typeof(c)) === Discrete
    @test pdf(c, 3) > 0
    @test pdf(c, 3) ≈ pdf(c, 3.0)

    bruteforce = sum(
        pdf(NegativeBinomial(5, 0.5), k) * pdf(Poisson(2.0), 3 - k)
            for k in 0:3
    )
    @test pdf(c, 3) ≈ bruteforce
    @test pdf(c, 3.0) ≈ bruteforce

    # Regression on the mixed case (#115): a mixed pair stays Continuous
    # (`_components_support` only reports `Discrete` when EVERY
    # component is), but its pdf is no longer silently zero -- the
    # mixed discrete/continuous fold sums the continuous density over
    # the Poisson's lattice, exactly, rather than falling into
    # continuous quadrature over a comb of point masses.
    mixed = convolved(Poisson(3.0), Normal(0.0, 1.0))
    @test Distributions.value_support(typeof(mixed)) === Continuous
    @test pdf(mixed, 2.0) > 0.0
    @test ConvolvedDistributions.is_exact(mixed)
    @test ConvolvedDistributions.evaluation_path(mixed) === :numeric
end

@testsnippet DiscreteConvolvedCases begin
    using Distributions

    # A representative sweep of all-discrete `Convolved`s: two-component
    # bounded, two-component unbounded, unequal-p NegativeBinomial (no
    # analytic pair, exercises the lattice fold), and a three-component
    # mix.
    discrete_convolved_cases() = (
        (
            name = "bounded pair",
            d = convolved(Binomial(4, 0.3), DiscreteUniform(0, 5)),
            support = 0:9,
        ),
        (
            name = "unbounded pair",
            d = convolved(Poisson(3.0), Geometric(0.3)),
            support = 0:120,
        ),
        (
            name = "unequal-p NegativeBinomial",
            d = convolved(NegativeBinomial(5, 0.5), NegativeBinomial(3, 0.4)),
            support = 0:150,
        ),
        (
            name = "three-component mix",
            d = convolved(Poisson(1.0), Binomial(3, 0.4), DiscreteUniform(0, 2)),
            support = 0:12,
        ),
    )

    # Brute-force reference pmf, built once per distribution by
    # sequentially convolving the component supports (the bounded
    # components enumerate exactly; an unbounded component truncates far
    # enough into the tail that the truncation error is negligible next
    # to the `atol` used below). Returns a `k => mass` `Dict`.
    function brute_force_convolved_pmf(d)
        comps = components(d)
        acc = Dict(0 => 1.0)
        for c in comps
            lo = Int(max(0, minimum(c)))
            hi = isfinite(maximum(c)) ? Int(maximum(c)) : lo + 200
            next = Dict{Int, Float64}()
            for (s, p) in acc, x in lo:hi

                next[s + x] = get(next, s + x, 0.0) + p * pdf(c, x)
            end
            acc = next
        end
        return acc
    end
end

@testitem "exactness of the additive fold: masses, cdf, endpoints" setup = [
    DiscreteConvolvedCases,
] begin
    for case in discrete_convolved_cases()
        d = case.d
        support = case.support

        masses = [pdf(d, k) for k in support]
        @test all(m -> m >= 0, masses)
        @test isapprox(sum(masses), 1; atol = 1.0e-6)

        # Agreement with brute-force enumeration over the component
        # supports.
        reference = brute_force_convolved_pmf(d)
        for k in support
            @test pdf(d, k) ≈ get(reference, k, 0.0) atol = 1.0e-8
        end

        running = 0.0
        for (k, m) in zip(support, masses)
            running += m
            @test cdf(d, k) ≈ running atol = 1.0e-8
        end

        # The endpoint atom: the continuous guard's strict `x <=
        # minimum(d)` would have zeroed this. `≈` rather than `==`: the
        # lattice cdf's saturated term routes through a component's own
        # `cdf`, and `Distributions.jl`'s own `cdf`/`pdf` for some
        # families (e.g. `NegativeBinomial`, via the regularised
        # incomplete beta function) are not bit-identical at the
        # minimum even though they are mathematically equal.
        @test cdf(d, minimum(d)) ≈ pdf(d, minimum(d)) atol = 1.0e-12

        if isfinite(maximum(d))
            @test cdf(d, maximum(d)) == 1.0
        end

        mid = first(support) + 0.5
        @test pdf(d, mid) == 0
        @test logpdf(d, mid) == -Inf
        @test cdf(d, mid) == cdf(d, first(support))

        @test isnan(pdf(d, NaN))
        @test isnan(cdf(d, NaN))

        ks = collect(support)[1:5]
        @test pdf(d, ks) == pdf.(Ref(d), ks)
        @test cdf(d, ks) == cdf.(Ref(d), ks)
    end
end

@testitem "insupport rejects off-lattice points on a discrete combination" begin
    using Distributions

    d = convolved(Poisson(2.0), Poisson(3.0))
    @test insupport(d, 4)
    @test insupport(d, 4.0)
    @test !insupport(d, 4.5)
    @test !insupport(d, -1)
end

@testitem "rand does not InexactError on a Bool-eltype discrete combination" begin
    using Distributions, Random

    # `Bernoulli` has `eltype == Bool`; a bare `promote_type(Bool, Bool)`
    # for the combined `eltype` is too narrow for the RESULT of the
    # operation (`Convolved` reaches 2, `Difference` reaches -1), so
    # `Distributions.rand(d, n)` (which allocates `Array{eltype(d)}` for
    # a `Discrete`-typed `d`) threw `InexactError` the first time a draw
    # left `{false, true}`. Regression test: `Base.eltype` must reflect
    # the type the operation actually produces, not a bare promotion of
    # the component element types.
    Random.seed!(1234)

    dc = convolved(Bernoulli(0.5), Bernoulli(0.5))
    @test eltype(typeof(dc)) === Int
    @test all(v -> v in (0, 1, 2), rand(dc, 200))

    dc3 = convolved(Bernoulli(0.4), Bernoulli(0.6), Bernoulli(0.5))
    @test eltype(typeof(dc3)) === Int
    @test all(v -> v in (0, 1, 2, 3), rand(dc3, 200))

    dd = difference(Bernoulli(0.4), Bernoulli(0.6))
    @test eltype(typeof(dd)) === Int
    @test all(v -> v in (-1, 0, 1), rand(dd, 200))

    dp = product(Bernoulli(0.4), Bernoulli(0.6))
    @test all(v -> v in (0, 1), rand(dp, 200))
end
