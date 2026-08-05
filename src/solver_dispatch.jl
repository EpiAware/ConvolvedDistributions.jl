# Solver-method dispatch (#77) for `Convolved`, generalised to any number
# of components (#80 review A): the components travel together as a
# TUPLE, e.g. `convolved_cdf(d, components, x, method)`, so a pair
# closed form is just a method on a two-element tuple TYPE
# (`Tuple{Gamma, Uniform}`, plus its mirrored order) and nothing in the
# public surface is restricted to exactly two components. The
# `AnalyticalSolver` generic itself implements pairwise analytic
# collapse for any `n`: it looks for one component pair `_try_convolve`
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

    _try_convolve(a, b)

The analytic sum distribution for `a + b` when `Distributions.convolve`
applies, else `nothing`. Dispatch (not `try`/`catch`) keeps the path
differentiable under every AD backend. `Gamma` and `Exponential`
additionally need matching scale/rate, `Binomial` and
`NegativeBinomial` matching success probability, else the runtime
`convolve` throws.
"
_try_convolve(a::UnivariateDistribution, b::UnivariateDistribution) = nothing

_try_convolve(a::Normal, b::Normal) = Distributions.convolve(a, b)

function _try_convolve(a::Exponential, b::Exponential)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

function _try_convolve(a::Gamma, b::Gamma)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

_try_convolve(a::Poisson, b::Poisson) = Distributions.convolve(a, b)

function _try_convolve(a::Binomial, b::Binomial)
    return succprob(a) ≈ succprob(b) ? Distributions.convolve(a, b) : nothing
end

function _try_convolve(a::NegativeBinomial, b::NegativeBinomial)
    return succprob(a) ≈ succprob(b) ? Distributions.convolve(a, b) : nothing
end

# ---------------------------------------------------------------------------
# Pairwise analytic collapse (review A): the n-component fold
# ---------------------------------------------------------------------------

@doc "

    _collapse_analytic_pair(components::Tuple)

Scan every component pair (not just adjacent ones, so a non-analytic
component sitting between two collapsible ones does not block them) for
one where [`_try_convolve`](@ref) succeeds; replace that pair with the
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
    merged = _try_convolve(head, rest[1])
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
function _convolved_analytic_arm(generic::F, direct::G,
        d::Convolved, components::Tuple, x, method::AnalyticalSolver) where {
        F, G}
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
function convolved_cdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod)
    error("convolved_cdf not implemented for method type $(typeof(method))")
end

function convolved_cdf(d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_cdf, cdf, d, components, x,
        method)
end

function convolved_cdf(d::Convolved, components::Tuple,
        x::Real, method::NumericSolver)
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
function convolved_cdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::AbstractVector{<:Real},
        method::AbstractSolverMethod)
    error("convolved_cdf not implemented for method type $(typeof(method))")
end

function convolved_cdf(d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::AnalyticalSolver)
    direct(c, xv) = map(xi -> cdf(c, xi), xv)
    return _convolved_analytic_arm(convolved_cdf, direct, d, components, x,
        method)
end

function convolved_cdf(d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::NumericSolver)
    return _convolved_cdf_route(d, x)
end

@doc "
    convolved_logcdf(d, components, x, method)

The log CDF of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_logcdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod)
    error("convolved_logcdf not implemented for method type $(typeof(method))")
end

function convolved_logcdf(d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_logcdf, logcdf, d, components,
        x, method)
end

function convolved_logcdf(d::Convolved, components::Tuple,
        x::Real, method::NumericSolver)
    c = convolved_cdf(d, components, x, method)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

@doc "
    convolved_ccdf(d, components, x, method)

The complementary CDF of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_ccdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod)
    error("convolved_ccdf not implemented for method type $(typeof(method))")
end

function convolved_ccdf(d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_ccdf, ccdf, d, components, x,
        method)
end

function convolved_ccdf(d::Convolved, components::Tuple,
        x::Real, method::NumericSolver)
    return 1 - convolved_cdf(d, components, x, method)
end

@doc "
    convolved_logccdf(d, components, x, method)

The log complementary CDF of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_logccdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod)
    error(
        "convolved_logccdf not implemented for method type $(typeof(method))")
end

function convolved_logccdf(d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_logccdf, logccdf, d, components,
        x, method)
end

function convolved_logccdf(d::Convolved, components::Tuple,
        x::Real, method::NumericSolver)
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
function convolved_pdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod)
    error("convolved_pdf not implemented for method type $(typeof(method))")
end

function convolved_pdf(d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_pdf, pdf, d, components, x,
        method)
end

function convolved_pdf(d::Convolved, components::Tuple,
        x::Real, method::NumericSolver)
    # See `convolved_cdf`'s `NumericSolver` arm: `_convolved_pdf_route`
    # picks the exact lattice fold or quadrature by `d`'s derived
    # value-support type parameter (#85).
    return _convolved_pdf_route(d, x)
end

# Vector-`x` skeleton (S1.4): see `convolved_cdf`'s.
function convolved_pdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::AbstractVector{<:Real},
        method::AbstractSolverMethod)
    error("convolved_pdf not implemented for method type $(typeof(method))")
end

function convolved_pdf(d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::AnalyticalSolver)
    direct(c, xv) = map(xi -> pdf(c, xi), xv)
    return _convolved_analytic_arm(convolved_pdf, direct, d, components, x,
        method)
end

function convolved_pdf(d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::NumericSolver)
    return _convolved_pdf_route(d, x)
end

@doc "
    convolved_logpdf(d, components, x, method)

The log density of the sum of `components` at `x`. See
[`convolved_cdf`](@ref).
"
function convolved_logpdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::Real, method::AbstractSolverMethod)
    error("convolved_logpdf not implemented for method type $(typeof(method))")
end

function convolved_logpdf(d::Convolved, components::Tuple,
        x::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_logpdf, logpdf, d, components,
        x, method)
end

function convolved_logpdf(d::Convolved, components::Tuple,
        x::Real, method::NumericSolver)
    insupport(d, x) || return oftype(float(x), -Inf)
    p = _convolved_pdf_route(d, x)
    return p <= 0 ? oftype(float(x), -Inf) : log(p)
end

# Vector-`x` skeleton (S1.4): see `convolved_cdf`'s. The `NumericSolver`
# arm reuses `_batched_numeric_logpdf` (Convolved.jl), the same
# insupport-aware log of the shared composite-quadrature/lattice pdf
# batch.
function convolved_logpdf(d::AbstractConvolvedDistribution,
        components::Tuple, x::AbstractVector{<:Real},
        method::AbstractSolverMethod)
    error("convolved_logpdf not implemented for method type $(typeof(method))")
end

function convolved_logpdf(d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::AnalyticalSolver)
    direct(c, xv) = map(xi -> logpdf(c, xi), xv)
    return _convolved_analytic_arm(convolved_logpdf, direct, d, components,
        x, method)
end

function convolved_logpdf(d::Convolved, components::Tuple,
        x::AbstractVector{<:Real}, method::NumericSolver)
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
function convolved_quantile(d::AbstractConvolvedDistribution,
        components::Tuple, p::Real, method::AbstractSolverMethod)
    error(
        "convolved_quantile not implemented for method type $(typeof(method))")
end

function convolved_quantile(d::Convolved, components::Tuple,
        p::Real, method::AnalyticalSolver)
    return _convolved_analytic_arm(convolved_quantile, quantile, d,
        components, p, method)
end

@doc "
    convolved_minimum(d, components, method)

The minimum of the sum of `components`. A quantity with no evaluation
point takes no `x`/`p` argument at all. Not wired into `minimum`, which
is already exact by summation; only the unimplemented-method-type error
exists, demonstrating the shape compiles for a future zero-argument
quantity.
"
function convolved_minimum(d::AbstractConvolvedDistribution,
        components::Tuple, method::AbstractSolverMethod)
    error(
        "convolved_minimum not implemented for method type $(typeof(method))")
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
# (uncollapsible via `_try_convolve`, e.g. the Gamma+Uniform
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
function _more_specific_pair_method(generic::F, components::Tuple,
        method::AnalyticalSolver) where {F}
    fallback = which(generic, Tuple{Convolved, Tuple, Real, AnalyticalSolver})
    resolved = which(generic,
        Tuple{Convolved, typeof(components), Real, typeof(method)})
    return resolved !== fallback
end

const _CONVOLVED_QUANTITY_KEYS = (:pdf, :logpdf, :cdf, :logcdf, :ccdf,
    :logccdf)
const _CONVOLVED_QUANTITY_GENERICS = (convolved_pdf, convolved_logpdf,
    convolved_cdf, convolved_logcdf, convolved_ccdf, convolved_logccdf)

# Per-quantity closed-form answer for `components` under `method`,
# resolved once at construction (see the section banner above).
# `NumericSolver` always answers `false` for every quantity -- that
# method explicitly requests the numeric path. Under `AnalyticalSolver`,
# a quantity is analytic when the whole tuple collapses to one
# distribution via pairwise `_try_convolve` (every quantity is then
# analytic, since a genuine `Distributions.jl` object answers all of
# them) OR a pair-specific method is registered for that particular
# quantity (checked per quantity: a pair like Gamma+Uniform only
# registers `pdf`/`cdf`/`logpdf`, not `logcdf`/`ccdf`/`logccdf`).
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
