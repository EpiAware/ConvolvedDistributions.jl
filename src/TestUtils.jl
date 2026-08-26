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

using Random: Random

using Distributions: Distributions, Discrete, cdf, insupport, logcdf, logpdf,
    params, pdf

using ..ConvolvedDistributions: AbstractConvolvedDistribution, Convolved,
    Difference, Product, Ratio, _maybe_analytic,
    is_exact

@doc "

Assert a combined distribution satisfies the
[`AbstractConvolvedDistribution`](@ref) contract.

`test_convolved_interface(d; x)` checks `d` subtypes
`AbstractConvolvedDistribution` (a multi-base algebraic combination) and
exposes `params`, a finite `logpdf` at the in-support point `x`, and a
non-empty `show`. Use for [`Convolved`](@ref), [`Difference`](@ref),
[`Product`](@ref), and [`Ratio`](@ref) and any new member of the family.
Returns the `@testset` object.
"
function test_convolved_interface(
        d; name::AbstractString = string(nameof(typeof(d))), x::Real = 1.0
    )
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
This only covers the `:analytic` route: an object whose exact discrete
fold makes it [`is_exact`](@ref ConvolvedDistributions.is_exact) but
which has no closed form (`evaluation_path(d) === :numeric`) has no
reference distribution to compare against here, so it is also a no-op
for that case — use [`test_discrete_pmf`](@ref) instead. Returns the
`@testset` object.

# See also
- `ConvolvedDistributions.evaluation_path`: the queryable predicate this
  guards (#92).
- [`test_discrete_pmf`](@ref): the verifier for an exact discrete
  combination.
"
function test_analytic_skips_quadrature(
        d; name::AbstractString = string(nameof(typeof(d))), x::Real = 1.0
    )
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

Assert a discrete-typed combination is a well-formed, exact pmf over
`support`.

`test_discrete_pmf(d; support)` verifies `d` for any family member typed
`Discrete` (a [`Convolved`](@ref ConvolvedDistributions.Convolved),
[`Difference`](@ref), [`Product`](@ref ConvolvedDistributions.Product),
or a downstream member such as a compound distribution or an order
statistic): `Distributions.value_support(typeof(d)) === Discrete`; every
mass over `support` is non-negative; the masses over `support` sum to
`1` to within `atol`; `cdf(d, k)` equals the running sum of masses to the
same tolerance; the half-integer point just above `first(support)`
carries zero density (`pdf` `0`, `logpdf` `-Inf`); and
[`is_exact`](@ref ConvolvedDistributions.is_exact)`(d)` — evaluating `d`
carries no quadrature error, whether from a registered closed form or
the exact discrete fold; and that `rand(d, 20)` draws land in `d`'s
support (a `Base.eltype` that merely `promote_type`s the component
element types, rather than the type the combining operation actually
produces, is too narrow for some `Discrete`-typed members and throws
`InexactError` here). `support` should cover enough of `d`'s mass for
the sum-to-one check to be meaningful (the full support for a bounded
combination, a wide enough range for an unbounded one). Returns the
`@testset` object.
"
function test_discrete_pmf(
        d; support::AbstractVector{<:Integer},
        name::AbstractString = string(nameof(typeof(d))),
        atol::Real = 1.0e-8
    )
    return @testset "discrete pmf: $name" begin
        @test Distributions.value_support(typeof(d)) === Discrete

        masses = [pdf(d, k) for k in support]
        @test all(m -> m >= 0, masses)
        @test isapprox(sum(masses), 1; atol = atol)

        running = zero(atol)
        for (k, m) in zip(support, masses)
            running += m
            @test isapprox(cdf(d, k), running; atol = atol)
        end

        off_lattice = first(support) + 0.5
        @test pdf(d, off_lattice) == 0
        @test logpdf(d, off_lattice) == -Inf

        @test is_exact(d)

        # `rand(d, n)` must not throw: a `Base.eltype` that merely
        # `promote_type`s the component element types (rather than the
        # type the combining operation actually produces) is too narrow
        # for a `Discrete`-typed member built from e.g. `Bernoulli`
        # components (`eltype == Bool`), and `Distributions.rand`
        # allocates `Array{eltype(d)}` for a discrete distribution, so
        # the first out-of-range draw throws `InexactError`.
        draws = Base.rand(Random.default_rng(), d, 20)
        @test all(x -> insupport(d, x), draws)
    end
end

@doc "

Assert the built-in combination types subtype the family supertype.

`test_abstract_membership()` is the meta-test that the abstract hierarchy
stays consistent: the multi-base combinations `Convolved`, `Difference`,
`Product`, and `Ratio` subtype [`AbstractConvolvedDistribution`](@ref),
which itself sits under `Distributions.Distribution` so the univariate
members remain `UnivariateDistribution`s. A type filed under the wrong
family fails here. Returns the `@testset` object.
"
function test_abstract_membership()
    return @testset "abstract hierarchy membership" begin
        for T in (Convolved, Difference, Product, Ratio)
            @test T <: AbstractConvolvedDistribution
            @test T <: Distributions.UnivariateDistribution
        end
        @test AbstractConvolvedDistribution <: Distributions.Distribution
    end
end

# What a component is called on, split by whether the family can do
# without it. `Convolved` construction checks none of this: a fixed list
# in the constructor is both too strict (it rejects a type that dispatches
# through a supertype, or that gains the method later) and incomplete
# (which methods are needed depends on the component's position and the
# quantity asked for). This is the opt-in verifier instead.
const _COMPONENT_REQUIRED = (:logpdf, :pdf, :minimum, :maximum)
const _COMPONENT_SLOT_REQUIRED = (:cdf, :ccdf, :logcdf, :logccdf)
const _COMPONENT_OPTIONAL = (:mean, :var, :rand, :quantile, :params)

@doc "

Check a duck-typed component against what `Convolved` calls on it.

`test_component_interface(c; x)` is for a leaf that implements the
Distributions.jl univariate interface without subtyping
`UnivariateDistribution`. `Convolved` accepts any component and lets a
missing method fail on the call, so this is where a downstream author
checks their leaf deliberately rather than discovering a gap mid-fold.

Two tiers, because not everything is core. `logpdf`, `pdf`, `minimum`
and `maximum` are needed by every density evaluation and **fail**.
`cdf`, `ccdf`, `logcdf` and `logccdf` also fail when
`integration_slot = true`, meaning the component may sit last, where the
CDF quantities route through it. Everything else (`mean`, `var`,
`rand`, `quantile`, `params`) only matters for the quantity that asks
for it, so a gap **warns**: a leaf with no `mean` is perfectly usable
until someone calls `mean`.

`Base.eltype` sits in the warning tier too. `Convolved` reads a
duck-typed leaf's value support from it, and Base's fallback of `Any`
reads as continuous. That is right for a continuous leaf, so an
undefined `eltype` cannot fail. It is wrong for a discrete leaf on an
integer lattice, which is quietly routed to quadrature instead of the
exact fold, so an undefined `eltype` warns.

A method counts as present only when it resolves to something more
specific than the generic fallback. `hasmethod` is not enough on its own
because `Base.minimum`, `Base.maximum`, `Statistics.mean`,
`Statistics.var`, `Statistics.quantile` and `Random.rand` all accept
`Any`, so a leaf defining nothing would otherwise look complete.

Pass `strict = true` to promote the warnings to failures. Returns the
`@testset` object.

# See also
- [`test_convolved_interface`](@ref): the contract for a family *member*
  (something subtyping `AbstractConvolvedDistribution`), not a component.
"
function test_component_interface(
        c; name::AbstractString = string(nameof(typeof(c))), x::Real = 1.0,
        integration_slot::Bool = false, strict::Bool = false
    )
    T = typeof(c)
    required = integration_slot ?
        (_COMPONENT_REQUIRED..., _COMPONENT_SLOT_REQUIRED...) :
        _COMPONENT_REQUIRED
    return @testset "component interface: $name" begin
        for f in required
            @test _has_component_method(f, T)
        end
        for f in _COMPONENT_OPTIONAL
            if strict
                @test _has_component_method(f, T)
            elseif !_has_component_method(f, T)
                @warn "$name has no `$f` method. " *
                    "Any quantity needing it will fail on the call" T
            end
        end
        if strict
            @test _declares_eltype(T)
        elseif !_declares_eltype(T)
            @warn "$name does not define `Base.eltype`, so it is taken " *
                "as continuous. A discrete leaf on an integer lattice " *
                "must define it to reach the exact route" T
        end
        @test isfinite(logpdf(c, x))
    end
end

# `hasmethod(Base.eltype, Tuple{Type{T}})` is always true because of
# Base's generic fallback, so the check is on the answer instead: `Any`
# means the leaf declared nothing.
_declares_eltype(T::Type) = Base.eltype(T) !== Any

# The generic function each name is called through. `minimum` and
# `maximum` are Base's. `rand` is `Random`'s. The rest resolve in
# `Distributions`, which re-exports `Statistics`' `mean`, `var` and
# `quantile`.
function _component_generic(f::Symbol)
    f in (:minimum, :maximum) && return getfield(Base, f)
    f === :rand && return Random.rand
    return getfield(Distributions, f)
end

# The signature a component is called on, paired with the generic
# signature that catches anything. `minimum`, `maximum`, `params`, `mean`
# and `var` take the component alone. `rand` takes an rng first. The rest
# take a point or a probability.
function _component_signatures(f::Symbol, T::Type)
    f === :rand &&
        return Tuple{Random.AbstractRNG, T}, Tuple{Random.AbstractRNG, Any}
    f in (:minimum, :maximum, :params, :mean, :var) &&
        return Tuple{T}, Tuple{Any}
    return Tuple{T, Real}, Tuple{Any, Real}
end

_generic_fallback(g, sig) = hasmethod(g, sig) ? which(g, sig) : nothing

# `hasmethod` alone answers the wrong question here. `Base.minimum`,
# `Base.maximum`, `Statistics.mean`, `Statistics.var`,
# `Statistics.quantile` and `Random.rand` all accept `Any`, so a type
# defining no methods at all still satisfies `hasmethod` for most of
# these names. A method counts as present only when it resolves to
# something more specific than the generic fallback. That is the test
# `_more_specific_pair_method` applies to the closed-form pairs.
function _has_component_method(f::Symbol, T::Type)
    g = _component_generic(f)
    specific, generic = _component_signatures(f, T)
    hasmethod(g, specific) || return false
    return which(g, specific) !== _generic_fallback(g, generic)
end

end # module TestUtils
