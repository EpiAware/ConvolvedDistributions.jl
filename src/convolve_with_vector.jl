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
# so passing a continuous delay is rejected: the caller discretises first
# (with CensoredDistributions.jl, which owns primary/interval censoring)
# and feeds the resulting PMF to the PMF-vector method, either as a plain
# vector on the unit grid or as a `DiscreteNonParametric` on any regularly
# spaced grid (#79).
#
# A delay that changes over the series window (a reporting system that speeds
# up, a changed case definition) is carried by the time-varying forms at the
# end of this file: one delay per time point, as a vector of distributions, a
# matrix of masses (lags down columns) or a ragged vector of mass vectors,
# with `indexed_by` naming which time the delay belongs to (#126).
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

For a CONTINUOUS delay there is no mass on the integer grid until it is
discretised, and discretisation is an explicit modelling choice; that
method throws — see below.

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

Reject a continuous delay: discretising it needs an explicit censoring
scheme.

`convolve_series(delay, series)` for a `ContinuousUnivariateDistribution`
(including a [`Convolved`](@ref) total delay) throws an `ArgumentError`.
A continuous delay carries no mass on the integer lag grid until it is
discretised, and discretisation is a censoring choice this package does
not make (interval-censored-secondary with an exact primary vs. the usual
epidemiological double-interval-censored case). The caller discretises
first with CensoredDistributions.jl and passes the resulting PMF to
[`convolve_series(pmf, series)`](@ref convolve_series), either as a
plain vector on the unit grid or as a `DiscreteNonParametric` on any
regularly spaced grid.

# See also
- [`convolve_series(pmf, series)`](@ref convolve_series): convolve a
  caller-supplied PMF
"
function convolve_series(
        delay::ContinuousUnivariateDistribution,
        series::AbstractVector{<:Real})
    throw(ArgumentError(
        "convolve_series does not discretise a continuous delay: " *
        "discretising a continuous delay needs an explicit censoring " *
        "scheme. Build the PMF with CensoredDistributions.jl (which " *
        "owns primary/interval censoring), then pass it — as a plain " *
        "vector or a DiscreteNonParametric — to convolve_series(pmf, " *
        "series)."))
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
# A single PMF assumes the delay never changes over the series window, which
# is exactly what a changing reporting system, a changing case definition or
# a seasonal delay violate. The time-varying forms take one delay per time
# point — a vector of distributions, a matrix of masses (lags down columns,
# one column per time), or a ragged vector of mass vectors — all of length
# `length(series)`.
#
# WHICH time indexes the delay is a genuine modelling choice, not a detail,
# so it is an explicit keyword rather than a silent convention. Reusing the
# primary/secondary vocabulary of the censoring literature (the primary event
# happens, the secondary event is observed after the delay):
#
#   indexed_by = :primary   (default)
#       out[i] = Σ_s series[s] * pmf_s[i - s + 1]
#       The delay belongs to the events themselves: the cohort at time `s`
#       carries the delay in force when it occurred and spreads forward
#       through it. This is the generative reading, and it conserves mass —
#       each cohort's own PMF distributes its events over later times.
#
#   indexed_by = :secondary
#       out[i] = Σ_k pmf_i[k + 1] * series[i - k]
#       The delay belongs to the observation time: everything landing at
#       time `i` is attributed through the delay in force at `i`. This is
#       the reading for a delay that is a property of the reporting date,
#       and it does NOT conserve mass in general.
#
# Both reduce to the static `convolve_series(pmf, series)` when every time
# point carries the same PMF.
#
# Masses are used exactly as given, as in the static vector form: no
# renormalisation, and mass falling outside the series window is truncated.

# --- the kernel-collection accessors ---------------------------------------
#
# The three surfaces (matrix, vector-of-vectors, vector-of-distributions)
# differ only in how the lag-`k - 1` mass at time `j` is reached, so the
# convolution kernels are written once against these three accessors. The
# distribution form reads `pdf(delay, k - 1)` lazily rather than
# materialising an `n × n` mass matrix.

# Number of time points a kernel collection covers.
_kernel_count(kernels::AbstractMatrix) = size(kernels, 2)
_kernel_count(kernels::AbstractVector) = length(kernels)

# Number of lags the kernel at time `j` carries. A distribution has mass at
# every integer lag, so its kernel spans the whole window; the convolution
# loops clamp to the series window anyway.
_kernel_length(kernels::AbstractMatrix, j::Int) = size(kernels, 1)
_kernel_length(kernels::AbstractVector{<:AbstractVector}, j::Int) = length(kernels[j])
_kernel_length(kernels::AbstractVector{<:UnivariateDistribution}, j::Int) = length(kernels)

# The mass at time `j` and lag `k - 1` (`k` is the 1-based lag index).
_kernel_mass(kernels::AbstractMatrix, j::Int, k::Int) = kernels[k, j]
_kernel_mass(kernels::AbstractVector{<:AbstractVector}, j::Int, k::Int) = kernels[j][k]
function _kernel_mass(
        kernels::AbstractVector{<:UnivariateDistribution}, j::Int, k::Int)
    pdf(kernels[j], k - 1)
end

# The element type the masses contribute to the accumulator, so `Dual` /
# tracked numbers in the delay parameters propagate into the output.
_kernel_eltype(kernels::AbstractMatrix) = eltype(kernels)
function _kernel_eltype(kernels::AbstractVector{<:AbstractVector})
    mapreduce(eltype, promote_type, kernels)
end
function _kernel_eltype(kernels::AbstractVector{<:UnivariateDistribution})
    mapreduce(d -> typeof(pdf(d, 0)), promote_type, kernels)
end

# --- the time-varying causal convolution -----------------------------------

# Causal convolution of `series` with one delay kernel per time point, under
# either indexing convention (see the block comment above). Both branches are
# truncated to the series window and seed the accumulator element type from
# the promotion of series and mass types, as `_causal_convolve` does.
function _causal_convolve_varying(
        series::AbstractVector, kernels, indexed_by::Symbol)
    n = length(series)
    n == 0 && return zeros(float(eltype(series)), 0)
    T = promote_type(eltype(series), _kernel_eltype(kernels))
    out = zeros(T, n)
    if indexed_by === :secondary
        # Gather: time `i` reads its own kernel back over the series.
        @inbounds for i in 1:n
            acc = zero(T)
            for k in 1:min(_kernel_length(kernels, i), i)
                acc += _kernel_mass(kernels, i, k) * series[i - k + 1]
            end
            out[i] = acc
        end
    else
        # Scatter: the cohort at time `s` spreads forward through its own
        # kernel, landing at times `s, s + 1, ...` up to the window end.
        @inbounds for s in 1:n
            x = series[s]
            for k in 1:min(_kernel_length(kernels, s), n - s + 1)
                out[s + k - 1] += _kernel_mass(kernels, s, k) * x
            end
        end
    end
    return out
end

# --- shared validation for the time-varying surfaces ------------------------

function _check_indexed_by(indexed_by::Symbol)
    indexed_by === :primary || indexed_by === :secondary ||
        throw(ArgumentError(
            "convolve_series indexed_by must be :primary (the delay of the " *
            "time the events occur, spreading each cohort forward through " *
            "its own PMF) or :secondary (the delay of the time the events " *
            "are observed); got :$(indexed_by)"))
    return nothing
end

function _check_kernel_count(kernels, series::AbstractVector)
    count = _kernel_count(kernels)
    n = length(series)
    count == n || throw(ArgumentError(
        "convolve_series with a time-varying delay needs one delay PMF per " *
        "time point: got $(count) PMFs for a series of length $(n)"))
    return nothing
end

@doc "

Convolve a timeseries with a time-varying delay: one distribution per time
point.

`convolve_series(delays, series)` for a vector of
`DiscreteUnivariateDistribution`s — one per entry of `series`, so
`length(delays) == length(series)` — reads each delay's PMF off the
integer lag grid (the lag-`k` mass IS `pdf(delay, k)`, as in the
[single-delay method](@ref convolve_series)) and convolves causally,
truncated to the `series` window.

`indexed_by` chooses which time the delay belongs to; the two readings
differ whenever the delay changes over the window, and both reduce to the
static [`convolve_series(delay, series)`](@ref convolve_series) when it
does not.

- `:primary` (the default): the delay belongs to the events themselves —
  the cohort at time `s` spreads forward through `delays[s]`, giving
  `out[i] = Σ_s series[s] * pdf(delays[s], i - s)`. This is the
  generative reading and conserves mass (up to the truncated tail).
- `:secondary`: the delay belongs to the observation time — everything
  landing at time `i` is attributed through `delays[i]`, giving
  `out[i] = Σ_k pdf(delays[i], k) * series[i - k]`. Use this when the
  delay is a property of the reporting date rather than of the events.
  It does not conserve mass in general.

A CONTINUOUS delay anywhere in `delays` throws, exactly as in the
single-delay case: discretisation is an explicit modelling choice this
package does not make. Discretise first (e.g. with
CensoredDistributions.jl) and pass the per-time masses as a matrix or a
vector of vectors.

`pdf(delay, k)` is differentiable in the delay parameters for the
standard discrete families and the convolution is linear, so gradients
flow through both the delays and `series` under the supported AD
backends.

# Arguments
- `delays`: one `DiscreteUnivariateDistribution` per time point, in the
  same order as `series`.
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
# A reporting delay that shortens over the window.
delays = [Poisson(λ) for λ in range(3.0, 1.0; length = length(infections))]
expected_counts = convolve_series(delays, infections)
```

# See also
- [`convolve_series(delay, series)`](@ref convolve_series): the static
  single-delay form
- [`convolve_series(pmfs::AbstractMatrix, series)`](@ref convolve_series):
  the time-varying caller-supplied-PMF form
"
function convolve_series(
        delays::AbstractVector{<:UnivariateDistribution},
        series::AbstractVector{<:Real};
        indexed_by::Symbol = :primary)
    Base.require_one_based_indexing(delays, series)
    _check_indexed_by(indexed_by)
    _check_kernel_count(delays, series)
    all(d -> d isa DiscreteUnivariateDistribution, delays) ||
        throw(ArgumentError(
            "convolve_series does not discretise a continuous delay: " *
            "discretising a continuous delay needs an explicit censoring " *
            "scheme. Build the per-time PMFs with CensoredDistributions.jl " *
            "(which owns primary/interval censoring), then pass them — as " *
            "a matrix with lags down each column, or a vector of mass " *
            "vectors — to convolve_series(pmfs, series)."))
    return _causal_convolve_varying(series, delays, indexed_by)
end

@doc "

Convolve a timeseries with time-varying caller-supplied delay PMFs held in
a matrix.

`convolve_series(pmfs, series)` for an `AbstractMatrix` reads `pmfs` as one
delay PMF per time point, **lags down columns**: `pmfs[k + 1, j]` is the
mass at integer lag `k` for time point `j`, so `size(pmfs, 2)` must equal
`length(series)` and `size(pmfs, 1)` is the number of lags carried (it may
be shorter or longer than the series; longer tails are truncated to the
window). Column-major storage makes this layout the contiguous one; a
time-by-lag matrix `M` is passed as `transpose(M)`.

`indexed_by` chooses which time the delay belongs to, as in the
[vector-of-distributions form](@ref convolve_series):

- `:primary` (the default):
  `out[i] = Σ_s series[s] * pmfs[i - s + 1, s]` — the cohort at time `s`
  spreads forward through its own column.
- `:secondary`:
  `out[i] = Σ_k pmfs[k + 1, i] * series[i - k]` — time `i` is attributed
  through its own column.

Masses are used exactly as given: no renormalisation, no check that any
column sums to one, and no tail correction, so sub-normalised or
window-truncated PMFs stay truncated — the time-varying counterpart of the
[plain-vector form](@ref convolve_series). The convolution is linear, so
gradients flow through both `pmfs` and `series`.

# Arguments
- `pmfs`: delay masses with lags down columns and one column per time
  point (`n_lags × length(series)`).
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
# Column j is the delay PMF for time point j.
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
    _check_indexed_by(indexed_by)
    size(pmfs, 1) >= 1 ||
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    _check_kernel_count(pmfs, series)
    return _causal_convolve_varying(series, pmfs, indexed_by)
end

@doc "

Convolve a timeseries with time-varying caller-supplied delay PMFs held in
a vector of vectors.

`convolve_series(pmfs, series)` for a vector of mass vectors is the ragged
counterpart of the [matrix form](@ref convolve_series): `pmfs[j]` is the
delay PMF for time point `j` on the unit lag grid (`pmfs[j][k + 1]` is the
mass at lag `k`), so `length(pmfs)` must equal `length(series)` while the
individual PMFs may each have their own length. Use it when the delays
carry different numbers of lags; the matrix form is the rectangular,
contiguous alternative.

`indexed_by` chooses which time the delay belongs to, exactly as in the
matrix form: `:primary` (the default) spreads the cohort at time `s`
forward through `pmfs[s]`, `:secondary` attributes everything landing at
time `i` through `pmfs[i]`.

Masses are used exactly as given: no renormalisation and no tail
correction. The convolution is linear, so gradients flow through both the
masses and `series`.

# Arguments
- `pmfs`: one vector of delay masses per time point, each on the unit lag
  grid from lag 0.
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
    _check_indexed_by(indexed_by)
    _check_kernel_count(pmfs, series)
    all(!isempty, pmfs) ||
        throw(ArgumentError("convolve_series needs at least one PMF mass"))
    foreach(Base.require_one_based_indexing, pmfs)
    return _causal_convolve_varying(series, pmfs, indexed_by)
end
