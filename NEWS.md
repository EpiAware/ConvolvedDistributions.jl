## Unreleased

- Added the `AbstractCombinedDistribution` family supertype (mirroring the CensoredDistributions.jl abstract hierarchy) that `Convolved` and `Difference` now subtype, with the interface contract documented on the type and shipped `TestUtils.test_combined_interface` / `TestUtils.test_abstract_membership` verifiers for downstream family members.
- Added the timeseries form `convolve_distributions(delay, series)`: a numeric series (e.g. expected infections at unit-spaced times) convolved with the discretised delay PMF of any univariate distribution, ported censoring-free from CensoredDistributions.jl with AD-safe CDF-difference interval masses (#6).
- Restored `quantile` (inverse CDF) for `Convolved` and `Difference` via the new `ConvolvedDistributionsOptimizationExt` extension, loaded when both Optimization.jl and OptimizationOptimJL.jl are present (#20).

This file tracks notes for major releases and significant milestones; GitHub
Releases (auto-generated from merged PRs) cover every release in between.
