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

- `convolve_distributions` builds the distribution of a sum of independent delays (a convolution), with an analytic fast path (`Normal`+`Normal`, equal-scale `Gamma`, equal-rate `Exponential`) and an AD-safe Gauss-Legendre quadrature fallback for every other pair.
- `difference` builds the `X - Y` dual, the signed gap between two independent events.
- A pluggable `integrate` / `gl_integrate` layer with the lightweight fixed-node `GaussLegendre` default and an optional Integrals.jl backend.
- Gradients flow through the component parameters on every supported AD backend (ForwardDiff, ReverseDiff, Enzyme, Mooncake).

## Getting started

See [documentation](https://epiaware.org/ConvolvedDistributions.jl/stable/) for a full walkthrough.

```julia
using ConvolvedDistributions, Distributions

# Sum of two independent delays
d = convolve_distributions(Gamma(2.0, 1.0), LogNormal(1.5, 0.5))
cdf(d, 5.0)

# Signed gap between two events
z = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))
mean(z)
```

## Where to learn more

- [GitHub Discussions](https://github.com/EpiAware/ConvolvedDistributions.jl/discussions)
- [GitHub Repository](https://github.com/EpiAware/ConvolvedDistributions.jl)

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
  doi          = {10.5281/zenodo.XXXXXXX}, # replace once released
  url          = {https://github.com/EpiAware/ConvolvedDistributions.jl}
}
```

## Code of conduct

Please note that the ConvolvedDistributions project is released with a [Contributor Code of Conduct](https://github.com/EpiAware/.github/blob/main/CODE_OF_CONDUCT.md). By contributing, you agree to abide by its terms.
