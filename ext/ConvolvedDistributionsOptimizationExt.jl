module ConvolvedDistributionsOptimizationExt

# Optional inverse-CDF (quantile) support for `Convolved` and `Difference`.
#
# No closed form exists for a generic convolution or difference, so the
# quantile is found by numerically inverting `cdf` with a Nelder-Mead
# solve. The solver stack (Optimization.jl + OptimizationOptimJL.jl) is
# deliberately a weak dependency: `cdf`/`pdf`/`logpdf` and `truncated`
# scoring never need it, so the core package stays dependency-light and
# only consumers that need inverse-CDF sampling pull the solver. Ported
# from CensoredDistributions `src/utils/quantile_optimization.jl`.

using ConvolvedDistributions: Convolved, Difference, Product
import Distributions
using Distributions: UnivariateDistribution, cdf, insupport, quantile
using Optimization: OptimizationFunction, OptimizationProblem, solve,
                    ReturnCode
using OptimizationOptimJL: NelderMead

# Numerically invert `cdf(d, q) = p` by minimising the squared residual
# `(cdf(d, q) - p)^2` with Nelder-Mead from a caller-supplied initial
# guess vector `x0`. Validates `p` (rejecting NaN), returns the support
# ends exactly for p = 0 / 1, and penalises iterates outside the support
# heavily so the optimiser is guided back in. Errors if the solve does
# not converge.
function _quantile_optimization(
        d::UnivariateDistribution, p::Real, x0::AbstractVector{<:Real})
    if isnan(p) || p < 0 || p > 1
        throw(ArgumentError("p must be in [0, 1], got $p"))
    end

    # Boundary cases are exact: the support ends.
    p == 0 && return minimum(d)
    p == 1 && return maximum(d)

    objective = function (q, _)
        q_val = q[1]
        # Outside the support, apply a large penalty (growing with the
        # distance to the nearest finite support end) to guide the
        # optimisation back inside.
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
        return (cdf(d, q_val) - p)^2
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

Compute the quantile (inverse CDF) of the convolution.

No closed form exists for a generic convolution, so the quantile is found
by numerically inverting [`cdf`](@ref) with a Nelder-Mead solve. The
initial guess is the sum of the component quantiles, which is exact when
the components are degenerate and a good starting point otherwise.
Providing this method lets a `Convolved` compose under `truncated`, where
`Distributions` derives the truncated quantile and inverse-CDF sampler
from the base `quantile`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

See also: [`cdf`](@ref)
"
function Distributions.quantile(d::Convolved, p::Real)
    return _quantile_optimization(d, p, _convolved_quantile_guess(d, p))
end

@doc "

Compute the quantile (inverse CDF) of the difference.

No closed form exists for a generic difference, so the quantile is found
by numerically inverting [`cdf`](@ref) with a Nelder-Mead solve, starting
from the difference of the opposing component quantiles. Providing this
method lets a `Difference` compose under `truncated`, where
`Distributions` derives the truncated quantile and inverse-CDF sampler
from the base `quantile`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

See also: [`cdf`](@ref)
"
function Distributions.quantile(d::Difference, p::Real)
    return _quantile_optimization(d, p, _difference_quantile_guess(d, p))
end

@doc "

Compute the quantile (inverse CDF) of the product.

No closed form exists for a generic product, so the quantile is found by
numerically inverting [`cdf`](@ref) with a Nelder-Mead solve, starting
from the product of the component quantiles at `p` (the Convolved guess
on the log scale, since both supports are non-negative). Providing this
method lets a `Product` compose under `truncated`, where `Distributions`
derives the truncated quantile and inverse-CDF sampler from the base
`quantile`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

See also: [`cdf`](@ref)
"
function Distributions.quantile(d::Product, p::Real)
    return _quantile_optimization(d, p, _product_quantile_guess(d, p))
end

end # module
