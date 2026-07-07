<!-- PACKAGE-OWNED — your benchmark narrative. scaffold writes this once and
never overwrites it. The managed build splices this file verbatim into the
generated `docs/src/benchmarks.md`, between the page heading and the rendered
`## Performance history` section. ALL benchmark narrative lives here (the
managed skeleton carries none): describe what the suite covers, how to run it,
and how to read the history below. Add your own `## ...` subsections freely. -->

`ConvolvedDistributions` benchmarks its hot paths so the cost of the numeric quadrature backend is visible against the analytic one and regressions are caught on every pull request.

The suite (`benchmark/benchmarks.jl`) covers:

- `Baseline`: the bare Gamma and Normal components, the floor everything else is read against.
- `Convolved`: densities and CDFs on both backends — the analytic Normal+Normal pair (closed form, should sit near the baseline) and the numeric Gamma+LogNormal pair (Gauss-Legendre quadrature). The `batched` rows use the vector methods that share quadrature nodes across evaluation points; their gap to the scalar `logpdf broadcast` row over the same 100 points is the headline number for the numeric backend.
- `Difference`: the `Z = X - Y` dual on the same analytic/numeric split. Difference has no batched methods, so evaluation rows broadcast the scalar path.
- `Timeseries`: `convolve_series(delay, series)`, with the delay PMF discretised from a Gamma and from a numeric `Convolved` delay.
- `Quantile`: the Optimization-extension inverse CDF (Nelder-Mead over `cdf`); the numeric variants pay one quadrature CDF per optimiser iteration and are the slowest rows in the suite.
- `AD gradients`: `DifferentiationInterface.gradient` of every `test/ADFixtures` scenario across the ForwardDiff, ReverseDiff, Mooncake and Enzyme backends, sharing the fixtures that drive the AD test suite.

Run the suite locally with `task benchmark`, or compare against `main` with `task benchmark-compare` (see `benchmark/README.md`).
On pull requests the [benchmark workflow](https://github.com/EpiAware/ConvolvedDistributions.jl/blob/main/.github/workflows/benchmark.yaml) benchmarks head and base in separate jobs and posts a single comparison comment.
Pushes to `main` and tags append to the performance history shown below.
