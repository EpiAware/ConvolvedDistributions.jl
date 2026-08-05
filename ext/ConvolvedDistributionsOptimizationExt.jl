module ConvolvedDistributionsOptimizationExt

# Optional inverse-CDF (quantile) support for `Convolved`, `Difference`,
# `Product`, and `Ratio`.
#
# No closed form exists for a generic convolution, difference, product, or
# ratio, so the quantile is found by numerically inverting `cdf` with a
# Nelder-Mead solve. The solver stack (Optimization.jl +
# OptimizationOptimJL.jl) is deliberately a weak dependency:
# `cdf`/`pdf`/`logpdf` and `truncated` scoring never need it, so the core
# package stays dependency-light and only consumers that need inverse-CDF
# sampling pull the solver. Ported from CensoredDistributions
# `src/utils/quantile_optimization.jl`.
#
# For a `Discrete`-typed `d` this inverts an EXACT cdf (#85, #89) but
# still returns a non-lattice `Float64`, not the exact integer quantile;
# see #116 for a dedicated lattice-scan quantile.

using ConvolvedDistributions: ConvolvedDistributions, Convolved, Difference,
                              Product, Ratio, NumericSolver, _maybe_analytic
import ConvolvedDistributions: quantile_by_optimization
import Distributions
using Distributions: UnivariateDistribution, cdf, insupport, quantile
using Optimization: OptimizationFunction, OptimizationProblem, solve,
                    ReturnCode
using OptimizationOptimJL: NelderMead

# Log-odds transform used to steepen the tail objective below. Clamping
# keeps the residual finite when `cdf` under/overflows to exactly 0 or 1
# (or drifts just outside [0, 1] through quadrature error).
function _clamped_logit(p::Real)
    pf = float(p)
    pc = clamp(pf, eps(typeof(pf)), 1 - eps(typeof(pf)))
    return log(pc) - log1p(-pc)
end

# Minimises the squared log-odds residual, not the plain squared residual
# on `cdf`, because the latter is nearly flat in `q` in the far tails and
# the solve stopped early there (#48).
function quantile_by_optimization(
        d::UnivariateDistribution, p::Real,
        initial_guess::AbstractVector{<:Real};
        postprocess = identity, check_nan::Bool = true,
        solver = NelderMead(), solve_kwargs...)
    if check_nan && isnan(p)
        throw(ArgumentError("p must be in [0, 1], got $p"))
    end
    if p < 0 || p > 1
        throw(ArgumentError("p must be in [0, 1], got $p"))
    end

    # Boundary cases are exact: the support ends.
    p == 0 && return postprocess(minimum(d))
    p == 1 && return postprocess(maximum(d))

    target = _clamped_logit(p)
    objective = function (q, _)
        q_val = q[1]
        # Outside the support, apply a large penalty (growing with the
        # distance to the nearest finite support end) to guide the
        # optimisation back inside. 1e10 dominates the in-support
        # objective, which the logit clamp caps near (2 * logit(eps))^2
        # ~ 5e3.
        if !insupport(d, q_val)
            min_d = minimum(d)
            max_d = maximum(d)

            penalty = 1e10
            if q_val < min_d && isfinite(min_d)
                penalty += (q_val - min_d)^2
            elseif q_val > max_d && isfinite(max_d)
                penalty += (q_val - max_d)^2
            else
                penalty += q_val^2
            end
            return penalty
        end
        return (_clamped_logit(cdf(d, q_val)) - target)^2
    end

    optfun = OptimizationFunction(objective)
    prob = OptimizationProblem(optfun, initial_guess, nothing)

    default_solve_kwargs = (; reltol = 1e-8, abstol = 1e-8, maxiters = 10000)
    sol = solve(prob, solver; merge(default_solve_kwargs, solve_kwargs)...)

    if sol.retcode == ReturnCode.Success || sol.retcode == ReturnCode.Default
        return postprocess(sol.u[1])
    end
    error("Quantile optimization failed to converge for p = $p")
end

# Sum of the component quantiles as the inversion starting point: exact
# when the components are degenerate and a good guess otherwise.
function _convolved_quantile_guess(d::Convolved, p::Real)
    return [sum(c -> float(quantile(c, p)), d.components)]
end

# Difference of opposing component quantiles as the starting point:
# reflecting Y flips its tail, so pair `p` in X with `1 - p` in Y. Exact
# for degenerate components and centred for symmetric pairs.
function _difference_quantile_guess(d::Difference, p::Real)
    return [float(quantile(d.x, p)) - float(quantile(d.y, 1 - p))]
end

# Product of the component quantiles at `p` as the starting point. With
# both supports non-negative the product is monotone in each factor, so
# high `p` in X pairs with high `p` in Y (no tail flip, unlike the
# difference). On the log scale this is exactly the Convolved guess —
# log-quantiles add — so it is exact for degenerate components and exact
# at the median of a `LogNormal` pair; in the tails it overshoots
# (`σ_X + σ_Y >= sqrt(σ_X² + σ_Y²)`), which the Nelder-Mead inversion
# tolerates as a starting point.
function _product_quantile_guess(d::Product, p::Real)
    return [float(quantile(d.x, p)) * float(quantile(d.y, p))]
end

# Numerator quantile at `p` over denominator quantile at `1 - p`: the
# ratio increases in X and decreases in Y, so pair opposing tails (as
# the Difference guess does for subtraction). Falls back to the median
# ratio when that guess is not finite (a sign-crossing denominator makes
# the opposing-tail pairing meaningless, e.g. quantile(Y, 1 - p) == 0).
# The median-ratio fallback is itself a 0 / 0 = NaN for a Ratio whose
# numerator AND denominator are both symmetric about zero -- exactly the
# headline sign-crossing `Normal`/`Normal` case -- so a final fallback to
# 0 (a reasonable starting guess for a symmetric ratio; NelderMead only
# needs a finite, non-degenerate simplex point) catches that.
function _ratio_quantile_guess(d::Ratio, p::Real)
    g = float(quantile(d.x, p)) / float(quantile(d.y, 1 - p))
    isfinite(g) && return [g]
    m = float(quantile(d.x, 0.5)) / float(quantile(d.y, 0.5))
    return [isfinite(m) ? m : zero(m)]
end

@doc "

Numeric quantile for a `Convolved` the core two-component pair
mechanism does not resolve analytically -- three or more components, or
a non-analytic two-component pair (S2.4). Found by numerically
inverting [`cdf`](@ref) with a Nelder-Mead solve, starting from the sum
of the component quantiles (exact when the components are degenerate, a
good guess otherwise). `quantile(d::Convolved, p)` itself lives in core
and calls this only when it cannot resolve `d` analytically without a
solver.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).
"
function ConvolvedDistributions._convolved_general_quantile(
        d::Convolved, p::Real)
    return quantile_by_optimization(d, p, _convolved_quantile_guess(d, p))
end

@doc "

`NumericSolver` arm of [`convolved_quantile`](@ref): invert the numeric
[`cdf`](@ref) with a Nelder-Mead solve, starting from the sum of the
component quantiles.
"
function ConvolvedDistributions.convolved_quantile(
        d::Convolved, d1::UnivariateDistribution, d2::UnivariateDistribution,
        p::Real, method::NumericSolver)
    return quantile_by_optimization(d, p, _convolved_quantile_guess(d, p))
end

@doc "

Compute the quantile (inverse CDF) of the difference.

Exact where the components' difference names a distribution (currently
`Normal`-`Normal`); otherwise the quantile is found by numerically
inverting [`cdf`](@ref) with a Nelder-Mead solve, starting from the
difference of the opposing component quantiles. Providing this method
lets a `Difference` compose under `truncated`, where `Distributions`
derives the truncated quantile and inverse-CDF sampler from the base
`quantile`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

See also: [`cdf`](@ref)
"
function Distributions.quantile(d::Difference, p::Real)
    a = _maybe_analytic(d)
    a === nothing || return quantile(a, p)
    return quantile_by_optimization(d, p, _difference_quantile_guess(d, p))
end

@doc "

Compute the quantile (inverse CDF) of the product.

Exact where the components' product names a distribution (currently
`LogNormal`*`LogNormal`); otherwise the quantile is found by numerically
inverting [`cdf`](@ref) with a Nelder-Mead solve, starting from the
product of the component quantiles at `p` (the Convolved guess on the
log scale, since both supports are non-negative). Providing this method
lets a `Product` compose under `truncated`, where `Distributions`
derives the truncated quantile and inverse-CDF sampler from the base
`quantile`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

See also: [`cdf`](@ref)
"
function Distributions.quantile(d::Product, p::Real)
    a = _maybe_analytic(d)
    a === nothing || return quantile(a, p)
    return quantile_by_optimization(d, p, _product_quantile_guess(d, p))
end

@doc "

Compute the quantile (inverse CDF) of the ratio.

No closed form exists for a generic ratio, so the quantile is found by
numerically inverting [`cdf`](@ref) with a Nelder-Mead solve, starting
from the numerator quantile at `p` over the denominator quantile at
`1 - p` (the ratio increases in the numerator and decreases in the
denominator, so opposing tails pair, as the Difference guess does for
subtraction). Providing this method lets a `Ratio` compose under
`truncated`, where `Distributions` derives the truncated quantile and
inverse-CDF sampler from the base `quantile`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

See also: [`cdf`](@ref)
"
function Distributions.quantile(d::Ratio, p::Real)
    return quantile_by_optimization(d, p, _ratio_quantile_guess(d, p))
end

end # module
