# ============================================================================
# convolve_distributions(delay, series): timeseries delay convolution
# ============================================================================
#
# A `convolve_distributions` method whose second argument is a numeric
# timeseries vector convolves that series with the discretised delay PMF of a
# distribution. With `series` the expected events at times `0..t` (e.g.
# infections), the result is the expected downstream event counts at the same
# times: the EpiNow2-style latent / renewal observation layer.
#
# This reuses the existing distribution-level `convolve_distributions`: the
# second positional argument is `AbstractVector{<:Real}` (a numeric series),
# distinct from the `AbstractVector{<:UnivariateDistribution}` / tuple /
# two-distribution forms, so the timeseries method and the distribution-args
# forms never collide.
#
# AD-safety. The vector convolution is linear and the PMF depends
# differentiably on the delay parameters (the interval masses route through
# the AD-safe CDF helpers), so gradients flow through ForwardDiff /
# ReverseDiff / Enzyme / Mooncake w.r.t. the delay params.

# --- the discrete delay PMF over the grid 0..maxlag ------------------------

# Probability masses of `delay` on the unit-spaced intervals
# `[0, 1), [1, 2), ..., [maxlag, maxlag + 1)` (scaled by `interval`), as a
# length `maxlag + 1` vector. Masses are the raw CDF differences
# `F((k + 1) interval) - F(k interval)` (no silent renormalise), routed
# through `_cdf_ad_safe` so `Dual`/tracked CDF values survive (no `Float64`
# caching that would break AD).
function _delay_pmf(delay::UnivariateDistribution, maxlag::Integer, interval)
    return map(0:maxlag) do k
        _cdf_ad_safe(delay, (k + 1) * interval) -
        _cdf_ad_safe(delay, k * interval)
    end
end

# --- the causal discrete convolution series ⊛ pmf --------------------------

# Causal discrete convolution of a series with a delay PMF, truncated to the
# series window. `out[i] = Σ_{k≥0} pmf[k + 1] * series[i - k]`, i.e. mass from
# lag `k` carries `series[i - k]` forward to time `i`. The accumulator element
# type is seeded from the product so `Dual`/tracked numbers propagate.
function _causal_convolve(series::AbstractVector, pmf::AbstractVector)
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

# --- public API: the convolve_distributions timeseries method --------------

@doc "

Convolve a timeseries with the discretised delay PMF of a distribution.

`convolve_distributions(delay, series)`, where `series` is a numeric
timeseries vector, discretises `delay` to a PMF over the unit grid and
returns the causal discrete convolution of `series` with that PMF,
truncated to the `series` window. With `series` the expected events at
times `0, 1, ..., t` (e.g. infections), the result is the expected
downstream event counts at the same times (the EpiNow2-style latent /
renewal observation layer).

The PMF masses are the raw CDF differences ``F(k + 1) - F(k)`` over the
grid (no renormalisation), so delay mass beyond the series window — and
any mass below zero — is truncated. The masses depend differentiably on
the delay parameters, so gradients flow under the supported AD backends.

This method does a DIFFERENT operation from the distribution-level
`convolve_distributions(dists...)`. That form convolves DISTRIBUTIONS
together to produce a single [`Convolved`](@ref) distribution (the sum of
independent delays). This form convolves a NUMERIC SERIES with a delay
PMF to produce a count series. They share the name but never collide: the
numeric-vector second argument (`AbstractVector{<:Real}`) selects this
method, distinct from the `AbstractVector{<:UnivariateDistribution}` /
tuple / two-distribution forms.

# Arguments
- `delay`: the delay distribution (any `UnivariateDistribution`,
  including a [`Convolved`](@ref) total delay).
- `series`: the input timeseries (expected events at unit-spaced times
  from 0).

# Keyword Arguments
- `interval`: the discretisation grid width, which is also the series
  time-step. The series is unit-spaced and the causal convolution shifts
  by integer series steps, so this must be `1` (the default); any other
  value is rejected with an `ArgumentError` to avoid conflating the grid
  width with the series step.

# Examples
```@example
using ConvolvedDistributions, Distributions

delay = convolve_distributions(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
infections = [0.0, 1.0, 3.0, 6.0, 8.0, 5.0, 2.0]
expected_counts = convolve_distributions(delay, infections)
```

# See also
- [`Convolved`](@ref): the distribution-level convolution
"
function convolve_distributions(
        delay::UnivariateDistribution, series::AbstractVector{<:Real};
        interval = 1)
    # The causal convolution shifts the series by integer SERIES steps, so
    # the PMF bin width must equal the series time-step. `series` is
    # unit-spaced (see the docstring), so only `interval == 1` keeps the
    # discretisation grid aligned with the shift; any other width conflates
    # the two and silently mis-aligns the result. Reject it rather than
    # return a wrong answer.
    isone(interval) || throw(ArgumentError(
        "interval must be 1: the series is unit-spaced and the causal " *
        "convolution shifts by integer series steps, so a PMF grid width " *
        "other than 1 conflates the discretisation width with the series " *
        "time-step. Got interval = $(interval)."))
    maxlag = length(series) - 1
    pmf = _delay_pmf(delay, maxlag, interval)
    return _causal_convolve(series, pmf)
end
