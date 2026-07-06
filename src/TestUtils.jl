"""
    ConvolvedDistributions.TestUtils

Interface-contract verifiers for the package's abstract family.

`TestUtils` ships with the package (mirroring
`CensoredDistributions.TestUtils`) so a downstream author adding a new
algebraic combination can verify it against the
[`AbstractCombinedDistribution`](@ref) contract without copying test
code. Public but not exported.

# Examples
```@example
using ConvolvedDistributions, Distributions
using ConvolvedDistributions.TestUtils: test_combined_interface

d = convolve_distributions(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
test_combined_interface(d; x = 3.0);
nothing # hide
```
"""
module TestUtils

using Test: Test, @test, @testset

using Distributions: Distributions, logpdf, params

using ..ConvolvedDistributions: AbstractCombinedDistribution, Convolved,
                                Difference

@doc "

Assert a combined distribution satisfies the
[`AbstractCombinedDistribution`](@ref) contract.

`test_combined_interface(d; x)` checks `d` subtypes
`AbstractCombinedDistribution` (a multi-base algebraic combination) and
exposes `params`, a finite `logpdf` at the in-support point `x`, and a
non-empty `show`. Use for [`Convolved`](@ref) and [`Difference`](@ref)
and any new member of the family. Returns the `@testset` object.
"
function test_combined_interface(
        d; name::AbstractString = string(nameof(typeof(d))), x::Real = 1.0)
    return @testset "combined interface: $name" begin
        @test d isa AbstractCombinedDistribution
        @test params(d) isa Tuple
        @test isfinite(logpdf(d, x))
        @test !isempty(sprint(show, d))
    end
end

@doc "

Assert the built-in combination types subtype the family supertype.

`test_abstract_membership()` is the meta-test that the abstract hierarchy
stays consistent: the multi-base combinations `Convolved` and
`Difference` subtype [`AbstractCombinedDistribution`](@ref), which itself
sits under `Distributions.Distribution` so the univariate members remain
`UnivariateDistribution`s. A type filed under the wrong family fails
here. Returns the `@testset` object.
"
function test_abstract_membership()
    return @testset "abstract hierarchy membership" begin
        for T in (Convolved, Difference)
            @test T <: AbstractCombinedDistribution
            @test T <: Distributions.UnivariateDistribution
        end
        @test AbstractCombinedDistribution <: Distributions.Distribution
    end
end

end # module TestUtils
