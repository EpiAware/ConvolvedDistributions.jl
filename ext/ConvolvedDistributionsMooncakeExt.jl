module ConvolvedDistributionsMooncakeExt

using ConvolvedDistributions: _gamma_cdf, _window_quantile
using Distributions: UnivariateDistribution
using Mooncake: Mooncake

# Lifts the `ChainRulesCore.rrule` and `ChainRulesCore.frule` defined in
# `ConvolvedDistributionsChainRulesCoreExt` into Mooncake's rule registry
# (default mode generates both reverse `rrule!!` and forward `frule!!`)
# for every scalar `Real` triple, so callers that pass mixed concrete
# types (e.g. `_gamma_cdf(k + 1, θ, t)`, a `Float32` parameter, or
# `BigFloat` for higher-precision testing) hit the explicit rule rather
# than falling back to Mooncake tracing the function body. The forward
# `frule` is what closes the gap: without it the generated `frule!!` calls
# `ChainRulesCore.frule`, gets `nothing`, and errors with
# `iterate(::Nothing)`.
Mooncake.@from_chainrules Mooncake.DefaultCtx Tuple{typeof(_gamma_cdf), Real, Real, Real}

# `_window_quantile(comp, p)` returns a quadrature-window endpoint: an extreme
# quantile of an integration component used only to clamp an infinite bound to a
# finite one. It is computed on AD-stripped (primal) parameters, so the window is
# a non-differentiated hyperparameter (just where to integrate), not a quantity
# carrying gradient. The `ChainRulesCore.@non_differentiable` mark in
# `ConvolvedDistributionsChainRulesCoreExt` covers reverse-mode AD generally, but
# Mooncake does not lift that mark automatically: without an explicit rule
# Mooncake traces `quantile` (e.g. `gamma_inc_inv` for a `Gamma` component) and
# returns a `NaN` shape derivative. Both modes need shielding, so
# `@zero_derivative` (no mode argument: covers both ForwardMode and ReverseMode)
# registers the primitive and generates a zero `frule!!` and a zero `rrule!!`,
# each returning the correct zero tangent/rdata for its argument types (a
# hand-written `NoRData` would be wrong for the distribution argument, whose
# rdata is a `NamedTuple` of its parameters). `@zero_adjoint` would cover reverse
# only, leaving a forward `Difference` whose subtrahend is the differentiated,
# unbounded-above integration component (its upper window bound is always a
# quantile of that component) returning a `NaN` on Mooncake forward. This also
# hardens the `Convolved` numeric path.
Mooncake.@zero_derivative Mooncake.DefaultCtx Tuple{
    typeof(_window_quantile), UnivariateDistribution, Real}

end
