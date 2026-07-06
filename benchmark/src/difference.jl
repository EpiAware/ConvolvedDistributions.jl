# Difference (Z = X - Y), the dual of Convolved. The Normal-Normal pair
# has a closed-form difference (`analytic`); the Gamma-LogNormal pair
# runs the numeric cross-correlation quadrature (`numeric`), whose CDF
# window clamp is the extra cost over Convolved. Difference has no
# batched vector methods, so evaluation rows broadcast the scalar path
# over the shared signed points.

SUITE["Difference"] = BenchmarkGroup()

const DIFFERENCE_VARIANTS = [
    "analytic" => difference(Normal(1.0, 0.5), Normal(0.5, 1.0)),
    "numeric" => difference(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
]

for (name, d) in DIFFERENCE_VARIANTS
    g = SUITE["Difference"][name] = BenchmarkGroup()

    g["logpdf scalar"] = @benchmarkable logpdf($d, 0.5)
    g["cdf scalar"] = @benchmarkable cdf($d, 0.5)
    g["logpdf broadcast"] = @benchmarkable logpdf.($d, $TEST_ZS)
    g["cdf broadcast"] = @benchmarkable cdf.($d, $TEST_ZS)
    g["rand"] = @benchmarkable rand($d, 100)
    g["mean"] = @benchmarkable mean($d)
end

SUITE["Difference"]["analytic"]["construction"] = @benchmarkable difference(
    Normal(1.0, 0.5), Normal(0.5, 1.0))
SUITE["Difference"]["numeric"]["construction"] = @benchmarkable difference(
    Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
