# ConvolvedDistributions.jl Benchmarks

Benchmarks for the convolution distributions, reading the analytic and numeric quadrature backends against the bare component distributions.

## Quick Start

### One-time Setup

Install the `benchpkg` CLI to your global Julia environment:

```bash
task benchmark-install
# Or: julia -e 'using Pkg; Pkg.add("AirspeedVelocity")'
```

Ensure `~/.julia/bin` is on your PATH.

### Running Benchmarks

```bash
# Benchmark current state
task benchmark

# Compare main branch vs current state
task benchmark-compare

# Filter to specific benchmarks
task benchmark -- --filter=Convolved
task benchmark-compare -- --filter=Quantile
```

## Benchmark Structure

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

Product/
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
  Product numeric/     (median)

AD gradients/
  <scenario>/          (one leaf per AD backend)
```

The `Baseline` group is the floor: the bare components every convolution combines, evaluated over the same points.
The `analytic` variants (Normal+Normal, Normal-Normal) collapse to closed forms and should sit near that floor; the `numeric` variants (Gamma+LogNormal, Gamma-LogNormal) run the Gauss-Legendre quadrature.
Within `Convolved/numeric`, the `batched` rows hit the vector methods that share quadrature nodes across all evaluation points — the gap to `logpdf broadcast` (the scalar path mapped over the same points) is the headline number.
`Quantile` exercises the Optimization-extension inverse CDF (Nelder-Mead over `cdf`), the slowest path in the package.

The `AD gradients` group (`benchmark/src/ad_gradients.jl`) times `DifferentiationInterface.gradient` for every (scenario, backend) pair from the `test/ADFixtures` path package, which also drives the AD test suite (`test/ad/runtests.jl`), keeping the two surfaces in lock-step.
Backends cover ForwardDiff, ReverseDiff (tape), Mooncake (reverse and forward) and Enzyme (reverse and forward).
Each pair is smoke-tested for a finite gradient before registration, so known-broken combinations are silently omitted and the suite can run unattended.

## CI Integration

Benchmarks run automatically on PRs via `.github/workflows/benchmark.yaml`: each of PR head and `main` is benchmarked in its own job and a single comparison comment is posted (see `benchmark/compare.jl`, which calls the shared `EpiAwarePackageTools.Benchmarks` harness).
Pushes to `main` and tags additionally record a performance timeline to the repo's `benchmarks` branch via `.github/workflows/benchmark-history.yaml`, rendered on the docs' Benchmarks page.

## Direct CLI Usage

```bash
# Run benchmarks
benchpkg --rev=dirty --script=benchmark/benchmarks.jl

# Compare specific revisions
benchpkg --rev=main,dirty --script=benchmark/benchmarks.jl

# View results
benchpkgtable ConvolvedDistributions
```
