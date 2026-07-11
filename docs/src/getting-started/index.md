# [Getting started](@id getting-started)

`ConvolvedDistributions` builds the distribution of a sum (`X + Y`, a convolution), a signed gap (`X - Y`), or a product (`X * Y`) of independent random variables, for any pair of `Distributions.jl` univariate distributions.
Closed forms are used where they exist and an AD-safe Gauss-Legendre quadrature everywhere else, so the results can be scored, truncated, and differentiated inside a fitting loop.
This page walks through the main entry points; the [Public API](@ref public-api) has the full interface.

See [Installation](@ref installation) for how to install the package.

## Convolving distributions

`convolved` returns the distribution of the sum of independent components.
For pairs with a known closed form (`Normal` + `Normal`, equal-scale `Gamma`, equal-rate `Exponential`) it delegates to the analytic result; any other pair uses the numeric quadrature fallback.

```@example getting-started
using ConvolvedDistributions, Distributions

# An incubation period plus a reporting delay, say.
d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))

cdf(d, 5.0)
```

Densities and moments work the same way; the mean and variance are exact component sums, not quadrature results.

```@example getting-started
pdf(d, 5.0), mean(d), var(d)
```

More than two components can be passed as varargs, a tuple, or a vector.

```@example getting-started
d3 = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4),
    Exponential(2.0))
mean(d3)
```

## Composing convolutions

The result of `convolved` is itself a `UnivariateDistribution`, so it can be a component of another call.
Here `d` (the incubation plus reporting delay from above) is convolved with a further processing delay, and the nested distribution matches the flat three-component one.

```@example getting-started
total = convolved(d, Exponential(2.0))
mean(total), mean(d3), cdf(total, 8.0), cdf(d3, 8.0)
```

Nesting is how a multi-stage delay built in one part of a model is reused in another without unpacking its components.
The [Visualising convolutions](@ref visualising-convolutions) tutorial plots a nested convolution against its flat equivalent.

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

Either side can itself be a `Convolved`, so the signed gap between a multi-stage delay and a single delay is one call.
Here `cdf(gap, 0.0)` is the probability that the two-stage delay `d` is shorter than the single delay.

```@example getting-started
gap = difference(d, Gamma(2.5, 1.0))
mean(gap), cdf(gap, 0.0)
```

## Products

`product` builds the multiplicative member: the distribution of `Z = X * Y` for independent `X` and `Y`, as when a delay is stretched by an independent multiplicative factor.
`LogNormal` * `LogNormal` uses the closed form (the log-parameters add); everything else uses the numeric Mellin quadrature.
Both components must have non-negative support; sign-crossing supports throw an error and are future work.

```@example getting-started
w = product(Gamma(3.0, 1.0), LogNormal(0.0, 0.3))
mean(w), cdf(w, 3.0)
```

The mean and variance are the exact independent-product moments, and a `Convolved` (or another combination) can itself be a component, so a multi-stage delay scaled by a factor is one call.

```@example getting-started
scaled = product(d, LogNormal(0.0, 0.2))
mean(scaled), mean(d)
```

## Convolving a timeseries

`convolve_series` causally convolves a numeric series with a delay PMF on the unit lag grid.
If the series holds the expected events at times `0, 1, ..., t` (say infections), the result is the expected downstream counts at the same times, the renewal-style observation layer.

A discrete delay is read straight off its own PMF (the lag-`k` mass is `pdf(delay, k)`):

```@example getting-started
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
convolve_series(Poisson(2.0), infections)
```

A continuous delay carries no mass on the integer grid until it is discretised, and discretising it is an explicit modelling choice, so `convolve_series` will not do it silently.
Discretise it first with `discretise_pmf` (raw CDF-difference masses: interval-censored secondary event, exact primary), then convolve.
For a primary event known only to the day use CensoredDistributions.jl's double-interval-censored masses instead.
The masses depend differentiably on the delay parameters, so this composes with gradient-based fitting.

```@example getting-started
pmf = discretise_pmf(d, length(infections) - 1)
convolve_series(pmf, infections)
```

## Choosing the solver

Both constructors take a `method` keyword.
The default `AnalyticalSolver()` uses the closed form when one exists and falls back to quadrature; `NumericSolver()` forces the quadrature path, which is mainly useful for testing and for comparing the two.

```@example getting-started
da = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
dn = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0);
    method = NumericSolver())
cdf(da, 2.0), cdf(dn, 2.0)
```

## Truncation and scoring

`Convolved`, `Difference`, and `Product` compose with `Distributions.truncated`, so right-truncated (or doubly truncated) scoring works out of the box.
This is the usual pattern for fitting delay data observed up to a cut-off.

```@example getting-started
td = truncated(d, 0.0, 8.0)
logpdf(td, 5.0)
```

## Quantiles and sampling truncated distributions

There is no closed-form inverse CDF for a generic convolution, so `quantile` lives in an extension that is loaded when both Optimization.jl and OptimizationOptimJL.jl are present.
It finds the quantile by a Nelder-Mead inversion of `cdf`.
Loading it also enables `rand` on `truncated` wrappers, which routes through the base `quantile`.

```@example getting-started
using Optimization, OptimizationOptimJL

quantile(d, 0.5)     # median by inverse-CDF root-find
```

```@example getting-started
length(rand(truncated(d, 0.0, 8.0), 100))
```

Nothing else on this page needs the extension.
`rand` on a bare `Convolved`, `Difference`, or `Product` samples the components directly.

## Gradients

The `cdf`, `pdf`, and `logpdf` paths are AD-safe by construction.
The quadrature uses fixed nodes, the window clamp is shielded from the tape, and the gamma CDF carries analytic derivative rules.
Gradients with respect to the component parameters are tested on ForwardDiff, ReverseDiff, Enzyme (forward and reverse), and Mooncake (forward and reverse) on every CI run; the per-backend badges in the [README](https://github.com/EpiAware/ConvolvedDistributions.jl#readme) track their status.

## Learning more

- New to the package? [Installation](@ref installation) covers installing by URL and the optional quantile extension; for setting up Julia itself, see the [EpiAware site](https://epiaware.org/).
- Common questions (solver choice, the timeseries form, the extension, AD support) are answered in the [FAQ](@ref faq).
- Want the full interface? See the [Public API](@ref public-api).
- Curious how the numeric layer is put together? The internal quadrature (`integrate`, `gl_integrate`, `GaussLegendre`) is documented in the [Internal API](../lib/internals.md), and an Integrals.jl backend is available as an extension.
- Contributing, or adding a new member of the combination family? Start from the [developer documentation](@ref developer), the [Contributing guide](@ref contributing), and [Adding a new combination](@ref extending).
- Want to report a problem or ask a question? Open an issue or start a discussion on the [GitHub repository](https://github.com/EpiAware/ConvolvedDistributions.jl).
