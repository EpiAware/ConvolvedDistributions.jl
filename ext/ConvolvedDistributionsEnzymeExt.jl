module ConvolvedDistributionsEnzymeExt

using ConvolvedDistributions: _window_quantile
using Enzyme: Enzyme
using Enzyme.EnzymeRules: EnzymeRules

# `_window_quantile(comp, p)` returns a quadrature-window endpoint — the
# *location* at which to clamp an infinite integration limit
# (`_finite_window` in `src/Convolved.jl`). It is a non-differentiable
# hyperparameter of the quadrature (like the node count), so it is marked
# `EnzymeRules.inactive`: Enzyme runs the primal unchanged and treats the
# returned endpoint as a constant, contributing no tangent / no cotangent in
# either mode. Crucially this stops Enzyme tracing into the function at all, so
# it never reaches `quantile(::Gamma)` →
# `SpecialFunctions.gamma_inc_inv_qsmall`, which it cannot differentiate
# (`IllegalTypeAnalysisException`). `inactive` covers every activity /
# batch-width / mode permutation uniformly. Other backends get the same
# treatment via the ChainRules `@non_differentiable` mark on
# `_window_quantile` (this package) and on EpiAwareADTools' `primal`, plus
# the Mooncake `@zero_derivative` rule in the Mooncake extension. The
# gamma-CDF Enzyme rules that used to live here now ship in
# EpiAwareADTools' Enzyme extension.
EnzymeRules.inactive(::typeof(_window_quantile), args...) = nothing

end
