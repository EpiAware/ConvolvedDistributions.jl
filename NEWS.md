## Unreleased

- Tightened the batched numeric `cdf`/`pdf`/`logpdf` quadrature to integrate every point over its own scalar-path window via a shared composite panel grid with per-point end corrections: batched and scalar log densities now agree to well within ~1e-8 (typically near machine precision; previously up to ~2e-3 in the tails of wide batches) while the batched path stays 1.6-2.2x faster than broadcasting the scalar path (#29).
- Pre-release parity pass against the CensoredDistributions.jl integration branch: ported the ambiguity-free ForwardDiff `_gamma_cdf` Dual overloads and the AD-safe `Gamma` `logcdf`/`logccdf` Dual routing, enabled the extension-ambiguity QA checks, clamped discretised delay-PMF masses at zero, added a compact `GaussLegendre` show, removed the never-released `force_numeric` shim, and made `_ccdf_ad_safe`/`_logccdf_ad_safe` public (ComposedDistributions.jl extends them).
- Added the `AbstractCombinedDistribution` family supertype (mirroring the CensoredDistributions.jl abstract hierarchy) that `Convolved` and `Difference` now subtype, with the interface contract documented on the type and shipped `TestUtils.test_combined_interface` / `TestUtils.test_abstract_membership` verifiers for downstream family members.
- Added the timeseries form `convolve_series(delay, series)`: a numeric series (e.g. expected infections at unit-spaced times) convolved with the discretised delay PMF of any univariate distribution, ported censoring-free from CensoredDistributions.jl with AD-safe CDF-difference interval masses (#6).
- Restored `quantile` (inverse CDF) for `Convolved` and `Difference` via the new `ConvolvedDistributionsOptimizationExt` extension, loaded when both Optimization.jl and OptimizationOptimJL.jl are present (#20).

This file tracks notes for major releases and significant milestones; GitHub
Releases (auto-generated from merged PRs) cover every release in between.
