# [Adding a new combination](@id extending)

A combined distribution is a type built from two or more base distributions joined by an algebraic operation.
The package ships four members, [`Convolved`](@ref ConvolvedDistributions.Convolved) (the sum `X + Y + ...`), [`Difference`](@ref) (`Z = X - Y`), [`Product`](@ref ConvolvedDistributions.Product) (`Z = X * Y`, the Mellin convolution), and [`Ratio`](@ref) (`Z = X / Y`, the Mellin-quotient form), and the family is designed to grow (a min or max order statistic is the natural next member).
This page documents the contract a new member implements and the conventions the built-in members follow, using them as worked examples.

## The family supertype

`AbstractConvolvedDistribution{F, S}` in [`src/interface.jl`](https://github.com/EpiAware/ConvolvedDistributions.jl/blob/main/src/interface.jl) is the supertype of the multi-base algebraic combinations.
It is parametric on variate form and value support for symmetry with the wider EpiAware family model (`Distribution{F, S}`), so a univariate member subtypes

```julia
AbstractConvolvedDistribution{Distributions.Univariate, S}
```

and remains a `UnivariateDistribution`, keeping all existing `Distributions.jl` dispatch.
`S` is DERIVED from the member's own components, not hardcoded (`ConvolvedDistributions._components_support`, `src/interface.jl`): `Discrete` when every component is an integer-lattice discrete distribution (discrete with `eltype <: Integer`), `Continuous` otherwise.
A member typed `Discrete` MUST provide an exact route for its density and CDF — the shared `is_exact` predicate reports it as exact automatically, keyed off the type parameter alone, so a missing route makes that report a lie (see the checklist).
`Convolved`'s worked example (`_components_support(components)` in its inner constructor) is the pattern to copy, as the sketch below does.

## The contract

The documented interface contract on the abstract type requires of a concrete subtype:

- `params(d)` returning a tuple (the built-ins return the tuple of component parameter tuples);
- `logpdf(d, x)` finite at in-support points;
- `Base.show(io, d)` producing a non-empty display.

`ConvolvedDistributions.TestUtils.test_convolved_interface` verifies exactly this, and `test_abstract_membership` checks the hierarchy itself.

## Conventions the built-ins follow

Beyond the minimal contract, `Convolved`, `Difference`, `Product`, and `Ratio` share conventions a new member should copy so the family behaves uniformly.

**A solver-method field.**
Each type carries a `method::AbstractSolverMethod` field, defaulting to `AnalyticalSolver()`.
The CDF and PDF check for a closed form first and fall back to numeric quadrature; a `NumericSolver` forces the quadrature path, which is how the numeric machinery is validated against the analytic results.
Select the analytic pairs by dispatch (as `convolve_pair` does), never by `try`/`catch` — Mooncake reverse cannot differentiate through `try`/`catch`.

**AD-safe quadrature.**
The numeric path uses the shared fixed-node Gauss-Legendre layer (`gl_integrate` in `src/integration.jl`).
Infinite integration bounds are clamped to extreme quantiles of the integration component via `_finite_window`, which strips AD wrappers first so the window is a non-differentiated constant on every backend.

**Clamped probability outputs.**
`cdf` values are clamped to `[0, 1]`, `pdf` values to non-negative, and `logpdf` returns `-Inf` outside the support and for non-positive densities, so quadrature noise never produces an invalid probability.

**Exact moments where they exist.**
`mean`, `var`, and `std` use the exact algebra of the operation (sums of component moments for `Convolved`, differences and sums for `Difference`), not quadrature.
A component without an analytic moment errors from its own `mean`/`var`; there is no numeric fallback.

**Support, sampling, and element type.**
`minimum`/`maximum` combine the component supports under the operation, `insupport` derives from them (AND gates on `ConvolvedDistributions._on_lattice(d, x)` first, so an off-lattice point on a discrete-typed member is correctly out of support), `rand` applies the operation to component draws, and `Base.eltype` promotes the component element types (without it, `rand(rng, d, n)` falls back to `Vector{Any}`).

**Batched evaluation where it pays.**
`Convolved` provides vector-argument `cdf`/`pdf`/`logpdf` methods that share one quadrature window solve across the batch.
Optional, but worth copying for any member whose numeric path dominates.

**Quantiles stay in the extension.**
There is no closed-form inverse CDF for a generic combination, so `quantile` methods live in `ext/ConvolvedDistributionsOptimizationExt.jl` and invert `cdf` numerically.
A new member adds a `quantile` method and a starting-guess helper there, not in `src/`.

## A worked sketch

A sketch of a `Largest` member, the maximum of independent components, where independence gives the closed form ``F_Z(z) = \prod_i F_i(z)``:

```julia
struct Largest{C <: Tuple, S <: Distributions.ValueSupport} <:
       AbstractConvolvedDistribution{Distributions.Univariate, S}
    "Tuple of independent component distributions."
    components::C

    function Largest(components::C) where {C <: Tuple}
        length(components) >= 2 ||
            throw(ArgumentError("Largest needs at least two components"))
        all(c -> c isa UnivariateDistribution, components) ||
            throw(ArgumentError(
                "All components must be UnivariateDistributions"))
        S = ConvolvedDistributions._components_support(components)
        new{C, S}(components)
    end
end

# The user-facing constructor verb.
largest(components::UnivariateDistribution...) = Largest(components)

# --- the contract -----------------------------------------------------------

params(d::Largest) = map(params, d.components)

function logpdf(d::Largest, x::Real)
    insupport(d, x) || return oftype(float(x), -Inf)
    p = pdf(d, x)
    return p <= 0 ? oftype(float(x), -Inf) : log(p)
end

function Base.show(io::IO, d::Largest)
    print(io, "Largest(", join(string.(d.components), ", "), ")")
end

# --- the family conventions -------------------------------------------------

minimum(d::Largest) = maximum(map(minimum, d.components))
maximum(d::Largest) = maximum(map(maximum, d.components))
function insupport(d::Largest, x::Real)
    return ConvolvedDistributions._on_lattice(d, x) && minimum(d) <= x <= maximum(d)
end

Base.rand(rng::AbstractRNG, d::Largest) =
    maximum(map(c -> rand(rng, c), d.components))

function Base.eltype(::Type{<:Largest{C}}) where {C <: Tuple}
    return mapreduce(eltype, promote_type, fieldtypes(C))
end

# Independence: F_Z(z) = prod_i F_i(z), clamped against numeric noise.
function cdf(d::Largest, x::Real)
    result = prod(c -> cdf_ad_safe(c, x), d.components)
    return clamp(result, zero(result), one(result))
end

# Product rule: f_Z(z) = sum_i f_i(z) * prod_{j != i} F_j(z).
function pdf(d::Largest, x::Real)
    result = sum(eachindex(d.components)) do i
        fi = pdf(d.components[i], x)
        rest = prod(j -> j == i ? one(fi) : cdf_ad_safe(d.components[j], x),
            eachindex(d.components))
        fi * rest
    end
    return max(result, zero(result))
end
```

This sketch is illustrative rather than complete: no solver field, no batched methods, no exact discrete route, no extension `quantile`.
Building a real member from it, one gap matters more than the rest — `is_exact` would report a discrete-typed `Largest` built this way as exact when it is not, exactly the trap the checklist below warns about, so a real member ships the lattice fold alongside deriving `S`.

Route CDF evaluations through `cdf_ad_safe` (from [EpiAwareADTools.jl](https://github.com/EpiAware/EpiAwareADTools.jl), the shared home of the AD-safe hook family) rather than bare `cdf` so `Gamma` components differentiate on every backend.
A wrapper package with its own component types extends the EpiAwareADTools hooks (`cdf_ad_safe`, `logcdf_ad_safe`, `ccdf_ad_safe`, `logccdf_ad_safe`, `pdf_ad_safe`) by depending on EpiAwareADTools directly.
A member whose operation has no closed form at all (as for a general convolution) instead builds its `cdf`/`pdf` on `gl_integrate`, following `Convolved`'s numeric path.

## Verifying the new member

Verify the contract with the shipped `TestUtils` verifiers, the same entry points `test/package/interface.jl` uses for the built-ins:

```julia
using ConvolvedDistributions.TestUtils: test_convolved_interface,
                                        test_abstract_membership,
                                        test_discrete_pmf

test_convolved_interface(largest(Gamma(2.0, 1.0), LogNormal(0.5, 0.4));
    x = 3.0)
test_abstract_membership()

# A Discrete-typed member with a lattice fold also gets `test_discrete_pmf`
# (not the `Largest` sketch above, which has no exact discrete route):
test_discrete_pmf(convolved(Poisson(2.0), Poisson(3.0));
    support = 0:30)
```

`test_convolved_interface(d; x)` checks the subtyping, `params`, a finite `logpdf` at the in-support point `x`, and a non-empty `show`.
`test_abstract_membership` asserts the built-in members sit in the right place in the hierarchy; when adding a member to this package, add your type to its tuple in `src/TestUtils.jl` so the meta-test covers it.
`test_discrete_pmf(d; support)` is the verifier for any `Discrete`-typed family member: it asserts `value_support(typeof(d)) === Discrete`, non-negative masses summing to `≈ 1` over `support`, `cdf` matching the running mass sum, an off-lattice point carrying no mass, and `is_exact(d)`; that last assertion is what catches a `Discrete`-typed member that forgot to ship an exact route (see the checklist item above).
A downstream package defining its own member calls `test_convolved_interface` (and, when discrete, `test_discrete_pmf`) on its instances directly.

## Verifying a duck-typed component

A component is not required to subtype `Distributions.UnivariateDistribution`. A *duck-typed* leaf implements the univariate interface `convolved` calls on it — the densities, the CDF quantities, the moments, sampling and element type — without any distribution supertype, so a downstream author can use their own `Uniform`-ish type as a component of `convolved`, `difference`, `product`, or `ratio` without filing it in the package's type system. A duck-typed component has no registered closed form, so it always evaluates through numeric quadrature rather than an analytic fast path; it may sit in any position, including the integration slot ("last"), where the CDF quantities route through it.

Construction deliberately checks **no method list**. Which methods a component needs depends on where it sits and which quantity is asked for, so any fixed list is both too strict (it rejects a type that dispatches through a supertype, or gains the method later) and too incomplete. A missing method instead fails on the call itself, naming what to define — so it is only discovered mid-fold, in a `MethodError` the user has to interpret. `TestUtils.test_component_interface(c; x)` is the opt-in verifier that runs a leaf against what `convolved` calls on it before the fold ever happens. It splits the interface into tiers, because not everything is core:

- **fail** — `logpdf`, `pdf`, `minimum`, `maximum`: needed by every density evaluation and support fold, so a gap is fatal.
- **fail with `integration_slot = true`** — `cdf`, `ccdf`, `logcdf`, `logccdf`. These only bind if the leaf may sit last, in the quadrature's integration slot.
- **warn** — `mean`, `var`, `rand`, `quantile`, `params`. Each matters only to the quantity that asks, so a gap warns: a leaf with no `mean` is perfectly usable until someone calls `mean`.

`Base.eltype` sits in the warning tier too. `convolved` reads a duck-typed leaf's value support from it alone (there is no `value_support` to ask), and Base's fallback of `Any` reads as continuous — right for a continuous leaf, so an undefined `eltype` cannot fail, but wrong for a discrete leaf on an integer lattice, which is quietly routed to quadrature instead of the exact fold. A discrete leaf must define `Base.eltype` returning an `Integer` to reach that exact route. Pass `strict = true` to promote every warning to a failure, holding leaves that must be exact (or that the author simply wants well-specified) to the full interface.

One check the verifier does NOT make: a discrete leaf used as a [`ratio`](@ref) *denominator* must also define `Distributions.insupport` for the construction-time atom-at-zero check to apply. Without it the leaf is admitted and the check is skipped — deliberate, since `Distributions` defines `insupport` only for `UnivariateDistribution` subtypes and a raw `MethodError` at construction would be worse.

```julia
using Distributions
using ConvolvedDistributions.TestUtils: test_component_interface

# A Uniform on [a, b], implementing the univariate interface without
# subtyping `UnivariateDistribution`.
struct DuckUniform
    a::Float64
    b::Float64
end

Distributions.logpdf(d::DuckUniform, x::Real) =
    d.a <= x <= d.b ? -log(d.b - d.a) : -Inf
Distributions.pdf(d::DuckUniform, x::Real) =
    d.a <= x <= d.b ? 1 / (d.b - d.a) : 0.0
Distributions.cdf(d::DuckUniform, x::Real) =
    clamp((x - d.a) / (d.b - d.a), 0.0, 1.0)
Distributions.ccdf(d::DuckUniform, x::Real) = 1 - cdf(d, x)
Distributions.logcdf(d::DuckUniform, x::Real) = log(cdf(d, x))
Distributions.logccdf(d::DuckUniform, x::Real) = log(ccdf(d, x))
Distributions.quantile(d::DuckUniform, p::Real) = d.a + p * (d.b - d.a)
Distributions.params(d::DuckUniform) = (d.a, d.b)
Distributions.minimum(d::DuckUniform) = d.a
Distributions.maximum(d::DuckUniform) = d.b
Distributions.mean(d::DuckUniform) = (d.a + d.b) / 2
Distributions.var(d::DuckUniform) = (d.b - d.a)^2 / 12
Base.rand(rng::AbstractRNG, d::DuckUniform) = d.a + rand(rng) * (d.b - d.a)
Base.eltype(::Type{DuckUniform}) = Float64

duck = DuckUniform(0.0, 1.0)

# A complete leaf passes even in strict mode; `integration_slot = true`
# is right here because the leaf may be folded last (quadrature's
# integration variable), which also demands the CDF quantities.
test_component_interface(duck; x = 0.5, integration_slot = true,
    strict = true)
```

Where the family-member verifier `test_convolved_interface` in Verifying the new member above checks a *family member* (something subtyping `AbstractConvolvedDistribution`), `test_component_interface` checks a *component*, the leaf such a member folds over. `test_convolved_interface` verifies the member you build; `test_component_interface` verifies each leaf you pass it, before the first density computation ever runs.

## Checklist

- [ ] Struct subtyping `AbstractConvolvedDistribution{Univariate, S}` with `S` DERIVED via `_components_support(...)` in the inner constructor (not hardcoded `Continuous`), and a validated inner constructor (throw an `ArgumentError` naming the restriction for out-of-scope components, as `Product` does for sign-crossing supports)
- [ ] If the member can be typed `Discrete` (every component an integer-lattice discrete distribution), it MUST provide an exact route (a lattice-style fold, mirroring `src/lattice.jl`) — `is_exact` will report it as exact automatically, keyed off the type parameter alone, so a missing route makes that report a lie
- [ ] Lowercase constructor verb as the user-facing entry point; check the verb and type names against `names(Base)` and `names(Distributions)` first (`Product` is public-not-exported because Distributions exports a deprecated `Product`)
- [ ] The contract: `params`, finite in-support `logpdf`, `Base.show`
- [ ] Support (`minimum`/`maximum`/`insupport` gating on `_on_lattice`), `rand`, `sampler`, `Base.eltype`
- [ ] Analytic fast path by dispatch plus an AD-safe numeric fallback (and, if `Discrete`-typed, the exact discrete fold), with clamped `cdf`/`pdf` and the full log family (`logcdf`, `ccdf`, `logccdf` via `log1mexp`)
- [ ] Include the new file after `src/Convolved.jl`, which owns the shared window helpers (`_window_quantile`, `_CONVOLVED_TAIL`, `_min2`/`_max2`)
- [ ] Exact analytic moments where the operation admits them
- [ ] `quantile` method in the Optimization extension if inverse-CDF support is wanted
- [ ] Docstrings in the house style (`@doc` blocks, `# Examples`, `# See also`)
- [ ] Export the verb; mark the type `public` in `src/public.jl`
- [ ] Tests under `test/distributions/`, `test_convolved_interface` coverage in `test/package/interface.jl` (plus `test_discrete_pmf` coverage there if the member can be `Discrete`-typed), membership in `src/TestUtils.jl`, and ADFixtures gradient scenarios (numeric path w.r.t. each component, moments)
- [ ] Update the member lists in the prose surfaces: this page, the abstract-type docstring, the module docstring, the getting-started walkthrough and FAQ, the README why-bullets, and a NEWS bullet
- [ ] Benchmark rows under `benchmark/src/` wired into `benchmark/benchmarks.jl` and the suite tree in `docs/benchmarks.md`
