## Unreleased

### Breaking changes

- **Value support is derived from the components, not hardcoded.**
  `Convolved`, `Difference`, and `Product` used to advertise
  `Continuous` unconditionally, mistyping `discrete ⊛ discrete` and
  silently zeroing its density under Gauss-Legendre quadrature
  ([#85](https://github.com/EpiAware/ConvolvedDistributions.jl/issues/85)).
  `value_support` is now `Discrete` when every component is an
  integer-lattice discrete distribution (discrete with `eltype <:
  Integer`), `Continuous` otherwise. A discrete component on a
  non-integer grid (e.g. `DiscreteNonParametric` on halves) still gets
  `Continuous`: no exact route can evaluate it yet (follow-up issue).
  `insupport` on a discrete combination now rejects off-lattice points
  (`insupport(convolved(Poisson(2.0), Poisson(3.0)), 2.5)` is `false`).
  `Convolved{C, M}` is now `Convolved{C, M, S}` (and similarly for
  `Difference`/`Product`): the new value-support type parameter `S` is
  appended last, so every existing partial spelling (`Convolved{C}` in
  `Base.eltype`, `Difference{X, Y}` in ComposedDistributions.jl's codec
  generator) keeps matching.
- **Exact evaluation for all-discrete-integer combinations.** `pdf`,
  `logpdf`, `cdf`, and `logcdf` on a discrete-typed `Convolved` or
  `Difference` now use an exact integer-lattice fold, and a discrete
  `Product` an exact divisor fold (pmf) / conditioning sum (cdf),
  replacing quadrature — `pdf(convolved(NegativeBinomial(5, 0.5),
  Poisson(2.0)), 3)` stops being `0.0` and becomes the exact mass. Both
  routes are exact (see `is_exact` below); an unbounded component's
  window is still clamped at the same `~1e-8`-of-mass quantile the
  continuous quadrature paths already use. `Poisson`+`Poisson`,
  equal-success-probability `Binomial` pairs, and
  equal-success-probability `NegativeBinomial` pairs are now registered
  as analytic closed forms.
- **`convolve_series`'s continuous-only gate is removed.** The eager
  `ArgumentError` method for a `ContinuousUnivariateDistribution` delay
  is gone
  ([#95](https://github.com/EpiAware/ConvolvedDistributions.jl/issues/95)):
  a continuous delay now matches no `convolve_series` method at all, so
  `convolve_series(a_continuous_delay, series)` is a `MethodError`
  naming what is actually missing, rather than a pre-emptive
  `ArgumentError`. A discrete-typed `Convolved`/`Difference`/`Product`
  flows straight through the existing discrete method and reads its
  exact masses directly.
- **`is_exact` joins `evaluation_path`/`has_closed_form`.** A new
  predicate, true for a closed form OR the exact discrete fold, false
  only for genuine Gauss-Legendre quadrature. `evaluation_path` keeps
  its existing two-valued `:analytic`/`:numeric` contract unchanged (an
  exact discrete fold reports `:numeric`, the same as quadrature) — no
  new value was added, so nothing that branches on `evaluation_path`
  needs to change. `strict = true` accepts an all-discrete pair with no
  closed form (the discrete fold is exact, so the promise `strict =
  true` makes is kept).

### Additions

- Analytic pairs: `Poisson`+`Poisson`, equal-`p` `Binomial`, and
  equal-`p` `NegativeBinomial` (see above).
- `is_exact(d)`: whether evaluating `d` carries no quadrature error
  (public, alongside `evaluation_path`/`has_closed_form`).

Repeated self-convolution (a `power` keyword on `convolved`) was
originally planned alongside this work but is deferred to its own PR;
[#89](https://github.com/EpiAware/ConvolvedDistributions.jl/issues/89)
stays open for it.

- **`discretise_pmf` is removed.** Discretising a continuous delay is a
  censoring choice this package does not make; CensoredDistributions.jl
  owns primary and interval censoring, including double-interval-censored
  masses. `convolve_series` still accepts a `DiscreteUnivariateDistribution`
  directly, and still accepts a caller-supplied PMF for a continuous
  delay's masses, whoever builds them.
  Migration: replace `discretise_pmf(delay, maxlag; interval)` with masses
  built by CensoredDistributions.jl (or your own CDF-difference
  computation), then `convolve_series(masses, series)`.
  Closes [#68](https://github.com/EpiAware/ConvolvedDistributions.jl/issues/68).

- **`DelayPMF` is removed.** `convolve_series` accepts a caller-supplied
  PMF either as a plain `AbstractVector` (the unit grid) or as a
  `DiscreteNonParametric` (support = the delay's lag grid, regularly
  spaced and starting at `0`; probabilities = the masses) for a coarser
  grid, replacing `DelayPMF`'s separate `interval` field.
  `DiscreteNonParametric` is already ModifiedDistributions' discrete-delay
  type, so this is the same vocabulary across the org rather than a
  bespoke wrapper.
  Migration: replace `DelayPMF(masses, 1.0)` with `masses` passed
  directly, and `DelayPMF(masses, interval)` for `interval != 1` with
  `DiscreteNonParametric(0:interval:(interval * (length(masses) - 1)),
  masses)` — note that, unlike `DelayPMF`, `DiscreteNonParametric`
  enforces a genuine probability vector (`sum(masses) ≈ 1`) at
  construction, so a window-truncated or otherwise sub-normalised
  `DelayPMF` migrates to the plain-vector form instead, regardless of
  its grid width.
  Closes [#79](https://github.com/EpiAware/ConvolvedDistributions.jl/issues/79).

## 0.2.0

Breaking changes relative to 0.1.0, with migration notes:

- **`convolve_series` no longer discretises continuous delays.** A `DiscreteUnivariateDistribution` convolves via its own PMF (`pdf(delay, k)` at integer lags); a continuous delay throws. Migration: discretise explicitly — `convolve_series(discretise_pmf(delay, length(series) - 1), series)` for interval-censored-secondary masses (exact primary event), or build double-interval-censored masses with CensoredDistributions.jl's `convolve_series` extension when the primary event is only known to the day — then convolve the resulting PMF.
- **Family names.** `AbstractCombinedDistribution` is now `AbstractConvolvedDistribution`, and `TestUtils.test_combined_interface` is `test_convolved_interface`. Migration: rename references; behaviour is unchanged.

Additions and improvements:

- `product(x, y)` (public type `Product`) adds the Mellin convolution `Z = X * Y` for independent components with non-negative support: `LogNormal * LogNormal` closed form, AD-safe Mellin quadrature otherwise, exact independent-product moments, and `quantile` via the Optimization extension. Sign-crossing supports throw and are future work.
- `discretise_pmf(delay, maxlag; interval)` builds a reusable public `DelayPMF` (raw CDF-difference masses, clamped at zero, never renormalised) with `pdf(pmf, lag)` mass reads, and `convolve_series` accepts a `DelayPMF` or any raw PMF vector, with masses used exactly as given. A `DelayPMF` carries its grid width: the series is read at steps of `pmf.interval`, so weekly-binned masses convolve weekly series.
- Batched numeric `cdf`/`pdf`/`logpdf` now integrate every point over its own scalar-path window on a shared composite panel grid: batched and scalar log densities agree to well within `1e-8` (typically near machine precision; previously up to ~`2e-3` in wide-batch tails) while the batched path remains 1.6-2.2x faster than broadcasting (#29).
- The AD-safe component hook family and the tape-strip pair moved to [EpiAwareADTools.jl](https://github.com/EpiAware/EpiAwareADTools.jl) under underscore-free names, together with the analytic gamma-CDF derivative machinery and its per-backend rules. Wrapper packages now depend on EpiAwareADTools directly and extend its names; this package no longer declares its own hooks. Migration:

  | Old (`ConvolvedDistributions`) | New (`EpiAwareADTools`) |
  |---|---|
  | `_cdf_ad_safe` | `cdf_ad_safe` |
  | `_logcdf_ad_safe` | `logcdf_ad_safe` |
  | `_ccdf_ad_safe` | `ccdf_ad_safe` |
  | `_logccdf_ad_safe` | `logccdf_ad_safe` |
  | `_pdf_ad_safe` | `pdf_ad_safe` |
  | `_primal` | `primal` |
  | `_primal_distribution` | `primal_distribution` |
- The extension `quantile` is now accurate in the far tails: the solve minimises the log-odds residual rather than the near-flat squared probability residual (relative error at `p = 0.999` down from ~0.16 to ~4e-6 on the analytic product pair) (#48).
- `cdf`/`pdf` no longer throw on distributions whose components are themselves composites (for example a `difference` of two `Convolved` totals): composite integration windows recurse over the nested components with union-bound tail trims (#45).
- The batched `cdf`/`pdf`/`logpdf` methods now differentiate: AD tracers on component parameters survive the final convert (#43), ReverseDiff works with respect to the evaluation points (the per-point assembly no longer mutates tracked storage) (#44), and batched-path AD scenarios run on all six backend tags in CI.
- Numeric quadrature windows are split at the integration component's quantiles, so node density follows its mass: heavy-tailed components no longer starve the transition region (worst measured case, a `Gamma` x `LogNormal(0, 1.5)` product CDF, improved from ~1.4e-2 absolute error to ~5e-11) and most scalar paths got slightly faster (#49).

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
