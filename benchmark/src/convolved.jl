# Convolved (sum of independent components) on both backends. The
# Normal+Normal pair collapses to a closed-form Normal (`analytic`); the
# Gamma+LogNormal pair has no analytic convolution and runs the
# Gauss-Legendre quadrature (`numeric`). For each variant the scalar
# calls are broadcast over the shared points, and the `batched` rows hit
# the dedicated vector methods that share quadrature nodes across all
# evaluation points — the batched-vs-broadcast gap is the headline
# number for the numeric backend.

SUITE["Convolved"] = BenchmarkGroup()

const CONVOLVED_VARIANTS = [
    "analytic" => convolved(Normal(1.0, 0.5), Normal(0.5, 1.0)),
    "numeric" => convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
]

for (name, d) in CONVOLVED_VARIANTS
    g = SUITE["Convolved"][name] = BenchmarkGroup()

    g["logpdf scalar"] = @benchmarkable logpdf($d, 3.0)
    g["pdf scalar"] = @benchmarkable pdf($d, 3.0)
    g["cdf scalar"] = @benchmarkable cdf($d, 3.0)
    g["logpdf broadcast"] = @benchmarkable logpdf.($d, $TEST_XS)
    g["logpdf batched"] = @benchmarkable logpdf($d, $TEST_XS)
    g["pdf batched"] = @benchmarkable pdf($d, $TEST_XS)
    g["cdf batched"] = @benchmarkable cdf($d, $TEST_XS)
    g["rand"] = @benchmarkable rand($d, 100)
    g["mean"] = @benchmarkable mean($d)
end

# Construction, including the analytic-form resolution.
SUITE["Convolved"]["analytic"]["construction"] = @benchmarkable convolved(
    Normal(1.0, 0.5), Normal(0.5, 1.0))
SUITE["Convolved"]["numeric"]["construction"] = @benchmarkable convolved(
    Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
