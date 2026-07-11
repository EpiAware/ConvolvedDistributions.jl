"""
    ConvolvedDistributions.TestUtils

Interface-contract verifiers for the package's abstract family.

`TestUtils` ships with the package (mirroring
`CensoredDistributions.TestUtils`) so a downstream author adding a new
algebraic combination can verify it against the
[`AbstractConvolvedDistribution`](@ref) contract without copying test
code. Public but not exported.

# Examples
```@example
using ConvolvedDistributions, Distributions
using ConvolvedDistributions.TestUtils: test_convolved_interface

d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
test_convolved_interface(d; x = 3.0);
nothing # hide
```
"""
module TestUtils

using Test: Test, @test, @testset

using Distributions: Distributions, logpdf, params

using ..ConvolvedDistributions: AbstractConvolvedDistribution, Convolved,
                                Difference, Product

@doc "

Assert a combined distribution satisfies the
[`AbstractConvolvedDistribution`](@ref) contract.

`test_convolved_interface(d; x)` checks `d` subtypes
`AbstractConvolvedDistribution` (a multi-base algebraic combination) and
exposes `params`, a finite `logpdf` at the in-support point `x`, and a
non-empty `show`. Use for [`Convolved`](@ref), [`Difference`](@ref), and
[`Product`](@ref) and any new member of the family. Returns the
`@testset` object.
"
function test_convolved_interface(
        d; name::AbstractString = string(nameof(typeof(d))), x::Real = 1.0)
    return @testset "convolved interface: $name" begin
        @test d isa AbstractConvolvedDistribution
        @test params(d) isa Tuple
        @test isfinite(logpdf(d, x))
        @test !isempty(sprint(show, d))
    end
end

@doc "

Assert the built-in combination types subtype the family supertype.

`test_abstract_membership()` is the meta-test that the abstract hierarchy
stays consistent: the multi-base combinations `Convolved`, `Difference`,
and `Product` subtype [`AbstractConvolvedDistribution`](@ref), which itself
sits under `Distributions.Distribution` so the univariate members remain
`UnivariateDistribution`s. A type filed under the wrong family fails
here. Returns the `@testset` object.
"
function test_abstract_membership()
    return @testset "abstract hierarchy membership" begin
        for T in (Convolved, Difference, Product)
            @test T <: AbstractConvolvedDistribution
            @test T <: Distributions.UnivariateDistribution
        end
        @test AbstractConvolvedDistribution <: Distributions.Distribution
    end
end

end # module TestUtils
