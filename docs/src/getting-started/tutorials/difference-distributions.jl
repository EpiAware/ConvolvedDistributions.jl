# # [The difference of two delays](@id difference-distributions)
#
# ## Introduction
#
# A [`Difference`](@ref) is the signed gap between two events, so its support runs on both sides of zero — unlike [`Convolved`](@ref ConvolvedDistributions.Convolved) (see [Convolving distributions](@ref convolving-distributions)) or [`product`](@ref), whose supports only ever run in one direction.
# `product` has no dedicated plotting tutorial; see its worked example in the [Getting started](@ref getting-started) overview's Products section and the [FAQ](@ref faq).
#
# ### What are we going to do in this exercise
#
# 1. Plot the density and cumulative probability of the difference of two delays across zero.
# 2. Take the difference between a [`Convolved`](@ref ConvolvedDistributions.Convolved) total delay and a single delay.
#
# ### What might I need to know before starting
#
# This tutorial builds on the [Getting started](@ref getting-started) overview and uses AlgebraOfGraphics.jl and CairoMakie.jl for plotting.
# No fitting or MCMC is involved; every quantity is a direct evaluation.

# ## Packages used

using ConvolvedDistributions, Distributions
using CairoMakie, AlgebraOfGraphics, DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)

# ## The difference of two delays
#
# [`difference`](@ref) builds `Z = X - Y`, here a reporting delay minus an incubation period.
# Reflecting the subtracted component makes the support two-sided, so the density crosses zero.

incubation = Gamma(2.0, 1.0)
reporting = LogNormal(1.0, 0.5)

z_dist = difference(reporting, incubation)
z = -8.0:0.05:12.0
difference_df = vcat(
    DataFrame(z = z, value = pdf.(z_dist, z), Quantity = "Density (pdf)"),
    DataFrame(z = z, value = cdf.(z_dist, z), Quantity = "Cumulative (cdf)")
)
draw(
    data(difference_df) *
    mapping(:z, :value, color = :Quantity) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Reporting delay - incubation period (days)",
        ylabel = "Density / cumulative probability")
)

# The mass below zero is the probability that the reporting delay is shorter than the incubation period.

cdf(z_dist, 0.0)

# ## Differencing a Convolved total delay
#
# A [`Convolved`](@ref ConvolvedDistributions.Convolved) distribution is itself a `UnivariateDistribution`, so it can be one side of a [`difference`](@ref).
# Here the two-stage delay `incubation + reporting` is the minuend, and a single Gamma delay the subtrahend.

d = convolved(incubation, reporting)
gap = difference(d, Gamma(2.5, 1.0))
zg = -8.0:0.25:12.0
gap_df = vcat(
    DataFrame(z = zg, value = pdf.(gap, zg), Quantity = "Density (pdf)"),
    DataFrame(z = zg, value = cdf.(gap, zg), Quantity = "Cumulative (cdf)")
)
draw(
    data(gap_df) *
    mapping(:z, :value, color = :Quantity) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Two-stage delay - single delay (days)",
        ylabel = "Density / cumulative probability")
)

# The mass below zero is the probability that the two-stage delay resolves before the single delay.

cdf(gap, 0.0)

# ## Summary
#
# - [`difference`](@ref) has two-sided support, and its mass below zero is directly interpretable as an ordering probability.
# - A [`Convolved`](@ref ConvolvedDistributions.Convolved) can be one side of a [`difference`](@ref), so a multi-stage delay differences against a single delay in one call.
#
# See also: [Convolving distributions](@ref convolving-distributions), [Convolving a timeseries](@ref timeseries-convolution).
