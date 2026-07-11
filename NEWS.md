## 0.2.0

Breaking changes relative to 0.1.0, with migration notes:

- **`convolve_series` no longer discretises continuous delays.** A `DiscreteUnivariateDistribution` convolves via its own PMF (`pdf(delay, k)` at integer lags); a continuous delay throws. Migration: discretise explicitly — `convolve_series(discretise_pmf(delay, length(series) - 1), series)` for interval-censored-secondary masses (exact primary event), or build double-interval-censored masses with CensoredDistributions.jl's `convolve_series` extension when the primary event is only known to the day — then convolve the resulting PMF.
- **Family names.** `AbstractCombinedDistribution` is now `AbstractConvolvedDistribution`, and `TestUtils.test_combined_interface` is `test_convolved_interface`. Migration: rename references; behaviour is unchanged.

Additions and improvements:

- `product(x, y)` (public type `Product`) adds the Mellin convolution `Z = X * Y` for independent components with non-negative support: `LogNormal * LogNormal` closed form, AD-safe Mellin quadrature otherwise, exact independent-product moments, and `quantile` via the Optimization extension. Sign-crossing supports throw and are future work.
- `discretise_pmf(delay, maxlag; interval)` builds a reusable public `DelayPMF` (raw CDF-difference masses, clamped at zero, never renormalised) with `pdf(pmf, lag)` mass reads, and `convolve_series` accepts a `DelayPMF` or any raw PMF vector, with masses used exactly as given. A `DelayPMF` carries its grid width: the series is read at steps of `pmf.interval`, so weekly-binned masses convolve weekly series.
- Batched numeric `cdf`/`pdf`/`logpdf` now integrate every point over its own scalar-path window on a shared composite panel grid: batched and scalar log densities agree to well within `1e-8` (typically near machine precision; previously up to ~`2e-3` in wide-batch tails) while the batched path remains 1.6-2.2x faster than broadcasting (#29).
- The AD-safe component hooks `_cdf_ad_safe`, `_logcdf_ad_safe`, and `_pdf_ad_safe` are public, joining `_ccdf_ad_safe`/`_logccdf_ad_safe`, so wrapper packages can make their component types differentiable inside the quadrature.
- The extension `quantile` is now accurate in the far tails: the solve minimises the log-odds residual rather than the near-flat squared probability residual (relative error at `p = 0.999` down from ~0.16 to ~4e-6 on the analytic product pair) (#48).

## 0.1.0

Initial release. Raw-distribution convolution machinery for any `Distributions.jl` univariate distribution, split out of CensoredDistributions.jl:

- `convolved(dists...)` (public type `Convolved`): sums of independent components with analytic fast paths (`Normal`+`Normal`, equal-scale `Gamma`, equal-rate `Exponential`) and an AD-safe fixed-node Gauss-Legendre quadrature fallback; scalar and batched `cdf`/`pdf`/`logpdf`; exact additive moments.
- `difference(x, y)` (exported type `Difference`): the `Z = X - Y` dual with the `Normal`-`Normal` closed form and numeric cross-correlation.
- `convolve_series`: causal convolution of a numeric series with a delay PMF (the renewal-style observation layer).
- `quantile` for `Convolved`/`Difference` via the Optimization + OptimizationOptimJL extension.
- The `AbstractCombinedDistribution` family supertype with shipped `TestUtils` interface verifiers.
- AD extensions (ChainRulesCore, ForwardDiff, ReverseDiff, Mooncake, Enzyme) with analytic gamma-CDF rules; gradients tested on all backends in CI.

This file tracks notes for major releases and significant milestones; GitHub
Releases (auto-generated from merged PRs) cover every release in between.
