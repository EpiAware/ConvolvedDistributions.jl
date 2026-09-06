# ============================================================================
# Finite-support discrete components: exact closed forms
# ============================================================================
#
# `DiscreteNonParametric` is the discretised-delay type across the
# EpiAware stack (see `convolve_series`), yet `_component_support` reads
# it as `Continuous`: its `eltype` is the float type of its support, so
# the integer-lattice folds cannot serve it, and a combination of two
# such components was routed to Gauss-Legendre quadrature, whose nodes
# never land on an atom -- a density identically zero, returned silently
# (#226). The exact answer needs no grid at all. For two finite atom
# sets the combination is again a finite atom set, enumerated once by
# pairing every atom of one with every atom of the other; registering
# that as the pair's closed form (the `*_pair` methods below) makes the
# result an ordinary `DiscreteNonParametric`, so `pdf`/`cdf`/`quantile`
# come from Distributions.jl, `evaluation_path` reports `:analytic`,
# `is_exact` reports `true`, mismatched and irregular grids are handled
# identically, and `Convolved`'s n-ary collapse folds three or more such
# components pairwise for free (#117).
#
# A finite atom set next to a CONTINUOUS component is exact in closed
# form too: `D + Y` is the finite mixture of the shifted laws `Y + s_i`
# with weights `p_i` (and `s_i - Y`, `Y - s_i`, `s_i * Y`, `Y / s_i` for
# the other members), which `_AtomMixture` below evaluates exactly. A finite atom set next to an INTEGER-LATTICE
# discrete component stays on the mixed fold (`_convolved_mixed_pdf` and
# its `Difference`/`Product` twins), which evaluates the atom set's pmf
# pointwise and is exact for it; a `MixtureModel` of discrete laws has
# no `quantile`, so a closed form there would take a route away.
#
# None of this changes a combination's value-support type parameter. `S`
# is derived from the component TYPES (`_components_support`), and a
# `DiscreteNonParametric` is `Continuous` there by design (a grid is a
# runtime value; see `_component_support`). A pair of atom sets is
# therefore a `Continuous`-typed combination whose every quantity is
# exact: `is_exact` is the predicate to consult, not `value_support`.

# Merge coincident atoms. Two atoms whose values agree to within a
# tolerance scaled to the largest magnitude present are one atom: the
# values arrive from floating-point arithmetic on the component grids
# (`0.1 + 0.5` and `0.2 + 0.4` differ by one ulp), and a lookup on the
# result is an exact-equality test, so leaving them apart would split
# the mass of a single point over two keys neither of which the caller's
# value hits. The grouping runs on primal values (no index reaches the
# AD tape), the weights are summed per group without mutating any array
# (ReverseDiff's `TrackedArray` `setindex!` trap, #44), and the first
# value of each group is kept so the result's support carries the
# component supports' own element type.
function _merge_atoms(values::AbstractVector, weights::AbstractVector)
    pv = map(v -> Float64(primal(v)), values)
    perm = sortperm(pv)
    tol = sqrt(eps(Float64)) * max(1.0, maximum(abs, pv))
    groups = Vector{Vector{Int}}()
    for i in perm
        if !isempty(groups) && pv[i] - pv[last(last(groups))] <= tol
            push!(last(groups), i)
        else
            push!(groups, [i])
        end
    end
    xs = map(g -> values[first(g)], groups)
    ps = map(g -> sum(i -> weights[i], g), groups)
    return DiscreteNonParametric(xs, ps)
end

# Every atom of `a` combined with every atom of `b` under `op`, as one
# merged atom set. Comprehensions (not broadcasts) so a tracked
# probability vector yields a plain `Vector` of tracked reals rather
# than a `TrackedArray`.
function _atom_combination(
        op::F, a::DiscreteNonParametric, b::DiscreteNonParametric
    ) where {F}
    sa, pa = support(a), probs(a)
    sb, pb = support(b), probs(b)
    values = vec([op(x, y) for x in sa, y in sb])
    weights = vec([px * py for px in pa, py in pb])
    return _merge_atoms(values, weights)
end

# ---------------------------------------------------------------------------
# A finite atom set combined with a continuous component
# ---------------------------------------------------------------------------
#
# `Z = mu_i + sigma_i * Y` with probability `p_i`: the law of a continuous
# component `Y` combined with a finite atom set, one affine copy of `Y`
# per atom. A sum shifts (`mu_i = s_i`, `sigma_i = 1`), a difference
# shifts and reflects (`sigma_i = -1`) or negates the shift, a product
# scales (`sigma_i = s_i`), and a ratio scales by the reciprocal. This
# is a `MixtureModel` of affine copies in all but one respect: every
# quantity is evaluated through the package's AD-safe hooks
# (`pdf_ad_safe` and friends), and an atom whose copy does not reach the
# evaluation point is skipped on a primal comparison rather than
# evaluated at a point outside `Y`'s support, where the density is zero
# but a reverse-mode gradient through `Y`'s own density is `NaN`.
struct _AtomMixture{M, S, P, D} <: ContinuousUnivariateDistribution
    mu::M
    sigma::S
    probs::P
    base::D
end

function _atom_mixture(
        mu::AbstractVector, sigma::AbstractVector,
        atoms::DiscreteNonParametric, base
    )
    return _AtomMixture(mu, sigma, probs(atoms), base)
end

# The mixture with every AD tracer stripped, for the quantile search.
function _primal_atom_mixture(d::_AtomMixture)
    return _AtomMixture(
        map(v -> Float64(primal(v)), d.mu),
        map(v -> Float64(primal(v)), d.sigma),
        map(v -> Float64(primal(v)), d.probs),
        primal_distribution(d.base)
    )
end

# The point of `Y` that maps to `z` under the `i`-th affine copy, and
# whether it lies inside `Y`'s support (a primal comparison: the support
# ends are hyperparameters of the route, as every window is).
_atom_point(d::_AtomMixture, i, z) = (z - d.mu[i]) / d.sigma[i]
function _atom_reaches(d::_AtomMixture, i, z)
    y = Float64(primal(_atom_point(d, i, z)))
    return Float64(primal(minimum(d.base))) <= y <= Float64(primal(maximum(d.base)))
end

function params(d::_AtomMixture)
    return (d.mu, d.sigma, d.probs, params(d.base))
end

function Base.eltype(::Type{<:_AtomMixture{M, S, P, D}}) where {M, S, P, D}
    return float(promote_type(eltype(M), eltype(S), eltype(D)))
end

# Each copy's ends, with a negative scale swapping them; the mixture's
# support is their hull.
function _atom_ends(d::_AtomMixture, i)
    lo = d.mu[i] + d.sigma[i] * minimum(d.base)
    hi = d.mu[i] + d.sigma[i] * maximum(d.base)
    return _min2(lo, hi), _max2(lo, hi)
end
function minimum(d::_AtomMixture)
    lo, _ = _atom_ends(d, 1)
    for i in 2:length(d.mu)
        lo = _min2(lo, _atom_ends(d, i)[1])
    end
    return lo
end
function maximum(d::_AtomMixture)
    _, hi = _atom_ends(d, 1)
    for i in 2:length(d.mu)
        hi = _max2(hi, _atom_ends(d, i)[2])
    end
    return hi
end
insupport(d::_AtomMixture, z::Real) = minimum(d) <= z <= maximum(d)

function pdf(d::_AtomMixture, z::Real)
    acc = zero(float(promote_type(typeof(z), eltype(d))))
    for i in eachindex(d.mu)
        _atom_reaches(d, i, z) || continue
        acc += d.probs[i] * pdf_ad_safe(d.base, _atom_point(d, i, z)) /
            abs(d.sigma[i])
    end
    return acc
end
logpdf(d::_AtomMixture, z::Real) = log(pdf(d, z))

# `P(Z_i <= z)` for one copy: the base CDF at the mapped point when the
# scale is positive, its complement when the scale reflects, and the
# saturated value when the point lies beyond the base's support.
function _atom_cdf(d::_AtomMixture, i, z)
    y = _atom_point(d, i, z)
    lo = Float64(primal(minimum(d.base)))
    hi = Float64(primal(maximum(d.base)))
    yp = Float64(primal(y))
    T = float(promote_type(typeof(z), eltype(d)))
    positive = d.sigma[i] > 0
    if yp < lo
        return positive ? zero(T) : one(T)
    elseif yp > hi
        return positive ? one(T) : zero(T)
    end
    return positive ? cdf_ad_safe(d.base, y) : ccdf_ad_safe(d.base, y)
end

function cdf(d::_AtomMixture, z::Real)
    acc = zero(float(promote_type(typeof(z), eltype(d))))
    for i in eachindex(d.mu)
        acc += d.probs[i] * _atom_cdf(d, i, z)
    end
    return clamp(acc, zero(acc), one(acc))
end
ccdf(d::_AtomMixture, z::Real) = one(cdf(d, z)) - cdf(d, z)
logcdf(d::_AtomMixture, z::Real) = log(cdf(d, z))
logccdf(d::_AtomMixture, z::Real) = log(ccdf(d, z))

# Exact moments from the affine copies: `E[Z] = sum_i p_i (mu_i + sigma_i
# E[Y])` and `E[Z^2]` likewise, so `var` needs no quadrature.
function mean(d::_AtomMixture)
    m = mean(d.base)
    return sum(i -> d.probs[i] * (d.mu[i] + d.sigma[i] * m), eachindex(d.mu))
end
function var(d::_AtomMixture)
    m = mean(d.base)
    v = var(d.base)
    second = sum(
        i -> d.probs[i] * (d.sigma[i]^2 * v + (d.mu[i] + d.sigma[i] * m)^2),
        eachindex(d.mu)
    )
    return second - mean(d)^2
end
std(d::_AtomMixture) = sqrt(var(d))

# Pick a copy by its weight, then draw from it.
function Base.rand(rng::AbstractRNG, d::_AtomMixture)
    u = rand(rng)
    acc = zero(u)
    i = firstindex(d.mu)
    for j in eachindex(d.mu)
        i = j
        acc += primal(d.probs[j])
        acc >= u && break
    end
    return d.mu[i] + d.sigma[i] * rand(rng, d.base)
end
sampler(d::_AtomMixture) = d

# Bracketed bisection on the primal CDF. The bracket is the hull of the
# copies' own quantiles: at its lower end every copy's CDF is at most
# `p`, so the mixture's is too, and at its upper end at least `p`. A
# quantile is a step-free monotone inversion here, so bisecting to
# adjacent floats is exact to working precision; like the package's
# lattice and window quantiles it carries no gradient.
function quantile(d::_AtomMixture, p::Real)
    _validate_quantile_p(p)
    base = primal_distribution(d.base)
    ends = map(eachindex(d.mu)) do i
        mu = Float64(primal(d.mu[i]))
        sigma = Float64(primal(d.sigma[i]))
        q = sigma > 0 ? quantile(base, p) : quantile(base, 1 - p)
        mu + sigma * q
    end
    lo, hi = extrema(ends)
    lo == hi && return lo
    dp = _primal_atom_mixture(d)
    for _ in 1:200
        mid = (lo + hi) / 2
        (mid <= lo || mid >= hi) && break
        if cdf(dp, mid) < p
            lo = mid
        else
            hi = mid
        end
    end
    return hi
end

# --- two finite atom sets ---------------------------------------------------

function convolve_pair(a::DiscreteNonParametric, b::DiscreteNonParametric)
    return _atom_combination(+, a, b)
end

function difference_pair(x::DiscreteNonParametric, y::DiscreteNonParametric)
    return _atom_combination(-, x, y)
end

function product_pair(x::DiscreteNonParametric, y::DiscreteNonParametric)
    return _atom_combination(*, x, y)
end

# `Ratio` rejects a denominator with mass at zero at construction; the
# guard here only keeps a direct call on such a pair from dividing by
# zero.
function ratio_pair(x::DiscreteNonParametric, y::DiscreteNonParametric)
    any(iszero, support(y)) && return nothing
    return _atom_combination(/, x, y)
end

# --- a finite atom set and a continuous component ---------------------------

function convolve_pair(
        a::DiscreteNonParametric, b::ContinuousUnivariateDistribution
    )
    s = support(a)
    return _atom_mixture(s, map(one, s), a, b)
end
function convolve_pair(
        a::ContinuousUnivariateDistribution, b::DiscreteNonParametric
    )
    return convolve_pair(b, a)
end

# `s - Y` is the reflection `-Y` shifted by `s`: an affine copy with a
# negative scale. `X - s` is `X` shifted by `-s`.
function difference_pair(
        x::DiscreteNonParametric, y::ContinuousUnivariateDistribution
    )
    s = support(x)
    return _atom_mixture(s, map(v -> -one(v), s), x, y)
end
function difference_pair(
        x::ContinuousUnivariateDistribution, y::DiscreteNonParametric
    )
    s = support(y)
    return _atom_mixture(map(-, s), map(one, s), y, x)
end

# `Product` requires non-negative supports, so every atom is `>= 0`. An
# atom AT zero would put a point mass at zero next to a continuous
# density -- a mixed measure no `pdf` can represent -- so, exactly as
# `_check_mixed_atom_at_zero` rejects a lattice-discrete factor with
# mass at zero, no closed form is offered and construction fails on the
# atoms-under-quadrature guard instead.
function product_pair(
        x::DiscreteNonParametric, y::ContinuousUnivariateDistribution
    )
    s = support(x)
    any(iszero, s) && return nothing
    return _atom_mixture(map(zero, s), s, x, y)
end
function product_pair(
        x::ContinuousUnivariateDistribution, y::DiscreteNonParametric
    )
    return product_pair(y, x)
end

# `X / s_i` is `X` scaled by `1 / s_i`; the denominator's atoms are
# non-zero by construction (`_check_denominator`). `D / Y` has no such
# form: `s_i / Y` needs the law of a reciprocal, which this package does
# not compute.
function ratio_pair(
        x::ContinuousUnivariateDistribution, y::DiscreteNonParametric
    )
    s = support(y)
    any(iszero, s) && return nothing
    return _atom_mixture(map(zero, s), map(v -> one(v) / v, s), y, x)
end

# --- a finite atom set and a nested combination ----------------------------
#
# A `Continuous`-typed family member next to an atom set resolves through
# its own closed form first: an inner pair of atom sets has collapsed to
# one, so the outer pair collapses too, and an inner continuous closed
# form takes the mixture above. An inner combination with no closed form
# offers none here either, so `evaluation_path` keeps recursing honestly
# through nesting (a flat `convolved(x, y, atoms)` call folds the atoms
# into whichever continuous component they can, and integrates the
# rest). More specific than the `ContinuousUnivariateDistribution`
# methods above, which a `Continuous`-typed member also matches.
const _ContinuousMember = AbstractConvolvedDistribution{
    Distributions.Univariate, Continuous,
}

function _resolve_then(pair::F, atoms::DiscreteNonParametric, d::_ContinuousMember) where {F}
    inner = _maybe_analytic(d)
    inner === nothing && return nothing
    return pair(atoms, inner)
end

function convolve_pair(a::DiscreteNonParametric, b::_ContinuousMember)
    return _resolve_then(convolve_pair, a, b)
end
convolve_pair(a::_ContinuousMember, b::DiscreteNonParametric) = convolve_pair(b, a)

function difference_pair(x::DiscreteNonParametric, y::_ContinuousMember)
    return _resolve_then(difference_pair, x, y)
end
function difference_pair(x::_ContinuousMember, y::DiscreteNonParametric)
    inner = _maybe_analytic(x)
    inner === nothing && return nothing
    return difference_pair(inner, y)
end

function product_pair(x::DiscreteNonParametric, y::_ContinuousMember)
    return _resolve_then(product_pair, x, y)
end
product_pair(x::_ContinuousMember, y::DiscreteNonParametric) = product_pair(y, x)

function ratio_pair(x::_ContinuousMember, y::DiscreteNonParametric)
    inner = _maybe_analytic(x)
    inner === nothing && return nothing
    return ratio_pair(inner, y)
end
