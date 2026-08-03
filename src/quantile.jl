# Public entry point for the shared numeric quantile (inverse-CDF)
# inversion. `Convolved`/`Difference`/`Product` have no closed-form
# quantile in general, so their `Distributions.quantile` methods invert
# `cdf` numerically; other EpiAware packages facing the same problem
# (e.g. CensoredDistributions' `PrimaryCensored`/`IntervalCensored`) can
# reuse the same solve instead of each carrying their own copy (#112).
#
# The stub is declared here so the name is public and documented from
# the core package, but the method itself -- and the Optimization.jl /
# OptimizationOptimJL.jl dependency it needs -- lives in
# ConvolvedDistributionsOptimizationExt, keeping the core package
# dependency-light. Loading both trigger packages loads the extension,
# which adds the method.

@doc "

Numerically invert `cdf(d, ·) = p` for the quantile of `d` at `p`.

No closed form is assumed for `d`: the quantile is found by minimising a
clamped-logit-transformed residual between `cdf(d, q)` and `p` with a
Nelder-Mead solve, started from the caller-supplied `initial_guess`. The
logit transform keeps the objective steep in the far tails, where a
plain squared residual on `cdf` is nearly flat in `q` and lets the
solve stop early (issue #48).

# Arguments
- `d`: The distribution to invert.
- `p`: The target probability; must lie in `[0, 1]`.
- `initial_guess`: A length-1 vector giving the Nelder-Mead starting
  point.

# Keyword Arguments
- `postprocess`: Applied to the solved quantile before it is returned
  (e.g. to snap it onto a discrete grid). Defaults to `identity`.
- `check_nan`: Reject a `NaN` `p` with an `ArgumentError` when `true`
  (the default).

# Returns
- The quantile `q` such that `cdf(d, q) ≈ p`, after `postprocess`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

# Examples
```@example
using ConvolvedDistributions, Distributions
using Optimization, OptimizationOptimJL

d = Normal(0.0, 1.0)
ConvolvedDistributions.quantile_by_optimization(d, 0.5, [0.0])
```

See also: [`cdf`](@ref)
"
function quantile_by_optimization end
