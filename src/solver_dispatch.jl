# Solver-method dispatch (#77) for `Convolved`, generalised to any number
# of components (#80 review A): the components travel together as a
# TUPLE, e.g. `convolved_cdf(d, components, x, method)`, so a pair
# closed form is just a method on a two-element tuple TYPE
# (`Tuple{Gamma, Uniform}`, plus its mirrored order) and nothing in the
# public surface is restricted to exactly two components. The
# `AnalyticalSolver` generic itself implements pairwise analytic
# collapse for any `n`: it looks for one component pair `convolve_pair`
# resolves analytically, collapses it into a reduced `Convolved`, and
# recurses (`_collapse_analytic_pair`/`_convolved_analytic_arm` below);
# when no pair collapses, it falls through to the `NumericSolver` arm,
# which routes to the exact discrete lattice fold or Gauss-Legendre
# quadrature via `_convolved_cdf_route`/`_convolved_pdf_route`
# (Convolved.jl, #85). A registered pair-specific closed form (e.g. the
# Gamma+Uniform uniform-window forms in `src/uniform_window.jl`) is
# simply a more specific method on that pair's tuple type, so ordinary
# multiple dispatch prefers it over the generic `Tuple` fallback -- no
# route lookup needed for evaluation itself.
#
# `cdf`/`pdf`/`logpdf` repeat the skeleton for `x::AbstractVector{<:Real}`
# (S1.4), so a batched call also collapses/dispatches per component
# tuple rather than falling back to per-point scalar solves.

@doc "

    convolve_pair(a, b)

The analytic sum distribution for `a + b`, or `nothing` when no closed
form is registered for the pair. This is the extension point a
downstream package adds a method to, to teach `convolved` a closed
form for its own distribution type: dispatch (not `try`/`catch`) keeps
the path differentiable under every AD backend, and returning
`nothing` (rather than throwing) is what tells the caller to fall back
to pairwise collapse or numeric quadrature instead.

For the built-in families, `Gamma` and `Exponential` additionally need
matching scale/rate, `Binomial` and `NegativeBinomial` matching success
probability, else `Distributions.convolve` throws.

# Examples
```@example
using ConvolvedDistributions, Distributions

struct MyPairDelay <: ContinuousUnivariateDistribution end
function ConvolvedDistributions.convolve_pair(::MyPairDelay, ::MyPairDelay)
    return Exponential(2.0)
end
```

See also: [`convolve_power`](@ref)
"
convolve_pair(a::UnivariateDistribution, b::UnivariateDistribution) = nothing

convolve_pair(a::Normal, b::Normal) = Distributions.convolve(a, b)

function convolve_pair(a::Exponential, b::Exponential)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

function convolve_pair(a::Gamma, b::Gamma)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

convolve_pair(a::Poisson, b::Poisson) = Distributions.convolve(a, b)

function convolve_pair(a::Binomial, b::Binomial)
    return succprob(a) ≈ succprob(b) ? Distributions.convolve(a, b) : nothing
end

function convolve_pair(a::NegativeBinomial, b::NegativeBinomial)
    return succprob(a) ≈ succprob(b) ? Distributions.convolve(a, b) : nothing
end

@doc "

    convolve_power(d, k)

The analytic distribution of the sum of `k` iid copies of `d`, or
`nothing` when no closed form is registered for the family. This is
the extension point `convolved(d, k)` calls first, before falling back
to `k - 1` applications of [`convolve_pair`](@ref) or numeric
quadrature; a downstream package adds a method here to give its own
distribution type an `O(1)` repeat instead of the built `k`-component
fold.

For the built-in families this is registered directly rather than
routed through repeated `convolve_pair` collapse, since a family
closed under addition has a direct `k`-fold formula (e.g.
`Gamma(shape, scale)` becomes `Gamma(k * shape, scale)`). `Exponential`
is the one family whose repeat is not itself an `Exponential`: `k` iid
`Exponential(θ)` sum to `Gamma(k, θ)`.

# Examples
```@example
using ConvolvedDistributions, Distributions

struct MyPowerDelay <: ContinuousUnivariateDistribution end
function ConvolvedDistributions.convolve_power(::MyPowerDelay, k::Integer)
    return Exponential(2.0 * k)
end
```

See also: [`convolve_pair`](@ref)
"
convolve_power(d::UnivariateDistribution, k::Integer) = nothing

function convolve_power(d::Normal, k::Integer)
    μ, σ = params(d)
    return Normal(k * μ, sqrt(k) * σ)
end

convolve_power(d::Exponential, k::Integer) = Gamma(k, scale(d))

function convolve_power(d::Gamma, k::Integer)
    α, θ = params(d)
    return Gamma(k * α, θ)
end

convolve_power(d::Poisson, k::Integer) = Poisson(k * params(d)[1])

function convolve_power(d::Binomial, k::Integer)
    n, p = params(d)
    return Binomial(k * n, p)
end

function convolve_power(d::NegativeBinomial, k::Integer)
    r, p = params(d)
    return NegativeBinomial(k * r, p)
end

# ---------------------------------------------------------------------------
# Pairwise analytic collapse (review A): the n-component fold
# ---------------------------------------------------------------------------

@doc "

    _collapse_analytic_pair(components::Tuple)

Scan every component pair (not just adjacent ones, so a non-analytic
component sitting between two collapsible ones does not block them) for
one where [`convolve_pair`](@ref) succeeds; replace that pair with the
resulting distribution and return the reduced tuple, or `nothing` when
no pair collapses. Written as head/tail `Tuple` recursion (dispatching
on the empty- and single-element base cases below), rather than
building the result through a mutable `Vector`, so it stays
`@inferred`-stable for the common small-`n` case instead of widening to
`Any`.
"
_collapse_analytic_pair(::Tuple{}) = nothing
_collapse_analytic_pair(::Tuple{Any}) = nothing

function _collapse_analytic_pair(components::Tuple)
    head = components[1]
    rest = Base.tail(components)
    found = _collapse_with_head(head, rest)
    found === nothing || return found
    reduced_rest = _collapse_analytic_pair(rest)
    reduced_rest === nothing && return nothing
    return (head, reduced_rest...)
end

# Try `head` against each element of `rest` in turn; on a match, return
# the reduced tuple with `head` and that element merged (dropped from
# their original positions, `merged` taking the earlier one), else
# `nothing`.
_collapse_with_head(head, ::Tuple{}) = nothing

function _collapse_with_head(head, rest::Tuple)
    merged = convolve_pair(head, rest[1])
    merged === nothing || return (merged, Base.tail(rest)...)
    found = _collapse_with_head(head, Base.tail(rest))
    found === nothing && return nothing
    return (found[1], rest[1], Base.tail(found)...)
end

# Fold `components` down to a single analytic distribution by repeated
# pairwise collapse, or `nothing` when the fold gets stuck. Used both for
# `_maybe_analytic(d::Convolved)` (TestUtils' generic "is `d` fully
# analytic" check) and, at construction time only, to help resolve
# `evaluation_path` (see `_resolve_closed_form` below).
function _fully_collapse(components::Tuple)
    remaining = components
    while length(remaining) > 1
        reduced = _collapse_analytic_pair(remaining)
        reduced === nothing && return nothing
        remaining = reduced
    end
    return remaining[1]
end

@doc "

Shared `AnalyticalSolver` arm for a `convolved_*` quantity generic
(review A): a single remaining component evaluates directly
(`direct`); otherwise collapse one analytic pair
([`_collapse_analytic_pair`](@ref)) and recurse `generic` on the
reduced `Convolved`, or -- when no pair collapses -- fall through to
`generic`'s `NumericSolver` arm. No step is restricted to exactly two
components: this same arm handles a two-component pair (collapsing it
in one step) and a three-or-more fold (collapsing repeatedly, taking
whichever pair resolves first) uniformly.
"
function _convolved_analytic_arm(
        generic::F, direct::G,
        d::Convolved, components::Tuple, x, method::AnalyticalSolver
    ) where {
        F, G,
    }
    length(components) == 1 && return direct(components[1], x)
    reduced = _collapse_analytic_pair(components)
    reduced === nothing &&
        return generic(d, components, x, NumericSolver(method.solver))
    length(reduced) == 1 && return direct(reduced[1], x)
    # `Convolved(reduced, method)` -- the two-positional-argument form --
    # skips `_resolve_closed_form`'s which() probe: `d2` is transient,
    # discarded once this call returns, and its `_closed_form` is never
    # read (only `generic` continuing the fold on `reduced` matters).
    d2 = Convolved(reduced, method)
    return generic(d2, reduced, x, method)
end

@doc "
    convolved_cdf(d, components, x, method)

The CDF of the sum of `components` at `x`, dispatched on the solver
method `method`. `d` is the `Convolved` `components` came from (used by
the `NumericSolver` arm directly, instead of rebuilding it). Public,
alongside its `logcdf`/`ccdf`/`logccdf`/`pdf`/`logpdf`/`quantile`
siblings, so a downstream package adds its own analytic pair by
defining a method on a two-element tuple TYPE more specific than
`(Convolved, Tuple, Real, AnalyticalSolver)` -- no registration call
needed, plain dispatch picks it up.

# Examples
```@example
using ConvolvedDistributions, Distributions

d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
ConvolvedDistributions.convolved_cdf(
    d, (Gamma(2.0, 1.5), Uniform(0.0, 2.0)), 3.0, AnalyticalSolver())
```

See also: [`Convolved`](@ref)
"
function convolved_cdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod
    )
    error("convolved_cdf not implemented for method type $(typeof(method))")
end

function convolved_cdf(
        d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_cdf, cdf, d, components, x,
        method
    )
end

function convolved_cdf(
        d::Convolved, components::Tuple,
        x::Real, method::NumericSolver
    )
    # `_convolved_cdf_route` dispatches on `d`'s derived value-support
    # type parameter: the exact lattice fold for an all-discrete-integer
    # pair with no named closed form (e.g. Poisson+Geometric), quadrature
    # otherwise (#85).
    return _convolved_cdf_route(d, x)
end

# Vector-`x` skeleton (S1.4): `Convolved`'s batched `cdf` uses this so a
# pair-specific analytic method batches via its own vector method (only
# the uniform-window pairs ship one) rather than losing the
# composite-quadrature batch (`_convolved_numeric_cdf_batched`) that the
# `NumericSolver` arm shares across points.
function convolved_cdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::AbstractVector{<:Real},
        method::AbstractSolverMethod
    )
    error("convolved_cdf not implemented for method type $(typeof(method))")
end

function convolved_cdf(
        d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::AnalyticalSolver
    )
    direct(c, xv) = map(xi -> cdf(c, xi), xv)
    return _convolved_analytic_arm(
        convolved_cdf, direct, d, components, x,
        method
    )
end

function convolved_cdf(
        d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::NumericSolver
    )
    return _convolved_cdf_route(d, x)
end

@doc "
    convolved_logcdf(d, components, x, method)

The log CDF of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_logcdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod
    )
    error("convolved_logcdf not implemented for method type $(typeof(method))")
end

function convolved_logcdf(
        d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_logcdf, logcdf, d, components,
        x, method
    )
end

function convolved_logcdf(
        d::Convolved, components::Tuple,
        x::Real, method::NumericSolver
    )
    c = convolved_cdf(d, components, x, method)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

@doc "
    convolved_ccdf(d, components, x, method)

The complementary CDF of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_ccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod
    )
    error("convolved_ccdf not implemented for method type $(typeof(method))")
end

function convolved_ccdf(
        d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_ccdf, ccdf, d, components, x,
        method
    )
end

function convolved_ccdf(
        d::Convolved, components::Tuple,
        x::Real, method::NumericSolver
    )
    return 1 - convolved_cdf(d, components, x, method)
end

@doc "
    convolved_logccdf(d, components, x, method)

The log complementary CDF of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_logccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod
    )
    error(
        "convolved_logccdf not implemented for method type $(typeof(method))"
    )
end

function convolved_logccdf(
        d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_logccdf, logccdf, d, components,
        x, method
    )
end

function convolved_logccdf(
        d::Convolved, components::Tuple,
        x::Real, method::NumericSolver
    )
    l = convolved_logcdf(d, components, x, method)
    l == -Inf && return zero(l)
    l >= 0 && return oftype(l, -Inf)
    return log1mexp(l)
end

@doc "
    convolved_pdf(d, components, x, method)

The density of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_pdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod
    )
    error("convolved_pdf not implemented for method type $(typeof(method))")
end

function convolved_pdf(
        d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_pdf, pdf, d, components, x,
        method
    )
end

function convolved_pdf(
        d::Convolved, components::Tuple,
        x::Real, method::NumericSolver
    )
    # See `convolved_cdf`'s `NumericSolver` arm: `_convolved_pdf_route`
    # picks the exact lattice fold or quadrature by `d`'s derived
    # value-support type parameter (#85).
    return _convolved_pdf_route(d, x)
end

# Vector-`x` skeleton (S1.4): see `convolved_cdf`'s.
function convolved_pdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::AbstractVector{<:Real},
        method::AbstractSolverMethod
    )
    error("convolved_pdf not implemented for method type $(typeof(method))")
end

function convolved_pdf(
        d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::AnalyticalSolver
    )
    direct(c, xv) = map(xi -> pdf(c, xi), xv)
    return _convolved_analytic_arm(
        convolved_pdf, direct, d, components, x,
        method
    )
end

function convolved_pdf(
        d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::NumericSolver
    )
    return _convolved_pdf_route(d, x)
end

@doc "
    convolved_logpdf(d, components, x, method)

The log density of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_logpdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod
    )
    error("convolved_logpdf not implemented for method type $(typeof(method))")
end

function convolved_logpdf(
        d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_logpdf, logpdf, d, components,
        x, method
    )
end

function convolved_logpdf(
        d::Convolved, components::Tuple,
        x::Real, method::NumericSolver
    )
    insupport(d, x) || return oftype(float(x), -Inf)
    p = _convolved_pdf_route(d, x)
    return p <= 0 ? oftype(float(x), -Inf) : log(p)
end

# Vector-`x` skeleton (S1.4): see `convolved_cdf`'s. The `NumericSolver`
# arm reuses `_batched_numeric_logpdf` (Convolved.jl), the same
# insupport-aware log of the shared composite-quadrature/lattice pdf
# batch.
function convolved_logpdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, x::AbstractVector{<:Real},
        method::AbstractSolverMethod
    )
    error("convolved_logpdf not implemented for method type $(typeof(method))")
end

function convolved_logpdf(
        d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::AnalyticalSolver
    )
    direct(c, xv) = map(xi -> logpdf(c, xi), xv)
    return _convolved_analytic_arm(
        convolved_logpdf, direct, d, components,
        x, method
    )
end

function convolved_logpdf(
        d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::NumericSolver
    )
    return _batched_numeric_logpdf(d, x)
end

@doc "
    convolved_quantile(d, components, p, method)

The quantile of the sum of `components` at probability `p`. Skeleton and
`AnalyticalSolver` arm only: the `NumericSolver` arm needs a nonlinear
solve and lives in the `ConvolvedDistributionsOptimizationExt`
extension, so a non-analytic fold's quantile is unavailable until
Optimization.jl is loaded, while a fully analytic one
([`_collapse_analytic_pair`](@ref)) works without it.

See also: [`convolved_cdf`](@ref)
"
function convolved_quantile(
        d::AbstractConvolvedDistribution,
        components::Tuple, p::Real, method::AbstractSolverMethod
    )
    error(
        "convolved_quantile not implemented for method type $(typeof(method))"
    )
end

function convolved_quantile(
        d::Convolved, components::Tuple,
        p::Real, method::AnalyticalSolver
    )
    return _convolved_analytic_arm(
        convolved_quantile, quantile, d,
        components, p, method
    )
end

@doc "
    convolved_minimum(d, components, method)

The minimum of the sum of `components`. A quantity with no evaluation
point takes no `x`/`p` argument at all. Not wired into `minimum`, which
is already exact by summation; only the unimplemented-method-type error
exists, demonstrating the shape compiles for a future zero-argument
quantity.
"
function convolved_minimum(
        d::AbstractConvolvedDistribution,
        components::Tuple, method::AbstractSolverMethod
    )
    error(
        "convolved_minimum not implemented for method type $(typeof(method))"
    )
end

# `convolved_quantile`'s `NumericSolver` arm has no method in core: the
# Optimization extension supplies the Nelder-Mead implementation, for
# whatever fold the `AnalyticalSolver` arm's pairwise collapse gets
# stuck on -- see `ConvolvedDistributionsOptimizationExt`. There is no
# separate three-or-more-components quantile function any more (review
# A): one skeleton covers every component count.

# ---------------------------------------------------------------------------
# Construction-time closed-form resolution
# ---------------------------------------------------------------------------
#
# `evaluation_path`/`has_closed_form`/`is_exact` must answer without a
# method-table probe on every `pdf`/`cdf` call -- the actual evaluation
# above never runs one; it is plain dispatch, falling back to the
# `NumericSolver` arm exactly like CensoredDistributions'
# `primarycensored_cdf`. A `which()` comparison against the generic
# `Tuple` fallback IS still how the family-specific pair closed forms
# (uncollapsible via `convolve_pair`, e.g. the Gamma+Uniform
# uniform-window forms) get detected for `evaluation_path`'s per-quantity
# report, but it runs only from the *public* inner constructor (the
# one-positional-plus-`method`-keyword form), and the six-quantity
# answer is cached on `Convolved._closed_form`. Every later
# `evaluation_path`/`has_closed_form` query is then a plain field read.
# The transient `Convolved` wrappers `_convolved_analytic_arm` builds
# mid pairwise-collapse recursion use the *other* inner constructor (the
# two-positional-argument form, no closed-form probe) instead, precisely
# because their `_closed_form` is never queried -- so a `pdf`/`cdf` call
# on a 3-or-more-component `Convolved` never runs `which()` at all, only
# the outer, user-facing construction does.

# Whether `generic`'s `AnalyticalSolver` method for `components` resolves
# to something more specific than the untyped-`Tuple` fallback -- i.e. a
# registered pair-specific closed form rather than the collapse-or-numeric
# fallback itself. Called only from `_resolve_closed_form`, at
# construction.
#
# Type-keyed cache, not a per-call `which()` probe: the answer is
# entirely a function of `typeof(generic)`/`typeof(components)`/
# `typeof(method)`, so it is computed once per distinct type combination
# and reused after that. A `Convolved` rebuilt on every gradient
# evaluation inside a Turing model then only ever does a `Dict` lookup
# and a cheap `Base.get_world_counter()` read, not a `which()` call --
# `which()` is what was landing in the AD tape as a `foreigncall`
# Mooncake forward mode has no `frule!!` for; `get_world_counter()`
# traces through it cleanly. The lock guards concurrent first-touch
# writes from a multi-threaded sampler (e.g. parallel NUTS chains); a
# `Dict` read/write race, unlike a stale answer, would corrupt the cache
# outright.
#
# Each entry is stamped with the world it was resolved in and
# recomputed once the world has moved on, so a pair-specific method
# defined after a type combination was first cached (e.g. a downstream
# package loaded mid-session, or a new method added interactively) is
# picked up on the next construction rather than staying invisible for
# the rest of the process.
const _MORE_SPECIFIC_PAIR_CACHE = Dict{
    Tuple{DataType, DataType, DataType}, Tuple{UInt, Bool},
}()
const _MORE_SPECIFIC_PAIR_LOCK = ReentrantLock()

function _more_specific_pair_method(
        generic::F, components::Tuple,
        method::AnalyticalSolver
    ) where {F}
    key = (F, typeof(components), typeof(method))
    world = Base.get_world_counter()
    return lock(_MORE_SPECIFIC_PAIR_LOCK) do
        cached = get(_MORE_SPECIFIC_PAIR_CACHE, key, nothing)
        cached !== nothing && cached[1] == world && return cached[2]
        fallback = which(
            generic, Tuple{Convolved, Tuple, Real, AnalyticalSolver}
        )
        resolved = which(
            generic,
            Tuple{Convolved, typeof(components), Real, typeof(method)}
        )
        answer = resolved !== fallback
        _MORE_SPECIFIC_PAIR_CACHE[key] = (world, answer)
        return answer
    end
end

const _CONVOLVED_QUANTITY_KEYS = (
    :pdf, :logpdf, :cdf, :logcdf, :ccdf,
    :logccdf,
)
const _CONVOLVED_QUANTITY_GENERICS = (
    convolved_pdf, convolved_logpdf,
    convolved_cdf, convolved_logcdf, convolved_ccdf, convolved_logccdf,
)

# Per-quantity closed-form answer for `components` under `method`,
# resolved once at construction (see the section banner above).
# `NumericSolver` always answers `false` for every quantity -- that
# method explicitly requests the numeric path. Under `AnalyticalSolver`,
# a quantity is analytic when the whole tuple collapses to one
# distribution via pairwise `convolve_pair` (every quantity is then
# analytic, since a genuine `Distributions.jl` object answers all of
# them) OR a pair-specific method is registered for that particular
# quantity (checked per quantity: a pair may register a closed form for
# some quantities and not others).
function _resolve_closed_form(::Tuple, ::AbstractSolverMethod)
    return NamedTuple{_CONVOLVED_QUANTITY_KEYS}(ntuple(_ -> false, 6))
end

function _resolve_closed_form(components::Tuple, method::AnalyticalSolver)
    collapses = _fully_collapse(components) !== nothing
    flags = map(_CONVOLVED_QUANTITY_GENERICS) do g
        collapses || _more_specific_pair_method(g, components, method)
    end
    return NamedTuple{_CONVOLVED_QUANTITY_KEYS}(flags)
end

# `Convolved`'s `evaluation_path` route check (#92): a plain field read
# against the answer `_resolve_closed_form` computed once at
# construction -- never a per-call probe. Three-or-more components,
# `Difference`, `Product`, and `Ratio` answer via
# `interface.jl`'s generic `_maybe_analytic`-based fallback instead,
# unaffected by this override.
function _is_analytic(d::Convolved, f::F) where {F}
    i = findfirst(==(nameof(f)), _CONVOLVED_QUANTITY_KEYS)
    i === nothing && return _maybe_analytic(d) !== nothing
    return d._closed_form[i]
end

# ---------------------------------------------------------------------------
# `Difference`: the same per-quantity dispatch shape as `Convolved`
# above, simplified for a fixed X/Y pair. There is no n-ary fold to
# collapse -- the `AnalyticalSolver` arm just asks whether the one
# `(x, y)` pair resolves via `difference_pair`, and falls through to the
# `NumericSolver` arm when it does not.
# ---------------------------------------------------------------------------

@doc "

    difference_pair(x, y)

The analytic distribution for `x - y`, or `nothing` when no closed form
is registered for the pair. This is the extension point a downstream
package adds a method to, to teach `difference` a closed form for its own
distribution type: dispatch (not `try`/`catch`) keeps the path
differentiable under every AD backend, and returning `nothing` (rather
than throwing) is what tells the caller to fall back to numeric
quadrature instead.

# Examples
```@example
using ConvolvedDistributions, Distributions

struct MyDiffDelay <: ContinuousUnivariateDistribution end
function ConvolvedDistributions.difference_pair(::MyDiffDelay, ::MyDiffDelay)
    return Normal(0.0, 1.0)
end
```

See also: [`convolve_pair`](@ref)
"
difference_pair(x::UnivariateDistribution, y::UnivariateDistribution) = nothing

function difference_pair(x::Normal, y::Normal)
    return Normal(mean(x) - mean(y), sqrt(var(x) + var(y)))
end

@doc "

Shared `AnalyticalSolver` arm for a `difference_*` quantity generic: when
`(x, y)` resolves via [`difference_pair`](@ref), evaluate `direct` on the
result; otherwise fall through to `generic`'s `NumericSolver` arm.
"
function _difference_analytic_arm(
        generic::F, direct::G,
        d::Difference, components::Tuple, x, method::AnalyticalSolver
    ) where {
        F, G,
    }
    resolved = difference_pair(components[1], components[2])
    resolved === nothing &&
        return generic(d, components, x, NumericSolver(method.solver))
    return direct(resolved, x)
end

@doc "
    difference_cdf(d, components, z, method)

The CDF of `components[1] - components[2]` at `z`, dispatched on the
solver method `method`. Mirrors [`convolved_cdf`](@ref): a downstream
package adds its own analytic pair by defining a method on a
two-element tuple TYPE more specific than
`(Difference, Tuple, Real, AnalyticalSolver)`.

See also: [`Difference`](@ref)
"
function difference_cdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("difference_cdf not implemented for method type $(typeof(method))")
end

function difference_cdf(
        d::Difference, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_cdf, cdf, d, components, z,
        method
    )
end

function difference_cdf(
        d::Difference, components::Tuple,
        z::Real, method::NumericSolver
    )
    return _difference_cdf_route(d, z)
end

@doc "
    difference_logcdf(d, components, z, method)

The log CDF of `components[1] - components[2]` at `z`. See
[`difference_cdf`](@ref).
"
function difference_logcdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error(
        "difference_logcdf not implemented for method type $(typeof(method))"
    )
end

function difference_logcdf(
        d::Difference, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_logcdf, logcdf, d, components,
        z, method
    )
end

function difference_logcdf(
        d::Difference, components::Tuple,
        z::Real, method::NumericSolver
    )
    c = difference_cdf(d, components, z, method)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

@doc "
    difference_ccdf(d, components, z, method)

The complementary CDF of `components[1] - components[2]` at `z`. See
[`difference_cdf`](@ref).
"
function difference_ccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("difference_ccdf not implemented for method type $(typeof(method))")
end

function difference_ccdf(
        d::Difference, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_ccdf, ccdf, d, components, z,
        method
    )
end

function difference_ccdf(
        d::Difference, components::Tuple,
        z::Real, method::NumericSolver
    )
    return 1 - difference_cdf(d, components, z, method)
end

@doc "
    difference_logccdf(d, components, z, method)

The log complementary CDF of `components[1] - components[2]` at `z`. See
[`difference_cdf`](@ref).
"
function difference_logccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error(
        "difference_logccdf not implemented for method type $(typeof(method))"
    )
end

function difference_logccdf(
        d::Difference, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_logccdf, logccdf, d,
        components, z, method
    )
end

function difference_logccdf(
        d::Difference, components::Tuple,
        z::Real, method::NumericSolver
    )
    l = difference_logcdf(d, components, z, method)
    l == -Inf && return zero(l)
    l >= 0 && return oftype(l, -Inf)
    return log1mexp(l)
end

@doc "
    difference_pdf(d, components, z, method)

The density of `components[1] - components[2]` at `z`. See
[`difference_cdf`](@ref).
"
function difference_pdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("difference_pdf not implemented for method type $(typeof(method))")
end

function difference_pdf(
        d::Difference, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_pdf, pdf, d, components, z,
        method
    )
end

function difference_pdf(
        d::Difference, components::Tuple,
        z::Real, method::NumericSolver
    )
    return _difference_pdf_route(d, z)
end

@doc "
    difference_logpdf(d, components, z, method)

The log density of `components[1] - components[2]` at `z`. See
[`difference_cdf`](@ref).
"
function difference_logpdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error(
        "difference_logpdf not implemented for method type $(typeof(method))"
    )
end

function difference_logpdf(
        d::Difference, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_logpdf, logpdf, d, components,
        z, method
    )
end

function difference_logpdf(
        d::Difference, components::Tuple,
        z::Real, method::NumericSolver
    )
    insupport(d, z) || return oftype(float(z), -Inf)
    p = _difference_pdf_route(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end

@doc "
    difference_quantile(d, components, p, method)

The quantile of `components[1] - components[2]` at probability `p`.
Skeleton and `AnalyticalSolver` arm only, mirroring
[`convolved_quantile`](@ref): the `NumericSolver` arm needs a nonlinear
solve and lives in the `ConvolvedDistributionsOptimizationExt`
extension.

See also: [`difference_cdf`](@ref)
"
function difference_quantile(
        d::AbstractConvolvedDistribution,
        components::Tuple, p::Real, method::AbstractSolverMethod
    )
    error(
        "difference_quantile not implemented for method type $(typeof(method))"
    )
end

function difference_quantile(
        d::Difference, components::Tuple,
        p::Real, method::AnalyticalSolver
    )
    return _difference_analytic_arm(
        difference_quantile, quantile, d,
        components, p, method
    )
end

# ---------------------------------------------------------------------------
# `Product`: the same per-quantity dispatch shape as `Difference` above,
# for the multiplicative pair `Z = X * Y`. The `NumericSolver` arms call
# `_product_cdf_route`/`_product_pdf_route` (Product.jl), which already
# dispatch on `d`'s discrete/mixed/continuous type parameter (#85, #115)
# -- this generic layer adds nothing to that routing, it only decides
# whether the `AnalyticalSolver` arm short-circuits to a closed form
# first.
# ---------------------------------------------------------------------------

@doc "

    product_pair(x, y)

The analytic distribution for `x * y`, or `nothing` when no closed form
is registered for the pair. This is the extension point a downstream
package adds a method to, to teach `product` a closed form for its own
distribution type: dispatch (not `try`/`catch`) keeps the path
differentiable under every AD backend, and returning `nothing` (rather
than throwing) is what tells the caller to fall back to numeric
quadrature instead.

# Examples
```@example
using ConvolvedDistributions, Distributions

struct MyProdDelay <: ContinuousUnivariateDistribution end
function ConvolvedDistributions.product_pair(::MyProdDelay, ::MyProdDelay)
    return LogNormal(0.0, 1.0)
end
```

See also: [`convolve_pair`](@ref)
"
product_pair(x::UnivariateDistribution, y::UnivariateDistribution) = nothing

function product_pair(x::LogNormal, y::LogNormal)
    μx, σx = params(x)
    μy, σy = params(y)
    return LogNormal(μx + μy, sqrt(σx^2 + σy^2))
end

@doc "

Shared `AnalyticalSolver` arm for a `product_*` quantity generic: when
`(x, y)` resolves via [`product_pair`](@ref), evaluate `direct` on the
result; otherwise fall through to `generic`'s `NumericSolver` arm.
"
function _product_analytic_arm(
        generic::F, direct::G,
        d::Product, components::Tuple, x, method::AnalyticalSolver
    ) where {
        F, G,
    }
    resolved = product_pair(components[1], components[2])
    resolved === nothing &&
        return generic(d, components, x, NumericSolver(method.solver))
    return direct(resolved, x)
end

@doc "
    product_cdf(d, components, z, method)

The CDF of `components[1] * components[2]` at `z`, dispatched on the
solver method `method`. Mirrors [`difference_cdf`](@ref): a downstream
package adds its own analytic pair by defining a method on a
two-element tuple TYPE more specific than
`(Product, Tuple, Real, AnalyticalSolver)`.

See also: [`Product`](@ref)
"
function product_cdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("product_cdf not implemented for method type $(typeof(method))")
end

function product_cdf(
        d::Product, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(product_cdf, cdf, d, components, z, method)
end

function product_cdf(
        d::Product, components::Tuple,
        z::Real, method::NumericSolver
    )
    return _product_cdf_route(d, z)
end

@doc "
    product_logcdf(d, components, z, method)

The log CDF of `components[1] * components[2]` at `z`. See
[`product_cdf`](@ref).
"
function product_logcdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("product_logcdf not implemented for method type $(typeof(method))")
end

function product_logcdf(
        d::Product, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(
        product_logcdf, logcdf, d, components, z,
        method
    )
end

function product_logcdf(
        d::Product, components::Tuple,
        z::Real, method::NumericSolver
    )
    c = product_cdf(d, components, z, method)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

@doc "
    product_ccdf(d, components, z, method)

The complementary CDF of `components[1] * components[2]` at `z`. See
[`product_cdf`](@ref).
"
function product_ccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("product_ccdf not implemented for method type $(typeof(method))")
end

function product_ccdf(
        d::Product, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(
        product_ccdf, ccdf, d, components, z,
        method
    )
end

function product_ccdf(
        d::Product, components::Tuple,
        z::Real, method::NumericSolver
    )
    return 1 - product_cdf(d, components, z, method)
end

@doc "
    product_logccdf(d, components, z, method)

The log complementary CDF of `components[1] * components[2]` at `z`. See
[`product_cdf`](@ref).
"
function product_logccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error(
        "product_logccdf not implemented for method type $(typeof(method))"
    )
end

function product_logccdf(
        d::Product, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(
        product_logccdf, logccdf, d, components, z,
        method
    )
end

function product_logccdf(
        d::Product, components::Tuple,
        z::Real, method::NumericSolver
    )
    l = product_logcdf(d, components, z, method)
    l == -Inf && return zero(l)
    l >= 0 && return oftype(l, -Inf)
    return log1mexp(l)
end

@doc "
    product_pdf(d, components, z, method)

The density of `components[1] * components[2]` at `z`. See
[`product_cdf`](@ref).
"
function product_pdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("product_pdf not implemented for method type $(typeof(method))")
end

function product_pdf(
        d::Product, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(product_pdf, pdf, d, components, z, method)
end

function product_pdf(
        d::Product, components::Tuple,
        z::Real, method::NumericSolver
    )
    return _product_pdf_route(d, z)
end

@doc "
    product_logpdf(d, components, z, method)

The log density of `components[1] * components[2]` at `z`. See
[`product_cdf`](@ref).
"
function product_logpdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("product_logpdf not implemented for method type $(typeof(method))")
end

function product_logpdf(
        d::Product, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(
        product_logpdf, logpdf, d, components, z,
        method
    )
end

function product_logpdf(
        d::Product, components::Tuple,
        z::Real, method::NumericSolver
    )
    insupport(d, z) || return oftype(float(z), -Inf)
    p = _product_pdf_route(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end

@doc "
    product_quantile(d, components, p, method)

The quantile of `components[1] * components[2]` at probability `p`.
Skeleton and `AnalyticalSolver` arm only, mirroring
[`difference_quantile`](@ref): the `NumericSolver` arm needs a
nonlinear solve and lives in the `ConvolvedDistributionsOptimizationExt`
extension.

See also: [`product_cdf`](@ref)
"
function product_quantile(
        d::AbstractConvolvedDistribution,
        components::Tuple, p::Real, method::AbstractSolverMethod
    )
    error(
        "product_quantile not implemented for method type $(typeof(method))"
    )
end

function product_quantile(
        d::Product, components::Tuple,
        p::Real, method::AnalyticalSolver
    )
    return _product_analytic_arm(
        product_quantile, quantile, d,
        components, p, method
    )
end

# ---------------------------------------------------------------------------
# `Ratio`: the same per-quantity dispatch shape as `Difference`/`Product`
# above, for the quotient pair `Z = X / Y`. Unlike `Product`, `Ratio` has
# no discrete lattice or mixed fold (its value support is `Continuous`
# unconditionally -- see the `Ratio` docstring), so the `NumericSolver`
# arms call `_ratio_numeric_cdf`/`_ratio_numeric_pdf` (Ratio.jl) directly
# rather than through a route wrapper.
# ---------------------------------------------------------------------------

@doc "

    ratio_pair(x, y)

The analytic distribution for `x / y`, or `nothing` when no closed form
is registered for the pair. This is the extension point a downstream
package adds a method to, to teach `ratio` a closed form for its own
distribution type: dispatch (not `try`/`catch`) keeps the path
differentiable under every AD backend, and returning `nothing` (rather
than throwing) is what tells the caller to fall back to numeric
quadrature instead.

# Examples
```@example
using ConvolvedDistributions, Distributions

struct MyRatioDelay <: ContinuousUnivariateDistribution end
function ConvolvedDistributions.ratio_pair(::MyRatioDelay, ::MyRatioDelay)
    return Cauchy(0.0, 1.0)
end
```

See also: [`convolve_pair`](@ref)
"
ratio_pair(x::UnivariateDistribution, y::UnivariateDistribution) = nothing

# Normal(0, σx) / Normal(0, σy) ~ Cauchy(0, σx / σy). Only the zero-mean
# case is analytic: the general Marsaglia-Hinkley density has no
# elementary closed form and no `Distributions.jl` type, so non-zero
# means stay on the numeric path. Branching on `iszero(μ)` is
# parameter-value dependent; see the `Ratio` docstring for the resulting
# AD hazard exactly at zero means.
function ratio_pair(x::Normal, y::Normal)
    μx, σx = params(x)
    μy, σy = params(y)
    (iszero(μx) && iszero(μy)) || return nothing
    return Cauchy(zero(σx / σy), σx / σy)
end

# Gamma(αx, θx) / Gamma(αy, θy) ~ (θx / θy) * BetaPrime(αx, αy). Unequal
# scales are supported (unlike `convolve_pair(::Gamma, ::Gamma)`, which
# needs equal scales) since the scale ratio simply factors out. The
# affine wrapper is returned even when θx == θy so the return type stays
# value-independent.
function ratio_pair(x::Gamma, y::Gamma)
    αx, θx = params(x)
    αy, θy = params(y)
    return (θx / θy) * BetaPrime(αx, αy)
end

# Chisq(ν1) / Chisq(ν2) ~ (ν1 / ν2) * FDist(ν1, ν2). Registered
# separately from the Gamma rule because Chisq is its own Distributions.jl
# type; equivalent to it since Chisq(ν) == Gamma(ν / 2, 2) and the scales
# cancel in the Gamma rule above.
function ratio_pair(x::Chisq, y::Chisq)
    νx, = params(x)
    νy, = params(y)
    return (νx / νy) * FDist(νx, νy)
end

@doc "

Shared `AnalyticalSolver` arm for a `ratio_*` quantity generic: when
`(x, y)` resolves via [`ratio_pair`](@ref), evaluate `direct` on the
result; otherwise fall through to `generic`'s `NumericSolver` arm.
"
function _ratio_analytic_arm(
        generic::F, direct::G,
        d::Ratio, components::Tuple, x, method::AnalyticalSolver
    ) where {
        F, G,
    }
    resolved = ratio_pair(components[1], components[2])
    resolved === nothing &&
        return generic(d, components, x, NumericSolver(method.solver))
    return direct(resolved, x)
end

@doc "
    ratio_cdf(d, components, z, method)

The CDF of `components[1] / components[2]` at `z`, dispatched on the
solver method `method`. Mirrors [`difference_cdf`](@ref): a downstream
package adds its own analytic pair by defining a method on a
two-element tuple TYPE more specific than
`(Ratio, Tuple, Real, AnalyticalSolver)`.

See also: [`Ratio`](@ref)
"
function ratio_cdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("ratio_cdf not implemented for method type $(typeof(method))")
end

function ratio_cdf(
        d::Ratio, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(ratio_cdf, cdf, d, components, z, method)
end

function ratio_cdf(
        d::Ratio, components::Tuple,
        z::Real, method::NumericSolver
    )
    return _ratio_numeric_cdf(d, z)
end

@doc "
    ratio_logcdf(d, components, z, method)

The log CDF of `components[1] / components[2]` at `z`. See
[`ratio_cdf`](@ref).
"
function ratio_logcdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("ratio_logcdf not implemented for method type $(typeof(method))")
end

function ratio_logcdf(
        d::Ratio, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(
        ratio_logcdf, logcdf, d, components, z,
        method
    )
end

function ratio_logcdf(
        d::Ratio, components::Tuple,
        z::Real, method::NumericSolver
    )
    c = ratio_cdf(d, components, z, method)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

@doc "
    ratio_ccdf(d, components, z, method)

The complementary CDF of `components[1] / components[2]` at `z`. See
[`ratio_cdf`](@ref).
"
function ratio_ccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("ratio_ccdf not implemented for method type $(typeof(method))")
end

function ratio_ccdf(
        d::Ratio, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(ratio_ccdf, ccdf, d, components, z, method)
end

function ratio_ccdf(
        d::Ratio, components::Tuple,
        z::Real, method::NumericSolver
    )
    return 1 - ratio_cdf(d, components, z, method)
end

@doc "
    ratio_logccdf(d, components, z, method)

The log complementary CDF of `components[1] / components[2]` at `z`. See
[`ratio_cdf`](@ref).
"
function ratio_logccdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("ratio_logccdf not implemented for method type $(typeof(method))")
end

function ratio_logccdf(
        d::Ratio, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(
        ratio_logccdf, logccdf, d, components, z,
        method
    )
end

function ratio_logccdf(
        d::Ratio, components::Tuple,
        z::Real, method::NumericSolver
    )
    l = ratio_logcdf(d, components, z, method)
    l == -Inf && return zero(l)
    l >= 0 && return oftype(l, -Inf)
    return log1mexp(l)
end

@doc "
    ratio_pdf(d, components, z, method)

The density of `components[1] / components[2]` at `z`. See
[`ratio_cdf`](@ref).
"
function ratio_pdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("ratio_pdf not implemented for method type $(typeof(method))")
end

function ratio_pdf(
        d::Ratio, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(ratio_pdf, pdf, d, components, z, method)
end

function ratio_pdf(
        d::Ratio, components::Tuple,
        z::Real, method::NumericSolver
    )
    return _ratio_numeric_pdf(d, z)
end

@doc "
    ratio_logpdf(d, components, z, method)

The log density of `components[1] / components[2]` at `z`. See
[`ratio_cdf`](@ref).
"
function ratio_logpdf(
        d::AbstractConvolvedDistribution,
        components::Tuple, z::Real, method::AbstractSolverMethod
    )
    error("ratio_logpdf not implemented for method type $(typeof(method))")
end

function ratio_logpdf(
        d::Ratio, components::Tuple,
        z::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(
        ratio_logpdf, logpdf, d, components, z,
        method
    )
end

function ratio_logpdf(
        d::Ratio, components::Tuple,
        z::Real, method::NumericSolver
    )
    insupport(d, z) || return oftype(float(z), -Inf)
    p = _ratio_numeric_pdf(d, z)
    return p <= 0 ? oftype(float(z), -Inf) : log(p)
end

@doc "
    ratio_quantile(d, components, p, method)

The quantile of `components[1] / components[2]` at probability `p`.
Skeleton and `AnalyticalSolver` arm only, mirroring
[`difference_quantile`](@ref): the `NumericSolver` arm needs a
nonlinear solve and lives in the `ConvolvedDistributionsOptimizationExt`
extension.

See also: [`ratio_cdf`](@ref)
"
function ratio_quantile(
        d::AbstractConvolvedDistribution,
        components::Tuple, p::Real, method::AbstractSolverMethod
    )
    error(
        "ratio_quantile not implemented for method type $(typeof(method))"
    )
end

function ratio_quantile(
        d::Ratio, components::Tuple,
        p::Real, method::AnalyticalSolver
    )
    return _ratio_analytic_arm(
        ratio_quantile, quantile, d,
        components, p, method
    )
end
