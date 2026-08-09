@testitem "Convolved log methods consistency across component families" begin
    using Distributions

    # A grid of interior points appropriate to a distribution's support,
    # plus its two ends explicitly (the batched path's shared quadrature
    # panel grid starts/ends exactly at the requested window ends, so
    # these are worth exercising here too).
    function consistency_grid(d; n = 12)
        lo, hi = minimum(d), maximum(d)
        interior = if isfinite(lo) && isfinite(hi)
            collect(range(lo + 1e-6, hi - 1e-6; length = n))
        elseif isfinite(lo)
            collect(range(lo + 1e-6, lo + 15.0; length = n))
        elseif isfinite(hi)
            collect(range(hi - 15.0, hi - 1e-6; length = n))
        else
            collect(range(-10.0, 10.0; length = n))
        end
        return vcat(interior[1], interior, interior[end])
    end

    cases = [
        "Normal+Normal (analytic)" => convolved(
            Normal(1.0, 2.0), Normal(-0.5, 1.5)),
        "Gamma+Gamma equal-scale (analytic)" => convolved(
            Gamma(2.0, 1.5), Gamma(3.0, 1.5)),
        "Exponential+Exponential equal-rate (analytic)" => convolved(
            Exponential(2.0), Exponential(2.0)),
        "Gamma+LogNormal (numeric)" => convolved(
            Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        "LogNormal+Gamma order swapped (numeric)" => convolved(
            LogNormal(0.5, 0.4), Gamma(2.0, 1.0)),
        "Uniform+Uniform (bounded, numeric)" => convolved(
            Uniform(0.0, 2.0), Uniform(0.0, 3.0)),
        "Uniform+Gamma (bounded+unbounded, numeric)" => convolved(
            Uniform(0.0, 1.0), Gamma(2.0, 1.0)),
        "Gamma+Uniform (closed-form window pair)" => convolved(
            Gamma(2.0, 1.5), Uniform(0.0, 2.0)),
        "Weibull+Normal (numeric)" => convolved(
            Weibull(1.5, 2.0), Normal(1.0, 0.5)),
        "three-component Gamma+Gamma+LogNormal (pair breadth)" => convolved(
            Gamma(2.0, 1.0), Gamma(1.5, 2.0), LogNormal(0.5, 0.4)),
        "nested Convolved-of-Convolved (deeper nesting)" => convolved(
            convolved(Gamma(2.0, 1.0), Normal(1.0, 0.5)), LogNormal(0.3, 0.2))
    ]

    for (name, d) in cases
        @testset "$name" begin
            grid = consistency_grid(d)

            prev_cdf = -Inf
            for x in grid
                pdf_val = pdf(d, x)
                logpdf_val = logpdf(d, x)
                @test pdf_val >= 0.0
                if pdf_val > 0
                    @test logpdf_val≈log(pdf_val) rtol=1e-8
                else
                    @test logpdf_val == -Inf
                end

                cdf_val = cdf(d, x)
                logcdf_val = logcdf(d, x)
                if cdf_val > 0
                    @test logcdf_val≈log(cdf_val) atol=1e-8
                else
                    @test logcdf_val == -Inf
                end

                ccdf_val = ccdf(d, x)
                logccdf_val = logccdf(d, x)
                if ccdf_val > 0
                    @test logccdf_val≈log(ccdf_val) atol=1e-6
                else
                    @test logccdf_val == -Inf
                end

                @test cdf_val + ccdf_val≈1.0 atol=1e-8
                @test cdf_val >= prev_cdf - 1e-9  # non-decreasing
                prev_cdf = cdf_val
            end

            # Batched evaluation shares the numeric path's quadrature grid
            # across every point; it must agree with the scalar path
            # point-by-point, including at the grid's own ends. A bare
            # `atol` is too strict at the grid ends, where a far tail can
            # push logpdf to a large negative magnitude (e.g. -663, or
            # further for a three-component chain): the two paths still
            # agree to a relative ~1e-5 there (looser for deeper nesting,
            # where quadrature error compounds across components), so
            # `rtol` alongside a looser `atol` is the size-appropriate
            # check.
            @test pdf(d, grid) ≈ [pdf(d, x) for x in grid] atol=1e-8
            @test isapprox(logpdf(d, grid), [logpdf(d, x) for x in grid];
                atol = 1e-6, rtol = 1e-4)
            @test cdf(d, grid) ≈ [cdf(d, x) for x in grid] atol=1e-8
        end
    end
end

@testitem "Difference log methods consistency across component families" begin
    using Distributions

    function consistency_grid(d; n = 12)
        lo, hi = minimum(d), maximum(d)
        interior = if isfinite(lo) && isfinite(hi)
            collect(range(lo + 1e-6, hi - 1e-6; length = n))
        elseif isfinite(lo)
            collect(range(lo + 1e-6, lo + 15.0; length = n))
        elseif isfinite(hi)
            collect(range(hi - 15.0, hi - 1e-6; length = n))
        else
            collect(range(-10.0, 10.0; length = n))
        end
        return vcat(interior[1], interior, interior[end])
    end

    cases = [
        "Normal-Normal (analytic)" => difference(
            Normal(5.0, 1.0), Normal(2.0, 1.0)),
        "Gamma-Gamma (numeric)" => difference(
            Gamma(3.0, 1.0), Gamma(2.0, 1.0)),
        "LogNormal-Gamma (numeric)" => difference(
            LogNormal(0.5, 0.4), Gamma(2.0, 1.0)),
        "Uniform-Uniform (bounded, numeric)" => difference(
            Uniform(0.0, 1.0), Uniform(0.0, 2.0)),
        "Weibull-Normal (numeric)" => difference(
            Weibull(1.5, 2.0), Normal(1.0, 0.5)),
        "Difference of a Convolved minuend (deeper nesting)" => difference(
            convolved(Gamma(2.0, 1.0), Normal(1.0, 0.5)), LogNormal(0.3, 0.2))
    ]

    for (name, d) in cases
        @testset "$name" begin
            grid = consistency_grid(d)

            prev_cdf = -Inf
            for x in grid
                pdf_val = pdf(d, x)
                logpdf_val = logpdf(d, x)
                @test pdf_val >= 0.0
                if pdf_val > 0
                    @test logpdf_val≈log(pdf_val) rtol=1e-8
                else
                    @test logpdf_val == -Inf
                end

                cdf_val = cdf(d, x)
                logcdf_val = logcdf(d, x)
                if cdf_val > 0
                    @test logcdf_val≈log(cdf_val) atol=1e-8
                else
                    @test logcdf_val == -Inf
                end

                ccdf_val = ccdf(d, x)
                logccdf_val = logccdf(d, x)
                if ccdf_val > 0
                    @test logccdf_val≈log(ccdf_val) atol=1e-6
                else
                    @test logccdf_val == -Inf
                end

                @test cdf_val + ccdf_val≈1.0 atol=1e-8
                @test cdf_val >= prev_cdf - 1e-9
                prev_cdf = cdf_val
            end

            # Broadcast-batched evaluation must agree with the scalar path
            # point-by-point, including at the grid's own ends (mirrors the
            # same check for Convolved above). Difference has no dedicated
            # batched method the way Convolved does, so `pdf.(d, grid)`
            # goes through the ordinary scalar `pdf` per element rather
            # than a shared-quadrature-grid implementation; kept anyway as
            # a broadcast-dispatch regression guard, using the `.`-form so
            # it does not hit Distributions.jl's deprecated bare
            # `pdf(d, ::AbstractArray)` fallback.
            @test pdf.(d, grid) ≈ [pdf(d, x) for x in grid] atol=1e-8
            @test isapprox(logpdf.(d, grid), [logpdf(d, x) for x in grid];
                atol = 1e-6, rtol = 1e-4)
            @test cdf.(d, grid) ≈ [cdf(d, x) for x in grid] atol=1e-8
        end
    end
end

@testitem "Product log methods consistency across component families" begin
    using Distributions

    function consistency_grid(d; n = 12)
        lo, hi = minimum(d), maximum(d)
        interior = if isfinite(lo) && isfinite(hi)
            collect(range(lo + 1e-6, hi - 1e-6; length = n))
        elseif isfinite(lo)
            collect(range(lo + 1e-6, lo + 15.0; length = n))
        elseif isfinite(hi)
            collect(range(hi - 15.0, hi - 1e-6; length = n))
        else
            collect(range(-10.0, 10.0; length = n))
        end
        return vcat(interior[1], interior, interior[end])
    end

    # v1 scope: both Product components must have non-negative support.
    cases = [
        "LogNormal*LogNormal (analytic)" => product(
            LogNormal(0.5, 0.4), LogNormal(1.0, 0.3)),
        "Gamma*LogNormal (numeric)" => product(
            Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        "Uniform*Uniform (bounded, numeric)" => product(
            Uniform(0.5, 2.0), Uniform(0.5, 3.0)),
        "Weibull*Gamma (numeric)" => product(
            Weibull(1.5, 2.0), Gamma(2.0, 1.0)),
        "Product of a Convolved multiplier (deeper nesting)" => product(
            convolved(Gamma(2.0, 1.0), Uniform(0.0, 1.0)), LogNormal(0.3, 0.2))
    ]

    for (name, d) in cases
        @testset "$name" begin
            grid = consistency_grid(d)

            prev_cdf = -Inf
            for x in grid
                pdf_val = pdf(d, x)
                logpdf_val = logpdf(d, x)
                @test pdf_val >= 0.0
                if pdf_val > 0
                    @test logpdf_val≈log(pdf_val) rtol=1e-8
                else
                    @test logpdf_val == -Inf
                end

                cdf_val = cdf(d, x)
                logcdf_val = logcdf(d, x)
                if cdf_val > 0
                    @test logcdf_val≈log(cdf_val) atol=1e-8
                else
                    @test logcdf_val == -Inf
                end

                ccdf_val = ccdf(d, x)
                logccdf_val = logccdf(d, x)
                if ccdf_val > 0
                    @test logccdf_val≈log(ccdf_val) atol=1e-6
                else
                    @test logccdf_val == -Inf
                end

                @test cdf_val + ccdf_val≈1.0 atol=1e-8
                @test cdf_val >= prev_cdf - 1e-9
                prev_cdf = cdf_val
            end

            # Broadcast-batched evaluation must agree with the scalar path
            # point-by-point, including at the grid's own ends (mirrors the
            # same check for Convolved above). Product has no dedicated
            # batched method the way Convolved does, so `pdf.(d, grid)`
            # goes through the ordinary scalar `pdf` per element rather
            # than a shared-quadrature-grid implementation; kept anyway as
            # a broadcast-dispatch regression guard, using the `.`-form so
            # it does not hit Distributions.jl's deprecated bare
            # `pdf(d, ::AbstractArray)` fallback.
            @test pdf.(d, grid) ≈ [pdf(d, x) for x in grid] atol=1e-8
            @test isapprox(logpdf.(d, grid), [logpdf(d, x) for x in grid];
                atol = 1e-6, rtol = 1e-4)
            @test cdf.(d, grid) ≈ [cdf(d, x) for x in grid] atol=1e-8
        end
    end
end

@testitem "Ratio log methods consistency across component families" begin
    using Distributions

    function consistency_grid(d; n = 12)
        lo, hi = minimum(d), maximum(d)
        interior = if isfinite(lo) && isfinite(hi)
            collect(range(lo + 1e-6, hi - 1e-6; length = n))
        elseif isfinite(lo)
            collect(range(lo + 1e-6, lo + 15.0; length = n))
        elseif isfinite(hi)
            collect(range(hi - 15.0, hi - 1e-6; length = n))
        else
            collect(range(-10.0, 10.0; length = n))
        end
        return vcat(interior[1], interior, interior[end])
    end

    cases = [
        "Normal/Normal (analytic, sign-crossing)" => ratio(
            Normal(0.0, 2.0), Normal(0.0, 0.5)),
        "Gamma/Gamma (analytic)" => ratio(Gamma(2.0, 1.5), Gamma(3.0, 0.5)),
        "Gamma/LogNormal (numeric)" => ratio(
            Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        "LogNormal/Uniform(0, 2) (numeric, zero-touching denominator)" =>
            ratio(LogNormal(0.5, 0.4), Uniform(0.0, 2.0)),
        "Ratio of a Convolved numerator (deeper nesting)" => ratio(
            convolved(Gamma(2.0, 1.0), Uniform(0.0, 1.0)), Gamma(3.0, 1.0))
    ]

    for (name, d) in cases
        @testset "$name" begin
            grid = consistency_grid(d)

            prev_cdf = -Inf
            for x in grid
                pdf_val = pdf(d, x)
                logpdf_val = logpdf(d, x)
                @test pdf_val >= 0.0
                if pdf_val > 0
                    @test logpdf_val≈log(pdf_val) rtol=1e-8
                else
                    @test logpdf_val == -Inf
                end

                cdf_val = cdf(d, x)
                logcdf_val = logcdf(d, x)
                if cdf_val > 0
                    @test logcdf_val≈log(cdf_val) atol=1e-8
                else
                    @test logcdf_val == -Inf
                end

                ccdf_val = ccdf(d, x)
                logccdf_val = logccdf(d, x)
                if ccdf_val > 0
                    @test logccdf_val≈log(ccdf_val) atol=1e-6
                else
                    @test logccdf_val == -Inf
                end

                @test cdf_val + ccdf_val≈1.0 atol=1e-8
                @test cdf_val >= prev_cdf - 1e-9
                prev_cdf = cdf_val
            end

            # Broadcast-batched evaluation must agree with the scalar path
            # point-by-point, including at the grid's own ends (mirrors the
            # same check for Convolved above). Ratio has no dedicated
            # batched method the way Convolved does, so `pdf.(d, grid)`
            # goes through the ordinary scalar `pdf` per element rather
            # than a shared-quadrature-grid implementation; kept anyway as
            # a broadcast-dispatch regression guard, using the `.`-form so
            # it does not hit Distributions.jl's deprecated bare
            # `pdf(d, ::AbstractArray)` fallback.
            @test pdf.(d, grid) ≈ [pdf(d, x) for x in grid] atol=1e-8
            @test isapprox(logpdf.(d, grid), [logpdf(d, x) for x in grid];
                atol = 1e-6, rtol = 1e-4)
            @test cdf.(d, grid) ≈ [cdf(d, x) for x in grid] atol=1e-8
        end
    end
end

@testitem "Convolved wide-batch consistency at shared panel-grid edges" begin
    using Distributions

    # A wide batch whose ends sit at the edges of the shared composite
    # quadrature grid (see `_convolved_quadrature_composite` in
    # src/Convolved.jl) — the case discussed on #50/#49. Checked here as
    # a standing mutual-consistency sweep rather than a single pinned
    # value, so a regression on any point shows up, not just the one
    # historically measured.
    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    grid = collect(0.5:0.5:8.0)

    @test pdf(d, grid) ≈ [pdf(d, x) for x in grid] atol=1e-8
    @test isapprox(logpdf(d, grid), [logpdf(d, x) for x in grid];
        atol = 1e-6, rtol = 1e-6)
    @test cdf(d, grid) ≈ [cdf(d, x) for x in grid] atol=1e-8

    for x in grid
        pdf_val, logpdf_val = pdf(d, x), logpdf(d, x)
        @test logpdf_val≈log(pdf_val) rtol=1e-8

        cdf_val, ccdf_val = cdf(d, x), ccdf(d, x)
        @test cdf_val + ccdf_val≈1.0 atol=1e-8
        @test logcdf(d, x)≈log(cdf_val) atol=1e-8
    end
end

@testitem "Convolved/Difference/Product/Ratio consistency at quantile panel-boundary points (#49/#50)" begin
    using Distributions
    using ConvolvedDistributions: _PANEL_PROBS

    # The numeric quadrature splits its integration window at the
    # integration component's `_PANEL_PROBS` quantiles (issue #49); #50
    # was an incidental casualty of that panel-splitting fix rather than a
    # separate bug (see e976b7c, #75). A mismatched panel boundary would
    # first show up as an inconsistency exactly at (or either side of) a
    # break, which evenly-spaced grid points can miss by landing inside a
    # single panel instead — so these are targeted at the break points
    # themselves, computed from the actual integration ("panelled")
    # component rather than pinned by hand.

    cases = [
        ("Convolved", convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
            LogNormal(0.5, 0.4)),
        ("Difference", difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4)),
            LogNormal(0.5, 0.4)),
        ("Product", product(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
            LogNormal(0.5, 0.4)),
        ("Ratio", ratio(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
            LogNormal(0.5, 0.4))
    ]

    for (name, d, panel_comp) in cases
        @testset "$name" begin
            lo, hi = minimum(d), maximum(d)
            breaks = [Float64(quantile(panel_comp, p)) for p in _PANEL_PROBS]
            interior_breaks = filter(b -> lo < b < hi, breaks)
            # Sanity: the case is actually heavy-tailed enough to panel;
            # otherwise this test would silently check nothing.
            @test !isempty(interior_breaks)

            for b in interior_breaks
                for x in (b - 1e-6, b, b + 1e-6)
                    pdf_val, logpdf_val = pdf(d, x), logpdf(d, x)
                    if pdf_val > 0
                        @test logpdf_val≈log(pdf_val) rtol=1e-6
                    else
                        @test logpdf_val == -Inf
                    end

                    cdf_val, ccdf_val = cdf(d, x), ccdf(d, x)
                    @test cdf_val + ccdf_val≈1.0 atol=1e-8
                    if cdf_val > 0
                        @test logcdf(d, x)≈log(cdf_val) atol=1e-8
                    end
                end

                # Continuity across the break itself: the panel split is a
                # quadrature implementation detail and must not introduce a
                # visible jump in either the CDF or the density. `2e-6`
                # (not `1e-6`) because a genuinely smooth CDF already
                # changes by `pdf(d, b) * 2e-6` over this step, and the
                # Ratio case's density near its break points (~0.5-0.6)
                # pushes that product to ~1.2e-6 on its own -- a real
                # slope, not a jump.
                @test cdf(d, b - 1e-6)≈cdf(d, b + 1e-6) atol=2e-6
                @test isapprox(pdf(d, b - 1e-6), pdf(d, b + 1e-6);
                    atol = 1e-6, rtol = 1e-3)
            end
        end
    end
end

@testitem "Convolved/Difference/Product/Ratio log methods at out-of-support and extreme values" begin
    using Distributions

    # Mirrors CensoredDistributions' log-methods extreme-value coverage
    # (test/consistency/log_methods_consistency.jl), adapted for these
    # types: pdf is not bounded by 1 here (continuous, not interval
    # probabilities), so unlike that suite there is no `logpdf <= 0`
    # assertion — only that nothing returns NaN or errors.
    cases = [
        "Convolved: Gamma+LogNormal (numeric, half-line support)" => convolved(
            Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        "Convolved: Normal+Normal (analytic, full-line support)" => convolved(
            Normal(1.0, 2.0), Normal(-0.5, 1.5)),
        "Convolved: Uniform+Uniform (bounded support)" => convolved(
            Uniform(0.0, 2.0), Uniform(0.0, 3.0)),
        "Difference: Gamma-Gamma (numeric, full-line support)" => difference(
            Gamma(3.0, 1.0), Gamma(2.0, 1.0)),
        "Difference: Normal-Normal (analytic, full-line support)" => difference(
            Normal(5.0, 1.0), Normal(2.0, 1.0)),
        "Product: Gamma*LogNormal (numeric, half-line support)" => product(
            Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        "Product: LogNormal*LogNormal (analytic, half-line support)" => product(
            LogNormal(0.5, 0.4), LogNormal(1.0, 0.3)),
        "Ratio: Gamma/LogNormal (numeric, half-line support)" => ratio(
            Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
        "Ratio: Normal/Normal (analytic, full-line support)" => ratio(
            Normal(0.0, 2.0), Normal(0.0, 0.5))
    ]

    for (name, d) in cases
        @testset "$name" begin
            lo, hi = minimum(d), maximum(d)

            @testset "Just outside a finite bound" begin
                if isfinite(lo)
                    @test pdf(d, lo - 1.0) == 0.0
                    @test logpdf(d, lo - 1.0) == -Inf
                    @test cdf(d, lo - 1.0) == 0.0
                end
                if isfinite(hi)
                    @test pdf(d, hi + 1.0) == 0.0
                    @test logpdf(d, hi + 1.0) == -Inf
                    @test ccdf(d, hi + 1.0) == 0.0
                end
            end

            @testset "Extreme finite and infinite values" begin
                for x in (-1e10, 1e10, -Inf, Inf)
                    pdf_val, logpdf_val = pdf(d, x), logpdf(d, x)
                    cdf_val, logcdf_val = cdf(d, x), logcdf(d, x)

                    @test !isnan(pdf_val)
                    @test !isnan(logpdf_val)
                    @test !isnan(cdf_val)
                    @test !isnan(logcdf_val)
                    @test pdf_val >= 0.0
                    @test 0.0 <= cdf_val <= 1.0
                end
            end

            # NaN input is deliberately left unconstrained here, mirroring
            # CensoredDistributions' own log-methods suite (which guards
            # every extreme-value assertion with `if !isnan(x)` and never
            # asserts a value for `x = NaN` itself). This does differ by
            # path: the numeric path's `insupport` check (`<=` against NaN
            # is always false) reads NaN as out-of-support and returns
            # `-Inf`, while the analytic fast path (Normal+Normal, equal-
            # scale Gamma+Gamma, ...) delegates straight to the component
            # distribution's own `logpdf`, which propagates NaN unchanged
            # (ordinary Julia/Distributions.jl semantics, not a bug this
            # suite is scoped to change) — asserting either value here would
            # just be pinning one branch's incidental behaviour.
        end
    end
end

@testitem "Uniform-window analytic pdf/cdf are mutually consistent" begin
    using Distributions

    # The density is the derivative of the CDF, so this validates the
    # generic uniform-window density (S3.2) directly: `pdf` against a
    # central finite difference of `cdf`, and `cdf` against a Simpson's-
    # rule integral of `pdf`, across delay families and window widths
    # (including one no analytic cdf method covers, Normal, which still
    # gets the generic density).
    cases = [
        Gamma(2.0, 1.5) => Uniform(0.0, 2.0),
        LogNormal(1.5, 0.5) => Uniform(0.0, 3.0),
        Weibull(1.5, 2.0) => Uniform(0.0, 1.5),
        Normal(2.0, 1.0) => Uniform(-1.0, 1.0),
        Exponential(2.0) => Uniform(0.0, 2.0),
        Gamma(2.0, 1.5) => Uniform(0.0, 1e-3)
    ]

    # Composite Simpson's rule on an even number of panels.
    function simpson(f, lo, hi, n)
        n = iseven(n) ? n : n + 1
        h = (hi - lo) / n
        s = f(lo) + f(hi)
        for i in 1:(n - 1)
            s += (iseven(i) ? 2 : 4) * f(lo + i * h)
        end
        return s * h / 3
    end

    for (delay, primary) in cases
        d = convolved(delay, primary)
        lo = max(minimum(d), 0.0) + 0.5
        for x in (lo, lo + 1.0, lo + 3.0, lo + 8.0)
            h = 1e-5 * max(abs(x), 1.0)
            fd = (cdf(d, x + h) - cdf(d, x - h)) / (2h)
            @test pdf(d, x)≈fd rtol=1e-4 atol=1e-8

            integral = cdf(d, lo) + simpson(t -> pdf(d, t), lo, x, 2000)
            @test cdf(d, x)≈integral atol=1e-5
        end
    end
end
