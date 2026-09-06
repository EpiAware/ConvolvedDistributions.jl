@doc "

Distribution of a random sum of independent random variables (a compound
distribution).

`Compound` represents ``Z = X_1 + X_2 + \\dots + X_N`` where `N` (the
count) is a discrete distribution on the non-negative integers and the
``X_i`` (the summands) are independent, identically distributed with
non-negative support, and independent of `N`; `Z = 0` when `N = 0`. It
is the random-length member of the family: where [`Convolved`](@ref)
sums a fixed number of delays, a compound sums a random number of them,
as when a cluster size, an aggregate claim, or a total of secondary
cases is formed from independently sized pieces.

`N` must be an integer-lattice discrete distribution with
`minimum(count) >= 0`, and the summand must have non-negative support:
the constructor throws an `ArgumentError` naming the offending family
otherwise (negative summands are future work). A continuous summand
must also belong to a family closed under convolution, one with a
registered [`convolve_power`](@ref) closed form (`Gamma` and
`Exponential` among the built-ins; `Normal` is already excluded by the
non-negativity rule) — see *Density and CDF computation* below.

# Value support

`S` is derived from the summand alone: `Discrete` when the summand is
an integer-lattice discrete distribution (a random sum of lattice
variables stays on the lattice), `Continuous` otherwise. The count is
not a summand and never enters this derivation; it is integer-lattice
discrete by construction.

# Independence

The construction assumes the ``X_i`` are i.i.d. and independent of
`N`. The density, CDF, mean and variance below all rely on this; they
are not correct for a count that depends on the summands.

# Density and CDF computation

Conditioning on `N = n` gives the mixture of `n`-fold convolutions

```math
f_Z(z) = \\sum_{n \\ge 0} \\mathbb{P}(N = n)\\, f_X^{*n}(z) ,
\\qquad
F_Z(z) = \\sum_{n \\ge 0} \\mathbb{P}(N = n)\\, F_X^{*n}(z) ,
```

and every route in this member evaluates that mixture exactly. There is
no quadrature route: a summand that would need one is rejected at
construction.

For a `Discrete`-typed compound the pmf comes from a recursion on the
lattice. When the count is in the `(a, b, 0)` class (`Poisson`,
`Binomial`, `NegativeBinomial`, `Geometric`) the Panjer recursion

```math
g_0 = \\mathrm{pgf}_N(f_0) ,
\\qquad
g_z = \\frac{1}{1 - a f_0} \\sum_{j = 1}^{z} \\left(a + \\frac{b j}{z}\\right)
      f_j\\, g_{z - j}
```

gives ``g_0, \\dots, g_z`` in one ``O(z^2)`` pass, exact for any summand
supported in ``\\{0, 1, 2, \\dots\\}``. Any other count (a
`DiscreteNonParametric` on integers, a nested `Compound`) sums the
mixture directly over `n`, with the `n`-fold pmfs built by iterated
discrete convolution; that sum is finite and exact when
`minimum(summand) >= 1` (only ``n \\le z`` contribute), and is
otherwise truncated at the count's ``1 - 10^{-8}`` quantile, the same
tail clamp the quadrature windows apply and [`is_exact`](@ref) already
tolerates. Both routes return zero mass beyond the lattice point past
which the CDF is one to within that clamp, so an evaluation far out in
the tail stays cheap.

For a `Continuous`-typed compound each `n`-fold convolution is the
registered `convolve_power(summand, n)` closed form, so the density and
CDF are finite mixtures of closed forms, truncated at the count's
``1 - 10^{-8}`` quantile in the same way. This is why [`is_exact`](@ref)
reports `true` for every `Compound`, the `Continuous`-typed ones
included, where the other members' continuous route is Gauss-Legendre
quadrature. [`evaluation_path`](@ref) still reports `:numeric` for both
routes, as it does for the lattice folds, since neither is a single
closed-form object.

Four pairs have closed forms, the Bernoulli-thinning identities: a
`Bernoulli(q)` summand thins `Poisson(λ)` to `Poisson(λ q)`,
`Binomial(n, p)` to `Binomial(n, p q)`, and `NegativeBinomial(r, p)`
or `Geometric(p)` to the same family with success probability
`p / (1 - (1 - p)(1 - q))`. They are registered on
[`compound_pair`](@ref).

The `method` field selects the backend: an [`AnalyticalSolver`](@ref)
(the default) uses the closed form where one exists and the exact
recursion otherwise, while a [`NumericSolver`](@ref) forces the
recursion even for a thinning pair (useful for validation).

# The atom at zero

When ``\\mathbb{P}(N = 0) > 0`` and the summand is continuous, `Z` is a
mixed law: a point mass ``\\mathbb{P}(N = 0)`` at zero next to a
continuous density on ``(0, \\infty)``. The atom is a genuine feature
of the law, so it is admitted rather than rejected. `cdf(d, 0)` equals
`pdf(count, 0)` and the CDF carries the atom from there; `pdf(d, z)`
for `z > 0` is the continuous density; and, by convention, `pdf(d, 0)`
returns the point mass ``\\mathbb{P}(N = 0)`` (`logpdf(d, 0)` its log)
rather than a density value. For a `Discrete`-typed compound the atom
is just the ordinary pmf at zero.

# Nesting

A `Discrete`-typed compound nests freely in another combination's
exact lattice fold, and a `Continuous`-typed one whose count puts no
mass at zero nests in another combination's numeric quadrature (its
effective-support window is bounded through the `n`-fold
`convolve_power` forms). A `Continuous`-typed compound carrying the
atom cannot: the quadrature would miss the point mass, so nesting it
throws an `ArgumentError` naming the situation rather than silently
dropping the atom. Used as the outermost distribution, a `Compound` has
no such restriction.

# Duck-typed components

Either component may be duck-typed, implementing the Distributions.jl
univariate interface without subtyping `UnivariateDistribution`. A
duck-typed count must define `Base.eltype` as an `Integer` type, since
that is how its support is read (Base's fallback `Any` reads as
continuous and is rejected); a duck-typed discrete summand needs the
same to reach the lattice recursion, and a duck-typed continuous
summand needs a [`convolve_power`](@ref) method.

# See also
- [`compound`](@ref): Constructor function
- [`Convolved`](@ref): The fixed-length sum ``X + Y``
- [`Difference`](@ref): The signed gap ``X - Y``
- [`Product`](@ref): The product ``X Y``
- [`Ratio`](@ref): The quotient ``X / Y``
- [`compound_pair`](@ref): The closed-form registry
- [`pgf`](@ref): The generating-function composition
"
struct Compound{
        N, X, M <: AbstractSolverMethod, S <: Distributions.ValueSupport,
    } <:
    AbstractConvolvedDistribution{Distributions.Univariate, S}
    "The count law `N`, a discrete distribution on the non-negative integers."
    count::N
    "The summand law of each `X_i`, with non-negative support."
    summand::X
    "Solver method choosing the closed-form vs exact-recursion backend."
    method::M

    function Compound(
            count::N, summand::X;
            method::AbstractSolverMethod = AnalyticalSolver()
        ) where {N, X}
        _check_component(count)
        _check_component(summand)
        _check_count(count)
        _check_summand(summand)
        S = _component_support(X)
        _check_summand_route(S, summand)
        return new{N, X, typeof(method), S}(count, summand, method)
    end
end

# Discrete-typed alias: matches only when the summand is an
# integer-lattice discrete distribution (see `_component_support` in
# `src/interface.jl`). Used to dispatch to the exact lattice recursion.
const _DiscreteCompound = Compound{
    <:Any, <:Any, <:AbstractSolverMethod, Discrete,
}

# Continuous-typed alias: the summand is a `convolve_power` family, so
# the density and CDF are finite mixtures of its `n`-fold closed forms.
const _ContinuousCompound = Compound{
    <:Any, <:Any, <:AbstractSolverMethod, Continuous,
}

# The count must be an integer-lattice discrete distribution on the
# non-negative integers: the recursion below indexes its masses by a
# non-negative integer `n`, and a count with mass below zero has no
# meaning as a number of summands. Checked at construction (from the
# inner constructor, so `Compound(...)` cannot bypass it), matching
# `Product`'s construction-time rejection of sign-crossing supports. A
# duck-typed count is read through `Base.eltype`, as every duck-typed
# component is.
function _check_count(count)
    ok = _component_support(typeof(count)) === Discrete && minimum(count) >= 0
    ok || throw(
        ArgumentError(
            "compound requires a count on the non-negative integers (an " *
                "integer-lattice discrete distribution with minimum(count) " *
                ">= 0), but $(nameof(typeof(count))) is not one; a " *
                "duck-typed count must define Base.eltype as an Integer type"
        )
    )
    return nothing
end

# The summand must have non-negative support: with negative summands
# the random sum is unbounded below and the lattice recursion (which
# runs upward from zero) and the non-negative `convolve_power` families
# both stop applying.
function _check_summand(summand)
    minimum(summand) >= 0 || throw(
        ArgumentError(
            "compound requires a summand with non-negative support " *
                "(minimum(summand) >= 0), but $(nameof(typeof(summand))) " *
                "reaches below zero; negative summands are future work"
        )
    )
    return nothing
end

# A continuous summand needs an exact `n`-fold route, i.e. a registered
# `convolve_power` closed form, because this member has no quadrature
# route to fall back on: a grid-discretised summand would need one.
# Dispatched on the derived value support so the check folds away for a
# discrete summand.
_check_summand_route(::Type{Discrete}, summand) = nothing
function _check_summand_route(::Type{Continuous}, summand)
    _summand_power(summand, 2) === nothing && throw(
        ArgumentError(
            "compound with a continuous summand needs a family with a " *
                "registered convolve_power closed form for its n-fold sums " *
                "(Gamma or Exponential among the built-ins), but " *
                "$(nameof(typeof(summand))) has none; use one of those, or " *
                "a discrete summand -- a grid-discretised route is future work"
        )
    )
    return nothing
end

# The `n`-fold closed form of the summand, or `nothing`. The
# `convolve_power` fallback is typed on `UnivariateDistribution`, so a
# duck-typed summand is asked through `applicable` rather than reaching
# a `MethodError`: no method reads as "none registered".
_summand_power(summand::UnivariateDistribution, n::Integer) =
    convolve_power(summand, n)
function _summand_power(summand, n::Integer)
    applicable(convolve_power, summand, n) || return nothing
    return convolve_power(summand, n)
end

@doc "

Create the distribution of a random sum of independent variables.

Returns a [`Compound`](@ref) representing ``Z = X_1 + \\dots + X_N``,
the random-length member of the family: where [`convolved`](@ref) sums
a fixed number of delays, a compound sums a random number `N` of i.i.d.
copies of one summand, with `Z = 0` when `N = 0`. The count must be an
integer-lattice discrete distribution on the non-negative integers and
the summand must have non-negative support (`ArgumentError`, naming the
family, otherwise); a continuous summand must additionally have a
registered [`convolve_power`](@ref) closed form.

The summands are assumed i.i.d. and independent of `N`.

# Arguments
- `count`: The count distribution (the `N` in `Z = X_1 + ... + X_N`),
  an integer-lattice discrete distribution with `minimum(count) >= 0`.
- `summand`: The summand distribution (the law of each `X_i`), with
  non-negative support.

# Keyword Arguments
- `method`: The solver method, an [`AnalyticalSolver`](@ref) (the
  default) or [`NumericSolver`](@ref). `NumericSolver` forces the exact
  recursion even for a registered thinning pair, mirroring `convolved`.
- `strict`: When `true`, error (naming the component families) rather
  than silently return an object without an exact route. Every
  `Compound` has one (see the [`Compound`](@ref) docstring), so this is
  accepted for symmetry with the other constructors. See
  [`evaluation_path`](@ref) to check the route after construction.

# Returns
- A [`Compound`](@ref) distribution of the random sum
  `Z = X_1 + ... + X_N`.

# Examples
```@example
using ConvolvedDistributions, Distributions

# Total secondary cases: a Poisson number of clusters, each Poisson-sized.
d = compound(Poisson(3.0), Poisson(2.0))
mean(d), pdf(d, 4)
```

# See also
- [`Compound`](@ref): The distribution type
- [`convolved`](@ref): The fixed-length sum ``X + Y``
- [`difference`](@ref): The signed gap ``X - Y``
- [`product`](@ref): The product ``X Y``
- [`ratio`](@ref): The quotient ``X / Y``
- [`evaluation_path`](@ref): Check the route without asserting it.
"
function compound(
        count, summand;
        method::AbstractSolverMethod = AnalyticalSolver(), strict::Bool = false
    )
    return _check_strict(Compound(count, summand; method = method), strict)
end

# The component-family names for a `strict = true` construction error
# (see `_check_strict` in interface.jl).
function _family_names(d::Compound)
    return (nameof(typeof(d.count)), nameof(typeof(d.summand)))
end

# Both routes are exact up to the documented tail clamp: the lattice
# recursion is the `Discrete` default already, and the `Continuous`
# route is a finite mixture of `convolve_power` closed forms rather
# than the Gauss-Legendre quadrature the other members' continuous
# route is, so it is declared exact here too. Only the `Continuous`
# alias is extended: a method on the bare `Compound` would be ambiguous
# with the `Discrete`-typed abstract default in interface.jl.
_exact_discrete_route(::_ContinuousCompound) = true

# ---------------------------------------------------------------------------
# Interface: params / support / sampling
# ---------------------------------------------------------------------------

params(d::Compound) = (params(d.count), params(d.summand))

# The element type of the SUM of summands, not the summand's own
# element type: `Base.promote_op(+, ...)` infers what `+` actually
# produces (a `Bernoulli` summand has `eltype` `Bool`, but two of them
# sum to an `Int`, and `rand(rng, d, n)` allocates `Array{eltype(d)}`).
function Base.eltype(::Type{<:Compound{N, X}}) where {N, X}
    return Base.promote_op(+, eltype(X), eltype(X))
end

# With non-negative summands the sum is monotone in both the count and
# each summand, so the ends multiply. `N = 0` gives `Z = 0`, which is
# exactly the `0 * minimum(summand)` corner when the count reaches zero;
# the maximum guards the indeterminate `0 * Inf` (a degenerate zero
# count with an unbounded summand) as `_ratio_bound` does.
minimum(d::Compound) = minimum(d.count) * minimum(d.summand)

maximum(d::Compound) = _ratio_bound(maximum(d.count), maximum(d.summand))

function insupport(d::Compound, z::Real)
    return _on_lattice(d, z) && minimum(d) <= z <= maximum(d)
end

# Draw the count, then sum that many summand draws. The accumulator is
# seeded from `zero(eltype(d))` so a zero count returns a typed zero
# and the loop stays type-stable across `Int`/`Float64` summands.
function Base.rand(rng::AbstractRNG, d::Compound)
    n = rand(rng, d.count)
    acc = zero(eltype(d))
    for _ in 1:n
        acc += rand(rng, d.summand)
    end
    return acc
end

sampler(d::Compound) = d

# ---------------------------------------------------------------------------
# Moments: exact by the laws of total expectation and total variance
# ---------------------------------------------------------------------------

@doc "

Mean of the random sum, `mean(count) * mean(summand)` by the law of
total expectation (Wald's identity). Exact; no quadrature.

See also: [`var`](@ref), [`std`](@ref)
"
mean(d::Compound) = mean(d.count) * mean(d.summand)

@doc "

Variance of the random sum,
`mean(count) * var(summand) + var(count) * mean(summand)^2` by the law
of total variance. Exact; no quadrature.

See also: [`mean`](@ref), [`std`](@ref)
"
function var(d::Compound)
    μ = mean(d.summand)
    return mean(d.count) * var(d.summand) + var(d.count) * μ^2
end

@doc "

Standard deviation of the random sum, the square root of [`var`](@ref).

See also: [`var`](@ref), [`mean`](@ref)
"
std(d::Compound) = sqrt(var(d))

# ---------------------------------------------------------------------------
# Analytical fast paths
# ---------------------------------------------------------------------------

# `compound_pair` (solver_dispatch.jl) is the analytic-pair hook: the
# Bernoulli-thinning identities for a `Poisson`, `Binomial`,
# `NegativeBinomial` or `Geometric` count.

# The analytic compound distribution to use for `d`, or `nothing` when
# none exists or when `d.method` is a `NumericSolver` requesting the
# exact recursion.
function _maybe_analytic(d::Compound)
    d.method isa NumericSolver && return nothing
    return compound_pair(d.count, d.summand)
end

# ---------------------------------------------------------------------------
# Tail clamp: how many count terms, and how far along the lattice
# ---------------------------------------------------------------------------

# The largest count value the mixtures below sum to: the count's
# `1 - _CONVOLVED_TAIL` quantile (AD-stripped through `_window_quantile`,
# exactly as every quadrature window is), trimming at most
# `_CONVOLVED_TAIL` of the count's mass; at least one term so the
# accumulators can always seed from `n = 1`. A count with finite support
# (`Binomial`) is never overshot: its quantile is at most its maximum.
function _compound_nmax(count)
    return max(1, round(Int, _window_quantile(count, 1 - _CONVOLVED_TAIL)))
end

# Lattice point beyond which the `Discrete` routes report zero mass and
# CDF one. On `{N <= n_hi}` the sum is at most `n_hi` times the largest
# summand, and the largest of `n_hi` i.i.d. summands exceeds the
# summand's `1 - _CONVOLVED_TAIL / n_hi` quantile with probability at
# most `_CONVOLVED_TAIL` (union bound), so the mass beyond `n_hi * x_hi`
# is at most `2 * _CONVOLVED_TAIL`. Without this cap an evaluation at a
# far-tail point would allocate and fill a lattice vector of that
# length, where the other members' folds return a typed zero once their
# clamped window is empty. The bound is a primal `Float64` (both
# quantiles are `_window_quantile`-stripped) and is compared, never
# converted to an `Int`, so the sentinel `_window_quantile` returns on
# a failed inversion cannot overflow it.
function _compound_lattice_cap(d::Compound)
    n_hi = _compound_nmax(d.count)
    x_hi = _window_quantile(d.summand, 1 - _CONVOLVED_TAIL / n_hi)
    return n_hi * x_hi
end

# ---------------------------------------------------------------------------
# Exact lattice recursion (`Discrete`-typed compound)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_DiscreteCompound` (integer-lattice discrete
# summand). The summand is non-negative by construction, so its support
# lies in `0, 1, 2, ...`, and so does the sum's.

# The `(a, b)` of a count in the Panjer `(a, b, 0)` class, i.e. one
# whose masses satisfy `P(N = n) = (a + b / n) P(N = n - 1)` for
# `n >= 1`, or `nothing` for any other count (which takes the direct
# mixture route below). Dispatch, not a runtime lookup, so the route
# choice folds away per count type.
_panjer_ab(count) = nothing

function _panjer_ab(count::Poisson)
    λ, = params(count)
    return zero(λ), λ
end

# Binomial(n, p): P(k) / P(k - 1) = (n - k + 1) / k * p / (1 - p).
function _panjer_ab(count::Binomial)
    n, p = params(count)
    r = p / (1 - p)
    return -r, (n + 1) * r
end

# NegativeBinomial(r, p) in the Distributions.jl parameterisation
# (failures before `r` successes, success probability `p`):
# P(k) / P(k - 1) = (k + r - 1) / k * (1 - p).
function _panjer_ab(count::NegativeBinomial)
    r, p = params(count)
    return 1 - p, (r - 1) * (1 - p)
end

# Geometric(p) is NegativeBinomial(1, p): P(k) / P(k - 1) = 1 - p.
function _panjer_ab(count::Geometric)
    p, = params(count)
    return 1 - p, zero(p)
end

# The summand masses `f_0, ..., f_zmax` as a plain `Vector`. A
# comprehension (not a preallocated `TrackedArray`) so that under
# ReverseDiff the elements are `TrackedReal`s in an ordinary `Vector`,
# which the recursions below may index and the accumulators may read
# without ever calling `setindex!` on tracked storage.
_summand_masses(summand, zmax::Int) = [pdf_ad_safe(summand, j) for j in 0:zmax]

# The Panjer recursion, `g_0, ..., g_zmax` in one pass:
#   g_0 = pgf_N(f_0),
#   g_z = (1 - a f_0)^{-1} Σ_{j = 1}^{z} (a + b j / z) f_j g_{z - j}.
# Exact for any summand support in the non-negative integers: only
# `f_j`, `j <= z`, enter `g_z`. The element type is promoted from every
# input once (`T`), and each `g_z` accumulator is seeded from its `j = 1`
# term, so `Dual`s and tracked reals from the count parameters (`a`,
# `b`, the pgf) and the summand masses all propagate. The lattice
# indices are primal `Int`s and never reach the tape.
function _panjer_pmf(count, summand, a, b, zmax::Int)
    f = _summand_masses(summand, zmax)
    f0 = f[1]
    g0 = pgf(count, f0)
    scale = inv(1 - a * f0)
    T = typeof((a + b) * f0 * g0 * scale)
    g = Vector{T}(undef, zmax + 1)
    g[1] = g0
    for z in 1:zmax
        acc = (a + b / z) * f[2] * g[z]
        for j in 2:z
            acc += (a + b * j / z) * f[j + 1] * g[z + 1 - j]
        end
        g[z + 1] = acc * scale
    end
    return g
end

# The direct mixture `g_z = Σ_{n = 0}^{nmax} P(N = n) f^{*n}(z)` for a
# count outside the `(a, b, 0)` class, with the `n`-fold pmfs built by
# iterated discrete convolution on the lattice `0:zmax` (each fold only
# needs the previous one, so two vectors are live at a time). `f^{*0}`
# is the unit mass at zero. Every accumulator seeds from its first term
# and the vectors are plain `Vector{T}`s, as in `_panjer_pmf`.
function _mixture_pmf(count, summand, zmax::Int, nmax::Int)
    f = _summand_masses(summand, zmax)
    p0 = pdf_ad_safe(count, 0)
    unit = one(f[1])
    T = typeof(p0 * f[1])
    g = Vector{T}(undef, zmax + 1)
    g[1] = p0 * unit
    for z in 1:zmax
        g[z + 1] = p0 * zero(f[1])
    end
    cur = [unit * fj for fj in f]
    for n in 1:nmax
        pn = pdf_ad_safe(count, n)
        for z in 0:zmax
            g[z + 1] += pn * cur[z + 1]
        end
        n == nmax && break
        nxt = Vector{T}(undef, zmax + 1)
        for z in 0:zmax
            acc = f[1] * cur[z + 1]
            for j in 1:z
                acc += f[j + 1] * cur[z + 1 - j]
            end
            nxt[z + 1] = acc
        end
        cur = nxt
    end
    return g
end

# How many count terms the direct mixture sums: exactly `zmax` when the
# summand is bounded away from zero (`f^{*n}(z) = 0` for `n > z`, so the
# mixture is finite and exact with no clamp), the count's tail-clamped
# quantile otherwise.
function _mixture_nmax(d::Compound, zmax::Int)
    minimum(d.summand) >= 1 && return zmax
    return _compound_nmax(d.count)
end

# `g_0, ..., g_zmax` by whichever recursion the count admits.
function _compound_pmf(d::Compound, zmax::Int)
    ab = _panjer_ab(d.count)
    ab === nothing &&
        return _mixture_pmf(d.count, d.summand, zmax, _mixture_nmax(d, zmax))
    return _panjer_pmf(d.count, d.summand, ab[1], ab[2], zmax)
end

# P(Z = z) on the lattice; zero off it, outside the support, and beyond
# the tail-clamp cap (see `_compound_lattice_cap`).
function _compound_lattice_pdf(d::Compound, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    insupport(d, z) || return zero(float(typeof(z)))
    zp = Float64(primal(z))
    zp > _compound_lattice_cap(d) && return zero(float(typeof(z)))
    zi = Int(zp)
    g = _compound_pmf(d, zi)
    return max(g[zi + 1], zero(g[zi + 1]))
end

# F_Z(z) = Σ_{k = 0}^{floor(z)} g_k, a step function between lattice
# points; one beyond the tail-clamp cap. The running sum seeds from
# `g_0`.
function _compound_lattice_cdf(d::Compound, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z < minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))
    zp = Float64(primal(z))
    zp >= _compound_lattice_cap(d) && return one(float(typeof(z)))
    zi = floor(Int, zp)
    g = _compound_pmf(d, zi)
    acc = g[1]
    for i in 2:(zi + 1)
        acc += g[i]
    end
    return clamp(acc, zero(acc), one(acc))
end

# ---------------------------------------------------------------------------
# Exact mixture of `n`-fold closed forms (`Continuous`-typed compound)
# ---------------------------------------------------------------------------
#
# Only reachable for a `_ContinuousCompound`: construction guaranteed
# `convolve_power(summand, n)` exists, so each conditional law given
# `N = n >= 1` is a closed-form distribution and the mixture is summed
# term by term. The `n = 0` term is the atom at zero (see the type
# docstring), carried by the CDF and, by convention, returned by the
# density exactly at zero.

# The `n`-fold closed form, `n >= 1`. Construction has already checked
# it exists for this summand, so the `nothing` arm is unreachable here;
# it is typed away rather than tested so the mixture stays inferrable.
_compound_fold(summand, n::Int) = _summand_power(summand, n)

function _compound_mixture_pdf(d::Compound, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    insupport(d, z) || return zero(float(typeof(z)))
    iszero(z) && return pdf_ad_safe(d.count, 0)
    nmax = _compound_nmax(d.count)
    acc = pdf_ad_safe(d.count, 1) * pdf_ad_safe(_compound_fold(d.summand, 1), z)
    for n in 2:nmax
        acc += pdf_ad_safe(d.count, n) *
            pdf_ad_safe(_compound_fold(d.summand, n), z)
    end
    return max(acc, zero(acc))
end

# F_Z(z) = P(N = 0) + Σ_{n >= 1} P(N = n) F_X^{*n}(z): the atom plus the
# mixture, seeded together from the `n = 0` and `n = 1` terms so the
# accumulator's type is fixed before the loop.
function _compound_mixture_cdf(d::Compound, z::Real)
    isnan(z) && return convert(float(typeof(z)), NaN)
    z < minimum(d) && return zero(float(typeof(z)))
    z >= maximum(d) && return one(float(typeof(z)))
    nmax = _compound_nmax(d.count)
    acc = pdf_ad_safe(d.count, 0) +
        pdf_ad_safe(d.count, 1) * cdf_ad_safe(_compound_fold(d.summand, 1), z)
    for n in 2:nmax
        acc += pdf_ad_safe(d.count, n) *
            cdf_ad_safe(_compound_fold(d.summand, n), z)
    end
    return clamp(acc, zero(acc), one(acc))
end

# ---------------------------------------------------------------------------
# Route selection: lattice recursion vs closed-form mixture
# ---------------------------------------------------------------------------
#
# Dispatch on the derived value-support parameter, as the other members
# do, so the route is a compile-time choice per type and `is_exact`'s
# report cannot drift from the route actually executed.

_compound_pdf_route(d::_DiscreteCompound, z::Real) = _compound_lattice_pdf(d, z)
_compound_pdf_route(d::Compound, z::Real) = _compound_mixture_pdf(d, z)

_compound_cdf_route(d::_DiscreteCompound, z::Real) = _compound_lattice_cdf(d, z)
_compound_cdf_route(d::Compound, z::Real) = _compound_mixture_cdf(d, z)

# ---------------------------------------------------------------------------
# Nesting: composite window quantile (issue #45 style)
# ---------------------------------------------------------------------------

# With non-negative summands `Z <= S_n` on `{N <= n}` and `Z >= S_n` on
# `{N >= n}`, where `S_n` is the fixed `n`-fold sum, so the `p`-quantile
# of `S_n` at `n` the count's own `p`-quantile bounds the compound's
# `p`-quantile on either side by a union bound, trimming at most
# `2 * _CONVOLVED_TAIL` — the additive analogue of the composite
# `_window_quantile` methods of `Convolved` and `Product`. `S_n`'s
# quantile is the registered `convolve_power` form's own when the
# summand has one (always, for a `Continuous`-typed compound; e.g. a
# `Poisson` summand too) and otherwise `n` times the summand's quantile,
# which over-covers by a further union bound over the `n` summands. A
# `Continuous`-typed compound with mass at `N = 0` throws instead: it
# carries an atom at zero that an outer quadrature would miss, so it
# cannot be a component of one (used as the outermost distribution it
# is unaffected). `@noinline` so the per-backend AD rules attach to the
# call site, as for every `_window_quantile` method.
@noinline function _window_quantile(d::Compound, p::Real)
    _compound_nestable(d) || _throw_compound_window(d)
    n = round(Int, _window_quantile(d.count, p))
    n < 1 && return zero(float(p))
    power = _summand_power(d.summand, n)
    return _compound_fold_quantile(d.summand, power, n, p)
end

_compound_fold_quantile(summand, ::Nothing, n::Int, p::Real) =
    n * _window_quantile(summand, p)
_compound_fold_quantile(summand, power, n::Int, p::Real) =
    _window_quantile(power, p)

# A `Discrete`-typed compound nests unconditionally (its atom, if any, is
# an ordinary lattice mass); a `Continuous`-typed one only without mass
# at `N = 0`. Read on the primal so a live tracer never decides it.
_compound_nestable(::_DiscreteCompound) = true
_compound_nestable(d::Compound) = iszero(primal(pdf(d.count, 0)))

function _throw_compound_window(d::Compound)
    throw(
        ArgumentError(
            "a Compound with a continuous $(nameof(typeof(d.summand))) " *
                "summand and a $(nameof(typeof(d.count))) count that puts " *
                "mass at zero carries a point mass at zero next to its " *
                "density, which another combination's numeric quadrature " *
                "would miss, so it cannot be a component of one; use a " *
                "count with no mass at zero, a discrete summand, or place " *
                "the compound outermost"
        )
    )
end

# Default `quantile_initial_guess`: a Normal-approximation guess from
# `d`'s own exact mean/variance, clamped above `d`'s lower support bound
# (the guess can land negative in the left tail of a compound whose
# atom at zero holds much of the mass), and rounded onto the lattice
# for a `Discrete`-typed compound (`_discrete_guess`; see the note in
# src/quantile.jl). A downstream package overrides this per type.
function quantile_initial_guess(d::Compound, p::Real)
    _validate_quantile_p(p)
    guess = mean(d) + std(d) * quantile(Normal(), p)
    clamped = max(guess, float(minimum(d)))
    return [_discrete_guess(d, clamped)]
end

# ---------------------------------------------------------------------------
# CDF / logcdf / pdf / logpdf
# ---------------------------------------------------------------------------

@doc "

Compute the cumulative distribution function.

Uses the analytic thinning closed form where one applies, otherwise the
exact lattice recursion (`Discrete`-typed) or the exact mixture of
`n`-fold closed forms (`Continuous`-typed); see the `Compound`
docstring's *Density and CDF computation* section. Carries the atom at
zero: `cdf(d, 0) == pdf(count, 0)`.

See also: [`logcdf`](@ref)
"
function cdf(d::Compound, z::Real)
    return compound_cdf(d, (d.count, d.summand), z, d.method)
end

@doc "

Compute the log cumulative distribution function.

See also: [`cdf`](@ref)
"
function logcdf(d::Compound, z::Real)
    return compound_logcdf(d, (d.count, d.summand), z, d.method)
end

function ccdf(d::Compound, z::Real)
    return compound_ccdf(d, (d.count, d.summand), z, d.method)
end

function logccdf(d::Compound, z::Real)
    return compound_logccdf(d, (d.count, d.summand), z, d.method)
end

@doc "

Compute the probability density (or mass) function.

Uses the analytic thinning closed form where one applies, otherwise the
exact lattice recursion (`Discrete`-typed, a probability mass) or the
exact mixture ``f_Z(z) = \\sum_n \\mathbb{P}(N = n) f_X^{*n}(z)`` of
`n`-fold closed forms (`Continuous`-typed, a density for `z > 0`). By
convention `pdf(d, 0)` of a `Continuous`-typed compound is the point
mass ``\\mathbb{P}(N = 0)``; see the `Compound` docstring's *The atom at
zero* section.

See also: [`logpdf`](@ref)
"
function pdf(d::Compound, z::Real)
    return compound_pdf(d, (d.count, d.summand), z, d.method)
end

@doc "

Compute the log probability density (or mass) function.

See also: [`pdf`](@ref), [`logcdf`](@ref)
"
function logpdf(d::Compound, z::Real)
    return compound_logpdf(d, (d.count, d.summand), z, d.method)
end

@doc "

Compute the quantile (inverse CDF) of the random sum.

Routes through [`compound_quantile`](@ref), so a registered analytic
pair (the Bernoulli-thinning identities) is answered exactly with no
dependency on Optimization.jl. A `Continuous`-typed compound with no
closed form falls through to the `NumericSolver` arm, which lives in
the `ConvolvedDistributionsOptimizationExt` extension and returns
exactly `0` for `p <= pdf(count, 0)`, the atom's share of the mass.

See also: [`cdf`](@ref)
"
function quantile(d::Compound, p::Real)
    _validate_quantile_p(p)
    return compound_quantile(d, (d.count, d.summand), p, d.method)
end

@doc "

Compute the quantile (inverse CDF) of the random sum.

For a `Discrete`-typed compound, returns an exact integer lattice
point, with `p == 0`/`p == 1` always returning the bounds exactly.
Any other case falls through to the method above.

See also: [`cdf`](@ref)
"
function quantile(d::_DiscreteCompound, p::Real)
    boundary = p == 0 || p == 1
    (boundary || isfinite(minimum(d))) && return _lattice_quantile(d, p)
    return invoke(quantile, Tuple{Compound, Real}, d, p)
end
