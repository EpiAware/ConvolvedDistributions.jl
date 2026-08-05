"""
    ADFixtures

Shared AD gradient scenarios and backend metadata for ConvolvedDistributions.
Used by `test/ad/runtests.jl`. Covers the `Convolved`, `Difference`,
`Product`, and `Ratio` densities and moments on the analytic, numeric
(Gauss-Legendre quadrature), and exact discrete lattice/divisor fold
(#85, #89) paths, across the ForwardDiff / ReverseDiff / Enzyme /
Mooncake backend matrix.

The reference gradient is computed with `ForwardDiff`. It propagates its
Dual numbers through the package's own densities and matches the reverse
backends (ReverseDiff, Mooncake reverse, Enzyme reverse) to ~1e-6.
"""
module ADFixtures

# `__precompile__(false)` skips the precompile cache so the Mooncake / Enzyme
# load chain does not break the package build on CI. Negligible cost — this
# module is only loaded by the AD test.
__precompile__(false)

using ConvolvedDistributions
using ConvolvedDistributions: pgf
using Distributions: Distributions, Gamma, Geometric, LogNormal,
                     NegativeBinomial, Normal, Poisson, Uniform, Weibull,
                     mean, var, pdf, logpdf, cdf, logcdf
using ADTypes: ADTypes, AutoForwardDiff, AutoReverseDiff, AutoMooncake,
               AutoMooncakeForward, AutoEnzyme
using DifferentiationInterface: DifferentiationInterface, Constant
import DifferentiationInterfaceTest as DIT
import ForwardDiff, ReverseDiff, Mooncake, Enzyme

export scenarios, backends, broken_scenario_names,
       backend_broken_scenarios, backend_skip_scenarios

# `contexts` is a tuple of `Constant`-wrapped data passed positionally to DI's
# `gradient` and to the differentiated function.
function _reference(f, θ, contexts)
    return DifferentiationInterface.gradient(
        f, AutoForwardDiff(), θ, contexts...)
end

"""
    backends()

AD backends tested, as `(; name, backend)` named tuples. The `name` is what
`test/ad/scenarios.jl` selects by tag.
"""
function backends()
    return [
        (name = "ForwardDiff", backend = AutoForwardDiff()),
        (name = "ReverseDiff (tape)",
            backend = AutoReverseDiff(compile = false)),
        (name = "Mooncake reverse",
            backend = AutoMooncake(config = nothing)),
        (name = "Mooncake forward", backend = AutoMooncakeForward()),
        (name = "Enzyme reverse",
            backend = AutoEnzyme(
                mode = Enzyme.set_runtime_activity(Enzyme.Reverse))),
        (name = "Enzyme forward",
            backend = AutoEnzyme(
                mode = Enzyme.set_runtime_activity(Enzyme.Forward)))
    ]
end

"Scenario names broken on every backend."
broken_scenario_names() = String[]

"Per-backend broken scenario names (`Dict{String, Set{String}}`)."
backend_broken_scenarios() = Dict{String, Set{String}}()

"Per-backend scenario names too unstable to run at all."
backend_skip_scenarios() = Dict{String, Set{String}}()

"""
    scenarios(; with_reference::Bool = false, category::Symbol = :marginal)

The AD gradient scenarios. Each is a `DIT.Scenario{:gradient, :out}` whose
`res1` carries a ForwardDiff reference when `with_reference = true`. All
scenarios sit in one group, so `category` is accepted for the harness contract
but unused.
"""
function scenarios(; with_reference::Bool = false, category::Symbol = :marginal)
    obs = [0.5, 1.2, 2.5, 3.8, 5.1]

    out = DIT.Scenario{:gradient, :out}[]

    function _push!(name, f, θ₀, contexts)
        res1 = with_reference ? _reference(f, θ₀, contexts) : nothing
        prep_args = (; x = θ₀, contexts = contexts)
        push!(out,
            res1 === nothing ?
            DIT.Scenario{:gradient, :out}(
                f, θ₀, contexts...; prep_args = prep_args, name = name) :
            DIT.Scenario{:gradient, :out}(
                f, θ₀, contexts...;
                res1 = res1, prep_args = prep_args, name = name))
    end

    # Convolved (sum of independent delays). The analytic Normal+Normal pair
    # differentiates through `Distributions.convolve`; the Gamma+LogNormal pair
    # has no analytic convolution and exercises the AD-safe numeric quadrature
    # path. Literal constructors keep Enzyme forward working.
    _push!("Convolved Normal+Normal analytical",
        (θ, obs) -> sum(
            x -> logpdf(convolved(
                    Normal(θ[1], θ[2]), Normal(0.0, 1.0)), x), obs),
        [1.0, 2.0], (Constant(obs),))
    _push!("Convolved Gamma+LogNormal numerical",
        (θ, obs) -> sum(
            x -> logpdf(convolved(
                    Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4)), x), obs),
        [2.0, 1.0], (Constant(obs),))
    # Gamma as the INTEGRATION (last) component. The numeric quadrature clamps
    # the infinite window with a quantile of the last component; a trailing
    # `Gamma` would route that quantile through `gamma_inc_inv`, which Enzyme
    # cannot differentiate. `_finite_window` computes the endpoint on
    # AD-stripped params, so the bound is a non-differentiated constant and
    # every backend differentiates the logpdf. The differentiated parameters
    # are on the trailing Gamma so the gradient flows through the integration
    # component, not just `rest`.
    _push!("Convolved LogNormal+Gamma numerical",
        (θ, obs) -> sum(
            x -> logpdf(convolved(
                    LogNormal(0.5, 0.4), Gamma(θ[1], θ[2])), x), obs),
        [2.0, 1.0], (Constant(obs),))
    # Batched vector logpdf (issues #43/#44): one composite-quadrature
    # solve for the whole batch, differentiated through the VECTOR
    # method rather than a scalar sum. W.r.t. parameters the final
    # clamp/convert must promote with the quadrature result type (#43);
    # w.r.t. the evaluation points the accumulator must not mutate
    # tracked storage (#44).
    _push!("Convolved Gamma+LogNormal batched logpdf wrt params",
        (θ, obs) -> sum(logpdf(convolved(
                Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4)), obs)),
        [2.0, 1.0], (Constant(obs),))
    _push!("Convolved Gamma+LogNormal batched logpdf wrt points",
        (x, _obs) -> sum(logpdf(convolved(
                Gamma(2.0, 1.0), LogNormal(0.5, 0.4)), x)),
        copy(obs), (Constant(obs),))
    # Convolved analytic moments: mean/var are the sums of the component
    # moments, so the gradient flows through each component's closed-form
    # `mean`/`var`. The `obs` context is unused but keeps the scenario shape
    # uniform.
    _push!("Convolved Gamma+Normal mean+var moments",
        (θ, _obs) -> let d = convolved(
                Gamma(θ[1], θ[2]), Normal(θ[3], θ[4]))
            mean(d) + var(d)
        end,
        [2.0, 1.5, -0.5, 0.8], (Constant(obs),))

    # Uniform-window closed form (#77): `AnalyticalSolver` is the default,
    # so these exercise the `convolved_cdf`/`convolved_pdf`/
    # `convolved_logpdf` methods in src/uniform_window.jl (Gamma/
    # LogNormal/Weibull + Uniform for cdf; any delay + Uniform for
    # pdf/logpdf).
    cdf_obs = [0.5, 1.5, 3.0]
    _push!("Convolved Gamma+Uniform closed-form logcdf",
        (θ, xs) -> sum(
            x -> logcdf(
                convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), x),
            xs),
        [2.0, 1.5], (Constant(cdf_obs),))
    _push!("Convolved LogNormal+Uniform closed-form logcdf",
        (θ, xs) -> sum(
            x -> logcdf(
                convolved(LogNormal(θ[1], θ[2]), Uniform(0.0, 3.0)), x),
            xs),
        [1.5, 0.5], (Constant(cdf_obs),))
    _push!("Convolved Weibull+Uniform closed-form logcdf",
        (θ, xs) -> sum(
            x -> logcdf(
                convolved(Weibull(θ[1], θ[2]), Uniform(0.0, 1.5)), x),
            xs),
        [1.5, 2.0], (Constant(cdf_obs),))
    # Batched cdf through the same closed form (scalar and batched paths
    # are separate `cdf` methods -- see src/Convolved.jl -- so both need
    # a differentiated check).
    _push!("Convolved Gamma+Uniform closed-form batched cdf",
        (θ, xs) -> sum(
            cdf(convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), xs)),
        [2.0, 1.5], (Constant(cdf_obs),))
    # The generic uniform-window density (S3.2): `convolved_pdf`/
    # `convolved_logpdf` dispatch on any delay + `Uniform`, not just the
    # three CDF families. Gamma+Uniform exercises the
    # cancellation-guarded density; Normal+Uniform (no cdf closed form)
    # exercises the density on a pair outside `_WINDOW_DELAY`.
    _push!("Convolved Gamma+Uniform closed-form logpdf",
        (θ, xs) -> sum(
            x -> logpdf(
                convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 2.0)), x),
            xs),
        [2.0, 1.5], (Constant(cdf_obs),))
    _push!("Convolved Normal+Uniform closed-form pdf",
        (θ, xs) -> sum(
            x -> pdf(
                convolved(Normal(θ[1], θ[2]), Uniform(0.0, 2.0)), x),
            xs),
        [1.0, 0.5], (Constant(cdf_obs),))

    # Difference (Z = X - Y), the dual of Convolved. The analytic Normal-Normal
    # pair differentiates through the closed-form difference; the
    # Gamma-LogNormal pairs exercise the numeric cross-correlation quadrature.
    # Two pairs cover gradients through the minuend X and the subtrahend Y:
    # when Y is the unbounded-above integration factor the upper quadrature
    # window is a quantile of the differentiated component, so the window-clamp
    # must stay off the AD path (`_window_quantile` shields).
    _push!("Difference Normal-Normal analytical",
        (θ, obs) -> sum(
            z -> logpdf(difference(
                    Normal(θ[1], θ[2]), Normal(0.0, 1.0)), z), obs),
        [1.0, 2.0], (Constant(obs),))
    _push!("Difference Gamma-LogNormal numerical wrt X",
        (θ, obs) -> sum(
            z -> logpdf(difference(
                    Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4)), z), obs),
        [3.0, 1.0], (Constant(obs),))
    _push!("Difference LogNormal-Gamma numerical wrt Y",
        (θ, obs) -> sum(
            z -> logpdf(difference(
                    LogNormal(0.5, 0.4), Gamma(θ[1], θ[2])), z), obs),
        [3.0, 1.0], (Constant(obs),))
    _push!("Difference Gamma-Normal mean+var moments",
        (θ, _obs) -> let d = difference(
                Gamma(θ[1], θ[2]), Normal(θ[3], θ[4]))
            mean(d) + var(d)
        end,
        [3.0, 1.5, 2.0, 0.5], (Constant(obs),))

    # Product (Z = X * Y), the Mellin-convolution member (non-negative
    # supports). The analytic LogNormal*LogNormal pair differentiates
    # through the closed-form product; the Gamma/LogNormal pairs exercise
    # the numeric Mellin quadrature. Two pairs cover gradients through
    # the multiplicand X and the multiplier Y: Y is the integration
    # component, whose zero lower support end and unbounded upper end are
    # both clamped to extreme quantiles of the differentiated component,
    # so the window clamp must stay off the AD path (`_window_quantile`
    # shields, as for Difference).
    _push!("Product LogNormal*LogNormal analytical",
        (θ, obs) -> sum(
            z -> logpdf(product(
                    LogNormal(θ[1], θ[2]), LogNormal(0.5, 0.4)), z), obs),
        [1.0, 0.3], (Constant(obs),))
    _push!("Product Gamma*LogNormal numerical wrt X",
        (θ, obs) -> sum(
            z -> logpdf(product(
                    Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4)), z), obs),
        [3.0, 1.0], (Constant(obs),))
    _push!("Product LogNormal*Gamma numerical wrt Y",
        (θ, obs) -> sum(
            z -> logpdf(product(
                    LogNormal(0.5, 0.4), Gamma(θ[1], θ[2])), z), obs),
        [3.0, 1.0], (Constant(obs),))
    _push!("Product Gamma*LogNormal mean+var moments",
        (θ, _obs) -> let d = product(
                Gamma(θ[1], θ[2]), LogNormal(θ[3], θ[4]))
            mean(d) + var(d)
        end,
        [3.0, 1.5, 0.5, 0.4], (Constant(obs),))

    # Exact discrete lattice fold (#85, #89): integer observation points
    # select the lattice route rather than quadrature. Poisson+Geometric
    # has no registered analytic pair, so it exercises the lattice fold
    # with a gradient in the Poisson rate (the differentiated
    # parameter); Geometric stays fixed so the scenario has one free
    # parameter, matching the analytical scenario's shape.
    obs_discrete = [0.0, 1.0, 2.0, 3.0, 4.0]
    _push!("Convolved Poisson+Geometric lattice",
        (θ, ks) -> sum(
            k -> logpdf(convolved(Poisson(θ[1]), Geometric(0.3)), k), ks),
        [2.0], (Constant(obs_discrete),))
    # The #85 object itself: NegativeBinomial+Poisson, both differentiated
    # (one parameter per component), on the lattice route.
    _push!("Convolved NegativeBinomial+Poisson lattice (#85)",
        (θ, ks) -> sum(
            k -> logpdf(
                convolved(NegativeBinomial(5.0, θ[1]), Poisson(θ[2])), k),
            ks),
        [0.5, 2.0], (Constant(obs_discrete),))
    # Poisson+Poisson is newly analytic (#89): the closed-form Poisson
    # convolution differentiates through both rates.
    _push!("Convolved Poisson+Poisson analytical (#89)",
        (θ, ks) -> sum(
            k -> logpdf(convolved(Poisson(θ[1]), Poisson(θ[2])), k), ks),
        [2.0, 1.5], (Constant(obs_discrete),))
    # Difference and Product also route a fully-discrete pair to their own
    # exact lattice fold (`_difference_lattice_pdf`/`_product_lattice_pdf`),
    # gated behind the SAME `float(...)` guard on `_difference_window`/
    # `_product_mass_window` that keeps the `_min2`/`_max2` union
    # type-stable for Enzyme. Poisson-Geometric/Poisson*Poisson have no
    # analytic pair for either family, so both land on the lattice route.
    _push!("Difference Poisson-Geometric lattice",
        (θ, ks) -> sum(
            k -> logpdf(difference(Poisson(θ[1]), Geometric(0.3)), k), ks),
        [2.0], (Constant(obs_discrete),))
    _push!("Product Poisson*Poisson lattice",
        (θ, ks) -> sum(
            k -> logpdf(product(Poisson(θ[1]), Poisson(θ[2])), k), ks),
        [2.0, 1.5], (Constant(obs_discrete),))

    # Mixed discrete/continuous fold (#115): exactly one component
    # (Poisson) is integer-lattice discrete, the other (Normal)
    # genuinely continuous, so the combination is typed `Continuous`
    # (`_component_support`) but folds exactly by summing the Normal
    # density over the Poisson's own lattice rather than falling into
    # quadrature over a comb of point masses. Both the discrete rate and
    # a continuous parameter are differentiated: the rate flows through
    # the summed pmf weights, the mean through the pointwise Normal
    # density each weight multiplies.
    _push!("Convolved Poisson+Normal mixed fold (#115)",
        (θ, xs) -> sum(
            x -> logpdf(convolved(Poisson(θ[1]), Normal(θ[2], 1.0)), x), xs),
        [3.0, 0.0], (Constant(obs),))

    # Ratio (Z = X / Y), the quotient member. The analytic zero-mean
    # Normal/Normal pair differentiates the two scales through the
    # closed-form Cauchy; the Gamma/LogNormal pairs exercise the numeric
    # branch-split quadrature. Two pairs cover gradients through the
    # numerator X and the denominator Y: Y is the integration component
    # (the `_panel_integrate` calls in src/Ratio.jl all integrate over
    # `d.y`), whose window narrowing against X's effective support and
    # own quantile-panel breaks must stay off the AD path
    # (`_window_quantile` shields, as for Difference/Product).
    _push!("Ratio Normal/Normal analytical",
        (θ, obs) -> sum(
            z -> logpdf(ratio(
                    Normal(0.0, θ[1]), Normal(0.0, θ[2])), z), obs),
        [2.0, 0.5], (Constant(obs),))
    _push!("Ratio Gamma/LogNormal numerical wrt X",
        (θ, obs) -> sum(
            z -> logpdf(ratio(
                    Gamma(θ[1], θ[2]), LogNormal(0.5, 0.4)), z), obs),
        [3.0, 1.0], (Constant(obs),))
    _push!("Ratio LogNormal/Gamma numerical wrt Y",
        (θ, obs) -> sum(
            z -> logpdf(ratio(
                    LogNormal(0.5, 0.4), Gamma(θ[1], θ[2])), z), obs),
        [3.0, 1.0], (Constant(obs),))
    _push!("Ratio Gamma/Gamma analytic moments",
        (θ, _obs) -> let d = ratio(
                Gamma(θ[1], θ[2]), Gamma(θ[3], θ[4]))
            mean(d) + var(d)
        end,
        [2.0, 1.5, 3.0, 0.5], (Constant(obs),))

    # Timeseries convolution. This package no longer discretises
    # continuous delays itself (#68 — CensoredDistributions.jl owns that),
    # so only the discrete direct-PMF path remains in scope here; the
    # `cdf_ad_safe` machinery a caller-owned discretisation would use is
    # already covered by the Convolved/Difference/Product fixtures above.
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    # Discrete delay: the direct-PMF path reads `pdf(delay, k)` off the
    # integer grid. `pdf(::Poisson, k)` differentiates cleanly on every
    # backend (checked: ForwardDiff / ReverseDiff / Mooncake / Enzyme all
    # agree), so the discrete surface differentiates w.r.t. the rate.
    _push!("Timeseries convolve discrete Poisson delay",
        (θ, s) -> sum(convolve_series(Poisson(θ[1]), s)),
        [2.0], (Constant(series),))
    # Time-varying delays (#126): one PMF per time point, covering both
    # `:primary` (scatter) and `:secondary` (gather).
    _push!("Timeseries convolve time-varying Poisson delays",
        (θ, s) -> sum(convolve_series(
            [Poisson(θ[1] + θ[2] * (t - 1)) for t in 1:length(s)], s)),
        [2.0, 0.25], (Constant(series),))
    _push!("Timeseries convolve time-varying PMF matrix",
        (θ, s) -> sum(convolve_series(
            θ[1] .* repeat([0.5, 0.3, 0.2], 1, length(s)), s;
            indexed_by = :secondary)),
        [1.0], (Constant(series),))

    # pgf primitive (#90): the closed-form Poisson pgf differentiated
    # w.r.t. its rate parameter, exp(λ(s-1)), gradient (s-1)exp(λ(s-1)).
    # The `obs` context is unused but keeps the scenario shape uniform.
    _push!("pgf Poisson closed form wrt rate",
        (θ, _obs) -> pgf(Poisson(θ[1]), 0.6),
        [2.0], (Constant(obs),))

    return out
end

end # module ADFixtures
