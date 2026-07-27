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

using Distributions: Distributions, cdf, logcdf, logpdf, params, pdf

using ..ConvolvedDistributions: AbstractConvolvedDistribution, Convolved,
                                Difference, Product, _maybe_analytic

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

Assert that a combination reporting the analytic evaluation path does not
touch the quadrature machinery: `pdf`/`logpdf`/`cdf`/`logcdf` at `x` match
the underlying closed-form distribution's own values exactly (`===`, not
just `≈`), rather than merely agreeing with it to within a numerical
tolerance a quadrature computation could also hit by coincidence.

A no-op when `d` has no closed form (nothing is asserted), so it can be
called unconditionally in a sweep over both analytic and numeric cases.
Returns the `@testset` object.

# See also
- `ConvolvedDistributions.evaluation_path`: the queryable predicate this
  guards (#92).
"
function test_analytic_skips_quadrature(
        d; name::AbstractString = string(nameof(typeof(d))), x::Real = 1.0)
    return @testset "analytic path skips quadrature: $name" begin
        analytic = _maybe_analytic(d)
        if analytic !== nothing
            @test pdf(d, x) === pdf(analytic, x)
            @test logpdf(d, x) === logpdf(analytic, x)
            @test cdf(d, x) === cdf(analytic, x)
            @test logcdf(d, x) === logcdf(analytic, x)
        end
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
