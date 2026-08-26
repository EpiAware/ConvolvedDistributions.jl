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
    Product, Ratio, NumericSolver, _validate_quantile_p
import ConvolvedDistributions: quantile_by_optimization,
    quantile_initial_guess
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
        solver = NelderMead(), solve_kwargs...
    )
    _validate_quantile_p(p; check_nan)

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

            penalty = 1.0e10
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

    default_solve_kwargs = (; reltol = 1.0e-8, abstol = 1.0e-8, maxiters = 10000)
    sol = solve(prob, solver; merge(default_solve_kwargs, solve_kwargs)...)

    if sol.retcode == ReturnCode.Success || sol.retcode == ReturnCode.Default
        return postprocess(sol.u[1])
    end
    error("Quantile optimization failed to converge for p = $p")
end

@doc "

`NumericSolver` arm of [`convolved_quantile`](@ref): invert the numeric
[`cdf`](@ref) with a Nelder-Mead solve, starting from the sum of the
component quantiles (exact when the components are degenerate, a good
guess otherwise). This is the fallback for any fold the
`AnalyticalSolver` arm's pairwise collapse gets stuck on -- any number
of components, not just three-or-more (review A).
"
function ConvolvedDistributions.convolved_quantile(
        d::Convolved, components::Tuple, p::Real, method::NumericSolver
    )
    return quantile_by_optimization(d, p, quantile_initial_guess(d, p))
end

@doc "

`NumericSolver` arm of [`difference_quantile`](@ref): invert the numeric
[`cdf`](@ref) with a Nelder-Mead solve, starting from the difference of
the opposing component quantiles. The `AnalyticalSolver` arm in core
handles a registered pair (currently `Normal`-`Normal`) without needing
this extension at all.

Reaching the quantile through the generic is what lets a `Difference`
compose under `truncated`, where `Distributions` derives the truncated
quantile and inverse-CDF sampler from the base `quantile`.
"
function ConvolvedDistributions.difference_quantile(
        d::Difference, components::Tuple, p::Real, method::NumericSolver
    )
    return quantile_by_optimization(d, p, quantile_initial_guess(d, p))
end

@doc "

`NumericSolver` arm of [`product_quantile`](@ref): invert the numeric
[`cdf`](@ref) with a Nelder-Mead solve, starting from the product of the
component quantiles at `p` (the Convolved guess on the log scale, since
both supports are non-negative). The `AnalyticalSolver` arm in core
handles a registered pair (currently `LogNormal`*`LogNormal`) without
needing this extension at all.

Reaching the quantile through the generic is what lets a `Product`
compose under `truncated`, where `Distributions` derives the truncated
quantile and inverse-CDF sampler from the base `quantile`.
"
function ConvolvedDistributions.product_quantile(
        d::Product, components::Tuple, p::Real, method::NumericSolver
    )
    return quantile_by_optimization(d, p, quantile_initial_guess(d, p))
end

@doc "

`NumericSolver` arm of [`ratio_quantile`](@ref): invert the numeric
[`cdf`](@ref) with a Nelder-Mead solve, starting from the numerator
quantile at `p` over the denominator quantile at `1 - p` (the ratio
increases in the numerator and decreases in the denominator, so opposing
tails pair, as the Difference guess does for subtraction). No ratio pair
has a registered closed form yet, so every `Ratio` reaches this arm
today.

Reaching the quantile through the generic is what lets a `Ratio` compose
under `truncated`, where `Distributions` derives the truncated quantile
and inverse-CDF sampler from the base `quantile`.
"
function ConvolvedDistributions.ratio_quantile(
        d::Ratio, components::Tuple, p::Real, method::NumericSolver
    )
    return quantile_by_optimization(d, p, quantile_initial_guess(d, p))
end

end # module
