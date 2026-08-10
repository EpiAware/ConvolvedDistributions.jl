module ConvolvedDistributionsMooncakeExt

using ConvolvedDistributions: _window_quantile, _lattice_quantile,
                              AbstractSolverMethod, _resolve_closed_form
using Distributions: UnivariateDistribution
using Mooncake: Mooncake

# `_window_quantile(comp, p)` returns a quadrature-window endpoint: an
# extreme quantile of an integration component used only to clamp an
# infinite bound to a finite one. It is computed on AD-stripped (primal)
# parameters, so the window is a non-differentiated hyperparameter (just
# where to integrate), not a quantity carrying gradient. The
# `ChainRulesCore.@non_differentiable` mark in
# `ConvolvedDistributionsChainRulesCoreExt` covers reverse-mode AD
# generally, but Mooncake does not lift that mark automatically: without
# an explicit rule Mooncake traces `quantile` (e.g. `gamma_inc_inv` for a
# `Gamma` component) and returns a `NaN` shape derivative. Both modes need
# shielding, so `@zero_derivative` (no mode argument: covers both
# ForwardMode and ReverseMode) registers the primitive and generates a
# zero `frule!!` and a zero `rrule!!`, each returning the correct zero
# tangent/rdata for its argument types (a hand-written `NoRData` would be
# wrong for the distribution argument, whose rdata is a `NamedTuple` of
# its parameters). `@zero_adjoint` would cover reverse only, leaving a
# forward `Difference` whose subtrahend is the differentiated,
# unbounded-above integration component (its upper window bound is always
# a quantile of that component) returning a `NaN` on Mooncake forward.
# This also hardens the `Convolved` numeric path. The gamma-CDF
# `@from_chainrules` lift that used to live here now ships in
# EpiAwareADTools' Mooncake extension.
Mooncake.@zero_derivative Mooncake.DefaultCtx Tuple{
    typeof(_window_quantile), UnivariateDistribution, Real}

# `_lattice_quantile` returns an `Int` lattice point via a summation
# scan: a step function computed on AD-stripped (primal) bounds, so it
# needs the same shield as `_window_quantile` above, for the same
# reason (Mooncake does not lift the ChainRulesCore mark). The first
# argument is untyped in its declaration (`Convolved`/`Difference`/
# `Product` share one method), so the registered tuple type is `Any`.
Mooncake.@zero_derivative Mooncake.DefaultCtx Tuple{
    typeof(_lattice_quantile), Any, Real}

# `_resolve_closed_form(components, method)` answers, once at
# construction, which quantities resolve to a closed form for
# `components`. It probes method availability with `which()` (a pure
# dispatch-metadata lookup), and the resulting flags are constant w.r.t.
# the component parameters — but a `convolved(...)` built inside a
# differentiated function would otherwise be traced through `which()`'s
# `invoke_default_compiler` foreigncall, which Mooncake cannot rrule.
# Mark it zero-derivative so construction stays off the tape.
Mooncake.@zero_derivative Mooncake.DefaultCtx Tuple{
    typeof(_resolve_closed_form), Tuple, AbstractSolverMethod}

end
