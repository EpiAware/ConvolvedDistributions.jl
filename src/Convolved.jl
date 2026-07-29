@doc """

Distribution of a sum of independent random variables (a convolution).

`Convolved` represents ``X = X_1 + X_2 + \\dots + X_n`` where the
``X_i`` are independent univariate distributions. It is the keystone
primitive for multi-delay epidemiological models, where an observed
delay is the sum of several independent stages (e.g.
onset-to-death = onset-to-admission ``\\oplus`` admission-to-death).

Components may have negative support (for example a `Normal` capturing
pre-symptomatic transmission timing); `minimum` and `maximum` are the
sums of the component supports, taking the value ``\\pm\\infty`` where a
component is unbounded.

# Value support

The value support is DERIVED from the components, not hardcoded: when
every component is an integer-lattice discrete distribution (discrete
with `eltype <: Integer`), `Convolved` is itself `Discrete` and its
density/CDF are computed by an exact fold over the integer lattice
instead of quadrature (see [`is_exact`](@ref)). Otherwise it is
`Continuous`, as before. The lattice fold costs `O(window)` lattice
points per evaluation (and multiplies across nested components), so
evaluating at a very large point is correspondingly expensive; no cap is
imposed.

# CDF computation

The CDF is computed by integrating one component out against the CDF of
the others:

```math
F_X(x) = \\int F_{R}(x - t)\\, f_{C}(t)\\, \\mathrm{d}t
```

where ``C`` is the last component (the integration variable) and ``R``
is the convolution of the remaining components. For more than two
components the remaining convolution is folded recursively.

Where an analytical convolution is available (`Distributions.convolve`
applies, e.g. `Normal`+`Normal`, equal-scale `Gamma`, equal-rate
`Exponential`, `Poisson`+`Poisson`, equal-`p` `Binomial`/
`NegativeBinomial`) the two-component result is taken directly from the
convolved distribution unless a [`NumericSolver`](@ref) method is set. All
other `Continuous`-typed cases use AD-safe fixed-node Gauss-Legendre
quadrature: the integral is mapped from the fixed reference domain
``(-1, 1)`` onto the real bounds inside the integrand and reduced as a
bare weighted dot product (`gl_integrate`), which lets every AD backend
specialise on the integrand's own type so component `Dual`s and tangents
propagate. A `Discrete`-typed `Convolved` never reaches quadrature at
all — see "Value support" above.

The `method` field selects the CDF/PDF backend: an [`AnalyticalSolver`](@ref)
(the default) uses the analytic convolution when one exists and falls back to
the numeric path otherwise, while a [`NumericSolver`](@ref) forces that
numeric path even when an analytic convolution exists; the latter is useful
for validation and debugging. For a `Continuous`-typed `Convolved` the
numeric path is quadrature; for a `Discrete`-typed one it is the exact
integer-lattice fold, never quadrature — `NumericSolver` means "skip the
closed form", not "run Gauss-Legendre".

# See also
- [`convolved`](@ref): Constructor function
"""
struct Convolved{C <: Tuple, M <: AbstractSolverMethod,
    S <: Distributions.ValueSupport} <:
       AbstractConvolvedDistribution{Distributions.Univariate, S}
    "Tuple of independent component distributions to be summed."
    components::C
    "Solver method choosing the analytic vs numeric quadrature backend."
    method::M

    function Convolved(components::C;
            method::AbstractSolverMethod = AnalyticalSolver()) where {
            C <: Tuple}
        # The type allows a single-component (degenerate) convolution so the
        # recursive moment fold and rebuild paths can wrap one component; the
        # user-facing `convolved` requires two or more, since
        # convolving fewer is a no-op.
        length(components) >= 1 ||
            throw(ArgumentError("Convolved needs at least one component"))
        all(c -> c isa UnivariateDistribution, components) ||
            throw(ArgumentError(
                "All components must be UnivariateDistributions"))
        S = _components_support(components)
        new{C, typeof(method), S}(components, method)
    end
end

# Discrete-typed alias: matches only when every component is an
# integer-lattice discrete distribution (see `_components_support` in
# `src/interface.jl`). Used to dispatch to the exact lattice fold.
const _DiscreteConvolved = Convolved{<:Tuple, <:AbstractSolverMethod, Discrete}

# Single-component alias. `convolved(...)` always builds two or more
# components (see below), but `Convolved` itself is public and its inner
# constructor permits one component — the recursive rebuild uses this for
# the degenerate "rest of one" case. Used below to fix a pre-existing bug:
# a directly-constructed, single-component `Convolved` under
# `NumericSolver` throws instead of evaluating.
const _SingleConvolved = Convolved{<:Tuple{UnivariateDistribution}}

@doc "

Create the distribution of a sum of independent delays (a convolution).

Accepts either two or more positional component distributions, or a
single vector/tuple of components. Returns a [`Convolved`](@ref)
distribution.

# Arguments
- `components`: Two or more `UnivariateDistribution`s, or a vector/tuple
  of them.

# Keyword Arguments
- `method`: The solver method, an [`AnalyticalSolver`](@ref) (the default)
  or [`NumericSolver`](@ref). `NumericSolver` forces numeric quadrature
  even when an analytic convolution is available.
- `strict`: When `true`, error (naming the component families) rather
  than silently return an object whose density/CDF would fall back to
  quadrature. `false` by default. See [`evaluation_path`](@ref) to check
  the route after construction instead of asserting it up front.

# Returns
- A [`Convolved`](@ref) distribution of the sum of the components.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Sum of two delays
d = convolved(Gamma(2.0, 1.0), LogNormal(1.5, 0.5))
cdf_at_5 = cdf(d, 5.0)

# Sum of three delays from a vector
d3 = convolved([Gamma(2.0, 1.0), Gamma(1.0, 1.0), Normal(0.0, 1.0)])
mean_sample = rand(d3)

# Force numeric quadrature even for an analytic pair
dn = convolved(Normal(0.0, 1.0), Normal(1.0, 2.0);
    method = NumericSolver())
cdf_numeric = cdf(dn, 2.0)
```

# See also
- [`Convolved`](@ref): The distribution type
- [`evaluation_path`](@ref): Check the route without asserting it.
"
function convolved(
        components::AbstractVector{<:UnivariateDistribution};
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false)
    length(components) >= 2 ||
        throw(ArgumentError("convolved needs at least two components"))
    return _check_strict(Convolved(Tuple(components); method = method), strict)
end

function convolved(
        c1::UnivariateDistribution, c2::UnivariateDistribution,
        rest::UnivariateDistribution...;
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false)
    return _check_strict(
        Convolved((c1, c2, rest...); method = method), strict)
end

function convolved(components::Tuple;
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false)
    length(components) >= 2 ||
        throw(ArgumentError("convolved needs at least two components"))
    return _check_strict(Convolved(components; method = method), strict)
end

# The component-family names for a `strict = true` construction error
# (see `_check_strict` in interface.jl).
_family_names(d::Convolved) = nameof.(typeof.(d.components))

# ---------------------------------------------------------------------------
# Interface: params / support / sampling
# ---------------------------------------------------------------------------

params(d::Convolved) = map(params, d.components)

"""
    components(d::Convolved)

The independent delay distributions whose sum `d` represents, returned as the
component tuple. The public accessor for peeling a `Convolved` apart without
reaching into its fields — a downstream `lower` bridge, for one, folds them
into a series phase-type chain. Extends `Distributions.components` (the standard
composite-distribution accessor), so it composes with `using Distributions`
rather than clashing with it.
"""
components(d::Convolved) = d.components

# The element type of the SUM, not a bare `promote_type` of the
# components: for `Bernoulli`+`Bernoulli` (`eltype == Bool` each),
# `promote_type(Bool, Bool) == Bool`, too narrow for a sum that reaches
# 2 and throws `InexactError` from `rand`. `Base.promote_op(+, ...)`
# infers the type `+` actually produces (`Int64` for two `Bool`s).
function Base.eltype(::Type{<:Convolved{C}}) where {C <: Tuple}
    return Base.promote_op(+, map(eltype, fieldtypes(C))...)
end

minimum(d::Convolved) = sum(minimum, d.components)
maximum(d::Convolved) = sum(maximum, d.components)

function insupport(d::Convolved, x::Real)
    return _on_lattice(d, x) && minimum(d) <= x <= maximum(d)
end

function Base.rand(rng::AbstractRNG, d::Convolved)
    return sum(c -> rand(rng, c), d.components)
end

sampler(d::Convolved) = d

# ---------------------------------------------------------------------------
# Moments: exact analytic sum of independent components
# ---------------------------------------------------------------------------
#
# A `Convolved` is a sum of independent components, so the mean and variance
# are exact and additive: `mean = sum(mean.(components))` and
# `var = sum(var.(components))`. No sampling, no discretisation. Each component
# must provide an analytic `mean`/`var`; a component without one errors from
# its own `mean`/`var` (no fallback). The moments flow through the component
# parameters, so the path is AD-safe.

# Per-component moments via the component's analytic `mean`/`var`. A nested
# `Convolved` is itself a `UnivariateDistribution`, so it recurses through this
# same additive sum via its own `mean`/`var`.
_component_mean(c::UnivariateDistribution) = mean(c)
_component_var(c::UnivariateDistribution) = var(c)

@doc "

Mean of the convolution: the exact sum of the component means.

A [`Convolved`](@ref) is a sum of independent components, so the mean is
``\\sum_i \\mathbb{E}[X_i]``. Each component must provide an analytic `mean`;
a component without one errors (there is no numeric fallback).

See also: [`var`](@ref), [`std`](@ref)
"
mean(d::Convolved) = sum(_component_mean, d.components)

@doc "

Variance of the convolution: the exact sum of the component variances.

Independence makes the variance additive, ``\\sum_i \\mathrm{Var}[X_i]``. As
for [`mean`](@ref), each component must provide an analytic `var` or the call
errors.

See also: [`mean`](@ref), [`std`](@ref)
"
var(d::Convolved) = sum(_component_var, d.components)

@doc "

Standard deviation of the convolution, ``\\sqrt{\\mathrm{Var}[X]}``.

See also: [`var`](@ref), [`mean`](@ref)
"
std(d::Convolved) = sqrt(var(d))

# ---------------------------------------------------------------------------
# Analytical fast path via Distributions.convolve
# ---------------------------------------------------------------------------

# `_try_convolve` returns the analytically convolved distribution when a
# closed form exists for the pair, otherwise `nothing`. Dispatch (rather
# than `try`/`catch`) selects the analytic pairs so the path stays
# differentiable under every AD backend — Mooncake reverse cannot
# differentiate through `try`/`catch`. Both continuous and discrete
# families are enabled, wherever `Distributions.convolve` always succeeds
# for the given parameters; several families additionally need a matching
# parameter (`Gamma`/`Exponential` equal scale, `Binomial`/
# `NegativeBinomial` equal success probability, mirroring
# `Distributions._check_convolution_args`'s own guard) — else the runtime
# `convolve` would throw — so a parameter check guards those and falls
# through to the exact discrete lattice fold (still exact, just not a
# closed form) rather than to quadrature.
_try_convolve(a::UnivariateDistribution, b::UnivariateDistribution) = nothing

function _try_convolve(a::Normal, b::Normal)
    return Distributions.convolve(a, b)
end

function _try_convolve(a::Exponential, b::Exponential)
    # convolve(::Exponential, ::Exponential) asserts equal rate and throws
    # otherwise, so guard the parameters and fall back to numeric.
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

function _try_convolve(a::Gamma, b::Gamma)
    return scale(a) ≈ scale(b) ? Distributions.convolve(a, b) : nothing
end

function _try_convolve(a::Poisson, b::Poisson)
    return Distributions.convolve(a, b)
end

function _try_convolve(a::Binomial, b::Binomial)
    return succprob(a) ≈ succprob(b) ? Distributions.convolve(a, b) : nothing
end

function _try_convolve(a::NegativeBinomial, b::NegativeBinomial)
    return succprob(a) ≈ succprob(b) ? Distributions.convolve(a, b) : nothing
end

# Reduce the component tuple to a single distribution, folding pairwise
# with `Distributions.convolve` where it applies. Returns the fully
# convolved distribution when every pair convolves analytically, else
# `nothing` so the caller falls back to numeric quadrature.
function _analytic_convolution(components::Tuple)
    acc = components[1]
    for i in 2:length(components)
        acc = _try_convolve(acc, components[i])
        acc === nothing && return nothing
    end
    return acc
end

# The analytic convolution to use for `d`, or `nothing` when none exists
# or when `d.method` is a `NumericSolver` requesting the numeric quadrature
# path.
function _maybe_analytic(d::Convolved)
    d.method isa NumericSolver && return nothing
    return _analytic_convolution(d.components)
end

# Fraction of probability trimmed from each tail of an unbounded
# integration component when clamping an infinite quadrature window.
const _CONVOLVED_TAIL = 1e-8

# Quantile used only to pick a finite quadrature endpoint. Reconstructing
# the component from primal (AD-stripped) params via EpiAwareADTools'
# `primal_distribution` means `quantile` — and so `gamma_inc_inv` for a
# `Gamma` integration component — only ever sees plain `Float64`s. No AD
# backend differentiates through it, which is correct: the window choice
# carries no gradient (it is a fixed hyperparameter of the quadrature,
# like the node count). Previously the live `Dual`/`TrackedReal` params
# flowed into `quantile`, and Enzyme cannot push duals through
# `SpecialFunctions.gamma_inc_inv_qsmall` (`IllegalTypeAnalysisException`).
# `@noinline` so the call survives as a call site for the per-backend AD
# rules (the Enzyme `EnzymeRules` rule and the ChainRules
# `@non_differentiable` mark) to attach to; if it inlined, Enzyme would
# type-analyse `quantile`/`gamma_inc_inv` directly and abort.
#
# Wrapped in `float(...)`: `quantile` on a discrete distribution returns
# an `Int` for some families (`Poisson`) and a `Float64` for others
# (`Geometric`), so a caller that ternary-branches between this and an
# already-finite `Float64` bound (`_finite_window` below,
# `_difference_window`/`_product_mass_window` in Difference.jl/
# Product.jl) would otherwise infer a `Union{Int, Float64}` result —
# harmless for the continuous quadrature path (later arithmetic resolves
# it) but rejected outright by Enzyme's type analysis on the exact
# discrete lattice fold, the same class of union `_min2`/`_max2` guards
# against.
@noinline function _window_quantile(comp::UnivariateDistribution, p::Real)
    return float(quantile(primal_distribution(comp), p))
end

# Composite window quantile for a `Convolved` component (issue #45). A
# composite cannot round-trip through the generic `D(params...)` rebuild
# above, and its exact quantile needs the Optimization extension — but
# the window clamp only needs an effective-support bound. The sum of the
# per-component window quantiles at the same `p` over-covers either tail
# (union bound: if the sum lies beyond it, some component lies beyond
# its own `p`-quantile), so at most `length(components) *
# _CONVOLVED_TAIL` of mass is trimmed. This keeps the window cheap,
# extension-free and, like the generic method, a non-differentiated
# constant (`@noinline` so the per-backend AD rules attach to the call
# site).
@noinline function _window_quantile(d::Convolved, p::Real)
    return sum(c -> _window_quantile(c, p), d.components)
end

# Clamp an integration window to a finite range. Both the integrand's
# `f_C(t)` factor and (for the CDF) the transition of `F_R(x - t)` are
# negligible outside the integration component's effective support, so an
# infinite endpoint is replaced by an extreme quantile of `last_comp`.
# This lets the numeric path handle components unbounded on either side
# (e.g. Normal+Normal under a `NumericSolver`). The endpoint quantile is
# computed on AD-stripped params (`_window_quantile`) so the window stays
# a non-differentiated constant across every AD backend.
function _finite_window(last_comp, lower::Real, upper::Real)
    lo = isfinite(lower) ? lower : _window_quantile(last_comp, _CONVOLVED_TAIL)
    hi = isfinite(upper) ? upper :
         _window_quantile(last_comp, 1 - _CONVOLVED_TAIL)
    return lo, hi
end

# Interior panel breaks for the quantile-panelled quadrature (issue
# #49): the integration component's `_PANEL_PROBS` quantiles that fall
# strictly inside the primal window `(lo, hi)`, in increasing order
# (quantiles are monotone in `p`). Like the window clamp above, the
# breaks are quadrature hyperparameters — just *where* to split — so
# they are computed on AD-stripped params (`_window_quantile`) and stay
# non-differentiated constants across every AD backend.
function _panel_breaks(comp, lo::Float64, hi::Float64)
    breaks = Float64[]
    for p in _PANEL_PROBS
        b = Float64(_window_quantile(comp, p))
        lo < b < hi && push!(breaks, b)
    end
    return breaks
end

# Quantile-panelled scalar quadrature: integrate `f` over `[lo, hi]` by
# splitting the window at the integration component's quantile breaks
# and applying the `_PANEL_GL` rule per panel, so node density follows
# the component's mass even when a heavy tail stretches the window
# (issue #49). The interior breaks are primal constants (see
# `_panel_breaks`); the outermost panels keep the live `lo`/`hi`
# endpoints, so gradient flow through the window bounds matches the old
# single-window rule. A window with no interior breaks (within one
# quantile band, or in a far tail) falls back to the single-window
# `_CONVOLVED_GL` rule unchanged.
function _panel_integrate(f::F, lo, hi, comp) where {F}
    lop = Float64(primal(lo))
    hip = Float64(primal(hi))
    breaks = _panel_breaks(comp, lop, hip)
    isempty(breaks) && return gl_integrate(f, lo, hi)
    acc = gl_integrate(f, lo, first(breaks), _PANEL_GL)
    for i in 1:(length(breaks) - 1)
        acc += gl_integrate(f, breaks[i], breaks[i + 1], _PANEL_GL)
    end
    acc += gl_integrate(f, last(breaks), hi, _PANEL_GL)
    return acc
end

# ---------------------------------------------------------------------------
# Numeric convolution (AD-safe Gauss-Legendre dot product)
# ---------------------------------------------------------------------------

# Integrate the last component out against a function `kernel` of the
# remaining convolution `rest`. The "rest" distribution is itself a
# `Convolved` (or a single distribution) so both the CDF and PDF kernels
# fold recursively for more than two components.
_rest_distribution(c::Tuple{<:UnivariateDistribution}) = c[1]
_rest_distribution(c::Tuple) = Convolved(c)

# Scalar min/max helpers, promoting to a common type first. Every
# continuous-only call site historically had `a` and `b` already the
# same type (Float64 bounds on both sides), so a bare `a < b ? a : b`
# was type-stable in practice; a discrete component's `minimum`/`maximum`
# is often `Int` (e.g. `minimum(Poisson) == 0`) while the other side is
# `Float64`, and without promotion the ternary infers a
# `Union{Int, Float64}` result. That union is harmless for the
# continuous numeric path (later arithmetic resolves it), but it reaches
# the differentiated closure on the exact discrete lattice fold and
# Enzyme's type analysis rejects unions outright
# (`IllegalTypeAnalysisException`), so promoting here — not deeper in
# the call chain — is what keeps every route AD-safe.
_min2(a, b) = ((pa, pb) = promote(a, b); pa < pb ? pa : pb)
_max2(a, b) = ((pa, pb) = promote(a, b); pa > pb ? pa : pb)

# ---------------------------------------------------------------------------
# Route selection: numeric quadrature vs the exact discrete lattice fold
# ---------------------------------------------------------------------------
#
# Dispatch on the `Discrete` type parameter (not a runtime `if`) selects
# the exact lattice fold (`_convolved_lattice_pdf`/`_convolved_lattice_cdf`,
# defined below) for an all-discrete-integer combination, and numeric
# quadrature otherwise. `is_exact` in `src/interface.jl` keys off the SAME
# `_exact_discrete_route` predicate these dispatch on, so a discrete
# combination's reported exactness cannot drift from the route actually
# executed (#85, #89).
_convolved_pdf_route(d::Convolved, x::Real) = _convolved_numeric_pdf(d, x)
_convolved_pdf_route(d::_DiscreteConvolved, x::Real) = _convolved_lattice_pdf(d, x)
_convolved_cdf_route(d::Convolved, x::Real) = _convolved_numeric_cdf(d, x)
_convolved_cdf_route(d::_DiscreteConvolved, x::Real) = _convolved_lattice_cdf(d, x)

function _convolved_pdf_route(d::Convolved, x::AbstractVector{<:Real})
    _convolved_numeric_pdf_batched(d, x)
end
function _convolved_pdf_route(d::_DiscreteConvolved, x::AbstractVector{<:Real})
    map(xi -> _convolved_lattice_pdf(d, xi), x)
end
function _convolved_cdf_route(d::Convolved, x::AbstractVector{<:Real})
    _convolved_numeric_cdf_batched(d, x)
end
function _convolved_cdf_route(d::_DiscreteConvolved, x::AbstractVector{<:Real})
    map(xi -> _convolved_lattice_cdf(d, xi), x)
end

# Recursion bases / steps for the two kernels. For a single (degenerate)
# component the kernel is just that component's CDF/PDF; for a nested
# `Convolved` it recurses through its own route, so a nested discrete
# `rest` folds exactly (lattice) rather than through quadrature.
_convolution_cdf(d::UnivariateDistribution, x::Real) = cdf_ad_safe(d, x)
_convolution_cdf(d::Convolved, x::Real) = _convolved_cdf_route(d, x)

_convolution_pdf(d::UnivariateDistribution, x::Real) = pdf(d, x)
_convolution_pdf(d::Convolved, x::Real) = _convolved_pdf_route(d, x)

# The convolution quadrature uses the shared Gauss-Legendre machinery in
# `src/integration.jl` (`gl_integrate` and the rule constants, see there
# for the node-count rationale) through the quantile-panelled
# `_panel_integrate` above. Holding the rules directly and reducing
# inline keeps the path AD-safe (the accumulator type is seeded from the
# integrand). The batched companion below shares a composite panel grid
# across the points instead.

# Scalar convolution quadrature:
#   ∫ kernel(rest, x - t) · f_C(t) dt   over t ∈ [lower, upper],
# where C is the last component and `rest` the convolution of the others.
# `kernel` is `_convolution_cdf` (CDF) or `_convolution_pdf` (PDF).
# Returns the bare integral; callers add any saturated constant and clamp.
function _convolved_quadrature(
        last_comp, rest, kernel::F, x::Real, lower, upper) where {F}
    return _panel_integrate(
        t -> kernel(rest, x - t) * pdf_ad_safe(last_comp, t),
        lower, upper, last_comp)
end

# Per-point PDF integration window, shared by the scalar and batched
# paths: the integration component's support intersected with the range
# where `x - t` lands in the support of `rest`, then clamped finite.
# Returns a degenerate `(lower, lower)` window when it is empty.
function _pdf_point_window(last_comp, rest, x::Real)
    lower = _max2(minimum(last_comp), x - maximum(rest))
    upper = _min2(maximum(last_comp), x - minimum(rest))
    upper <= lower && return (lower, lower)
    return _finite_window(last_comp, lower, upper)
end

# Per-point CDF integration window plus the saturated constant, shared by
# the scalar and batched paths: F_R(x - t) = 1 below `cut = x - max(R)`,
# so the mass of C below the cut is a constant term and the quadrature
# only covers the transition region (see `_convolved_numeric_cdf`).
function _cdf_point_window(last_comp, rest, x::Real)
    cmin = minimum(last_comp)
    cut = x - maximum(rest)
    lower = _max2(cmin, cut)
    upper = _min2(maximum(last_comp), x - minimum(rest))
    saturated = cut > cmin ? cdf_ad_safe(last_comp, cut) :
                zero(float(typeof(x)))
    upper <= lower && return lower, lower, saturated
    lower, upper = _finite_window(last_comp, lower, upper)
    return lower, upper, saturated
end

# Union of the non-empty per-point windows, as AD-stripped (primal)
# `Float64`s: the batched panel grid laid over it is a quadrature
# hyperparameter, like the window clamp, so it stays off the AD tape.
# Any NaN endpoint (a NaN evaluation point) poisons the union so the
# caller falls back to per-point scalar solves.
function _window_union(wins)
    L, U = Inf, -Inf
    for w in wins
        wl = Float64(primal(w[1]))
        wu = Float64(primal(w[2]))
        (isnan(wl) || isnan(wu)) && return (NaN, NaN)
        wu > wl || continue
        L = _min2(L, wl)
        U = _max2(U, wu)
    end
    return L, U
end

# Batched composite quadrature: the raw per-point integrals
#   ∫ kernel(rest, x_j - t) · f_C(t) dt   over t ∈ [lower_j, upper_j],
# each over its own scalar-path window `wins[j]`, in one shared pass.
#
# The union window `[L, U]` is split at the integration component's
# quantile breaks (see `_panel_breaks`) into panels whose nodes and
# `f_C(t)` factors are evaluated once and reused across every point;
# each point then sums the panels inside its own window plus small
# end-correction integrals from its live window endpoints to the panel
# grid. Every integrand kink (a support edge of `rest`) sits on a
# window endpoint, i.e. on a correction boundary, so each integrated
# piece is smooth and the small per-panel rule converges spectrally —
# this is what removes the old shared-window tail error (issue #29).
# Quantile spacing keeps node density proportional to `f_C`'s mass, so
# a heavy-tailed component cannot stretch any panel across orders of
# magnitude of density (issue #49; equal spacing drifted to ~2e-5 on
# the Gamma + LogNormal(0, 1.5) CDF). The panel grid is primal (see
# `_window_union` and `_panel_breaks`); the corrections keep the live
# endpoints, so gradient flow through the window bounds matches the
# scalar path. The per-point assembly is a functional `map` with a
# scalar accumulator seeded from the integrand, so tracer element types
# (`Dual`s, tracked reals) propagate and no tracked storage is mutated
# — `fill` of a ReverseDiff `TrackedReal` yields a `TrackedArray`,
# whose `setindex!` throws (issue #44).
function _convolved_quadrature_composite(
        last_comp, rest, kernel::F, x::AbstractVector{<:Real},
        wins, L::Float64, U::Float64) where {F}
    np = length(_PANEL_GL.nodes)
    nd, wts = _PANEL_GL.nodes, _PANEL_GL.weights
    bounds = vcat(L, _panel_breaks(last_comp, L, U), U)
    npan = length(bounds) - 1

    # Shared panel nodes and f_C-weighted quadrature weights; the
    # comprehensions seed the element types from the values so component
    # `Dual`s propagate. Panels are quantile-spaced, so each carries its
    # own half-width.
    Tc = [(bounds[p] + bounds[p + 1]) / 2 +
          (bounds[p + 1] - bounds[p]) / 2 * nd[k]
          for k in 1:np, p in 1:npan]
    Wc = [(bounds[p + 1] - bounds[p]) / 2 * wts[k] *
          pdf_ad_safe(last_comp, Tc[k, p])
          for k in 1:np, p in 1:npan]

    z = zero(kernel(rest, first(x) - Tc[1, 1]) * Wc[1, 1])
    return map(eachindex(x)) do j
        wl, wu = wins[j][1], wins[j][2]
        wu > wl || return z
        wlp = Float64(primal(wl))
        wup = Float64(primal(wu))
        ilo = searchsortedfirst(bounds, wlp)
        ihi = searchsortedlast(bounds, wup)
        xj = x[j]
        integrand = t -> kernel(rest, xj - t) * pdf_ad_safe(last_comp, t)
        if ilo > ihi
            # Window inside one panel: a single small solve.
            return z + gl_integrate(integrand, wl, wu, _PANEL_GL)
        end
        acc = z
        @inbounds for p in ilo:(ihi - 1), k in 1:np

            acc += Wc[k, p] * kernel(rest, xj - Tc[k, p])
        end
        if wlp < bounds[ilo]
            acc += gl_integrate(integrand, wl, bounds[ilo], _PANEL_GL)
        end
        if wup > bounds[ihi]
            acc += gl_integrate(integrand, bounds[ihi], wu, _PANEL_GL)
        end
        return acc
    end
end

# Numeric convolution CDF.
#
# X = C + R with C the integration component (`last_comp`) and R the
# convolution of the remaining components (`rest`):
#   F_X(x) = ∫ F_R(x - t) f_C(t) dt   over t ∈ support(C).
# F_R(x - t) is 1 for t ≤ x - max(R) and 0 for t ≥ x - min(R), so the
# integral splits into a saturated constant term plus a transition
# integral over [lower, upper]:
#   F_X(x) = F_C(x - max(R)) + ∫_{lower}^{upper} F_R(x - t) f_C(t) dt
# Dropping the F_C term loses the mass of C in the region where R is
# already certain to be below x — wrong for bounded components (Uniform).
function _convolved_numeric_cdf(d::Convolved, x::Real)
    isnan(x) && return convert(float(typeof(x)), NaN)
    x <= minimum(d) && return zero(float(typeof(x)))
    x >= maximum(d) && return one(float(typeof(x)))

    last_comp = d.components[end]
    rest = _rest_distribution(d.components[1:(end - 1)])

    # Window over the transition region of F_R plus the mass of C below
    # it (where F_R = 1); see `_cdf_point_window`. Dropping the
    # saturated term would lose that mass — wrong for bounded
    # components (Uniform).
    lower, upper, saturated = _cdf_point_window(last_comp, rest, x)

    upper <= lower && return clamp(saturated, zero(saturated), one(saturated))

    result = saturated +
             _convolved_quadrature(
        last_comp, rest, _convolution_cdf, x, lower, upper)
    return clamp(result, zero(result), one(result))
end

# Numeric convolution PDF.
#
# f_X(x) = ∫ f_R(x - t) f_C(t) dt   over t ∈ support(C).
# f_R(x - t) is 0 outside R's support, so there is no saturated constant:
# the natural window is the component support intersected with the range
# where x - t lands in R's support.
function _convolved_numeric_pdf(d::Convolved, x::Real)
    isnan(x) && return convert(float(typeof(x)), NaN)
    (x <= minimum(d) || x >= maximum(d)) && return zero(float(typeof(x)))

    last_comp = d.components[end]
    rest = _rest_distribution(d.components[1:(end - 1)])

    lower, upper = _pdf_point_window(last_comp, rest, x)

    upper <= lower && return zero(float(typeof(x)))

    result = _convolved_quadrature(
        last_comp, rest, _convolution_pdf, x, lower, upper)
    return max(result, zero(result))
end

# ---------------------------------------------------------------------------
# Exact discrete lattice convolution (#85, #89)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_DiscreteConvolved` (every component
# integer-lattice discrete; see `_components_support`/`_exact_discrete_route`
# in `src/interface.jl`), via the route dispatch above. Replaces the
# quadrature integral with an exact sum over the same window the
# quadrature path uses, so no accuracy is traded away.

# Exact discrete convolution mass:
#   f_X(x) = Σ_t f_R(x - t) f_C(t)
# over the integer lattice points t of the integration component C, on
# the SAME window the quadrature path uses (`_pdf_point_window`): C's
# support intersected with the range where x - t lands in R's support.
# With every component non-negative that window is finite and the fold
# is exact; a component unbounded BELOW has its window clamped at the
# `_CONVOLVED_TAIL` quantile, trimming at most ~1e-8 of mass, exactly as
# on the quadrature path (this does not affect `is_exact` — see its
# docstring).
function _convolved_lattice_pdf(d::Convolved, x::Real)
    isnan(x) && return convert(float(typeof(x)), NaN)
    insupport(d, x) || return zero(float(typeof(x)))

    last_comp = d.components[end]
    rest = _rest_distribution(d.components[1:(end - 1)])

    t0, t1 = _lattice_range(_pdf_point_window(last_comp, rest, x)...)
    t1 < t0 && return zero(float(typeof(x)))

    return _lattice_sum(
        t -> _convolution_pdf(rest, x - t) * pdf_ad_safe(last_comp, t),
        t0, t1)
end

# Exact discrete convolution CDF, keeping the quadrature path's
# decomposition:
#   F_X(x) = F_C(cut) + Σ_{cut < t <= upper} F_R(x - t) f_C(t),
# cut = x - max(R) (F_R is exactly 1 at or below it) and
# upper = min(max(C), x - min(R)) (F_R is exactly 0 strictly above it;
# t = upper itself contributes f_R(min R) and is kept). The cut is
# INCLUSIVE in `F_C(cut)`, so the fold starts strictly above it —
# unlike the continuous path, where that single point has measure zero.
function _convolved_lattice_cdf(d::Convolved, x::Real)
    isnan(x) && return convert(float(typeof(x)), NaN)
    x < minimum(d) && return zero(float(typeof(x)))
    x >= maximum(d) && return one(float(typeof(x)))

    last_comp = d.components[end]
    rest = _rest_distribution(d.components[1:(end - 1)])

    cmin = minimum(last_comp)
    cut = x - maximum(rest)
    upper = _min2(maximum(last_comp), x - minimum(rest))
    saturated = cut > cmin ? cdf_ad_safe(last_comp, cut) :
                zero(float(typeof(x)))
    lower, upper = _finite_window(last_comp, _max2(cmin, cut), upper)

    t0, t1 = cut > cmin ? _lattice_range_above(cut, upper) :
             _lattice_range(lower, upper)
    t1 < t0 && return clamp(saturated, zero(saturated), one(saturated))

    result = saturated + _lattice_sum(
        t -> _convolution_cdf(rest, x - t) * pdf_ad_safe(last_comp, t),
        t0, t1)
    return clamp(result, zero(result), one(result))
end

# ---------------------------------------------------------------------------
# Single-component fix: `Convolved((X,); method = NumericSolver())`
# ---------------------------------------------------------------------------
#
# `convolved(...)` always builds two or more components, but `Convolved`
# itself is public and its inner constructor permits one — reachable
# directly, bypassing `convolved`'s check. Under the default
# `AnalyticalSolver`, `_analytic_convolution` already short-circuits a
# one-tuple to its single component, so `_maybe_analytic` never falls
# through to the numeric/lattice routes for that case. Under
# `NumericSolver`, `_maybe_analytic` always returns `nothing`, and the
# general fold's `_rest_distribution(d.components[1:(end - 1)])` then
# receives an EMPTY tuple and throws from `Convolved(())`
# ("Convolved needs at least one component") — a pre-existing bug,
# reachable today (not only through a deferred `power` keyword; see
# #89), fixed here with a regression test.
_convolved_numeric_pdf(d::_SingleConvolved, x::Real) = pdf(d.components[1], x)
_convolved_numeric_cdf(d::_SingleConvolved, x::Real) = cdf(d.components[1], x)
function _convolved_numeric_pdf_batched(
        d::_SingleConvolved, x::AbstractVector{<:Real})
    return map(xi -> pdf(d.components[1], xi), x)
end
function _convolved_numeric_cdf_batched(
        d::_SingleConvolved, x::AbstractVector{<:Real})
    return map(xi -> cdf(d.components[1], xi), x)
end
_convolved_lattice_pdf(d::_SingleConvolved, x::Real) = pdf(d.components[1], x)
_convolved_lattice_cdf(d::_SingleConvolved, x::Real) = cdf(d.components[1], x)

# ---------------------------------------------------------------------------
# CDF / logcdf / pdf / logpdf
# ---------------------------------------------------------------------------

@doc "

Compute the cumulative distribution function.

Uses an analytical convolution when `Distributions.convolve` applies to
all component pairs, otherwise AD-safe numeric quadrature.

See also: [`logcdf`](@ref)
"
function cdf(d::Convolved, x::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return cdf(analytic, x)
    end
    return _convolved_cdf_route(d, x)
end

@doc "

Compute the log cumulative distribution function.

See also: [`cdf`](@ref)
"
function logcdf(d::Convolved, x::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logcdf(analytic, x)
    end
    c = _convolved_cdf_route(d, x)
    return c <= 0 ? oftype(float(c), -Inf) : log(c)
end

function ccdf(d::Convolved, x::Real)
    return 1 - cdf(d, x)
end

function logccdf(d::Convolved, x::Real)
    logcdf_val = logcdf(d, x)
    if logcdf_val == -Inf
        return zero(logcdf_val)
    elseif logcdf_val >= 0
        return oftype(logcdf_val, -Inf)
    end
    return log1mexp(logcdf_val)
end

@doc "

Compute the probability density function.

Uses the exact analytical convolved density where `Distributions.convolve`
applies to all component pairs, otherwise the AD-safe numeric density
convolution ``f_X(x) = \\int f_R(x - t) f_C(t) \\, dt``.

See also: [`logpdf`](@ref)
"
function pdf(d::Convolved, x::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return pdf(analytic, x)
    end
    return _convolved_pdf_route(d, x)
end

@doc "

Compute the log probability density function.

See also: [`pdf`](@ref), [`logcdf`](@ref)
"
function logpdf(d::Convolved, x::Real)
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return logpdf(analytic, x)
    end
    if !insupport(d, x)
        return oftype(float(x), -Inf)
    end
    p = _convolved_pdf_route(d, x)
    return p <= 0 ? oftype(float(x), -Inf) : log(p)
end

# ---------------------------------------------------------------------------
# Batched cdf / logpdf: a single quadrature solve for a vector of points
# ---------------------------------------------------------------------------

@doc "

Compute the CDF for a vector of evaluation points in one batched
composite-quadrature pass.

Each point is integrated over the same window the scalar path picks,
on a shared panel grid whose nodes and integration-component density
are evaluated once and reused across points, plus small per-point
end-correction integrals. Batched and scalar results therefore agree
to well within ~1e-8 (typically near machine precision) for batches
spanning up to ~40x point ranges; extreme spans (100x and beyond)
stay within ~1e-6. See the FAQ.

See also: [`cdf`](@ref)
"
function cdf(d::Convolved, x::AbstractVector{<:Real})
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return map(xi -> cdf(analytic, xi), x)
    end
    return _convolved_cdf_route(d, x)
end

# Batched numeric CDF via the composite panel grid: each point keeps the
# scalar path's decomposition
#   F_X(x_i) = F_C(cut_i) + ∫_{lower_i}^{upper_i} F_R(x_i - t) f_C(t) dt
# with its own window and saturated constant (see `_cdf_point_window`),
# while the quadrature shares panel nodes and f_C evaluations across the
# batch (see `_convolved_quadrature_composite`).
function _convolved_numeric_cdf_batched(d::Convolved, x::AbstractVector{<:Real})
    T = promote_type(eltype(x), float(eltype(d)))
    last_comp = d.components[end]
    rest = _rest_distribution(d.components[1:(end - 1)])

    dmin = minimum(d)
    dmax = maximum(d)

    wins = map(xi -> _cdf_point_window(last_comp, rest, xi), x)
    L, U = _window_union(wins)

    if !(U > L) || !isfinite(L) || !isfinite(U)
        # Degenerate union window: fall back to per-point scalar solves.
        return map(xi -> _convolved_numeric_cdf(d, T(xi)), x)
    end

    raw = _convolved_quadrature_composite(
        last_comp, rest, _convolution_cdf, x, wins, L, U)

    # `eltype(d)` stays `Float64` when the component parameters carry AD
    # tracers (Duals, tracked reals), so promote with the quadrature
    # result type before the clamp/convert (#43).
    Tr = promote_type(T, eltype(raw))
    return map(zip(x, raw, wins)) do (xi, ri, wi)
        if xi <= dmin
            zero(Tr)
        elseif xi >= dmax
            one(Tr)
        else
            clamp(Tr(wi[3] + ri), zero(Tr), one(Tr))
        end
    end
end

# Batched numeric PDF via the composite panel grid. No saturated
# constant (f_R vanishes outside support).
function _convolved_numeric_pdf_batched(d::Convolved, x::AbstractVector{<:Real})
    T = promote_type(eltype(x), float(eltype(d)))
    last_comp = d.components[end]
    rest = _rest_distribution(d.components[1:(end - 1)])

    dmin = minimum(d)
    dmax = maximum(d)

    wins = map(xi -> _pdf_point_window(last_comp, rest, xi), x)
    L, U = _window_union(wins)

    if !(U > L) || !isfinite(L) || !isfinite(U)
        # Degenerate union window: fall back to per-point scalar solves.
        return map(xi -> _convolved_numeric_pdf(d, T(xi)), x)
    end

    raw = _convolved_quadrature_composite(
        last_comp, rest, _convolution_pdf, x, wins, L, U)

    # Promote with the quadrature result type: `eltype(d)` misses
    # AD tracers on the component parameters (#43).
    Tr = promote_type(T, eltype(raw))
    return map(zip(x, raw)) do (xi, ri)
        (xi <= dmin || xi >= dmax) ? zero(Tr) : max(Tr(ri), zero(Tr))
    end
end

@doc "

Compute densities for a vector of points in one batched
composite-quadrature pass (see the batched [`cdf`](@ref) method).

See also: [`pdf`](@ref)
"
function pdf(d::Convolved, x::AbstractVector{<:Real})
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return map(xi -> pdf(analytic, xi), x)
    end
    return _convolved_pdf_route(d, x)
end

@doc "

Compute log densities for a vector of points, reusing the batched PDF
solve for the numeric path.

Each point is integrated over the same window the scalar path picks
(shared composite panels plus per-point end corrections), so batched
and scalar log densities agree to well within ~1e-8 even for wide
batches (typically near machine precision; extreme 100x-plus point
spans stay within ~1e-6).

See also: [`logpdf`](@ref), [`pdf`](@ref)
"
function logpdf(d::Convolved, x::AbstractVector{<:Real})
    analytic = _maybe_analytic(d)
    if analytic !== nothing
        return map(xi -> logpdf(analytic, xi), x)
    end

    pdfs = _convolved_pdf_route(d, x)
    # Promote with the batched-PDF result type: `eltype(d)` misses
    # AD tracers on the component parameters (#43).
    T = promote_type(eltype(x), float(eltype(d)), eltype(pdfs))

    return map(zip(x, pdfs)) do (xi, p)
        if !insupport(d, xi)
            T(-Inf)
        else
            p <= 0 ? T(-Inf) : T(log(p))
        end
    end
end
