# [Adding a new combination](@id extending)

A combined distribution is a type built from two or more base distributions joined by an algebraic operation.
The package ships three members, [`Convolved`](@ref ConvolvedDistributions.Convolved) (the sum `X + Y + ...`), [`Difference`](@ref) (`Z = X - Y`), and [`Product`](@ref ConvolvedDistributions.Product) (`Z = X * Y`, the Mellin convolution), and the family is designed to grow (a min or max order statistic is the natural next member).
This page documents the contract a new member implements and the conventions the built-in members follow, using them as worked examples.
`Product` was added by following this page, so it doubles as a worked end-to-end example: `src/Product.jl` for the type and numeric path, the Optimization extension for `quantile`, `test/distributions/Product.jl` and the `test/ADFixtures` scenarios for the verification surface.

## The family supertype

`AbstractConvolvedDistribution{F, S}` in [`src/interface.jl`](https://github.com/EpiAware/ConvolvedDistributions.jl/blob/main/src/interface.jl) is the supertype of the multi-base algebraic combinations.
It is parametric on variate form and value support for symmetry with the wider EpiAware family model (`Distribution{F, S}`), so a univariate member subtypes

```julia
AbstractConvolvedDistribution{Distributions.Univariate, Continuous}
```

and remains a `UnivariateDistribution`, keeping all existing `Distributions.jl` dispatch.

## The contract

The documented interface contract on the abstract type requires of a concrete subtype:

- `params(d)` returning a tuple (the built-ins return the tuple of component parameter tuples);
- `logpdf(d, x)` finite at in-support points;
- `Base.show(io, d)` producing a non-empty display.

`ConvolvedDistributions.TestUtils.test_convolved_interface` verifies exactly this, and `test_abstract_membership` checks the hierarchy itself.

## Conventions the built-ins follow

Beyond the minimal contract, `Convolved`, `Difference`, and `Product` share conventions a new member should copy so the family behaves uniformly.

**A solver-method field.**
Each type carries a `method::AbstractSolverMethod` field, defaulting to `AnalyticalSolver()`.
The CDF and PDF check for a closed form first and fall back to numeric quadrature; a `NumericSolver` forces the quadrature path, which is how the numeric machinery is validated against the analytic results.
Select the analytic pairs by dispatch (as `_try_convolve` does), never by `try`/`catch` — Mooncake reverse cannot differentiate through `try`/`catch`.

**AD-safe quadrature.**
The numeric path uses the shared fixed-node Gauss-Legendre layer (`gl_integrate` in `src/integration.jl`).
Infinite integration bounds are clamped to extreme quantiles of the integration component via `_finite_window`, which strips AD wrappers first so the window is a non-differentiated constant on every backend.

**Clamped probability outputs.**
`cdf` values are clamped to `[0, 1]`, `pdf` values to non-negative, and `logpdf` returns `-Inf` outside the support and for non-positive densities, so quadrature noise never produces an invalid probability.

**Exact moments where they exist.**
`mean`, `var`, and `std` use the exact algebra of the operation (sums of component moments for `Convolved`, differences and sums for `Difference`), not quadrature.
A component without an analytic moment errors from its own `mean`/`var`; there is no numeric fallback.

**Support, sampling, and element type.**
`minimum`/`maximum` combine the component supports under the operation, `insupport` derives from them, `rand` applies the operation to component draws, and `Base.eltype` promotes the component element types (without it, `rand(rng, d, n)` falls back to `Vector{Any}`).

**Batched evaluation where it pays.**
`Convolved` provides vector-argument `cdf`/`pdf`/`logpdf` methods that share one quadrature window solve across the batch.
Optional, but worth copying for any member whose numeric path dominates.

**Quantiles stay in the extension.**
There is no closed-form inverse CDF for a generic combination, so `quantile` methods live in `ext/ConvolvedDistributionsOptimizationExt.jl` and invert `cdf` numerically.
A new member adds a `quantile` method and a starting-guess helper there, not in `src/`.

## A worked sketch

A sketch of a `Largest` member, the maximum of independent components, where independence gives the closed form ``F_Z(z) = \prod_i F_i(z)``.
This is illustrative rather than complete (no solver field, no batched methods, no extension `quantile`):

```julia
struct Largest{C <: Tuple} <:
       AbstractConvolvedDistribution{Distributions.Univariate, Continuous}
    "Tuple of independent component distributions."
    components::C

    function Largest(components::C) where {C <: Tuple}
        length(components) >= 2 ||
            throw(ArgumentError("Largest needs at least two components"))
        all(c -> c isa UnivariateDistribution, components) ||
            throw(ArgumentError(
                "All components must be UnivariateDistributions"))
        new{C}(components)
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
insupport(d::Largest, x::Real) = minimum(d) <= x <= maximum(d)

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

Route CDF evaluations through `cdf_ad_safe` (from [EpiAwareADTools.jl](https://github.com/EpiAware/EpiAwareADTools.jl), the shared home of the AD-safe hook family) rather than bare `cdf` so `Gamma` components differentiate on every backend.
A wrapper package with its own component types extends the EpiAwareADTools hooks (`cdf_ad_safe`, `logcdf_ad_safe`, `ccdf_ad_safe`, `logccdf_ad_safe`, `pdf_ad_safe`) by depending on EpiAwareADTools directly.
A member whose operation has no closed form at all (as for a general convolution) instead builds its `cdf`/`pdf` on `gl_integrate`, following `Convolved`'s numeric path.

## Verifying the new member

Verify the contract with the shipped `TestUtils` verifiers, the same entry points `test/package/interface.jl` uses for the built-ins:

```julia
using ConvolvedDistributions.TestUtils: test_convolved_interface,
                                        test_abstract_membership

test_convolved_interface(largest(Gamma(2.0, 1.0), LogNormal(0.5, 0.4));
    x = 3.0)
test_abstract_membership()
```

`test_convolved_interface(d; x)` checks the subtyping, `params`, a finite `logpdf` at the in-support point `x`, and a non-empty `show`.
`test_abstract_membership` asserts the built-in members sit in the right place in the hierarchy; when adding a member to this package, add your type to its tuple in `src/TestUtils.jl` so the meta-test covers it.
A downstream package defining its own member calls `test_convolved_interface` on its instances directly.

## Checklist

- [ ] Struct subtyping `AbstractConvolvedDistribution{Univariate, Continuous}` with a validated inner constructor (throw an `ArgumentError` naming the restriction for out-of-scope components, as `Product` does for sign-crossing supports)
- [ ] Lowercase constructor verb as the user-facing entry point; check the verb and type names against `names(Base)` and `names(Distributions)` first (`Product` is public-not-exported because Distributions exports a deprecated `Product`)
- [ ] The contract: `params`, finite in-support `logpdf`, `Base.show`
- [ ] Support (`minimum`/`maximum`/`insupport`), `rand`, `sampler`, `Base.eltype`
- [ ] Analytic fast path by dispatch plus an AD-safe numeric fallback, with clamped `cdf`/`pdf` and the full log family (`logcdf`, `ccdf`, `logccdf` via `log1mexp`)
- [ ] Include the new file after `src/Convolved.jl`, which owns the shared window helpers (`_window_quantile`, `_CONVOLVED_TAIL`, `_min2`/`_max2`)
- [ ] Exact analytic moments where the operation admits them
- [ ] `quantile` method in the Optimization extension if inverse-CDF support is wanted
- [ ] Docstrings in the house style (`@doc` blocks, `# Examples`, `# See also`)
- [ ] Export the verb; mark the type `public` in `src/public.jl`
- [ ] Tests under `test/distributions/`, `test_convolved_interface` coverage in `test/package/interface.jl`, membership in `src/TestUtils.jl`, and ADFixtures gradient scenarios (numeric path w.r.t. each component, moments)
- [ ] Update the member lists in the prose surfaces: this page, the abstract-type docstring, the module docstring, the getting-started walkthrough and FAQ, the README why-bullets, and a NEWS bullet
- [ ] Benchmark rows under `benchmark/src/` wired into `benchmark/benchmarks.jl` and the suite tree in `docs/benchmarks.md`
