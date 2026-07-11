<!-- PACKAGE-OWNED — your benchmark narrative. scaffold writes this once and
never overwrites it. The managed build splices this file verbatim into the
generated `docs/src/benchmarks.md`, between the page heading and the rendered
`## Performance history` section. ALL benchmark narrative lives here (the
managed skeleton carries none): describe what the suite covers, how to run it,
and how to read the history below. Add your own `## ...` subsections freely. -->

Benchmarks for the convolution distributions, reading the analytic and numeric quadrature backends against the bare component distributions.

## Quick start

Install the `benchpkg` CLI once:

```bash
task benchmark-install
# Or: julia -e 'using Pkg; Pkg.add("AirspeedVelocity")'
```

then run the suite:

```bash
# Benchmark current state
task benchmark

# Compare main branch vs current state
task benchmark-compare

# Filter to specific benchmarks
task benchmark -- --filter=Convolved
task benchmark-compare -- --filter=Quantile
```

## Benchmark structure

```
Baseline/
  Gamma/               (logpdf, cdf)
  Normal/              (logpdf, cdf)

Convolved/
  analytic/            (construction, logpdf/pdf/cdf scalar,
                        logpdf broadcast, logpdf/pdf/cdf batched,
                        rand, mean)
  numeric/             (same operations)

Difference/
  analytic/            (construction, logpdf/cdf scalar,
                        logpdf/cdf broadcast, rand, mean)
  numeric/             (same operations)

Timeseries/
  Gamma delay          (convolve_series(discretise_pmf(delay, m), series))
  Convolved delay
  Poisson delay        (discrete: convolve_series(delay, series))

Quantile/
  Convolved analytic/  (median, grid)
  Convolved numeric/   (median)
  Difference numeric/  (median)

AD gradients/
  <every test/ADFixtures scenario>/
    ForwardDiff, ReverseDiff (tape), Enzyme forward, Enzyme reverse,
    Mooncake forward, Mooncake reverse
```

## Analytic vs numeric

`convolved` and `difference` use a closed form where one exists (`Normal` + `Normal`, equal-scale `Gamma`, equal-rate `Exponential`; `Normal` - `Normal`) and AD-safe Gauss-Legendre quadrature otherwise.
The analytic rows should sit near the `Baseline` floor; the gap between the numeric rows and their analytic counterparts is the cost of the quadrature backend.
The `batched` rows share the composite quadrature grid across evaluation points; their gap to the `logpdf broadcast` row over the same points is the headline batching win.
Pass `method = NumericSolver()` to force the numeric path.

## CI integration

Pull requests benchmark head and base in separate jobs via the [benchmark workflow](https://github.com/EpiAware/ConvolvedDistributions.jl/blob/main/.github/workflows/benchmark.yaml) and post a single comparison comment.
Pushes to `main` and tagged releases append to the performance history below.
