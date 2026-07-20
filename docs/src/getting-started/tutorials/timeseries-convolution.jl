# # [Convolving a timeseries](@id timeseries-convolution)
#
# ## Introduction
#
# This tutorial shows what [`convolve_series`](@ref) does by plotting it.
# It convolves a numeric series with a delay PMF on the unit lag grid, the renewal-style observation layer that turns an infection curve into an expected count curve.
#
# ### What are we going to do in this exercise
#
# 1. Build a two-stage delay and a synthetic infection curve.
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
# The delay here is continuous, so we discretise it explicitly with `discretise_pmf` (raw CDF-difference masses: interval-censored secondary event, exact primary) and convolve the resulting PMF; a discrete delay would be passed straight to `convolve_series`.
# With the series an expected infection curve, the result is the expected downstream count curve.

d = convolved(Gamma(2.0, 1.0), LogNormal(1.0, 0.5))

t = 0:40
infections = 100 .* exp.(-((t .- 12.0) .^ 2) ./ 30.0)
delay_pmf = discretise_pmf(d, length(infections) - 1)
expected = convolve_series(delay_pmf, infections)

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

# ## Summary
#
# - The timeseries form turns an infection curve into an expected count curve through the discretised delay PMF.
#
# See also: [Convolving distributions](@ref convolving-distributions), [The difference of two delays](@ref difference-distributions).
