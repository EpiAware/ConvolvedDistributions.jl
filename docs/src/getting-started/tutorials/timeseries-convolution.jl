# # [Convolving a timeseries](@id timeseries-convolution)
#
# ## Introduction
#
# This tutorial shows what [`convolve_series`](@ref) does by plotting it.
# It convolves a numeric series with a delay PMF on the unit lag grid, the renewal-style observation layer that turns an infection curve into an expected count curve.
#
# ### What are we going to do in this exercise
#
# 1. Build a delay PMF and a synthetic infection curve.
# 2. Convolve the infection curve into an expected downstream count curve.
#
# ### What might I need to know before starting
#
# This tutorial builds on the [Getting started](@ref getting-started) overview and uses AlgebraOfGraphics.jl and CairoMakie.jl for plotting.
# No fitting or MCMC is involved; every quantity is a direct evaluation.

# ## Packages used

using ConvolvedDistributions, Distributions
using CairoMakie, AlgebraOfGraphics, DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)

# ## Timeseries convolution
#
# The timeseries form `convolve_series` convolves a numeric series with a delay PMF on the unit lag grid.
# The delay here is discrete, so its PMF reads straight off `pdf.(delay, 0:maxlag)` and convolves as a plain vector of masses.
# With the series an expected infection curve, the result is the expected downstream count curve.

t = 0:40
infections = 100 .* exp.(-((t .- 12.0) .^ 2) ./ 30.0)
maxlag = length(infections) - 1
delay_masses = pdf.(NegativeBinomial(5, 0.5), 0:maxlag)
expected = convolve_series(delay_masses, infections)

timeseries_df = vcat(
    DataFrame(t = t, count = infections, Series = "Infections"),
    DataFrame(t = t, count = expected, Series = "Expected reports")
)
draw(
    data(timeseries_df) *
    mapping(:t, :count, color = :Series) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Day", ylabel = "Expected count")
)

# The report curve is shifted right by the mean total delay and is flatter than the infection curve, because convolution smears each day's infections across the delay distribution.
# Mass delayed beyond the series window is truncated rather than renormalised, so the report curve carries slightly less total mass.

# ## A delay that changes over the window
#
# A single PMF assumes the delay never changes, which a reporting system that speeds up over an outbreak plainly violates.
# Passing one delay per time point — here a Poisson delay whose mean falls from six days to two across the window — convolves each time point through its own PMF.
# The delays can be a vector of distributions, a matrix of masses with lags down columns, or a ragged vector of mass vectors; all three read the same way.

mean_delay = range(6.0, 2.0; length = length(t))
delays = [Poisson(m) for m in mean_delay]
timevarying = convolve_series(delays, infections)

# `indexed_by` names which time the delay belongs to.
# The default `:primary` gives it to the events: the cohort infected at time `s` is reported through the delay in force then, so each cohort spreads forward through its own PMF and mass is conserved up to the truncated tail.
# `:secondary` gives it to the reporting date instead, reading everything reported at time `i` through the delay in force at `i`.

timevarying_secondary = convolve_series(delays, infections; indexed_by = :secondary)

timevarying_df = vcat(
    DataFrame(t = t, count = infections, Series = "Infections"),
    DataFrame(t = t, count = timevarying, Series = "Time-varying (primary)"),
    DataFrame(
        t = t, count = timevarying_secondary,
        Series = "Time-varying (secondary)")
)
draw(
    data(timevarying_df) *
    mapping(:t, :count, color = :Series) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Day", ylabel = "Expected count")
)

# Early infections are reported with the long delay in force at the time and late ones with the short delay, so the report curve is pulled forward and compressed relative to the constant-delay run.
# The two conventions separate wherever the delay is actually changing: the primary curve carries each cohort's own delay, while the secondary curve reads every report date through a single delay, which is why it is not mass-conserving.

# ## Summary
#
# - The timeseries form turns an infection curve into an expected count curve through the discretised delay PMF.
# - A time-varying delay is one PMF per time point, with `indexed_by` naming whether the delay belongs to the events (`:primary`) or to the reporting date (`:secondary`).
#
# See also: [Convolving distributions](@ref convolving-distributions), [The difference of two delays](@ref difference-distributions), [The product of two delays](@ref product-distributions).
