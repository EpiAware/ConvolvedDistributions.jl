# [Installation](@id installation)

`ConvolvedDistributions` is registered in the Julia General Registry; install it with:

```julia
using Pkg; Pkg.add("ConvolvedDistributions")
```

For the development version, install from GitHub:

```julia
using Pkg
Pkg.add(url = "https://github.com/EpiAware/ConvolvedDistributions.jl")
```

Load it alongside Distributions.jl:

```julia
using ConvolvedDistributions, Distributions
```

`quantile` for `Convolved` and `Difference`, and `rand` on their `truncated` wrappers, live in a package extension.
Load Optimization.jl and OptimizationOptimJL.jl to activate it:

```julia
using Optimization, OptimizationOptimJL
```

Everything else (`cdf`, `pdf`, `logpdf`, moments, sampling, truncated scoring) works without the extension.

The [Getting started](@ref getting-started) overview tours the constructors with worked examples.
