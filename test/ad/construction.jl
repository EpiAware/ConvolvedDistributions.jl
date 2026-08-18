# Bespoke construction-time AD item (#174). The scenario suite
# differentiates evaluations of an already-built `Convolved`; this pins
# differentiating through FRESH construction on every call -- the pattern
# a Turing model body uses (the distribution is rebuilt on every gradient
# evaluation) that broke Mooncake forward mode when `Convolved`'s
# `_closed_form` resolution ran a `which()` method-table probe on the
# construction-time hot path.

@testitem "Mooncake forward AD through fresh Convolved construction (#174)" tags = [
    :ad, :mooncake, :mooncake_forward,
] begin
    using ConvolvedDistributions
    using ConvolvedDistributions.Distributions: Gamma, Uniform, logpdf
    using ADTypes: AutoMooncakeForward, AutoForwardDiff
    using DifferentiationInterface: gradient
    using Mooncake: Mooncake
    using ForwardDiff: ForwardDiff

    # `Convolved` is built INSIDE the differentiated function, not
    # hoisted out, so its construction-time closed-form resolution
    # (`_resolve_closed_form`/`_more_specific_pair_method`) is itself
    # part of what Mooncake must derive a forward rule for.
    f(θ) = logpdf(convolved(Gamma(θ[1], θ[2]), Uniform(0.0, 1.0)), 2.0)

    θ0 = [2.0, 1.5]
    g_ref = ForwardDiff.gradient(f, θ0)
    g_mc = gradient(f, AutoMooncakeForward(), θ0)
    @test g_mc ≈ g_ref rtol = 1.0e-8
end
