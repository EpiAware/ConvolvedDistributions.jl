# Bare component distributions: the floor the convolution overhead is
# read against. Every `Convolved`/`Difference` variant below combines
# these same components and evaluates over the same points.

SUITE["Baseline"] = BenchmarkGroup()

let
    g = Gamma(2.0, 1.0)
    SUITE["Baseline"]["Gamma"] = BenchmarkGroup()
    SUITE["Baseline"]["Gamma"]["logpdf"] = @benchmarkable logpdf.(
        $g, $TEST_XS)
    SUITE["Baseline"]["Gamma"]["cdf"] = @benchmarkable cdf.($g, $TEST_XS)

    n = Normal(1.0, 0.5)
    SUITE["Baseline"]["Normal"] = BenchmarkGroup()
    SUITE["Baseline"]["Normal"]["logpdf"] = @benchmarkable logpdf.(
        $n, $TEST_XS)
    SUITE["Baseline"]["Normal"]["cdf"] = @benchmarkable cdf.($n, $TEST_XS)
end
