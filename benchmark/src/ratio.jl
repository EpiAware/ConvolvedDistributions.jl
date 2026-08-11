# Ratio (Z = X / Y), the quotient member. The Gamma-Gamma pair has a
# closed-form ratio (`analytic`, a scaled BetaPrime); the Gamma-LogNormal
# pair runs the numeric branch-split quadrature (`numeric`), whose extra
# cost over Product is the control-variate anchor call per branch (§4.3
# of the design note) and the numerator-side window narrowing.
# Ratio has no batched vector methods, so evaluation rows broadcast the
# scalar path over the shared positive points.
#
# `mean` has no closed form for the numeric (Gamma-LogNormal) pair — see
# `_ratio_moment_source` in src/Ratio.jl — so only the analytic variant
# gets a `mean` row.
#
# `BenchmarkTools` exports its own `ratio` (trial-comparison helper), and
# `benchmark/benchmarks.jl` loads both unqualified, so the bare name is
# ambiguous here -- the one naming clash the design spec's `names(Base)`/
# `names(Distributions)` check (src/Ratio.jl §3) did not anticipate. The
# `const` below shadows the bare name with `ConvolvedDistributions.ratio`
# for the rest of this file (and any file included after it in the same
# benchmark run), so it is qualified once here rather than at every call
# site; nothing else in this suite currently needs
# `BenchmarkTools.ratio`, but a later file that does would silently pick
# up the distribution constructor instead unless it re-qualifies.
const ratio = ConvolvedDistributions.ratio

SUITE["Ratio"] = BenchmarkGroup()

const RATIO_VARIANTS = [
    "analytic" => ratio(Gamma(2.0, 1.5), Gamma(3.0, 0.5)),
    "numeric" => ratio(Gamma(2.0, 1.0), LogNormal(0.5, 0.4)),
]

for (name, d) in RATIO_VARIANTS
    g = SUITE["Ratio"][name] = BenchmarkGroup()

    g["logpdf scalar"] = @benchmarkable logpdf($d, 2.0)
    g["cdf scalar"] = @benchmarkable cdf($d, 2.0)
    g["logpdf broadcast"] = @benchmarkable logpdf.($d, $TEST_XS)
    g["cdf broadcast"] = @benchmarkable cdf.($d, $TEST_XS)
    g["rand"] = @benchmarkable rand($d, 100)
    name == "analytic" && (g["mean"] = @benchmarkable mean($d))
end

SUITE["Ratio"]["analytic"]["construction"] = @benchmarkable ratio(
    Gamma(2.0, 1.5), Gamma(3.0, 0.5)
)
SUITE["Ratio"]["numeric"]["construction"] = @benchmarkable ratio(
    Gamma(2.0, 1.0), LogNormal(0.5, 0.4)
)
