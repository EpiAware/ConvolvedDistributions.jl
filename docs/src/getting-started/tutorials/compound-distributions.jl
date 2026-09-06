# # [Compound distributions](@id compound-distributions)
#
# ## Introduction
#
# A [`Compound`](@ref) is the random-length member of the family: it builds `Z = X_1 + ... + X_N` for a count `N` on the non-negative integers and i.i.d. non-negative summands `X_i` independent of it, with `Z = 0` when `N = 0`.
# Where [`Convolved`](@ref ConvolvedDistributions.Convolved) (see [Convolving distributions](@ref convolving-distributions)) sums a fixed number of delays, a compound sums a random number of them, as when a Poisson number of clusters each contributes a Poisson number of cases, or a random number of claims each has a `Gamma` size.
# Nothing in a compound is quadrature: a lattice summand is evaluated by the exact Panjer recursion, and a `Gamma` or `Exponential` summand by an exact mixture of its n-fold closed forms.
#
# ### What are we going to do in this exercise
#
# 1. Overlay a count pmf, a summand pmf, and the pmf of their compound.
# 2. Check the Panjer recursion against a brute-force mixture computed by hand.
# 3. Look at the point mass at zero a continuous summand leaves under a count with mass at zero.
# 4. Compare the exact recursion with the Bernoulli-thinning closed form.
#
# ### What might I need to know before starting
#
# This tutorial builds on the [Getting started](@ref getting-started) overview and uses AlgebraOfGraphics.jl and CairoMakie.jl for plotting.
# No fitting or MCMC is involved; every quantity is a direct evaluation.

# ## Packages used

using ConvolvedDistributions, Distributions
using CairoMakie, AlgebraOfGraphics, DataFramesMeta

CairoMakie.activate!(type = "png", px_per_unit = 2)

# ## A count, a summand, and their random sum
#
# [`compound`](@ref) returns the distribution of `Z = X_1 + ... + X_N`.
# Here the count is the number of clusters and the summand the size of each, so the compound is the total number of cases.
# Both components are lattice-valued, so the compound is `Discrete`-typed and its `pdf` is a probability mass evaluated by the Panjer recursion.

clusters = Poisson(3.0)
cluster_size = Poisson(2.0)
total = compound(clusters, cluster_size)

k = 0:25
pmf_df = vcat(
    DataFrame(
        k = k, mass = pdf.(clusters, k),
        Distribution = "Clusters (Poisson)"
    ),
    DataFrame(
        k = k, mass = pdf.(cluster_size, k),
        Distribution = "Cluster size (Poisson)"
    ),
    DataFrame(
        k = k, mass = pdf.(total, k),
        Distribution = "Total cases (Compound)"
    )
)
draw(
    data(pmf_df) *
        mapping(:k, :mass, color = :Distribution, dodge = :Distribution) *
        visual(BarPlot);
    axis = (xlabel = "Count", ylabel = "Probability mass")
)

# The compound's mean is the product of the component means (Wald's identity), and its variance follows the law of total variance, so the compound is both larger and more dispersed than either component.

mean(total), mean(clusters) * mean(cluster_size), var(total)

# ## Checking the recursion against brute force
#
# The compound pmf is the mixture `Σ_n P(N = n) f^{*n}(k)` of the summand's n-fold convolutions.
# Building that mixture directly — iterating the discrete convolution and truncating the count far out in its tail — is slow but independent of the package's recursion, so it is a good check.

function brute_pmf(count, summand, kmax; nmax = 200)
    f = [pdf(summand, j) for j in 0:kmax]
    g = zeros(kmax + 1)
    g[1] += pdf(count, 0)
    fold = copy(f)
    for n in 1:nmax
        g .+= pdf(count, n) .* fold
        fold = [sum(f[j + 1] * fold[i - j + 1] for j in 0:i) for i in 0:kmax]
    end
    return g
end

reference = brute_pmf(clusters, cluster_size, last(k))
maximum(abs, pdf.(total, k) .- reference)

# The two agree to floating-point rounding: the Panjer recursion is exact, and [`is_exact`](@ref ConvolvedDistributions.is_exact) reports as much even though [`evaluation_path`](@ref ConvolvedDistributions.evaluation_path) says `:numeric` (there is no single closed-form object behind it).

ConvolvedDistributions.is_exact(total), ConvolvedDistributions.evaluation_path(total)

# ## The point mass at zero
#
# With a `Gamma` summand the compound is `Continuous`-typed: each `N = n` contributes a `Gamma(n * shape, scale)` and the density is the exact mixture of those closed forms.
# When the count can be zero, `Z = 0` with probability `P(N = 0)`, so the law is mixed: a point mass at zero next to a continuous density on `(0, ∞)`.
# The CDF carries the atom as a jump at zero, and by convention `pdf(d, 0)` returns the point mass itself.

claims = Poisson(3.0)
claim_size = Gamma(2.0, 1.0)
aggregate = compound(claims, claim_size)

pdf(aggregate, 0.0), cdf(aggregate, 0.0), pdf(claims, 0)

# The density on the positive half-line integrates to `1 - P(N = 0)`; the rest of the mass sits in the atom.

z = 0.0:0.05:25.0
atom_df = vcat(
    DataFrame(z = z, value = pdf.(aggregate, z), Quantity = "Density"),
    DataFrame(z = z, value = cdf.(aggregate, z), Quantity = "CDF")
)
draw(
    data(atom_df) *
        mapping(:z, :value, layout = :Quantity) *
        visual(Lines, linewidth = 2);
    axis = (xlabel = "Aggregate size", ylabel = "Value"),
    facet = (; linkyaxes = :none)
)

# The density panel starts at the atom's mass rather than at zero because `pdf(d, 0)` is the point mass; the CDF panel starts at that same height, the jump the atom makes.
# A midpoint-rule integral of the density on `(0, 40]` plus the atom recovers essentially all of the mass.

dz = 0.01
grid = (dz / 2):dz:40.0
sum(pdf.(aggregate, grid)) * dz + pdf(aggregate, 0.0)

# ## The thinning closed form
#
# A `Bernoulli(q)` summand thins the count: a `Poisson(λ)` number of events each kept independently with probability `q` is `Poisson(λ q)`, and the same identity holds for `Binomial`, `NegativeBinomial`, and `Geometric` counts.
# The default [`AnalyticalSolver`](@ref) uses the closed form; passing [`NumericSolver`](@ref) forces the Panjer recursion on the same pair, which lets us check the recursion against the exact answer.

thinned = compound(Poisson(2.0), Bernoulli(0.3))
thinned_numeric = compound(Poisson(2.0), Bernoulli(0.3); method = NumericSolver())

ConvolvedDistributions.evaluation_path(thinned),
    ConvolvedDistributions.evaluation_path(thinned_numeric)

# The recursion reproduces the closed form to rounding.

ks = 0:10
maximum(abs, pdf.(thinned_numeric, ks) .- pdf.(Poisson(0.6), ks))

# ## Summary
#
# - `compound` builds the random sum `X_1 + ... + X_N`; its mean and variance are the exact laws of total expectation and variance.
# - A lattice summand is evaluated by the exact Panjer recursion (checked here against a brute-force mixture); a `Gamma`/`Exponential` summand by an exact mixture of n-fold closed forms.
# - A continuous summand under a count with mass at zero gives a point mass at zero: the CDF carries it and `pdf(d, 0)` returns it.
# - The Bernoulli-thinning identities are the closed forms, and forcing the [`NumericSolver`](@ref) reproduces them to rounding.
#
# See also: [Convolving distributions](@ref convolving-distributions), [The difference of two delays](@ref difference-distributions), [The product of two delays](@ref product-distributions), [Convolving a timeseries](@ref timeseries-convolution).
