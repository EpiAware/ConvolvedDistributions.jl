module ConvolvedDistributionsOptimizationExt

# Optional inverse-CDF (quantile) support for `Convolved`, `Difference`, and
# `Product`.
#
# No closed form exists for a generic convolution or difference, so the
# quantile is found by numerically inverting `cdf` with a Nelder-Mead
# solve. The solver stack (Optimization.jl + OptimizationOptimJL.jl) is
# deliberately a weak dependency: `cdf`/`pdf`/`logpdf` and `truncated`
# scoring never need it, so the core package stays dependency-light and
# only consumers that need inverse-CDF sampling pull the solver. Ported
# from CensoredDistributions `src/utils/quantile_optimization.jl`.

using ConvolvedDistributions: ConvolvedDistributions, Convolved, Difference,
                              Product, NumericSolver, _maybe_analytic
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

# Numerically invert `cdf(d, q) = p` by minimising the squared log-odds
# residual `(logit(cdf(d, q)) - logit(p))^2` with Nelder-Mead from a
# caller-supplied initial guess vector `x0`. Minimising the plain squared
# residual `(cdf(d, q) - p)^2` is nearly flat in `q` in the far tails, so
# the solve stopped early there (#48); the logit transform keeps the
# objective steep at extreme `p`. Validates `p` (rejecting NaN), returns
# the support ends exactly for p = 0 / 1, and penalises iterates outside
# the support heavily so the optimiser is guided back in. Errors if the
# solve does not converge.
function _quantile_optimization(
        d::UnivariateDistribution, p::Real, x0::AbstractVector{<:Real})
    if isnan(p) || p < 0 || p > 1
        throw(ArgumentError("p must be in [0, 1], got $p"))
    end

    # Boundary cases are exact: the support ends.
    p == 0 && return minimum(d)
    p == 1 && return maximum(d)

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
    prob = OptimizationProblem(optfun, x0, nothing)

    sol = solve(prob, NelderMead();
        reltol = 1e-8, abstol = 1e-8, maxiters = 10000)

    if sol.retcode == ReturnCode.Success || sol.retcode == ReturnCode.Default
        return sol.u[1]
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
    return _quantile_optimization(d, p, _convolved_quantile_guess(d, p))
end

@doc "

`NumericSolver` arm of [`convolved_quantile`](@ref): invert the numeric
[`cdf`](@ref) with a Nelder-Mead solve, starting from the sum of the
component quantiles.
"
function ConvolvedDistributions.convolved_quantile(
        d::Convolved, d1::UnivariateDistribution, d2::UnivariateDistribution,
        p::Real, method::NumericSolver)
    return _quantile_optimization(d, p, _convolved_quantile_guess(d, p))
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
    return _quantile_optimization(d, p, _difference_quantile_guess(d, p))
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
    return _quantile_optimization(d, p, _product_quantile_guess(d, p))
end

end # module
