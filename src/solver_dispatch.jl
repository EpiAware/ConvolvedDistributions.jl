# Solver-method dispatch (#77): one internal generic per quantity, each
# with a four-method skeleton, mirroring CensoredDistributions'
# `primarycensored_cdf`. Method 1 errors for an unrecognised solver
# type; method 2 (`AnalyticalSolver`) tries the named-distribution route
# (`_try_convolve`) then falls back to method 3 (`NumericSolver`,
# quadrature); method 4 is one specific analytic pair (defined
# elsewhere, e.g. src/uniform_window.jl), more specific than method 2 so
# ordinary dispatch prefers it. `Convolved`'s two-component call sites
# use these; three or more components keep the pre-existing pairwise
# fold (`_maybe_analytic` in Convolved.jl), untouched.

@doc "

    _try_convolve(a, b)

The analytic sum distribution for `a + b` when `Distributions.convolve`
applies, else `nothing`. Dispatch (not `try`/`catch`) keeps the path
differentiable under every AD backend. `Gamma` and `Exponential`
additionally need matching scale/rate, else the runtime `convolve`
throws.
"
_try_convolve(a::UnivariateDistribution, b::UnivariateDistribution) = nothing

_try_convolve(a::Normal, b::Normal) = Distributions.convolve(a, b)

function _try_convolve(a::Exponential, b::Exponential)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

function _try_convolve(a::Gamma, b::Gamma)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

@doc "

    convolved_cdf(d1, d2, x, method)
    convolved_logcdf(d1, d2, x, method)
    convolved_ccdf(d1, d2, x, method)
    convolved_logccdf(d1, d2, x, method)
    convolved_pdf(d1, d2, x, method)
    convolved_logpdf(d1, d2, x, method)

The named quantity of `d1 + d2` at `x`, dispatched on the solver method
`method`. `AnalyticalSolver` prefers a named-distribution or
component-specific analytic method, falling back to `NumericSolver`
quadrature. Public so a downstream package (e.g.
CensoredDistributions.jl) can add its own analytic pair by defining a
method more specific than `(UnivariateDistribution,
UnivariateDistribution, Real, AnalyticalSolver)`.

See also: [`Convolved`](@ref), [`AnalyticalSolver`](@ref),
[`NumericSolver`](@ref)
"
function convolved_cdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::Real, method::AbstractSolverMethod)
    error("convolved_cdf not implemented for method type $(typeof(method))")
end

function convolved_cdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return cdf(a, x)
    return convolved_cdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_cdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::Real, method::NumericSolver)
    return _convolved_numeric_cdf(Convolved((d1, d2); method = method), x)
end

function convolved_logcdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AbstractSolverMethod)
    error("convolved_logcdf not implemented for method type $(typeof(method))")
end

function convolved_logcdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return logcdf(a, x)
    return convolved_logcdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_logcdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::NumericSolver)
    c = convolved_cdf(d1, d2, x, method)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

function convolved_ccdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AbstractSolverMethod)
    error("convolved_ccdf not implemented for method type $(typeof(method))")
end

function convolved_ccdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return ccdf(a, x)
    return convolved_ccdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_ccdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::NumericSolver)
    return 1 - convolved_cdf(d1, d2, x, method)
end

function convolved_logccdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AbstractSolverMethod)
    error(
        "convolved_logccdf not implemented for method type $(typeof(method))")
end

function convolved_logccdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return logccdf(a, x)
    return convolved_logccdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_logccdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::NumericSolver)
    l = convolved_logcdf(d1, d2, x, method)
    l == -Inf && return zero(l)
    l >= 0 && return oftype(l, -Inf)
    return log1mexp(l)
end

function convolved_pdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::Real, method::AbstractSolverMethod)
    error("convolved_pdf not implemented for method type $(typeof(method))")
end

function convolved_pdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return pdf(a, x)
    return convolved_pdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_pdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::Real, method::NumericSolver)
    return _convolved_numeric_pdf(Convolved((d1, d2); method = method), x)
end

function convolved_logpdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AbstractSolverMethod)
    error("convolved_logpdf not implemented for method type $(typeof(method))")
end

function convolved_logpdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return logpdf(a, x)
    return convolved_logpdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_logpdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::Real, method::NumericSolver)
    d = Convolved((d1, d2); method = method)
    insupport(d, x) || return oftype(float(x), -Inf)
    p = _convolved_numeric_pdf(d, x)
    return p <= 0 ? oftype(float(x), -Inf) : log(p)
end

@doc "

    convolved_quantile(d1, d2, p, method)

The quantile of `d1 + d2` at `p`. Skeleton methods 1-2 only: the
`NumericSolver` arm (method 3) needs a nonlinear solve and lives in the
`ConvolvedDistributionsOptimizationExt` extension, so a non-analytic
pair's quantile is unavailable until Optimization.jl is loaded, while an
analytic pair (`_try_convolve`) works without it.

See also: [`convolved_cdf`](@ref)
"
function convolved_quantile(d1::UnivariateDistribution,
        d2::UnivariateDistribution, p::Real, method::AbstractSolverMethod)
    error(
        "convolved_quantile not implemented for method type $(typeof(method))")
end

function convolved_quantile(d1::UnivariateDistribution,
        d2::UnivariateDistribution, p::Real, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return quantile(a, p)
    return convolved_quantile(d1, d2, p, NumericSolver(method.solver))
end

# S1.4: a quantity with no evaluation point takes no `x`/`p` argument at
# all. Demonstrates the shape compiles; not wired into `minimum`, which
# is already exact by summation (S2.5).
function convolved_minimum(d1::UnivariateDistribution,
        d2::UnivariateDistribution, method::AbstractSolverMethod)
    error(
        "convolved_minimum not implemented for method type $(typeof(method))")
end

# `_convolved_general_quantile` is `Convolved`'s numeric quantile for
# what the pair mechanism does not cover (three or more components).
# Declared with no methods here; the Optimization extension supplies the
# Nelder-Mead implementation.
function _convolved_general_quantile end

@doc "

Whether `f(d1, d2, x, method)` resolves to a method more specific than
the `AnalyticalSolver` generic fallback for component types `D1`/`D2` --
an analytic route exists, checked by method lookup (`which`), never by
evaluating `f` (#92). Julia disallows `which`/code reflection inside a
`@generated` function body, so this cost is paid at every call rather
than once per `(F, D1, D2)` type combination -- see the note on
`_convolved_pair` below.
"
function _has_analytic_route(f::F, ::Type{D1}, ::Type{D2},
        method::AnalyticalSolver) where {F, D1, D2}
    fallback = which(f,
        Tuple{UnivariateDistribution, UnivariateDistribution, Real,
            AnalyticalSolver})
    resolved = which(f, Tuple{D1, D2, Real, typeof(method)})
    return resolved !== fallback
end

@doc "

Whether an analytic route exists for `f(d1, d2, ...)` and, if so, the
`(a1, a2)` component order to call `f` in: the named-distribution route
(S2.3) first, since it is symmetric and cheap, then method lookup
(`_has_analytic_route`) in each order (S1.5/S4.1). Computed once per
`(d1, d2, method)` rather than per evaluation point, so batched callers
(`Convolved`'s vector `cdf`/`pdf`/`logpdf`) share one answer across
their whole point vector instead of paying a `which` lookup per point.
Falls back to `(false, d1, d2)` when neither order has a route.
"
function _convolved_route(f::F, d1, d2, method::AnalyticalSolver) where {F}
    _try_convolve(d1, d2) !== nothing && return (true, d1, d2)
    _has_analytic_route(f, typeof(d1), typeof(d2), method) &&
        return (true, d1, d2)
    _has_analytic_route(f, typeof(d2), typeof(d1), method) &&
        return (true, d2, d1)
    return (false, d1, d2)
end

_convolved_route(f::F, d1, d2, ::NumericSolver) where {F} = (false, d1, d2)

@doc "

Evaluate `f(d1, d2, extra, method)` for a two-component pair via
[`_convolved_route`](@ref): try the given order, then (`AnalyticalSolver`
only) the reversed order, before settling on whichever method actually
matches. `Convolved` is commutative but dispatch is not, and the caller
chooses the component order (S1.5); `Difference`/`Product` are not
commutative and never use this.

Pays a `_convolved_route` lookup per call -- for a delay family whose
closed form is itself cheap (a handful of arithmetic ops), that lookup
cost can be comparable to or larger than the closed form, so the
analytic route is not guaranteed to beat quadrature on raw wall-clock
for a small batch. It is guaranteed to be *exact* and to skip
quadrature, which is the property `evaluation_path`/`has_closed_form`
and the `TestUtils` skip-quadrature check verify.
"
function _convolved_pair(f::F, d1, d2, extra, method) where {F}
    _, a1, a2 = _convolved_route(f, d1, d2, method)
    return f(a1, a2, extra, method)
end

# Maps a Distributions.jl quantity function to its `convolved_*` generic,
# for `evaluation_path`'s per-quantity route check.
_convolved_generic(::typeof(cdf)) = convolved_cdf
_convolved_generic(::typeof(logcdf)) = convolved_logcdf
_convolved_generic(::typeof(ccdf)) = convolved_ccdf
_convolved_generic(::typeof(logccdf)) = convolved_logccdf
_convolved_generic(::typeof(pdf)) = convolved_pdf
_convolved_generic(::typeof(logpdf)) = convolved_logpdf

@doc "

Per-quantity route check for a two-component `Convolved` (#92): true
when `d1 + d2` names a distribution (checked the same way the
`AnalyticalSolver` generic itself does, S2.3), or when `f`'s
`convolved_*` generic resolves to a method more specific than the
`AnalyticalSolver` fallback in either component order (S1.5/S4.1).
Neither check evaluates `f`. Three or more components, or a
`NumericSolver` method, fall back to [`interface.jl`](@ref)'s generic
`_maybe_analytic`-based answer.
"
function _is_analytic(d::Convolved, f::F) where {F}
    length(d.components) == 2 || return _maybe_analytic(d) !== nothing
    d1, d2 = d.components
    has, _, _ = _convolved_route(_convolved_generic(f), d1, d2, d.method)
    return has
end
