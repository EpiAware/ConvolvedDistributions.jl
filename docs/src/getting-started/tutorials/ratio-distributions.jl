# # [The ratio of two delays](@id ratio-distributions)
#
# ## Introduction
#
# A [`Ratio`](@ref) is the quotient member of the family: it builds `Z = X / Y` for independent `X` and `Y`, as when a rate, a proportion, or a normalised measurement is formed from two independent uncertain quantities.
# Where [`Convolved`](@ref) sums two delays (see [Convolving distributions](@ref convolving-distributions)), [`Difference`](@ref) takes their signed gap (see [The difference of two delays](@ref difference-distributions)), and [`Product`](@ref) scales one by the other, a ratio divides one by the other.
#
# ### What are we going to do in this exercise
#
# 1. Overlay two component densities with their ratio density.
# 2. Recognise a Gamma/Gamma ratio as a scaled Beta-Prime closed form and check the numeric path reproduces it.
# 3. Compare the analytic and numeric solver CDFs for the same pair and plot their residual.
#
# ### What might I need to know before starting
#
# This tutorial builds on the [Getting started](@ref getting-started) overview and uses AlgebraOfGraphics.jl and CairoMakie.jl for plotting.
# No fitting or MCMC is involved; every quantity is a direct evaluation.
# Unlike [`product`](@ref), a [`ratio`](@ref) denominator may not carry probability mass at zero, and either component may otherwise have two-sided support.

# ## Packages used

using ConvolvedDistributions, Distributions
using CairoMakie, AlgebraOfGraphics, DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)

# ## Two components and their ratio
#
# [`ratio`](@ref) returns the distribution of `Z = X / Y`, here an incubation period divided by a reporting delay.
# The denominator must not carry probability mass at zero (`Gamma` does not), so the construction is valid.
# The shared x-axis below is labelled "Value" rather than "Delay (days)": only the numerator and denominator curves are delays, while the ratio itself sits on a rate-like scale.

incubation = Gamma(2.0, 1.0)
reporting = Gamma(1.5, 1.0)
z_dist = ratio(incubation, reporting)

x = 0.0:0.05:12.0
components_df = vcat(
    DataFrame(
        x = x, density = pdf.(incubation, x),
        Distribution = "Incubation (Gamma)"
    ),
    DataFrame(
        x = x, density = pdf.(reporting, x),
        Distribution = "Reporting (Gamma)"
    ),
    DataFrame(
        x = x, density = pdf(z_dist, collect(x)),
        Distribution = "Ratio"
    )
)
draw(
    data(components_df) *
        mapping(:x, :density, color = :Distribution) *
        visual(Lines, linewidth = 2);
    axis = (xlabel = "Value", ylabel = "Density")
)

# Dividing one positive delay by another puts the ratio density on a positive axis with a different shape than either component: the mass concentrates around the typical multiple of the numerator per denominator unit, and it is heavier-tailed than the components it came from.

mean(z_dist)

# ## A Gamma ratio is a scaled Beta-Prime
#
# The `Gamma`/`Gamma` pair has a closed form: `Gamma(αₓ, θₓ) / Gamma(αᵧ, θᵧ)` is `(θₓ / θᵧ) * BetaPrime(αₓ, αᵧ)`.
# So a rate formed from two independent Gamma quantities is simply a scaled Beta distribution of the second kind, and `mean`, `var` and the CDF all delegate to that closed form rather than going through quadrature.
# The raw formula for our pair is `(1.0 / 1.0) * BetaPrime(3.0, 2.0)`: both scales are 1.0, so the `θₓ / θᵧ` prefix is exactly 1.
# Forcing the [`NumericSolver`](@ref) on the same pair exercises the quadrature path, which we overlay on the closed form.

num = Gamma(3.0, 1.0)
den = Gamma(2.0, 1.0)
d_rate = ratio(num, den)
d_numeric = ratio(num, den; method = NumericSolver())
closed_form = (1.0 / 1.0) * BetaPrime(3.0, 2.0)

g = 0.05:0.05:8.0
closed_df = vcat(
    DataFrame(
        x = g, density = pdf(d_numeric, collect(g)),
        Source = "Numeric (quadrature)"
    ),
    DataFrame(
        x = g, density = pdf(closed_form, collect(g)),
        Source = "Closed form"
    )
)
draw(
    data(closed_df) *
        mapping(:x, :density, color = :Source, linestyle = :Source) *
        visual(Lines, linewidth = 2);
    axis = (xlabel = "Value", ylabel = "Density")
)

# The two curves lie exactly on top of each other: the numeric quadrature reproduces the scaled-Beta-Prime closed form to floating-point precision.
# The ratio's mean exists here and equals the closed form's own mean, because the delegating `mean` passes straight through to the BetaPrime.

mean(d_rate), mean(closed_form)

# ## Analytic and numeric solvers agree
#
# The default [`AnalyticalSolver`](@ref) reads off the closed form for the `Gamma`/`Gamma` pair, while passing [`NumericSolver`](@ref) forces the quadrature path on the same pair, which lets us check the numeric machinery against the exact answer.

d_analytic = ratio(num, den)
d_solver_numeric = ratio(num, den; method = NumericSolver())

xs = 0.05:0.05:8.0
solver_df = vcat(
    DataFrame(
        x = xs, cdf = cdf(d_analytic, collect(xs)),
        Solver = "Analytic (closed form)"
    ),
    DataFrame(
        x = xs, cdf = cdf(d_solver_numeric, collect(xs)),
        Solver = "Numeric (quadrature)"
    )
)
draw(
    data(solver_df) *
        mapping(:x, :cdf, color = :Solver, linestyle = :Solver) *
        visual(Lines, linewidth = 2);
    axis = (xlabel = "Value", ylabel = "CDF")
)

# The two curves lie on top of each other, so we plot the residual to see the actual size of the quadrature error.

residual_df = DataFrame(
    x = xs,
    residual = cdf(d_solver_numeric, collect(xs)) .- cdf(d_analytic, collect(xs))
)
draw(
    data(residual_df) *
        mapping(:x, :residual) *
        visual(Lines, linewidth = 2);
    axis = (
        xlabel = "Value",
        ylabel = "Numeric CDF - analytic CDF",
    )
)

# The largest absolute residual across the grid is a few parts in ten billion, the size of the fixed-node quadrature error.

maximum(abs, residual_df.residual)

# ## Summary
#
# - [`ratio`](@ref) divides one delay by another, and the result sits on a one-sided, rate-like scale with a different shape than either component.
# - The `Gamma`/`Gamma` pair is exactly a scaled Beta-Prime, so its mean and CDF come from the closed form while the [`NumericSolver`](@ref) reproduces it.
# - Forcing the [`NumericSolver`](@ref) on an analytic `Gamma`/`Gamma` pair reproduces the closed-form CDF to a few parts in ten billion.
#
# See also: [Convolving distributions](@ref convolving-distributions), [The difference of two delays](@ref difference-distributions), [The product of two delays](@ref product-distributions), [Convolving a timeseries](@ref timeseries-convolution).
