# ============================================================================
# convolve_series(delay, series): timeseries delay convolution
# ============================================================================
#
# `convolve_series` convolves a numeric timeseries with a delay PMF on the
# unit lag grid. With `series` the expected events at times `0..t` (e.g.
# infections), the result is the expected downstream event counts at the
# same times: the renewal-style observation layer.
#
# The delay enters as a PMF over integer lags. For a DISCRETE delay the
# lag-`k` mass is simply `pdf(delay, k)`, so the discrete method below is
# the only distribution method: it reads the distribution's own PMF
# directly, and a `Convolved`/`Difference`/`Product` of integer-lattice
# discrete components is itself a `DiscreteUnivariateDistribution` (#85),
# so it flows straight through the same method. A CONTINUOUS delay has no
# mass on the integer grid until it is discretised, and discretisation is
# a modelling choice this package does not make; a continuous delay
# simply matches no method here — `convolve_series(Gamma(2.0, 1.0),
# series)` is a `MethodError` naming what is actually missing, not a
# hand-rolled `ArgumentError` (#95). Caller-supplied masses come as a
# vector, a `DiscreteNonParametric`, or one per time point for a delay
# that changes over the window (#79).
#
# It has its own verb (rather than a `convolved` method) because it returns
# a numeric series, not a distribution.
#
# AD-safety. The convolution is linear, so gradients flow through
# ForwardDiff / ReverseDiff / Enzyme / Mooncake from masses (and a `series`)
# that are themselves differentiable in some upstream parameter.

# --- the convolution kernels: series ⊛ pmf ---------------------------------

# One PMF for the whole window: `out[i] = Σ_{k≥0} pmf[k + 1] * series[i - k]`,
# so mass at lag `k` carries `series[i - k]` forward to time `i`. The
# accumulator type is seeded from the product so `Dual` / tracked numbers
# propagate.
function _convolve_series_fixed(series::AbstractVector, pmf::AbstractVector)
    # The @inbounds loop below indexes both vectors from 1; offset axes
    # would silently shift every mass and read past the end.
    Base.require_one_based_indexing(series, pmf)
    n = length(series)
    T = promote_type(eltype(series), eltype(pmf))
    out = zeros(T, n)
    @inbounds for i in 1:n
        acc = zero(T)
        kmax = min(length(pmf), i)
        for k in 1:kmax
            acc += pmf[k] * series[i - k + 1]
        end
        out[i] = acc
    end
    return out
end

# A masked-output sibling of `_convolve_series_fixed`, kept as a separate
# function (rather than a branch inside the loop above) so the unmasked
# path stays exactly as it was. `mask[i] == false` positions are never
# entered: no `acc`, no PMF read, no accumulate, only `zero(T)` from the
# `zeros` fill. The outer loop is bounded to the requested window
# (`findfirst`/`findlast` on `mask`) so a small window deep inside a long
# series does not even iterate over the untouched positions either side.
function _convolve_series_fixed(
        series::AbstractVector, pmf::AbstractVector, mask::AbstractVector{Bool})
    Base.require_one_based_indexing(series, pmf, mask)
    n = length(series)
    T = promote_type(eltype(series), eltype(pmf))
    out = zeros(T, n)
    first_i = findfirst(mask)
    first_i === nothing && return out
    last_i = findlast(mask)
    @inbounds for i in first_i:last_i
        mask[i] || continue
        acc = zero(T)
        kmax = min(length(pmf), i)
        for k in 1:kmax
            acc += pmf[k] * series[i - k + 1]
        end
        out[i] = acc
    end
    return out
end

# --- the output-position mask ------------------------------------------

# A `Bool` vector the same length as the output: `true` marks a position
# to compute, `false` leaves it at `zero(eltype(result))`. Bool entries
# are never AD tracers (only `series` and the PMF carry Dual / tracked
# numbers), so branching on `mask` needs no `primal` stripping — the
# branch is already off the differentiated path.
function _check_mask(mask::AbstractVector{Bool}, n::Int)
    Base.require_one_based_indexing(mask)
    length(mask) == n || throw(ArgumentError(
        "convolve_series mask must be the same length as the output " *
        "series; got $(length(mask)) for a series of length $(n)"))
    return nothing
end

# How many lags are worth building for a single-PMF window: no lag past a
# mask's last requested position can ever be read (`_convolve_series_fixed`
# only ever reads `pmf[1:i]` for output position `i`), so the masses built
# above that are pure waste. `nothing` keeps every position, so the answer
# is the series length, unchanged. An all-`false` mask still asks for one
# lag on a non-empty series — not because it is read, but so a genuinely
# empty result still passes through as a real (if unused) PMF rather than
# tripping the "at least one PMF mass" guard on its way to the early
# return that actually produces the all-zero output.
_mass_reach(::Nothing, n::Int) = n
function _mass_reach(mask::AbstractVector{Bool}, n::Int)
    last_i = findlast(mask)
    return last_i === nothing ? min(n, 1) : last_i
end

# --- public API: the timeseries convolution verb ---------------------------

@doc "

Convolve a timeseries with the PMF of a discrete delay distribution.

`convolve_series(delay, series)` for a `DiscreteUnivariateDistribution`
`delay` reads the delay PMF directly off the integer lag grid — the
lag-`k` mass IS `pdf(delay, k)` — and returns the causal discrete
convolution of `series` with that PMF, truncated to the `series` window.
With `series` the expected events at times `0, 1, ..., t` (e.g.
infections), the result is the expected downstream event counts at the
same times (the EpiNow2-style latent / renewal observation layer).

The masses are `[pdf(delay, k) for k in 0:(length(series) - 1)]`, used as
given: no renormalisation, so any delay mass beyond the series window is
truncated. `pdf(delay, k)` is differentiable in the delay parameters for
the standard discrete families, so gradients flow under the supported AD
backends.

Direct PMF evaluation, NOT a CDF difference: for an integer-support
delay, ``F(k + 1) - F(k) = P(k < X \\le k + 1) = pdf(delay, k + 1)``, an
off-by-one, so the discrete method reads `pdf(delay, k)` rather than a
CDF-difference mass.

Only the integer lags `0, 1, 2, ...` are read. A delay with atoms off the
integer grid is out of scope (a lag grid means masses at the integers),
and mass at negative lags cannot enter a causal convolution, so lags
below `0` are not read (consistent with the causal kernel).

A [`Convolved`](@ref)/[`Difference`](@ref)/[`Product`](@ref) of
integer-lattice discrete components is itself a
`DiscreteUnivariateDistribution` (#85) and flows straight through this
method, reading its exact masses. A CONTINUOUS delay has no mass on the
integer grid until it is discretised, and discretisation is an explicit
modelling choice this package does not make; it matches no method here,
so `convolve_series(a_continuous_delay, series)` is a `MethodError`
naming what is actually missing, rather than a pre-emptive gate (#95) —
see [`convolve_series(pmf, series)`](@ref convolve_series) below for the
caller-owned discretisation path.

Unlike [`convolved`](@ref), which combines distributions into a single
[`Convolved`](@ref) distribution, this returns a numeric series; the
separate verb keeps `convolved` strictly for distribution construction.

# Arguments
- `delay`: a `DiscreteUnivariateDistribution` (e.g. `Poisson`,
  `DiscreteUniform`, a shifted count delay).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `mask`: optional. A `Bool` vector the same length as `series`; when
  given, only the output positions where `mask` is `true` are computed
  and the rest hold `zero(eltype(result))`. Masked-out positions are
  genuinely skipped, not computed and discarded, so a mask selecting a
  few positions out of a long series is cheap — `pdf(delay, k)` is only
  evaluated for the lags a requested position can actually read, so a
  mask restricted to an early window also skips evaluating the delay's
  `pdf` at the later lags. Omitted (the default), every position is
  computed.

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = Poisson(2.0)
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(delay, infections)
```

# See also
- [`convolved`](@ref): the distribution-level convolution
- [`convolve_series(pmf, series)`](@ref convolve_series): the PMF-vector
  form for caller-owned discretisation
"
function convolve_series(
        delay::DiscreteUnivariateDistribution,
        series::AbstractVector{<:Real};
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    # The lag-`k` mass of a discrete delay is `pdf(delay, k)` directly; do
    # NOT reuse the CDF-difference `_delay_pmf`, which would compute
    # `F(k + 1) - F(k) = pdf(delay, k + 1)` for integer support — an
    # off-by-one. Lags run 0..(reach - 1); negative-support mass is never
    # read (it cannot enter a causal convolution). `reach` is the series
    # length with no mask, or the mask's last requested position with one
    # — a `pdf` evaluated per lag is real work for some delay families, so
    # a mask restricted to an early window must not pay for the lags past
    # it.
    mask === nothing || _check_mask(mask, length(series))
    reach = _mass_reach(mask, length(series))
    masses = [pdf(delay, k) for k in 0:(reach - 1)]
    return convolve_series(masses, series; mask)
end

@doc "

Convolve a timeseries with a caller-supplied discretised delay PMF.

`convolve_series(pmf, series)` returns the causal discrete convolution
of `series` with the probability masses `pmf`, truncated to the `series`
window:
`out[i] = sum(pmf[k + 1] * series[i - k] for k in 0:(min(length(pmf), i) - 1))`.
`pmf[k + 1]` is read as the delay mass at integer lag `k` on the same
unit grid as `series`.

The masses are used exactly as given: no renormalisation, no validation
that they sum to one, and no tail correction — mass at lags beyond the
series window (including any `pmf` entries past `length(series)`) is
simply never used, so sub-normalised or window-truncated PMFs stay
truncated. This is the decoupled form of
[`convolve_series(delay, series)`](@ref convolve_series): the caller
owns the discretisation (e.g. double-interval-censored masses from
CensoredDistributions.jl), and this method only convolves. The
convolution is linear, so gradients flow through both `pmf` and
`series` under the supported AD backends.

# Arguments
- `pmf`: the discretised delay probability masses at integer lags
  `0, 1, 2, ...` (used as given).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `mask`: optional output-position mask, as in
  [`convolve_series(delay, series)`](@ref convolve_series).

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions

pmf = [0.5, 0.3, 0.2]
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(pmf, infections)
```

# See also
- [`convolve_series(pmf::DiscreteNonParametric, series)`](@ref
  convolve_series): the non-unit-grid form
"
function convolve_series(
        pmf::AbstractVector{<:Real}, series::AbstractVector{<:Real};
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    isempty(pmf) &&
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    mask === nothing && return _convolve_series_fixed(series, pmf)
    _check_mask(mask, length(series))
    return _convolve_series_fixed(series, pmf, mask)
end

# --- the non-unit-grid form: DiscreteNonParametric --------------------------
#
# A plain vector only ever reads as the unit grid `0, 1, 2, ...`. A delay
# discretised on a coarser grid (e.g. weekly bins) needs its own step
# recorded somewhere; `DiscreteNonParametric` already carries exactly that
# (support = the grid, probs = the masses), and ModifiedDistributions
# already uses it as the org's discrete-delay type, so it is read here
# rather than adding a bespoke wrapper (#79).

# `DiscreteNonParametric`'s support is sorted and unique by construction,
# so consecutive gaps are always positive; only the constant-spacing check
# is needed. `grid[1] == 0` is required because `convolve_series` has no
# separate "starting lag" argument: the first probability mass is always
# read as the lag-0 mass.
function _check_regular_delay_grid(grid::AbstractVector{<:Real})
    first(grid) == 0 ||
        throw(ArgumentError(
            "convolve_series needs a DiscreteNonParametric delay support " *
            "starting at lag 0 (the first support point is read as the " *
            "lag-0 mass); got first support point $(first(grid))"))
    length(grid) == 1 && return nothing
    steps = diff(grid)
    all(isapprox.(steps, steps[1])) ||
        throw(ArgumentError(
            "convolve_series needs a regularly spaced DiscreteNonParametric " *
            "delay support (a constant lag width); got steps $(steps)"))
    return nothing
end

@doc "

Convolve a timeseries with a delay's `DiscreteNonParametric` PMF.

`convolve_series(pmf, series)` for a `DiscreteNonParametric` `pmf` reads
its support as the delay's lag grid and its probabilities as the masses
at those lags, then convolves as
[`convolve_series(probs(pmf), series)`](@ref convolve_series). The
support must start at `0` and be regularly spaced (a constant gap
between consecutive support points); an irregular or offset grid throws
an `ArgumentError`, since `convolve_series` has no separate argument to
carry a grid width or starting lag.

This is the non-unit-grid caller-supplied form: a `DiscreteNonParametric`
built on a coarser grid (e.g. `DiscreteNonParametric(0:7:28, weekly_masses)`
for weekly bins) convolves correctly, whereas a plain
`AbstractVector` PMF only ever reads as the unit grid.

Unlike the [`AbstractVector` form](@ref convolve_series), which uses
masses exactly as given (no renormalisation, so a window-truncated tail
stays sub-normalised), `DiscreteNonParametric` enforces a genuine
probability vector at construction (`sum(probs(pmf)) ≈ 1`, or
`Distributions.jl` throws a `DomainError`). A window-truncated or
otherwise sub-normalised PMF therefore needs the plain vector form
instead.

# Arguments
- `pmf`: a `DiscreteNonParametric` whose support is the delay's lag grid
  (regularly spaced, starting at `0`) and whose probabilities are the
  masses at those lags.
- `series`: the input timeseries, sampled at the same grid steps as
  `pmf`'s support, from time 0.
- `mask`: optional output-position mask, as in
  [`convolve_series(delay, series)`](@ref convolve_series).

# Examples
```@example
using ConvolvedDistributions, Distributions

pmf = DiscreteNonParametric([0.0, 7.0, 14.0], [0.6, 0.3, 0.1])
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series(pmf, infections)
```

# See also
- [`convolve_series(pmf::AbstractVector, series)`](@ref convolve_series):
  the unit-grid vector form
"
function convolve_series(
        pmf::DiscreteNonParametric, series::AbstractVector{<:Real};
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    grid = support(pmf)
    _check_regular_delay_grid(grid)
    return convolve_series(probs(pmf), series; mask)
end

# --- time-varying delays: one delay per time point --------------------------
#
#   :primary (default)  out[i] = Σ_s series[s] * pmf_s[i - s + 1]
#   :secondary          out[i] = Σ_k pmf_i[k + 1] * series[i - k]

# The mass at time `j`, lag `k - 1`, however the caller supplied it.
_kernel_count(ks::AbstractMatrix) = size(ks, 2)
_kernel_count(ks::AbstractVector) = length(ks)

_kernel_length(ks::AbstractMatrix, j::Int) = size(ks, 1)
_kernel_length(ks::AbstractVector{<:AbstractVector}, j::Int) = length(ks[j])

_kernel_mass(ks::AbstractMatrix, j::Int, k::Int) = ks[k, j]
_kernel_mass(ks::AbstractVector{<:AbstractVector}, j::Int, k::Int) = ks[j][k]

# Seeds the accumulator type so `Dual` / tracked masses propagate.
_kernel_eltype(ks::AbstractMatrix) = eltype(ks)
_kernel_eltype(ks::AbstractVector{<:AbstractVector}) = mapreduce(
    eltype, promote_type, ks)

# One kernel per time point, truncated to the series window. The convention
# dispatches through `Val`, so each is a loop and another one is a method
# away. `mask` (when given) is validated once here and threaded to the
# masked `_accumulate_varying!` method; `nothing` reaches the unmasked
# method, which computes every position.
function _convolve_series_varying(
        series::AbstractVector, kernels, indexed_by::Symbol,
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    n = length(series)
    mask === nothing || _check_mask(mask, n)
    n == 0 && return zeros(float(eltype(series)), 0)
    T = promote_type(eltype(series), _kernel_eltype(kernels))
    mask === nothing && return _accumulate_varying!(
        zeros(T, n), series, kernels, Val(indexed_by))
    return _accumulate_varying!(
        zeros(T, n), series, kernels, Val(indexed_by), mask)
end

# Gather: time `i` reads its own kernel back over the series.
function _accumulate_varying!(out, series, kernels, ::Val{:secondary})
    @inbounds for i in eachindex(out)
        acc = zero(eltype(out))
        for k in 1:min(_kernel_length(kernels, i), i)
            acc += _kernel_mass(kernels, i, k) * series[i - k + 1]
        end
        out[i] = acc
    end
    return out
end

# Masked gather: a separate method (not a branch inside the loop above) so
# the unmasked path is untouched. Bounded to the requested window and
# skips every position `mask` excludes before touching a kernel or series
# entry.
function _accumulate_varying!(
        out, series, kernels, ::Val{:secondary}, mask::AbstractVector{Bool})
    first_i = findfirst(mask)
    first_i === nothing && return out
    last_i = findlast(mask)
    @inbounds for i in first_i:last_i
        mask[i] || continue
        acc = zero(eltype(out))
        for k in 1:min(_kernel_length(kernels, i), i)
            acc += _kernel_mass(kernels, i, k) * series[i - k + 1]
        end
        out[i] = acc
    end
    return out
end

# Scatter: the cohort at time `s` spreads forward through its own kernel.
function _accumulate_varying!(out, series, kernels, ::Val{:primary})
    n = length(out)
    @inbounds for s in 1:n
        for k in 1:min(_kernel_length(kernels, s), n - s + 1)
            out[s + k - 1] += _kernel_mass(kernels, s, k) * series[s]
        end
    end
    return out
end

# Masked scatter: each source `s` only reaches targets `s:(s + kmax - 1)`,
# so a source whose whole reach falls short of the first requested
# position contributes nothing and is skipped before its kernel is read
# at all (`s + kmax - 1 >= first_i`). The outer loop stops at `last_i`
# (no source before it can land past it), and the inner loop breaks the
# moment a target overshoots `last_i` (targets rise monotonically with
# `k`). What survives both bounds is still checked against `mask`
# directly, so a hole inside the requested window is skipped too.
function _accumulate_varying!(
        out, series, kernels, ::Val{:primary}, mask::AbstractVector{Bool})
    n = length(out)
    first_i = findfirst(mask)
    first_i === nothing && return out
    last_i = findlast(mask)
    @inbounds for s in 1:min(n, last_i)
        kmax = min(_kernel_length(kernels, s), n - s + 1)
        s + kmax - 1 >= first_i || continue
        for k in 1:kmax
            target = s + k - 1
            target > last_i && break
            mask[target] || continue
            out[target] += _kernel_mass(kernels, s, k) * series[s]
        end
    end
    return out
end

# Lags time point `j` of `n` can reach: the cohort at `j` lands at `j:n`,
# and time `j` reads back to time 1. `nothing` (no mask) keeps this
# unchanged from before the mask existed: every position is built at full
# reach.
_kernel_lags(n::Int, ::Val{:primary}, ::Nothing) = n:-1:1
_kernel_lags(n::Int, ::Val{:secondary}, ::Nothing) = 1:n

# Masked scatter: source `j` only ever lands on `j:(j + kernel_length - 1)`
# (see the masked `_accumulate_varying!` above), and that loop never reads
# past `last_i`, so `j` needs no more than `last_i - j + 1` lags — matching
# `_accumulate_varying!`'s own `kmax` bound exactly — and a source entirely
# past `last_i` needs none of its kernel at all. `1`, not `0`, for that
# unused case: the entry is genuinely never read either way, but
# `delay_masses` and the downstream "at least one PMF mass" guard both
# expect a real PMF, not an empty one.
function _kernel_lags(n::Int, ::Val{:primary}, mask::AbstractVector{Bool})
    last_i = findlast(mask)
    last_i === nothing && return fill(1, n)
    return [j <= last_i ? (last_i - j + 1) : 1 for j in 1:n]
end

# Masked gather: time `j`'s kernel is read only when `mask[j]` asks for it
# (see the masked `_accumulate_varying!` above); every other time point's
# kernel is never read, so it costs one placeholder lag rather than `j`.
function _kernel_lags(n::Int, ::Val{:secondary}, mask::AbstractVector{Bool})
    return [mask[j] ? j : 1 for j in 1:n]
end

function _check_kernel_count(kernels, series::AbstractVector)
    count = _kernel_count(kernels)
    count == length(series) || throw(ArgumentError(
        "convolve_series needs one delay PMF per time point; got $(count) " *
        "for a series of length $(length(series))"))
    return nothing
end

@doc "

A delay's probability masses at lags `0:(n - 1)`.

The extension point for the time-varying
[`convolve_series(delays, series)`](@ref convolve_series): it reads each
delay's masses through this function. The default convolves a unit impulse
at time 0 through the delay's own single-delay
[`convolve_series(delay, series)`](@ref convolve_series) method, which
returns exactly that delay's kernel, so a delay type needs no method here
at all. Discrete delays take the `pdf` read that method makes anyway, at
O(n) rather than O(n²).

Add a method when a delay's masses are NOT what its single-delay method
would give — a discrete-support type whose lag masses are not
`pdf(delay, k)`, say.

Keyword arguments (e.g. a continuous delay's discretisation `interval`)
are forwarded to the single-delay `convolve_series` call whenever any are
given, so this default agrees with the scalar
[`convolve_series(delay, series)`](@ref convolve_series) path under the
same keywords.
A call with no keywords dispatches exactly as a plain two-argument call
would, so a delay type whose own `delay_masses` or `convolve_series`
method takes no keywords at all keeps working unchanged as long as no
keywords are asked of it. Asking such a delay for keywords it cannot
honour raises an `ArgumentError` naming `delay_masses`, not a bare
keyword-sorter `MethodError`.

# Arguments
- `delay`: the delay.
- `n`: how many lags to return, from lag 0.
- `kwargs...`: discretisation keywords, forwarded to the delay's
  single-delay `convolve_series` method.

# Returns
- A vector of `n` probability masses.

# Examples
```@example
using ConvolvedDistributions, Distributions

ConvolvedDistributions.delay_masses(Poisson(2.0), 4)
```
"
delay_masses(d::DiscreteUnivariateDistribution, n::Int) = pdf.(d, 0:(n - 1))

# The kwargs-carrying default. Routing through the delay's own single-delay
# `convolve_series` method is what makes this agree with the scalar path
# under the same keywords: whatever `convolve_series(delay, series;
# kwargs...)` does for one delay is exactly what each time point gets here.
#
# Keywords are forwarded only when given. An EMPTY splat (`; kwargs...`
# with `kwargs` empty) dispatches identically to a plain call — Julia
# resolves a keyword-free call by positional specificity alone, so a
# two-argument-only downstream `delay_masses` specialisation (no keyword
# support at all, e.g. CensoredDistributions.jl's interval-censored
# continuous delays) is still selected and still runs unmodified when
# nothing asks it for keywords.
#
# When keywords ARE given, `_accepts_kwargs` probes whether the delay's
# `convolve_series` method declares the requested keywords by name or
# through a catch-all, before calling it. A method that takes some other
# keyword would otherwise pass a mere can-it-take-keywords test and fail
# later in the keyword sorter; the probe turns that into an actionable
# error naming `delay_masses` instead. This is
# also why a two-argument-only downstream `delay_masses` override does
# not shadow this default when keywords are given: Julia's keyword
# dispatch only considers methods that accept keywords at all, so the
# override (no keywords) is skipped in favour of this one, and the
# keywords still reach the delay's `convolve_series` method if it can
# take them, restoring agreement with the scalar path even though the
# override itself was never touched.
function delay_masses(d, n::Int; kwargs...)
    impulse = [i == 1 ? 1.0 : 0.0 for i in 1:n]
    isempty(kwargs) && return convolve_series(d, impulse)
    _accepts_kwargs(d, impulse, keys(kwargs)) ||
        throw(_delay_masses_kwargs_error(d, kwargs))
    return convolve_series(d, impulse; kwargs...)
end

# Whether the `convolve_series` method for these positional arguments
# declares every requested keyword, by name or through a catch-all.
# `@noinline` and shielded from AD in the extension modules: the answer
# depends only on the argument TYPES, never on parameter values, and the
# method-table lookup underneath is a reflection primitive no AD backend
# can trace (the same class of call that had to be shielded for
# construction-time closed-form resolution).
@noinline function _accepts_kwargs(d, impulse, requested)
    types = Tuple{typeof(d), typeof(impulse)}
    return all(requested) do name
        hasmethod(convolve_series, types, (name,))
    end
end

# Message factored out to keep the dispatch-check line above short; named
# after `delay_masses` (not `convolve_series`) because that is the call
# the caller made and the extension point they need to fix.
function _delay_masses_kwargs_error(d, kwargs)
    names = join(keys(kwargs), ", ")
    return ArgumentError(
        "convolve_series was given discretisation keyword argument(s) " *
        "$names for a delay of type $(typeof(d)), but its " *
        "convolve_series method does not accept them. Define " *
        "delay_masses(::$(nameof(typeof(d))), ::Int; kwargs...) (or a " *
        "convolve_series(::$(nameof(typeof(d))), series; kwargs...) " *
        "method) that accepts `; kwargs...` so this delay type can " *
        "take discretisation keywords.")
end

@doc "

Convolve a timeseries with a time-varying delay: one delay per time point.

`convolve_series(delays, series)` takes one delay per entry of `series` and
returns the convolution, truncated to the `series` window. Each
delay's lag masses come from its own single-delay
[`convolve_series(delay, series)`](@ref convolve_series) method, so the
elements may be of any, and of mixed, types. A type whose masses are not
what that method gives specialises
[`delay_masses`](@ref ConvolvedDistributions.delay_masses) instead.

Identical delays share one set of masses, however often they recur, so a
delay is only ever built once. With a `mask`, a delay is also built no
larger than the requested output positions can actually read — a delay
at a time point a mask excludes entirely is never built beyond a single
placeholder lag.

`indexed_by` names which time the delay belongs to:

- `:primary` (the default): the delay belongs to the events, so the cohort
  at time `s` spreads forward through `delays[s]` —
  `out[i] = Σ_s series[s] * pmf_s[i - s + 1]`. Conserves mass up to the
  truncated tail.
- `:secondary`: the delay belongs to the observation time, so everything
  landing at time `i` is read through `delays[i]` —
  `out[i] = Σ_k pmf_i[k + 1] * series[i - k]`. Not mass-conserving.

Any other keyword is forwarded to each distinct delay's
[`delay_masses`](@ref ConvolvedDistributions.delay_masses) call, so a
vector of continuous delays needing a non-default discretisation (e.g.
`interval`) agrees with the same keywords passed to the single-delay
[`convolve_series(delay, series)`](@ref convolve_series) form.

# Arguments
- `delays`: one delay per time point, in `series` order.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `indexed_by`: `:primary` (default) or `:secondary`.
- `mask`: optional output-position mask, as in
  [`convolve_series(delay, series)`](@ref convolve_series).
- `kwargs...`: discretisation keywords, forwarded to
  [`delay_masses`](@ref ConvolvedDistributions.delay_masses) for each
  distinct delay.

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions, Distributions

infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
delays = [Poisson(λ) for λ in range(3.0, 1.0; length = length(infections))]
expected_counts = convolve_series(delays, infections)
```

# See also
- [`convolve_series(delay, series)`](@ref convolve_series): the static
  single-delay form
- [`convolve_series(pmfs::AbstractMatrix, series)`](@ref convolve_series):
  the caller-supplied-PMF form
- [`delay_masses`](@ref ConvolvedDistributions.delay_masses): how one
  delay's masses are read, and where to specialise it
"
function convolve_series(
        delays::AbstractVector, series::AbstractVector{<:Real};
        indexed_by::Symbol = :primary,
        mask::Union{Nothing, AbstractVector{Bool}} = nothing, kwargs...)
    Base.require_one_based_indexing(delays, series)
    _check_kernel_count(delays, series)
    n = length(series)
    mask === nothing || _check_mask(mask, n)
    lags = _kernel_lags(n, Val(indexed_by), mask)
    return convolve_series(
        _distinct_masses(delays, lags; kwargs...), series; indexed_by, mask)
end

# Masses per time point, built once per DISTINCT delay however often it
# recurs: a delay that holds for a stretch, or comes back later, costs one
# `delay_masses` call. Each distinct delay is built at the longest length any
# of its time points needs; the convolution clamps the rest. Delays are
# matched with `===`, which is bitwise for immutables — so separately
# constructed but identical delays do match, while two duals that agree in
# value and differ in tangent do not, and never share masses. Discretisation
# keywords are forwarded to every `delay_masses` call unchanged.
function _distinct_masses(delays, lags; kwargs...)
    index, firsts, needed = zeros(Int, length(lags)), Int[], Int[]
    @inbounds for j in eachindex(lags)
        slot = findfirst(f -> delays[j] === delays[f], firsts)
        if slot === nothing
            push!(firsts, j)
            push!(needed, lags[j])
            slot = length(firsts)
        else
            needed[slot] = max(needed[slot], lags[j])
        end
        index[j] = slot
    end
    masses = [delay_masses(delays[firsts[s]], needed[s]; kwargs...)
              for s in eachindex(firsts)]
    return masses[index]
end

@doc "

Convolve a timeseries with a delay that changes less often than the series.

`convolve_series(runs, series)` takes `delay => length` pairs, each holding
for that many consecutive time points, and expands them before convolving
— so the delays (or mass vectors) are given once per regime rather than
once per time point. The lengths must sum to `length(series)`.

`indexed_by` is as in the
[one-delay-per-time-point form](@ref convolve_series).

# Arguments
- `runs`: `delay => length` pairs, in `series` order. Each `delay` is
  anything the one-per-time-point form accepts, including a mass vector.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `indexed_by`: `:primary` (default) or `:secondary`.
- `mask`: optional output-position mask, as in
  [`convolve_series(delay, series)`](@ref convolve_series).

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions, Distributions

infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_series([Poisson(3.0) => 3, Poisson(1.0) => 4],
    infections)
```

# See also
- [`convolve_series(delays::AbstractVector, series)`](@ref convolve_series):
  one delay per time point
"
function convolve_series(
        runs::AbstractVector{<:Pair}, series::AbstractVector{<:Real};
        indexed_by::Symbol = :primary,
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    return convolve_series(
        _expand_runs(runs, length(series)), series; indexed_by, mask)
end

# `fill` repeats the SAME object, so an expanded run is one run to
# `_run_masses` and its masses are still built once.
function _expand_runs(runs, n)
    all(r -> last(r) > 0, runs) ||
        throw(ArgumentError("convolve_series run lengths must be positive"))
    total = sum(last, runs)
    total == n || throw(ArgumentError(
        "convolve_series run lengths must sum to the series length; got " *
        "$(total) for a series of length $(n)"))
    return reduce(vcat, [fill(first(r), last(r)) for r in runs])
end

@doc "

Convolve a timeseries with time-varying caller-supplied delay PMFs held in
a matrix.

`convolve_series(pmfs, series)` reads an `AbstractMatrix` as one delay PMF
per time point, **lags down columns**: `pmfs[k + 1, j]` is the mass at lag
`k` for time point `j`, so `size(pmfs, 2)` must equal `length(series)`.
The lag count `size(pmfs, 1)` is free. A time-by-lag matrix `M` is passed
as `transpose(M)`.

`indexed_by` is as in the [vector-of-delays form](@ref convolve_series).
Masses are used exactly as given: no renormalisation, no sum-to-one check
and no tail correction.

# Arguments
- `pmfs`: delay masses, lags down columns, one column per time point.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `indexed_by`: `:primary` (default) or `:secondary`.
- `mask`: optional output-position mask, as in
  [`convolve_series(delay, series)`](@ref convolve_series).

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions

infections = [0.0, 1.0, 3.0, 6.0]
pmfs = [0.5 0.5 0.6 0.7
        0.3 0.3 0.3 0.2
        0.2 0.2 0.1 0.1]
expected_counts = convolve_series(pmfs, infections)
```

# See also
- [`convolve_series(pmf::AbstractVector, series)`](@ref convolve_series):
  the static unit-grid vector form
- [`convolve_series(delays::AbstractVector, series)`](@ref
  convolve_series): the vector-of-distributions form
"
function convolve_series(
        pmfs::AbstractMatrix{<:Real}, series::AbstractVector{<:Real};
        indexed_by::Symbol = :primary,
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    Base.require_one_based_indexing(pmfs, series)
    size(pmfs, 1) >= 1 ||
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    _check_kernel_count(pmfs, series)
    return _convolve_series_varying(series, pmfs, indexed_by, mask)
end

@doc "

Convolve a timeseries with time-varying caller-supplied delay PMFs held in
a vector of vectors.

The ragged counterpart of the [matrix form](@ref convolve_series):
`pmfs[j]` is the delay PMF for time point `j` on the unit lag grid, so
`length(pmfs)` must equal `length(series)` while each PMF may carry its own
number of lags. `indexed_by` and the masses-as-given contract are as in the
matrix form.

# Arguments
- `pmfs`: one vector of delay masses per time point, each from lag 0.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `indexed_by`: `:primary` (default) or `:secondary`.
- `mask`: optional output-position mask, as in
  [`convolve_series(delay, series)`](@ref convolve_series).

# Returns
- A numeric vector of expected downstream counts, the same length as
  `series`.

# Examples
```@example
using ConvolvedDistributions

infections = [0.0, 1.0, 3.0, 6.0]
pmfs = [[0.5, 0.3, 0.2], [0.5, 0.5], [1.0], [0.4, 0.4, 0.1, 0.1]]
expected_counts = convolve_series(pmfs, infections)
```

# See also
- [`convolve_series(pmfs::AbstractMatrix, series)`](@ref convolve_series):
  the rectangular matrix form
"
function convolve_series(
        pmfs::AbstractVector{<:AbstractVector{<:Real}},
        series::AbstractVector{<:Real};
        indexed_by::Symbol = :primary,
        mask::Union{Nothing, AbstractVector{Bool}} = nothing)
    Base.require_one_based_indexing(pmfs, series)
    _check_kernel_count(pmfs, series)
    all(!isempty, pmfs) ||
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    foreach(Base.require_one_based_indexing, pmfs)
    return _convolve_series_varying(series, pmfs, indexed_by, mask)
end
