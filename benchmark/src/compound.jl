# Compound (Z = X_1 + ... + X_N), the random-length member. The
# Poisson∘Bernoulli pair has a closed-form thinning (`analytic`, a
# `Poisson`); the Poisson∘Poisson pair runs the exact Panjer recursion on
# the lattice (`lattice`, `O(z^2)` per evaluation, so its cost grows with
# the evaluation point); the Poisson∘Gamma pair runs the exact mixture
# of n-fold `Gamma` closed forms (`mixture`, one `Gamma` density or CDF
# per count term up to the count's tail quantile). None of the three is
# quadrature, so there is no `numeric` variant in the other groups'
# sense; every variant is exact.
#
# Compound has no batched vector methods, so evaluation rows broadcast
# the scalar path. The lattice variants evaluate on integer points
# (`TEST_KS`) since off-lattice points are answered in O(1) as zero mass;
# the mixture variant uses the shared positive points. Every variant has
# an exact `mean`, so each gets a `mean` row.

SUITE["Compound"] = BenchmarkGroup()

const TEST_KS = collect(0:11)

const COMPOUND_VARIANTS = [
    ("analytic", compound(Poisson(2.0), Bernoulli(0.3)), 2, TEST_KS),
    ("lattice", compound(Poisson(3.0), Poisson(2.0)), 6, TEST_KS),
    ("mixture", compound(Poisson(3.0), Gamma(2.0, 1.0)), 6.0, TEST_XS),
]

for (name, d, x, xs) in COMPOUND_VARIANTS
    g = SUITE["Compound"][name] = BenchmarkGroup()

    g["logpdf scalar"] = @benchmarkable logpdf($d, $x)
    g["cdf scalar"] = @benchmarkable cdf($d, $x)
    g["logpdf broadcast"] = @benchmarkable logpdf.($d, $xs)
    g["cdf broadcast"] = @benchmarkable cdf.($d, $xs)
    g["rand"] = @benchmarkable rand($d, 100)
    g["mean"] = @benchmarkable mean($d)
end

SUITE["Compound"]["analytic"]["construction"] = @benchmarkable compound(
    Poisson(2.0), Bernoulli(0.3)
)
SUITE["Compound"]["lattice"]["construction"] = @benchmarkable compound(
    Poisson(3.0), Poisson(2.0)
)
SUITE["Compound"]["mixture"]["construction"] = @benchmarkable compound(
    Poisson(3.0), Gamma(2.0, 1.0)
)
