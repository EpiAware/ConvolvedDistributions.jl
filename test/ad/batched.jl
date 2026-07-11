# Bespoke batched-path AD items. The scenario suite covers the batched
# vector `logpdf` end to end (see `ADFixtures`); these pin the issue #44
# ReverseDiff regression directly: the batched composite accumulator
# must not mutate tracked storage ("TrackedArrays do not support
# setindex!" from the old `fill`-seeded accumulator).

@testitem "batched ReverseDiff gradient wrt evaluation points (#44)" tags=[
    :ad, :reversediff] begin
    using ConvolvedDistributions
    using ConvolvedDistributions.Distributions: Gamma, LogNormal,
                                                logpdf, pdf, cdf
    using ForwardDiff, ReverseDiff

    d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
    obs = [1.0, 2.0, 3.0, 5.0]

    # The scalar-path ForwardDiff gradient is the trusted reference.
    for f in (logpdf, pdf, cdf)
        g_ref = ForwardDiff.gradient(
            x -> sum(xi -> f(d, xi), x), obs)
        g_rd = ReverseDiff.gradient(x -> sum(f(d, x)), obs)
        @test g_rd ≈ g_ref rtol=1e-6
    end
end
