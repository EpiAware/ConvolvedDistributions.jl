# [Frequently asked questions](@id faq)

This page answers common questions about ConvolvedDistributions.jl.
If your question is not answered here, open a discussion on the [GitHub repository](https://github.com/EpiAware/ConvolvedDistributions.jl).

## How do I build a convolved or difference distribution?

Each constructor takes distributions and returns a distribution:

```@example faq
using ConvolvedDistributions, Distributions

d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
z = difference(Gamma(3.0, 1.0), LogNormal(0.5, 0.4))

cdf(d, 5.0), cdf(z, 0.0)
```

`convolved` accepts two or more components as varargs, a tuple, or a vector, and the results nest, so a `Convolved` can itself be a component.

## When should I use `convolved` rather than `Distributions.convolve`?

`Distributions.convolve` only handles pairs with a closed-form result (for example `Normal` + `Normal`, or two `Gamma`s with equal scale) and errors on anything else.
`convolved` works for any pair of univariate distributions: it delegates to the closed form when one exists and falls back to AD-safe numeric quadrature otherwise.
It also takes more than two components, keeps exact analytic moments, and stays differentiable with respect to the component parameters.
If you only ever combine an analytic pair and want the closed-form type back directly, `Distributions.convolve` is fine; for anything else use `convolved`.

## Why does `quantile` need the Optimization extension?

There is no closed-form inverse CDF for a generic convolution or difference, so the quantile is found by numerically inverting `cdf` with a Nelder-Mead solve.
That solver stack is a deliberate weak dependency: `cdf`, `pdf`, `logpdf`, moments, sampling, and `truncated` scoring never need it, so the core package stays dependency-light.
Load both trigger packages to activate it:

```julia
using Optimization, OptimizationOptimJL

quantile(d, 0.5)
```

Loading the extension also enables `rand` on `truncated` wrappers of `Convolved` and `Difference`, which routes through the base `quantile`.
`rand` on a bare `Convolved` or `Difference` samples the components directly and needs no extension.

## What is the difference between `AnalyticalSolver` and `NumericSolver`?

Both constructors take a `method` keyword.
The default `AnalyticalSolver()` uses the closed form when `Distributions.convolve` applies to every component pair (or, for `difference`, when both components are `Normal`) and falls back to Gauss-Legendre quadrature otherwise.
`NumericSolver()` forces the quadrature path even when a closed form exists.
Results agree to quadrature accuracy, so forcing the numeric path is mainly useful for testing, debugging, and comparing the two:

```@example faq
da = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0))
dn = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0);
    method = NumericSolver())
cdf(da, 2.0), cdf(dn, 2.0)
```

## Do batched and scalar log densities agree?

Yes, to well within `1e-8`.
Evaluating `cdf`, `pdf`, or `logpdf` over a vector integrates every point over the same window the scalar path picks, on a composite quadrature grid whose panel nodes and integration-component density are shared across the batch (plus small per-point end corrections), which is what makes the batched path cheap.
Batched and scalar results typically agree near machine precision; the widest measured gap is around `1e-10` for batches spanning a 40-fold point range, and batches spanning extreme ranges (100-fold and beyond) stay within about `1e-6`.
Earlier versions shared one quadrature window across the whole batch and could drift from the scalar path by around `2e-3` in the tails of wide batches; the per-point-window construction ([issue #29](https://github.com/EpiAware/ConvolvedDistributions.jl/issues/29)) removed that gap.

## How does the timeseries form differ from the distribution form?

They do different jobs and have separate names.
The distribution form, `convolved(dists...)`, combines distributions into a single `Convolved` distribution (the sum of independent delays).
The timeseries form, `convolve_series(delay, series)` with `series` a numeric vector, discretises the delay to a PMF over the unit grid and returns the causal discrete convolution of the series with that PMF:

```@example faq
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
convolve_series(d, infections)
```

With `series` the expected events at times `0, 1, ..., t` (say infections), the result is the expected downstream counts at the same times, the renewal-style observation layer.
The separate verb reflects the different return type: `convolved` always returns a distribution, `convolve_series` always returns a numeric series.
The PMF masses depend differentiably on the delay parameters, so the timeseries form composes with gradient-based fitting.

## Can I use this with automatic differentiation?

Yes.
The `cdf`, `pdf`, and `logpdf` paths are AD-safe by construction: the quadrature uses fixed nodes, the integration window is shielded from the tape, and the gamma CDF carries analytic derivative rules.
Gradients with respect to the component parameters are tested on ForwardDiff, ReverseDiff, Enzyme (forward and reverse), and Mooncake (forward and reverse) on every CI run.
The per-backend badges in the [README](https://github.com/EpiAware/ConvolvedDistributions.jl#readme) track their status.
Note that `quantile` (via the Optimization extension) is a numeric root-find and is not intended to sit on an AD path.

## How does this relate to CensoredDistributions.jl and ComposedDistributions.jl?

ConvolvedDistributions.jl is the raw-distribution convolution layer of the EpiAware distribution-operations stack, ported from the corresponding machinery in [CensoredDistributions.jl](https://github.com/EpiAware/CensoredDistributions.jl).
It operates on plain `Distributions.jl` univariate distributions and knows nothing about censoring; CensoredDistributions.jl owns primary and interval censoring.
[ComposedDistributions.jl](https://github.com/EpiAware/ComposedDistributions.jl) composes these operations into chains and re-exports this package's public surface, so in a composed model you usually reach the convolution through it rather than directly.

## How can I run the tutorial notebooks?

The tutorials (for example `docs/src/getting-started/tutorials/visualising-convolutions.md`) are built from Literate.jl scripts.
You have two options:

**Option 1: Copy and paste (easiest)**
- Copy code blocks from the online tutorials
- Paste into your Julia REPL or script

**Option 2: Run the tutorial scripts directly**
1. Clone the repository: `git clone https://github.com/EpiAware/ConvolvedDistributions.jl.git`
2. Start Julia in the docs environment: `julia --project=docs`
3. `include` the tutorial's `.jl` source from `docs/src/getting-started/tutorials/`

The tutorial `.jl` files are plain Julia scripts that can be run top-to-bottom in the REPL.

## I get "Package not found" errors

Make sure you are in the right environment, and remember the package installs by URL until it is registered:

```julia
using Pkg
Pkg.activate(".")           # Activate current directory
Pkg.instantiate()           # Install dependencies
Pkg.add(url = "https://github.com/EpiAware/ConvolvedDistributions.jl")
```

## How do I cite ConvolvedDistributions?

See the citation section of the [README](https://github.com/EpiAware/ConvolvedDistributions.jl#supporting-and-citing).

## I want to contribute to development

See the [Contributing guide](@ref contributing) and [Developer FAQ](@ref developer-faq) for development-specific questions and guidelines.

## Getting help

Still have questions?

- **Package-specific**: Open a [GitHub Discussion](https://github.com/EpiAware/ConvolvedDistributions.jl/discussions)
- **Bug reports**: [GitHub Issues](https://github.com/EpiAware/ConvolvedDistributions.jl/issues)
- **General Julia help**: [Julia Discourse](https://discourse.julialang.org/) or [Julia Slack](https://julialang.org/slack/)
