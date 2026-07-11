"""
    ADFixtures

Shared AD gradient scenarios and backend metadata for ConvolvedDistributions.
Used by `test/ad/runtests.jl`. Covers the `Convolved` and `Difference`
densities and moments on both the analytic and numeric (Gauss-Legendre
quadrature) paths, across the ForwardDiff / ReverseDiff / Enzyme / Mooncake
backend matrix.

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
using Distributions: Distributions, Gamma, LogNormal, Normal, mean, var, logpdf
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

    # Timeseries convolution: the series pushed through the discretised
    # delay PMF (`convolve_series(delay, series)`). The masses are
    # AD-safe CDF differences, so the gradient flows through the delay
    # parameters via `_delay_pmf`; the linear causal convolution carries
    # them through. The Gamma delay hits the `_gamma_cdf` AD-safe path,
    # the Convolved delay the numeric quadrature CDF.
    series = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
    _push!("Timeseries convolve Gamma delay",
        (θ, s) -> sum(convolve_series(Gamma(θ[1], θ[2]), s)),
        [2.0, 1.0], (Constant(series),))
    _push!("Timeseries convolve Convolved Gamma+LogNormal delay",
        (θ, s) -> sum(convolve_series(
            convolved(
                Gamma(θ[1], θ[2]), LogNormal(θ[3], θ[4])), s)),
        [2.0, 1.0, 0.5, 0.4], (Constant(series),))
    # Build-once DelayPMF: the gradient flows through the
    # `discretise_pmf` interval masses and the linear reuse path, so
    # the prebuilt surface matches the rebuild-every-time path above.
    _push!("Timeseries convolve prebuilt Gamma DelayPMF",
        (θ, s) -> sum(convolve_series(
            discretise_pmf(Gamma(θ[1], θ[2]), length(s) - 1), s)),
        [2.0, 1.0], (Constant(series),))

    return out
end

end # module ADFixtures
