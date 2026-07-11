module ConvolvedDistributionsChainRulesCoreExt

using ConvolvedDistributions: _window_quantile
using ChainRulesCore: ChainRulesCore

# The quadrature-window endpoint is a non-differentiable hyperparameter
# (just *where* to integrate), so the window-quantile call carries no
# gradient. Marking it `@non_differentiable` keeps reverse-mode AD — and
# Mooncake, which lifts ChainRules rules — off `quantile`'s
# `gamma_inc_inv` path for a `Gamma` integration component. The tape-strip
# `primal` inside `_window_quantile` carries the matching mark in
# EpiAwareADTools' ChainRulesCore extension, alongside the gamma-CDF
# rrule/frule that used to live here.
ChainRulesCore.@non_differentiable _window_quantile(::Any, ::Any)

end
