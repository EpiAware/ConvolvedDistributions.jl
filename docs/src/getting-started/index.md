# [Getting started](@id getting-started)

`ConvolvedDistributions` builds the distribution of a sum (`X + Y`, a convolution) or a signed gap (`X - Y`) of independent random variables, for any pair of `Distributions.jl` univariate distributions.
Closed forms are used where they exist and an AD-safe Gauss-Legendre quadrature everywhere else, so the results can be scored, truncated, and differentiated inside a fitting loop.
This page walks through the main entry points; the [Public API](@ref public-api) has the full interface.

## Installation

`ConvolvedDistributions` is not yet registered, so install it from GitHub:

```julia
using Pkg
Pkg.add(url = "https://github.com/EpiAware/ConvolvedDistributions.jl")
```

Once registered this becomes `Pkg.add("ConvolvedDistributions")`.

## Convolving distributions

`convolve_distributions` returns the distribution of the sum of independent components.
For pairs with a known closed form (`Normal` + `Normal`, equal-scale `Gamma`, equal-rate `Exponential`) it delegates to the analytic result; any other pair uses the numeric quadrature fallback.

```@example getting-started
using ConvolvedDistributions, Distributions

# An incubation period plus a reporting delay, say.
d = convolve_distributions(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

cdf(d, 5.0)
```

Densities and moments work the same way; the mean and variance are exact component sums, not quadrature results.

```@example getting-started
pdf(d, 5.0), mean(d), var(d)
```

More than two components can be passed as varargs, a tuple, or a vector, and `Convolved` distributions nest.

```@example getting-started
d3 = convolve_distributions(Gamma(2.0, 1.0), LogNormal(0.5, 0.4),
    Exponential(2.0))
mean(d3)
```

Evaluating `cdf` or `pdf` over a vector of points shares one quadrature window solve across the batch, which is much cheaper than mapping the scalar call.

```@example getting-started
cdf(d, [1.0, 2.5, 5.0, 10.0])
```

## Differences

`difference` is the dual of the sum: the distribution of `Z = X - Y` for independent `X` and `Y`, with support on both sides of zero.
`Normal` - `Normal` uses the closed form; everything else uses the numeric cross-correlation path.

```@example getting-started
z = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))
cdf(z, 0.0)
```

A symmetric difference is centred on zero:

```@example getting-started
zs = difference(Normal(1.0, 1.0), Normal(1.0, 1.0))
mean(zs), cdf(zs, 0.0)
```

## Choosing the solver

Both constructors take a `method` keyword.
The default `AnalyticalSolver()` uses the closed form when one exists and falls back to quadrature; `NumericSolver()` forces the quadrature path, which is mainly useful for testing and for comparing the two.

```@example getting-started
da = convolve_distributions(Normal(0.0, 1.0), Normal(1.0, 2.0))
dn = convolve_distributions(Normal(0.0, 1.0), Normal(1.0, 2.0);
    method = NumericSolver())
cdf(da, 2.0), cdf(dn, 2.0)
```

## Truncation and scoring

`Convolved` and `Difference` compose with `Distributions.truncated`, so right-truncated (or doubly truncated) scoring works out of the box.
This is the usual pattern for fitting delay data observed up to a cut-off.

```@example getting-started
td = truncated(d, 0.0, 8.0)
logpdf(td, 5.0)
```

## Quantiles and sampling truncated distributions

There is no closed-form inverse CDF for a generic convolution, so `quantile` lives behind an extension: load Optimization.jl and OptimizationOptimJL.jl and the method appears (a Nelder-Mead inversion of `cdf`).
This also unlocks `rand` on `truncated` wrappers, which routes through the base `quantile`.

```@example getting-started
using Optimization, OptimizationOptimJL

quantile(d, 0.5)     # median by inverse-CDF root-find
```

```@example getting-started
length(rand(truncated(d, 0.0, 8.0), 100))
```

Everything else on this page needs no extension: `rand` on a bare `Convolved`/`Difference` samples the components directly.

## Gradients

The `cdf`, `pdf`, and `logpdf` paths are AD-safe by construction: the quadrature uses fixed nodes, the window clamp is shielded from the tape, and the gamma CDF carries analytic derivative rules.
Gradients with respect to the component parameters are tested on ForwardDiff, ReverseDiff, Enzyme (forward and reverse), and Mooncake (forward and reverse) on every CI run; the per-backend badges in the [README](https://github.com/EpiAware/ConvolvedDistributions.jl#readme) track their status.

## Learning more

- Want the full interface? See the [Public API](@ref public-api).
- Curious how the numeric layer is put together? The internal quadrature (`integrate`, `gl_integrate`, `GaussLegendre`) is documented in the [Internal API](../lib/internals.md), and an Integrals.jl backend is available as an extension.
- See [Infrastructure and template sync](@ref infrastructure) for how this repository's docs and CI are generated, and [Customising your docs](@ref customising) for which pages are package-owned.
- Want to report a problem or ask a question? Open an issue or start a discussion on the [GitHub repository](https://github.com/EpiAware/ConvolvedDistributions.jl).
