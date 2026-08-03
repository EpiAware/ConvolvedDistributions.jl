# Solver-method dispatch (#77): one internal generic per quantity, each
# with a four-method skeleton, mirroring CensoredDistributions'
# `primarycensored_cdf`. Method 1 errors for an unrecognised solver
# type; method 2 (`AnalyticalSolver`) tries the named-distribution route
# (`_try_convolve`) then falls back to method 3 (`NumericSolver`, the
# exact discrete lattice fold for an all-discrete-integer pair,
# Gauss-Legendre quadrature otherwise -- `_convolved_cdf_route`/
# `_convolved_pdf_route` in Convolved.jl dispatch on the pair's derived
# value-support type parameter, #85); method 4 is one specific analytic
# pair (defined elsewhere, e.g. src/uniform_window.jl), more specific
# than method 2 so ordinary dispatch prefers it. `cdf`/`pdf`/`logpdf`
# repeat the skeleton for `x::AbstractVector{<:Real}` (S1.4), so a
# two-component `Convolved` batches a pair-specific analytic method
# (where one ships a vector form) or the composite-quadrature/lattice
# batch, never the runtime route lookup this replaced. `Convolved`'s
# two-component call sites use these; three or more components keep the
# pre-existing pairwise fold (`_maybe_analytic` in Convolved.jl), which
# reuses this same `_try_convolve`, untouched.

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

@doc "
    convolved_cdf(d1, d2, x, method)

The CDF of `d1 + d2` at `x`, dispatched on the solver method `method`.
`AnalyticalSolver` prefers a named-distribution or component-specific
analytic method, falling back to `NumericSolver` quadrature. Public,
alongside its `logcdf`/`ccdf`/`logccdf`/`pdf`/`logpdf`/`quantile`
siblings, so a downstream package adds its own analytic pair by
defining a method more specific than `(UnivariateDistribution,
UnivariateDistribution, Real, AnalyticalSolver)`.

# Examples
```@example
using ConvolvedDistributions, Distributions

ConvolvedDistributions.convolved_cdf(
    Gamma(2.0, 1.5), Uniform(0.0, 2.0), 3.0, AnalyticalSolver())
```

See also: [`Convolved`](@ref)
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
    # `_convolved_cdf_route` dispatches on the pair's derived value-support
    # type parameter: the exact lattice fold for an all-discrete-integer
    # pair with no named closed form (e.g. Poisson+Geometric), quadrature
    # otherwise (#85).
    return _convolved_cdf_route(Convolved((d1, d2); method = method), x)
end

# Vector-`x` skeleton (S1.4): `Convolved`'s batched `cdf` uses this so a
# pair-specific analytic method batches via its own vector method (only
# the uniform-window pairs ship one) rather than losing the
# composite-quadrature batch (`_convolved_numeric_cdf_batched`) that
# method 3 shares across points.
function convolved_cdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::AbstractVector{<:Real}, method::AbstractSolverMethod)
    error("convolved_cdf not implemented for method type $(typeof(method))")
end

function convolved_cdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::AbstractVector{<:Real}, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return map(xi -> cdf(a, xi), x)
    return convolved_cdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_cdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::AbstractVector{<:Real}, method::NumericSolver)
    return _convolved_cdf_route(Convolved((d1, d2); method = method), x)
end

@doc "
    convolved_logcdf(d1, d2, x, method)

The log CDF of `d1 + d2` at `x`. See [`convolved_cdf`](@ref).
"
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

@doc "
    convolved_ccdf(d1, d2, x, method)

The complementary CDF of `d1 + d2` at `x`. See [`convolved_cdf`](@ref).
"
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

@doc "
    convolved_logccdf(d1, d2, x, method)

The log complementary CDF of `d1 + d2` at `x`. See
[`convolved_cdf`](@ref).
"
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

@doc "
    convolved_pdf(d1, d2, x, method)

The density of `d1 + d2` at `x`. See [`convolved_cdf`](@ref).
"
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
    # See `convolved_cdf`'s `NumericSolver` arm: `_convolved_pdf_route`
    # picks the exact lattice fold or quadrature by the pair's derived
    # value-support type parameter (#85).
    return _convolved_pdf_route(Convolved((d1, d2); method = method), x)
end

# Vector-`x` skeleton (S1.4): see `convolved_cdf`'s.
function convolved_pdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::AbstractVector{<:Real}, method::AbstractSolverMethod)
    error("convolved_pdf not implemented for method type $(typeof(method))")
end

function convolved_pdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::AbstractVector{<:Real}, method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return map(xi -> pdf(a, xi), x)
    return convolved_pdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_pdf(d1::UnivariateDistribution, d2::UnivariateDistribution,
        x::AbstractVector{<:Real}, method::NumericSolver)
    return _convolved_pdf_route(Convolved((d1, d2); method = method), x)
end

@doc "
    convolved_logpdf(d1, d2, x, method)

The log density of `d1 + d2` at `x`. See [`convolved_cdf`](@ref).
"
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
    p = _convolved_pdf_route(d, x)
    return p <= 0 ? oftype(float(x), -Inf) : log(p)
end

# Vector-`x` skeleton (S1.4): see `convolved_cdf`'s. Method 3 reuses
# `_batched_numeric_logpdf` (Convolved.jl), the same insupport-aware log
# of the shared composite-quadrature pdf batch the 3+-component path
# uses.
function convolved_logpdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::AbstractVector{<:Real},
        method::AbstractSolverMethod)
    error("convolved_logpdf not implemented for method type $(typeof(method))")
end

function convolved_logpdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::AbstractVector{<:Real},
        method::AnalyticalSolver)
    a = _try_convolve(d1, d2)
    a === nothing || return map(xi -> logpdf(a, xi), x)
    return convolved_logpdf(d1, d2, x, NumericSolver(method.solver))
end

function convolved_logpdf(d1::UnivariateDistribution,
        d2::UnivariateDistribution, x::AbstractVector{<:Real},
        method::NumericSolver)
    return _batched_numeric_logpdf(Convolved((d1, d2); method = method), x)
end

@doc "
    convolved_quantile(d1, d2, p, method)

The quantile of `d1 + d2` at probability `p`. Skeleton methods 1-2
only: the `NumericSolver` arm needs a nonlinear solve and lives in the
`ConvolvedDistributionsOptimizationExt` extension, so a non-analytic
pair's quantile is unavailable until Optimization.jl is loaded, while
an analytic pair (`_try_convolve`) works without it.

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

@doc "
    convolved_minimum(d1, d2, method)

The minimum of `d1 + d2`. A quantity with no evaluation point takes no
`x`/`p` argument at all. Not wired into `minimum`, which is already
exact by summation; only the unimplemented-method-type error exists,
demonstrating the shape compiles for a future zero-argument quantity.
"
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
the `AnalyticalSolver` generic fallback for component types `D1`/`D2`,
checked by method lookup (`which`), never by evaluating `f` (#92).
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
`(a1, a2)` component order it was found in: the named-distribution
route first, then method lookup in each order (S1.5). Used only by
[`_is_analytic`](@ref) (#92's evaluation-path predicate, S1.5a); the
evaluation call sites in `Convolved.jl` dispatch directly and never
call this.
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
