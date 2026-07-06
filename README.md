# ConvolvedDistributions <img src="docs/src/assets/logo.svg" width="150" alt="ConvolvedDistributions logo" align="right">

<!-- badges:start -->
| **Documentation** | **Build Status** | **Code Quality** | **License & DOI** | **Downloads** |
|:-----------------:|:----------------:|:----------------:|:-----------------:|:-------------:|
| [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://epiaware.org/ConvolvedDistributions.jl/stable/) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://epiaware.org/ConvolvedDistributions.jl/dev/) | [![Test](https://github.com/EpiAware/ConvolvedDistributions.jl/actions/workflows/test.yaml/badge.svg?branch=main)](https://github.com/EpiAware/ConvolvedDistributions.jl/actions/workflows/test.yaml) [![codecov](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg)](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl) [![AD](https://github.com/EpiAware/ConvolvedDistributions.jl/actions/workflows/ad.yaml/badge.svg?branch=main)](https://github.com/EpiAware/ConvolvedDistributions.jl/actions/workflows/ad.yaml) | [![SciML Code Style](https://img.shields.io/static/v1?label=code%20style&message=SciML&color=9558b2&labelColor=389826)](https://github.com/SciML/SciMLStyle) [![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl) [![JET](https://img.shields.io/badge/%E2%9C%88%EF%B8%8F%20tested%20with%20-%20JET.jl%20-%20red)](https://github.com/aviatesk/JET.jl) | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) | [![Downloads](https://img.shields.io/badge/dynamic/json?url=http%3A%2F%2Fjuliapkgstats.com%2Fapi%2Fv1%2Ftotal_downloads%2FConvolvedDistributions&query=total_requests&label=Downloads)](https://juliapkgstats.com/pkg/ConvolvedDistributions) [![Downloads](https://img.shields.io/badge/dynamic/json?url=http%3A%2F%2Fjuliapkgstats.com%2Fapi%2Fv1%2Fmonthly_downloads%2FConvolvedDistributions&query=total_requests&suffix=%2Fmonth&label=Downloads)](https://juliapkgstats.com/pkg/ConvolvedDistributions) |

| ForwardDiff | ReverseDiff (tape) | Enzyme forward | Enzyme reverse | Mooncake reverse | Mooncake forward |
|:---:|:---:|:---:|:---:|:---:|:---:|
| [![cov ForwardDiff](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg?flag=ad-forwarddiff)](https://app.codecov.io/gh/EpiAware/ConvolvedDistributions.jl?flags%5B0%5D=ad-forwarddiff) | [![cov ReverseDiff](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg?flag=ad-reversediff)](https://app.codecov.io/gh/EpiAware/ConvolvedDistributions.jl?flags%5B0%5D=ad-reversediff) | [![cov Enzyme forward](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg?flag=ad-enzyme-forward)](https://app.codecov.io/gh/EpiAware/ConvolvedDistributions.jl?flags%5B0%5D=ad-enzyme-forward) | [![cov Enzyme reverse](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg?flag=ad-enzyme-reverse)](https://app.codecov.io/gh/EpiAware/ConvolvedDistributions.jl?flags%5B0%5D=ad-enzyme-reverse) | [![cov Mooncake reverse](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg?flag=ad-mooncake-reverse)](https://app.codecov.io/gh/EpiAware/ConvolvedDistributions.jl?flags%5B0%5D=ad-mooncake-reverse) | [![cov Mooncake forward](https://codecov.io/gh/EpiAware/ConvolvedDistributions.jl/graph/badge.svg?flag=ad-mooncake-forward)](https://app.codecov.io/gh/EpiAware/ConvolvedDistributions.jl?flags%5B0%5D=ad-mooncake-forward) |
<!-- badges:end -->

Raw-distribution convolution and shared numeric quadrature for any `Distributions.jl` distribution.

## Why ConvolvedDistributions?

- **Convolution of any pair**: `convolve_distributions` builds the distribution of a sum of independent delays (a convolution) from any two or more `Distributions.jl` distributions, not just pairs with a closed form.
- **Analytic fast path**: closed-form convolutions (`Normal` + `Normal`, equal-scale `Gamma`, equal-rate `Exponential`) are used where they exist, with an AD-safe Gauss-Legendre quadrature fallback for every other pair.
- **Differences as well as sums**: `difference` builds the `X - Y` dual, the signed gap between two independent events.
- **Timeseries convolution**: `convolve_distributions(delay, series)` convolves a numeric series (e.g. expected infections over time) with the discretised delay PMF to give expected downstream counts, the renewal-style observation layer. Gradients flow through the delay parameters.
- **Pluggable integration**: a shared `integrate` / `gl_integrate` layer with a lightweight fixed-node `GaussLegendre` default and an optional [Integrals.jl](https://github.com/SciML/Integrals.jl) backend.
- **Gradients everywhere**: gradients flow through the component parameters on every supported AD backend (ForwardDiff, ReverseDiff, Enzyme, Mooncake), so convolved distributions can be fitted with gradient-based samplers and optimisers.

## Getting started

See the [Getting started documentation](https://epiaware.org/ConvolvedDistributions.jl/stable/getting-started/) for a full walkthrough.

The following example convolves two delays, an incubation period and a reporting delay, and evaluates the resulting distribution:

```julia
using ConvolvedDistributions, Distributions

# Sum of two independent delays
incubation = Gamma(2.0, 1.0)
reporting = LogNormal(1.0, 0.5)
d = convolve_distributions(incubation, reporting)

(cdf(d, 5.0), pdf(d, 5.0))
```

`difference` gives the signed gap between two independent events, for example the delay between two reporting streams:

```julia
z = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))

(mean(z), cdf(z, 0.0))
```

A `Convolved` distribution is a `UnivariateDistribution`, so it composes with `Distributions.truncated`.
Right truncation is useful when scoring against data observed only up to a cutoff:

```julia
d_trunc = truncated(d; upper = 10.0)

cdf(d_trunc, 5.0)
```

Loading the Optimization extension adds `quantile` support by numerically inverting the CDF:

```julia
using Optimization, OptimizationOptimJL

quantile(d, 0.5)
```

## Relationship to Distributions.jl

Distributions.jl ships a `convolve` function, but it only covers pairs with a closed-form result:

| Aspect | Distributions.jl `convolve` | ConvolvedDistributions.jl `convolve_distributions` |
|--------|-----------------------------|-----------------------------------------------------|
| **Coverage** | Closed-form, same-family pairs only (e.g. `Normal` + `Normal`, equal-scale `Gamma`); errors otherwise | Any pair of univariate distributions |
| **Method** | Returns the closed-form distribution | Analytic fast path where a closed form exists, AD-safe Gauss-Legendre quadrature fallback otherwise |
| **Forms** | Two positional arguments | Nested, vector, tuple, and varargs forms for sums of many delays |
| **Differences** | Not supported | `difference` builds the `X - Y` dual |
| **Evaluation** | Whatever the returned distribution supports | Batched `cdf` / `pdf` / `logpdf` over vectors of points |
| **Gradients** | Depend on the returned distribution | Flow through the component parameters on all supported AD backends |

For example, `Distributions.convolve(Gamma(2, 1), LogNormal(0, 1))` throws a `MethodError` and `Distributions.convolve(Gamma(2, 1), Gamma(3, 2))` throws an `ArgumentError` because the scales differ, whereas `convolve_distributions` handles both via quadrature.
When a closed form does exist, `convolve_distributions` uses it, so there is no cost to reaching for the more general function.

## What packages work well with ConvolvedDistributions.jl?

- [Distributions.jl](https://github.com/JuliaStats/Distributions.jl) provides the base functionality for working with distributions; every component and every result is a `UnivariateDistribution`.
- [CensoredDistributions.jl](https://github.com/EpiAware/CensoredDistributions.jl) adds censoring and truncation layers for epidemiological observation processes; this package was split out of it and the two compose.
- [Turing.jl](https://github.com/TuringLang/Turing.jl) for Bayesian inference; the `cdf` / `pdf` / `logpdf` methods are AD-safe, so convolved distributions can be fitted with its samplers.
- [Integrals.jl](https://github.com/SciML/Integrals.jl) as an optional quadrature backend via the package extension.

## Where to learn more

- Want to get started running code? Check out the [Getting started documentation](https://epiaware.org/ConvolvedDistributions.jl/stable/getting-started/).
- Want to understand the API? Check out our [API reference](https://epiaware.org/ConvolvedDistributions.jl/stable/lib/public).
- Want to chat with someone about `ConvolvedDistributions`? Post on our [GitHub Discussions](https://github.com/EpiAware/ConvolvedDistributions.jl/discussions).
- Want to contribute to `ConvolvedDistributions`? Check the [open issues](https://github.com/EpiAware/ConvolvedDistributions.jl/issues) and the Contributing section below.
- Want to see our code? Check out our [GitHub Repository](https://github.com/EpiAware/ConvolvedDistributions.jl).

## Contributing

We welcome contributions and new contributors! This package follows [ColPrac](https://github.com/SciML/ColPrac) and the [SciML style](https://github.com/SciML/SciMLStyle).

## Supporting and citing

If you would like to support ConvolvedDistributions, please star the repository — such metrics help secure future funding.

If you use ConvolvedDistributions in your work, please cite it:

```bibtex
@software{ConvolvedDistributions_jl,
  author       = {Sam Abbott and EpiAware contributors},
  title        = {ConvolvedDistributions.jl},
  year         = {2026},
  url          = {https://github.com/EpiAware/ConvolvedDistributions.jl}
}
```

A citable DOI will be added with the first tagged release.

## Code of conduct

Please note that the ConvolvedDistributions project is released with a [Contributor Code of Conduct](https://github.com/EpiAware/.github/blob/main/CODE_OF_CONDUCT.md). By contributing, you agree to abide by its terms.
