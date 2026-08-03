## Unreleased

### `quantile_by_optimization`: shared numeric quantile inversion

Added the public (not exported) `quantile_by_optimization` function
(#112): a caller-supplied initial guess, a clamped-logit-residual
Nelder-Mead solve, `postprocess` and `check_nan` keywords. The stub
lives in the core package; the method is added by the
`ConvolvedDistributionsOptimizationExt` extension, so no solver
dependency is pulled unless it is loaded.

`Convolved`, `Difference`, and `Product`'s `Distributions.quantile`
methods now call it directly, with the same behaviour as before. Other
EpiAware packages inverting a `cdf` with no closed form (e.g.
CensoredDistributions' `PrimaryCensored`/`IntervalCensored`) can reuse
this instead of carrying their own copy of the same solve.

This file tracks notes for major releases and significant milestones;
GitHub Releases (auto-generated from merged PRs) cover every release in
between.
