# # [Visualising convolutions](@id visualising-convolutions)
#
# ## Introduction
#
# This tutorial shows what the package does by plotting it.
# A [`Convolved`](@ref ConvolvedDistributions.Convolved) distribution is the sum of independent delays, so its density sits to the right of, and is wider than, either component.
# A [`Difference`](@ref) is the signed gap between two events, so its support runs on both sides of zero.
# The plots below make each of these behaviours visible, and also check the analytic and numeric solver backends against each other.
#
# ### What are we going to do in this exercise
#
# 1. Overlay two component densities with their convolved density.
# 2. Plot the density of the [`difference`](@ref) of the same pair across zero.
# 3. Nest one convolution inside another and check it against the flat form.
# 4. Compare the analytic and numeric solver CDFs and plot their residual.
# 5. Compare a right-truncated convolution with the untruncated density.
# 6. Convolve a synthetic infection curve into an expected count curve.
#
# ### What might I need to know before starting
#
# This tutorial builds on the [Getting started](@ref getting-started) overview and uses AlgebraOfGraphics.jl and CairoMakie.jl for plotting.
# No fitting or MCMC is involved; every quantity is a direct evaluation.

# ## Packages used

using ConvolvedDistributions, Distributions
using CairoMakie, AlgebraOfGraphics, DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)

# ## Two components and their sum
#
# We use a Gamma incubation period and a LogNormal reporting delay, a pair with no closed-form convolution, so the density comes from the quadrature path.
# [`convolved`](@ref) returns the distribution of the sum, and the batched `pdf` method evaluates a whole grid with a single quadrature solve.

incubation = Gamma(2.0, 1.0)
reporting = LogNormal(1.0, 0.5)
d = convolved(incubation, reporting)

x = 0.0:0.05:15.0
components_df = vcat(
    DataFrame(x = x, density = pdf.(incubation, x),
        Distribution = "Incubation (Gamma)"),
    DataFrame(x = x, density = pdf.(reporting, x),
        Distribution = "Reporting (LogNormal)"),
    DataFrame(x = x, density = pdf(d, collect(x)),
        Distribution = "Convolved sum")
)
draw(
    data(components_df) *
    mapping(:x, :density, color = :Distribution) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay (days)", ylabel = "Density")
)

# The convolved density peaks later than either component and is flatter, because summing independent delays adds both their means and their variances.

# ## The difference of the same pair
#
# [`difference`](@ref) builds `Z = X - Y`, here the reporting delay minus the incubation period.
# Reflecting the subtracted component makes the support two-sided, so the density crosses zero.

z_dist = difference(reporting, incubation)
z = -8.0:0.05:12.0
difference_df = DataFrame(z = z, density = pdf.(z_dist, z))
draw(
    data(difference_df) *
    mapping(:z, :density) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Reporting delay - incubation period (days)",
        ylabel = "Density")
)

# The mass below zero is the probability that the reporting delay is shorter than the incubation period.

cdf(z_dist, 0.0)

# ## Composing on multiple distributions
#
# A [`Convolved`](@ref ConvolvedDistributions.Convolved) distribution is itself a `UnivariateDistribution`, so it can be a component of another [`convolved`](@ref) call, or one side of a [`difference`](@ref).
# Here the two-stage delay `d` gains an Exponential processing stage, built once by nesting (`convolved(d, processing)`) and once flat from the three leaves.

processing = Exponential(2.0)
total_nested = convolved(d, processing)
total_flat = convolved(incubation, reporting, processing)

xn = 0.0:0.25:20.0
nested_df = vcat(
    DataFrame(x = xn, density = pdf(d, collect(xn)),
        Distribution = "Two-stage delay"),
    DataFrame(x = xn, density = pdf(total_nested, collect(xn)),
        Distribution = "Nested three-stage"),
    DataFrame(x = xn, density = pdf(total_flat, collect(xn)),
        Distribution = "Flat three-stage")
)
draw(
    data(nested_df) *
    mapping(:x, :density,
        color = :Distribution, linestyle = :Distribution) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay (days)", ylabel = "Density")
)

# The nested and flat densities coincide, and adding the third stage shifts and widens the two-stage density.
# The quadrature folds the flat component tuple recursively, so the two forms evaluate the same integral; the moments are exact component sums either way.

mean(total_nested), mean(total_flat)

# The same composition applies to differences: the signed gap between the two-stage delay and a single Gamma delay is one call, with the `Convolved` as the minuend.

gap = difference(d, Gamma(2.5, 1.0))
zg = -8.0:0.25:12.0
gap_df = DataFrame(z = zg, density = pdf.(gap, zg))
draw(
    data(gap_df) *
    mapping(:z, :density) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Two-stage delay - single delay (days)",
        ylabel = "Density")
)

# The mass below zero is the probability that the two-stage delay resolves before the single delay.

cdf(gap, 0.0)

# ## Analytic and numeric solvers agree
#
# For an equal-scale Gamma pair a closed-form convolution exists and the default [`AnalyticalSolver`](@ref) uses it.
# Passing [`NumericSolver`](@ref) forces the quadrature path on the same pair, which lets us check the numeric machinery against the exact answer.

pair = (Gamma(2.0, 1.0), Gamma(3.0, 1.0))
d_analytic = convolved(pair...)
d_numeric = convolved(pair...; method = NumericSolver())

xs = 0.0:0.1:20.0
solver_df = vcat(
    DataFrame(x = xs, cdf = cdf(d_analytic, collect(xs)),
        Solver = "Analytic (closed form)"),
    DataFrame(x = xs, cdf = cdf(d_numeric, collect(xs)),
        Solver = "Numeric (quadrature)")
)
draw(
    data(solver_df) *
    mapping(:x, :cdf, color = :Solver, linestyle = :Solver) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay (days)", ylabel = "CDF")
)

# The two curves lie on top of each other, so we plot the residual to see the actual size of the quadrature error.

residual_df = DataFrame(x = xs,
    residual = cdf(d_numeric, collect(xs)) .- cdf(d_analytic, collect(xs)))
draw(
    data(residual_df) *
    mapping(:x, :residual) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay (days)",
        ylabel = "Numeric CDF - analytic CDF")
)

# The largest absolute residual across the grid is a few parts in a million, the size of the fixed-node quadrature error and its tail clamp.

maximum(abs, residual_df.residual)

# ## Truncation composes
#
# A `Convolved` distribution is a `UnivariateDistribution`, so `Distributions.truncated` applies directly.
# Right truncation renormalises the density over the kept region, which is the correction needed when scoring against data observed only up to a cutoff.

d_trunc = truncated(d; upper = 10.0)
truncation_df = vcat(
    DataFrame(x = x, density = pdf(d, collect(x)),
        Distribution = "Convolved"),
    DataFrame(x = x, density = pdf.(d_trunc, x),
        Distribution = "Truncated at 10")
)
draw(
    data(truncation_df) *
    mapping(:x, :density, color = :Distribution) *
    visual(Lines, linewidth = 2);
    axis = (xlabel = "Delay (days)", ylabel = "Density")
)

# The truncated density is zero beyond the cutoff and sits above the untruncated density below it, since the removed tail mass is redistributed over the kept region.

# ## Timeseries convolution
#
# The timeseries form `convolve_series` convolves a numeric series with a delay PMF on the unit lag grid.
# The delay here is discrete, so its PMF reads straight off `pdf.(delay, 0:maxlag)` and convolves as a plain vector; on a non-unit or shifted lag grid you would pass a `DiscreteNonParametric` instead, whose support carries the grid.
# With the series an expected infection curve, the result is the expected downstream count curve, the renewal-style observation layer.

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

# ## Summary
#
# - Convolving two delays shifts and widens the density; the batched `pdf` and `cdf` methods evaluate a grid in one quadrature solve.
# - [`difference`](@ref) has two-sided support and its mass below zero is directly interpretable as an ordering probability.
# - Combinations compose: a [`Convolved`](@ref ConvolvedDistributions.Convolved) can be a component of another convolution or one side of a difference, and a nested convolution matches its flat equivalent.
# - Forcing the [`NumericSolver`](@ref) on an analytic pair reproduces the closed-form CDF to a few parts in a million.
# - `truncated` composes with a [`Convolved`](@ref ConvolvedDistributions.Convolved) distribution for scoring under right truncation.
# - The timeseries form turns an infection curve into an expected count curve through the discretised delay PMF.
