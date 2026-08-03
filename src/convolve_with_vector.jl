# ============================================================================
# convolve_series(delay, series): timeseries delay convolution
# ============================================================================
#
# `convolve_series` convolves a numeric timeseries with a delay PMF on the
# unit lag grid. With `series` the expected events at times `0..t` (e.g.
# infections), the result is the expected downstream event counts at the
# same times: the EpiNow2-style latent / renewal observation layer.
#
# The delay enters as a PMF over integer lags. For a DISCRETE delay the
# lag-`k` mass is simply `pdf(delay, k)`, so the discrete method reads the
# distribution's own PMF directly. A CONTINUOUS delay has no mass on the
# integer grid until it is discretised, and discretisation is a modelling
# choice this package does not make (single- vs double-interval censoring),
# so it simply has no method (#95): the caller discretises first (with
# CensoredDistributions.jl, which owns primary/interval censoring) and
# feeds the resulting PMF to the PMF-vector method, either as a plain
# vector on the unit grid or as a `DiscreteNonParametric` on any regularly
# spaced grid (#79).
#
# A delay that changes over the window is carried by the time-varying forms
# at the end of this file: one delay per time point, with `indexed_by` naming
# which time the delay belongs to (#126).
#
# It has its own verb (rather than a `convolved` method) because it returns
# a numeric series, not a distribution: `convolved` is kept strictly for
# the participle idiom of lazy distribution construction, like `truncated`
# and `censored`.
#
# AD-safety. The vector convolution is linear, so gradients flow through
# ForwardDiff / ReverseDiff / Enzyme / Mooncake from a `pmf` (and `series`)
# that is itself differentiable in some upstream parameter.

# --- the causal discrete convolution series ⊛ pmf --------------------------

# Causal discrete convolution of a series with a delay PMF, truncated to the
# series window. `out[i] = Σ_{k≥0} pmf[k + 1] * series[i - k]`, i.e. mass from
# lag `k` carries `series[i - k]` forward to time `i`. The accumulator element
# type is seeded from the product so `Dual`/tracked numbers propagate.
function _causal_convolve(series::AbstractVector, pmf::AbstractVector)
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

A CONTINUOUS delay has no method: it carries no mass on the integer grid
until it is discretised, and discretisation is a censoring choice this
package does not make. Discretise first (e.g. with
CensoredDistributions.jl) and pass the masses to
[`convolve_series(pmf, series)`](@ref convolve_series).

Unlike [`convolved`](@ref), which combines distributions into a single
[`Convolved`](@ref) distribution, this returns a numeric series; the
separate verb keeps `convolved` strictly for distribution construction.

# Arguments
- `delay`: a `DiscreteUnivariateDistribution` (e.g. `Poisson`,
  `DiscreteUniform`, a shifted count delay).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

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
        series::AbstractVector{<:Real})
    # The lag-`k` mass of a discrete delay is `pdf(delay, k)` directly; do
    # NOT reuse the CDF-difference `_delay_pmf`, which would compute
    # `F(k + 1) - F(k) = pdf(delay, k + 1)` for integer support — an
    # off-by-one. Lags run 0..(n - 1); negative-support mass is never read
    # (it cannot enter a causal convolution).
    masses = [pdf(delay, k) for k in 0:(length(series) - 1)]
    return convolve_series(masses, series)
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
        pmf::AbstractVector{<:Real}, series::AbstractVector{<:Real})
    isempty(pmf) &&
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    return _causal_convolve(series, pmf)
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
        pmf::DiscreteNonParametric, series::AbstractVector{<:Real})
    grid = support(pmf)
    _check_regular_delay_grid(grid)
    return convolve_series(probs(pmf), series)
end

# --- time-varying delays: one delay per time point (#126) -------------------
#
# One delay per time point — a vector of delays, a matrix of masses (lags
# down columns), or a ragged vector of mass vectors — all of length
# `length(series)`. `indexed_by` names which time the delay belongs to, and
# both readings collapse to the static form when every PMF is the same:
#
#   :primary (default)  out[i] = Σ_s series[s] * pmf_s[i - s + 1]
#     The delay belongs to the events: the cohort at time `s` spreads
#     forward through its own PMF. Generative, and conserves mass.
#
#   :secondary          out[i] = Σ_k pmf_i[k + 1] * series[i - k]
#     The delay belongs to the observation time: everything landing at time
#     `i` reads `pmf_i`. Not mass-conserving in general.

# Kernel accessors. The caller-supplied surfaces (matrix, vector of mass
# vectors) differ only in how the mass at time `j`, lag `k - 1` is reached,
# so the convolution is written once against these.
_kernel_count(kernels::AbstractMatrix) = size(kernels, 2)
_kernel_count(kernels::AbstractVector) = length(kernels)

_kernel_length(kernels::AbstractMatrix, j::Int) = size(kernels, 1)
_kernel_length(kernels::AbstractVector{<:AbstractVector}, j::Int) = length(kernels[j])

_kernel_mass(kernels::AbstractMatrix, j::Int, k::Int) = kernels[k, j]
_kernel_mass(kernels::AbstractVector{<:AbstractVector}, j::Int, k::Int) = kernels[j][k]

# Seeds the accumulator type so `Dual` / tracked masses propagate.
_kernel_eltype(kernels::AbstractMatrix) = eltype(kernels)
function _kernel_eltype(kernels::AbstractVector{<:AbstractVector})
    mapreduce(eltype, promote_type, kernels)
end

# Causal convolution with one kernel per time point, truncated to the series
# window. `indexed_by` dispatches through `Val`, so the two conventions are
# methods rather than branches and another one is a method away — nothing
# here enumerates the allowed names (an unknown one is a MethodError).
function _causal_convolve_varying(
        series::AbstractVector, kernels, indexed_by::Symbol)
    return _causal_convolve_varying(series, kernels, Val(indexed_by))
end

# Gather: time `i` reads its own kernel back over the series.
function _causal_convolve_varying(
        series::AbstractVector, kernels, ::Val{:secondary})
    n = length(series)
    n == 0 && return zeros(float(eltype(series)), 0)
    T = promote_type(eltype(series), _kernel_eltype(kernels))
    out = zeros(T, n)
    @inbounds for i in 1:n
        acc = zero(T)
        for k in 1:min(_kernel_length(kernels, i), i)
            acc += _kernel_mass(kernels, i, k) * series[i - k + 1]
        end
        out[i] = acc
    end
    return out
end

# Scatter: the cohort at time `s` spreads forward through its own kernel.
function _causal_convolve_varying(
        series::AbstractVector, kernels, ::Val{:primary})
    n = length(series)
    n == 0 && return zeros(float(eltype(series)), 0)
    T = promote_type(eltype(series), _kernel_eltype(kernels))
    out = zeros(T, n)
    @inbounds for s in 1:n
        x = series[s]
        for k in 1:min(_kernel_length(kernels, s), n - s + 1)
            out[s + k - 1] += _kernel_mass(kernels, s, k) * x
        end
    end
    return out
end

# Lags time point `j` of `n` can reach under each convention: the cohort at
# `j` only lands at `j:n`, and time `j` only reads back to time 1. A new
# convention adds a method here and above.
_kernel_lags(n::Int, ::Val{:primary}) = n:-1:1
_kernel_lags(n::Int, ::Val{:secondary}) = 1:n

function _check_kernel_count(kernels, series::AbstractVector)
    count = _kernel_count(kernels)
    count == length(series) || throw(ArgumentError(
        "convolve_series needs one delay PMF per time point; got $(count) " *
        "for a series of length $(length(series))"))
    return nothing
end

# A delay's masses at lags `0:(n - 1)`: convolving a unit impulse at time 0
# through the delay's own single-delay method returns its kernel, whatever
# the type and wherever that method is defined.
function _delay_masses(delay, n::Int)
    return convolve_series(delay, [ifelse(i == 1, 1.0, 0.0) for i in 1:n])
end

@doc "

Convolve a timeseries with a time-varying delay: one delay per time point.

`convolve_series(delays, series)` takes one delay per entry of `series` and
returns the causal convolution, truncated to the `series` window. Each
delay's lag masses come from its own single-delay
[`convolve_series(delay, series)`](@ref convolve_series) method, so the
elements may be of any, and of mixed, types.

`indexed_by` names which time the delay belongs to:

- `:primary` (the default): the delay belongs to the events, so the cohort
  at time `s` spreads forward through `delays[s]` —
  `out[i] = Σ_s series[s] * pmf_s[i - s + 1]`. Conserves mass up to the
  truncated tail.
- `:secondary`: the delay belongs to the observation time, so everything
  landing at time `i` is read through `delays[i]` —
  `out[i] = Σ_k pmf_i[k + 1] * series[i - k]`. Not mass-conserving.

# Arguments
- `delays`: one delay per time point, in `series` order.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `indexed_by`: `:primary` (default) or `:secondary`.

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
"
function convolve_series(
        delays::AbstractVector, series::AbstractVector{<:Real};
        indexed_by::Symbol = :primary)
    Base.require_one_based_indexing(delays, series)
    _check_kernel_count(delays, series)
    n = length(series)
    lags = _kernel_lags(n, Val(indexed_by))
    masses = [_delay_masses(delays[j], lags[j]) for j in 1:n]
    return convolve_series(masses, series; indexed_by)
end

@doc "

Convolve a timeseries with time-varying caller-supplied delay PMFs held in
a matrix.

`convolve_series(pmfs, series)` reads an `AbstractMatrix` as one delay PMF
per time point, **lags down columns**: `pmfs[k + 1, j]` is the mass at lag
`k` for time point `j`, so `size(pmfs, 2)` must equal `length(series)`.
The lag count `size(pmfs, 1)` is free — masses past the window end are
never read. Column-major storage makes this the contiguous layout; a
time-by-lag matrix `M` is passed as `transpose(M)`.

`indexed_by` names which time the delay belongs to, as in the
[vector-of-delays form](@ref convolve_series): `:primary` (the default)
spreads the cohort at time `s` forward through column `s`, `:secondary`
reads everything landing at time `i` through column `i`.

Masses are used exactly as given: no renormalisation, no sum-to-one check
and no tail correction, so window-truncated columns stay truncated.

# Arguments
- `pmfs`: delay masses, lags down columns, one column per time point.
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).
- `indexed_by`: `:primary` (default) or `:secondary`.

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
        indexed_by::Symbol = :primary)
    Base.require_one_based_indexing(pmfs, series)
    size(pmfs, 1) >= 1 ||
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    _check_kernel_count(pmfs, series)
    return _causal_convolve_varying(series, pmfs, indexed_by)
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
        indexed_by::Symbol = :primary)
    Base.require_one_based_indexing(pmfs, series)
    _check_kernel_count(pmfs, series)
    all(!isempty, pmfs) ||
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    foreach(Base.require_one_based_indexing, pmfs)
    return _causal_convolve_varying(series, pmfs, indexed_by)
end
