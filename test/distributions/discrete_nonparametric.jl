@testsnippet AtomCases begin
    using Distributions

    # Brute-force reference: every atom of `a` against every atom of `b`
    # under `op`, keyed on the rounded value so one-ulp neighbours land on
    # one key, exactly what the package's own merge must reproduce.
    function brute_force_atoms(op, a, b)
        acc = Dict{Float64, Float64}()
        for (x, px) in zip(support(a), probs(a)),
                (y, py) in zip(support(b), probs(b))

            k = round(op(x, y); digits = 9)
            acc[k] = get(acc, k, 0.0) + px * py
        end
        return acc
    end

    # The collapsed atom set must carry the reference's atoms (up to the
    # one-ulp differences the rounding above absorbs) and masses, and a
    # lookup on each of its own support points must reproduce its mass:
    # `pdf` on an atom set is an exact-equality lookup, as it is on a
    # `DiscreteNonParametric` itself.
    function check_atoms(d, ref)
        atoms = ConvolvedDistributions._maybe_analytic(d)
        ks = sort(collect(keys(ref)))
        @test length(support(atoms)) == length(ks)
        @test support(atoms) ≈ ks
        @test probs(atoms) ≈ [ref[k] for k in ks]
        @test sum(probs(atoms)) ≈ 1.0
        for (x, p) in zip(support(atoms), probs(atoms))
            @test pdf(d, x) ≈ p
        end
        return nothing
    end

    a3 = DiscreteNonParametric([0.0, 1.0, 2.0], [0.2, 0.3, 0.5])
    half = DiscreteNonParametric([0.0, 0.5, 1.0], [0.2, 0.3, 0.5])
    thirds = DiscreteNonParametric([0.3, 0.6, 1.2, 2.4], [0.1, 0.2, 0.3, 0.4])
    positive = DiscreteNonParametric([0.5, 1.0, 2.5], [0.25, 0.5, 0.25])
end

@testitem "two DiscreteNonParametric components collapse exactly (#226)" setup = [AtomCases] begin
    using ConvolvedDistributions: evaluation_path, is_exact

    d = convolved(a3, a3)
    truth = [0.04, 0.12, 0.29, 0.3, 0.25]
    @test evaluation_path(d) === :analytic
    @test is_exact(d)
    @test Distributions.value_support(typeof(d)) === Continuous
    @test [pdf(d, x) for x in 0.0:4.0] ≈ truth
    @test [cdf(d, x) for x in 0.0:4.0] ≈ cumsum(truth)
    @test [logpdf(d, x) for x in 0.0:4.0] ≈ log.(truth)
    @test pdf(d, 0.5) == 0.0
    @test logpdf(d, 0.5) == -Inf
    @test ccdf(d, 2.0) ≈ 0.55
    @test mean(d) ≈ 2 * mean(a3)
    @test var(d) ≈ 2 * var(a3)
    @test minimum(d) == 0.0
    @test maximum(d) == 4.0
    @test quantile(d, 0.5) == 3.0
    @test quantile(d, 0.1) == 1.0

    # The closed form is what `strict = true` promises.
    @test convolved(a3, a3; strict = true) isa ConvolvedDistributions.Convolved
    ConvolvedDistributions.TestUtils.test_analytic_skips_quadrature(d; x = 2.0)
end

@testitem "DiscreteNonParametric collapse handles any grid (#117)" setup = [AtomCases] begin
    using ConvolvedDistributions: is_exact

    # A non-integer grid, a mismatched pair of grids, and an irregular one.
    for (x, y) in ((half, half), (half, thirds), (thirds, a3))
        d = convolved(x, y)
        @test is_exact(d)
        check_atoms(d, brute_force_atoms(+, x, y))
    end

    # Coincident sums from different atom pairs merge into one atom: the
    # mass at 1.0 comes from both 0.0 + 1.0 and 0.5 + 0.5.
    d = convolved(half, half)
    @test pdf(d, 1.0) ≈ 0.2 * 0.5 + 0.3 * 0.3 + 0.5 * 0.2
    @test length(support(ConvolvedDistributions._maybe_analytic(d))) == 5

    # Sums that differ by one ulp (`0.1 + 0.5` and `0.2 + 0.4`) are one
    # atom, not two, carrying the mass of both pairs.
    x = DiscreteNonParametric([0.1, 0.2], [0.5, 0.5])
    y = DiscreteNonParametric([0.4, 0.5], [0.5, 0.5])
    dxy = convolved(x, y)
    atoms = ConvolvedDistributions._maybe_analytic(dxy)
    @test length(support(atoms)) == 3
    @test probs(atoms) ≈ [0.25, 0.5, 0.25]
    @test pdf(dxy, 0.6) ≈ 0.5
end

@testitem "DiscreteNonParametric collapse folds n-ary and nests" setup = [AtomCases] begin
    using ConvolvedDistributions: evaluation_path, is_exact

    # Three atom sets fold pairwise into one.
    d3 = convolved(a3, half, thirds)
    @test evaluation_path(d3) === :analytic
    two = ConvolvedDistributions._maybe_analytic(convolved(a3, half))
    check_atoms(d3, brute_force_atoms(+, two, thirds))

    # Two atom sets and an integer-lattice count: the atom sets collapse,
    # and the residue is the mixed fold, which evaluates the collapsed
    # atom set pointwise.
    dm = convolved(a3, a3, Poisson(2.0))
    aa = ConvolvedDistributions._maybe_analytic(convolved(a3, a3))
    for k in 0:8
        ref = sum(
            pdf(aa, j) * pdf(Poisson(2.0), k - j) for j in 0:min(k, 4)
        )
        @test pdf(dm, k) ≈ ref
    end

    # A collapsed pair nests as a component of a further sum, collapsing
    # again with the outer atom set.
    inner = convolved(a3, half)
    outer = convolved(inner, thirds)
    @test evaluation_path(outer) === :analytic
    check_atoms(
        outer,
        brute_force_atoms(
            +, ConvolvedDistributions._maybe_analytic(inner), thirds
        )
    )
    @test pdf(outer, 1.3) ≈ pdf(d3, 1.3)

    # An inner combination with no closed form offers none to the outer
    # pair, so `evaluation_path` recurses honestly, and the atoms guard
    # refuses the quadrature that would follow. The flat form folds the
    # atoms into a continuous component and integrates the rest.
    numeric = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    @test_throws ArgumentError convolved(numeric, thirds)
    flat = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4), thirds)
    @test evaluation_path(flat) === :numeric
    s, p = support(thirds), probs(thirds)
    @test pdf(flat, 3.0) ≈ sum(p[i] * pdf(numeric, 3.0 - s[i]) for i in 1:4) rtol = 1.0e-4
    @test cdf(flat, 3.0) ≈ sum(p[i] * cdf(numeric, 3.0 - s[i]) for i in 1:4) rtol = 1.0e-4

    # The other members resolve a nested closed form the same way.
    @test evaluation_path(difference(inner, thirds)) === :analytic
    @test evaluation_path(difference(thirds, inner)) === :analytic
    @test pdf(difference(inner, thirds), 0.7) ≈ pdf(difference(two, thirds), 0.7)
    pos_inner = convolved(positive, positive)
    @test evaluation_path(product(pos_inner, thirds)) === :analytic
    @test evaluation_path(ratio(pos_inner, positive)) === :analytic
end

@testitem "difference/product/ratio of DiscreteNonParametric pairs" setup = [AtomCases] begin
    using ConvolvedDistributions: evaluation_path, is_exact

    dd = difference(thirds, half)
    @test evaluation_path(dd) === :analytic
    @test is_exact(dd)
    check_atoms(dd, brute_force_atoms(-, thirds, half))
    @test mean(dd) ≈ mean(thirds) - mean(half)

    dp = product(thirds, positive)
    @test evaluation_path(dp) === :analytic
    @test is_exact(dp)
    check_atoms(dp, brute_force_atoms(*, thirds, positive))
    @test mean(dp) ≈ mean(thirds) * mean(positive)

    dr = ratio(thirds, positive)
    @test evaluation_path(dr) === :analytic
    @test is_exact(dr)
    check_atoms(dr, brute_force_atoms(/, thirds, positive))
    # The analytic ratio delegates its moments to the collapsed atom set.
    @test mean(dr) ≈ sum(
        px * py * x / y
            for (x, px) in zip(support(thirds), probs(thirds)),
            (y, py) in zip(support(positive), probs(positive))
    )

    # A denominator with an atom at zero is still rejected up front.
    @test_throws ArgumentError ratio(thirds, a3)
    @test ConvolvedDistributions.ratio_pair(thirds, a3) === nothing
end

@testitem "DiscreteNonParametric next to a continuous component is a mixture" setup = [AtomCases] begin
    using ConvolvedDistributions: evaluation_path, is_exact

    g = Gamma(2.0, 1.0)
    s, p = support(half), probs(half)

    d = convolved(half, g)
    @test evaluation_path(d) === :analytic
    @test is_exact(d)
    for z in (0.25, 1.0, 2.5, 6.0)
        @test pdf(d, z) ≈ sum(p[i] * pdf(g, z - s[i]) for i in 1:3)
        @test cdf(d, z) ≈ sum(p[i] * cdf(g, z - s[i]) for i in 1:3)
        @test pdf(convolved(g, half), z) ≈ pdf(d, z)
        @test ccdf(d, z) ≈ 1 - cdf(d, z)
    end
    @test mean(d) ≈ mean(half) + mean(g)
    @test var(d) ≈ var(half) + var(g)
    @test quantile(d, 0.5) ≈ quantile(
        ConvolvedDistributions._maybe_analytic(d), 0.5
    )
    ConvolvedDistributions.TestUtils.test_analytic_skips_quadrature(
        d; x = 1.0
    )

    # Both orders of the difference reflect correctly.
    dxy = difference(half, g)
    dyx = difference(g, half)
    for z in (-3.0, -0.5, 0.25, 1.0)
        @test pdf(dxy, z) ≈ sum(p[i] * pdf(g, s[i] - z) for i in 1:3)
        @test pdf(dyx, -z) ≈ pdf(dxy, z)
        @test cdf(dxy, z) ≈ sum(p[i] * ccdf(g, s[i] - z) for i in 1:3)
    end
    @test mean(dxy) ≈ mean(half) - mean(g)

    # A product scales the continuous factor by each positive atom.
    sp, pp = support(positive), probs(positive)
    dp = product(positive, g)
    @test evaluation_path(dp) === :analytic
    for z in (0.5, 2.0, 7.0)
        @test pdf(dp, z) ≈ sum(pp[i] * pdf(g, z / sp[i]) / sp[i] for i in 1:3)
        @test pdf(product(g, positive), z) ≈ pdf(dp, z)
        @test cdf(dp, z) ≈ sum(pp[i] * cdf(g, z / sp[i]) for i in 1:3)
    end
    @test mean(dp) ≈ mean(positive) * mean(g)

    # A ratio with an atom-set denominator scales the numerator by each
    # reciprocal atom; the other way round has no closed form.
    dr = ratio(g, positive)
    @test evaluation_path(dr) === :analytic
    for z in (0.5, 2.0, 7.0)
        @test pdf(dr, z) ≈ sum(pp[i] * pdf(g, z * sp[i]) * sp[i] for i in 1:3)
        @test cdf(dr, z) ≈ sum(pp[i] * cdf(g, z * sp[i]) for i in 1:3)
    end
    @test ConvolvedDistributions.ratio_pair(positive, g) === nothing
end

@testitem "quadrature over a discrete component is refused (#226)" setup = [AtomCases] begin
    g = Gamma(2.0, 1.0)

    # A discrete component off the integer lattice with no closed form:
    # a shifted count, a product with an atom at zero, a ratio numerator.
    err = try
        convolved(Poisson(3.0) + 0.5, g)
    catch e
        e
    end
    @test err isa ArgumentError
    @test occursin("quadrature", err.msg)
    @test occursin("AffineDistribution", err.msg)
    @test_throws ArgumentError difference(g, Poisson(3.0) + 0.5)
    @test_throws ArgumentError product(a3, g)
    @test_throws ArgumentError ratio(a3, g)
    @test_throws ArgumentError ratio(Poisson(3.0), g)

    # Forcing the numeric path on an atom-set pair is refused rather than
    # returning a density of zero.
    @test_throws ArgumentError convolved(a3, a3; method = NumericSolver())

    # Three components: an integer-lattice count next to two continuous
    # components the mixed fold cannot take, unless the continuous pair
    # first collapses to one.
    @test_throws ArgumentError convolved(Poisson(1.0), g, Gamma(2.0, 2.0))
    ok = convolved(Poisson(1.0), g, Gamma(3.0, 1.0))
    @test pdf(ok, 2.0) ≈ pdf(convolved(Poisson(1.0), Gamma(5.0, 1.0)), 2.0)

    # The routes with an exact fold are untouched.
    @test convolved(Poisson(1.0), g) isa ConvolvedDistributions.Convolved
    @test convolved(Poisson(1.0), Geometric(0.3)) isa
        ConvolvedDistributions.Convolved
    @test product(DiscreteUniform(1, 5), g) isa ConvolvedDistributions.Product
end

@testitem "mixed fold keeps the boundary atom of an atom set (#227)" setup = [AtomCases] begin
    using ConvolvedDistributions: evaluation_path, is_exact

    d = convolved(a3, Poisson(1.0))
    @test evaluation_path(d) === :numeric
    @test is_exact(d)
    for k in 0:6
        ref = sum(pdf(a3, j) * pdf(Poisson(1.0), k - j) for j in 0:min(k, 2))
        @test pdf(d, k) ≈ ref
        @test pdf(convolved(Poisson(1.0), a3), k) ≈ ref
    end
    @test pdf(d, 0.0) ≈ 0.2 * exp(-1.0)
    @test cdf(d, 0.0) ≈ 0.2 * exp(-1.0)
    @test cdf(d, -0.5) == 0.0
    @test pdf(d, 0.5) == 0.0

    # A fractional grid next to a count: the atom at the lower end and
    # the interior points are both exact.
    dh = convolved(half, Poisson(1.0))
    for z in (0.0, 0.5, 1.0, 1.5, 3.0)
        ref = sum(
            pdf(half, z - k) * pdf(Poisson(1.0), k) for k in 0:floor(Int, z)
        )
        @test pdf(dh, z) ≈ ref
    end

    # Difference and product: the boundary atoms survive there too.
    dd = difference(a3, Poisson(1.0))
    @test pdf(dd, 2.0) ≈ 0.5 * exp(-1.0)
    @test pdf(difference(Poisson(1.0), a3), -2.0) ≈ 0.5 * exp(-1.0)
    dp = product(positive, DiscreteUniform(1, 3))
    @test pdf(dp, 0.5) ≈ 0.25 / 3
    @test pdf(dp, 7.5) ≈ 0.25 / 3
    @test pdf(product(DiscreteUniform(1, 3), positive), 7.5) ≈ 0.25 / 3

    # A continuous component still reports a zero density at an endpoint
    # (`Exponential` rather than `Uniform`, whose pair takes the
    # uniform-window closed form instead of the mixed fold).
    dc = convolved(Poisson(1.0), Exponential(1.0))
    @test pdf(dc, 0.0) == 0.0
    @test pdf(dc, 0.5) ≈ sum(pdf(Poisson(1.0), k) * pdf(Exponential(1.0), 0.5 - k) for k in 0:0)
end

@testitem "DiscreteNonParametric closed forms differentiate" setup = [AtomCases] begin
    using ForwardDiff

    s = [0.0, 1.0, 2.0]
    g = Gamma(2.0, 1.0)

    # Gradient of the collapsed pair's mass with respect to the atom
    # weights, against the enumerated form.
    f(p) = pdf(convolved(DiscreteNonParametric(s, p), a3), 2.0)
    p0 = [0.2, 0.3, 0.5]
    grad = ForwardDiff.gradient(f, p0)
    @test grad ≈ [pdf(a3, 2.0), pdf(a3, 1.0), pdf(a3, 0.0)]

    # Through the shift mixture, with respect to both the weights and the
    # continuous parameter.
    h(θ) = pdf(
        convolved(
            DiscreteNonParametric(s, θ[1:3] ./ sum(θ[1:3])), Gamma(θ[4], 1.0)
        ), 1.5
    )
    θ0 = [0.2, 0.3, 0.5, 2.0]
    gh = ForwardDiff.gradient(h, θ0)
    @test all(isfinite, gh)
    ref = ForwardDiff.gradient(
        θ -> sum(
            θ[i] / sum(θ[1:3]) * pdf(Gamma(θ[4], 1.0), 1.5 - s[i])
                for i in 1:3
        ), θ0
    )
    @test gh ≈ ref
end
