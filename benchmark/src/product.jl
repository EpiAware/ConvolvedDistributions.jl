# Product (Z = X * Y), the Mellin-convolution member. The
# LogNormal-LogNormal pair has a closed-form product (`analytic`); the
# Gamma-LogNormal pair runs the numeric Mellin quadrature (`numeric`),
# whose CDF saturated-mass split is the extra cost over Difference.
# Product has no batched vector methods, so evaluation rows broadcast
# the scalar path over the shared positive points.

SUITE["Product"] = BenchmarkGroup()

const PRODUCT_VARIANTS = [
    "analytic" => product(LogNormal(0.5, 0.4), LogNormal(0.0, 0.3)),
    "numeric" => product(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
]

for (name, d) in PRODUCT_VARIANTS
    g = SUITE["Product"][name] = BenchmarkGroup()

    g["logpdf scalar"] = @benchmarkable logpdf($d, 2.0)
    g["cdf scalar"] = @benchmarkable cdf($d, 2.0)
    g["logpdf broadcast"] = @benchmarkable logpdf.($d, $TEST_XS)
    g["cdf broadcast"] = @benchmarkable cdf.($d, $TEST_XS)
    g["rand"] = @benchmarkable rand($d, 100)
    g["mean"] = @benchmarkable mean($d)
end

SUITE["Product"]["analytic"]["construction"] = @benchmarkable product(
    LogNormal(0.5, 0.4), LogNormal(0.0, 0.3))
SUITE["Product"]["numeric"]["construction"] = @benchmarkable product(
    Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
