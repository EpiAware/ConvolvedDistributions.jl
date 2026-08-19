# Public entry point for the shared numeric quantile (inverse-CDF)
# inversion. `Convolved`/`Difference`/`Product` have no closed-form
# quantile in general, so their `Distributions.quantile` methods invert
# `cdf` numerically; other EpiAware packages facing the same problem
# (e.g. CensoredDistributions' `PrimaryCensored`/`IntervalCensored`) can
# reuse the same solve instead of each carrying their own copy (#112).
#
# The stub is declared here so the name is public and documented from
# the core package, but the method itself -- and the Optimization.jl /
# OptimizationOptimJL.jl dependency it needs -- lives in
# ConvolvedDistributionsOptimizationExt, keeping the core package
# dependency-light. Loading both trigger packages loads the extension,
# which adds the method.

@doc "

Numerically invert `cdf(d, ·) = p` for the quantile of `d` at `p`.

No closed form is assumed for `d`: the quantile is found by minimising a
clamped-logit-transformed residual between `cdf(d, q)` and `p` with a
Nelder-Mead solve, started from the caller-supplied `initial_guess`. The
logit transform keeps the objective steep in the far tails, where a
plain squared residual on `cdf` is nearly flat in `q` and lets the
solve stop early (issue #48).

# Arguments
- `d`: The distribution to invert.
- `p`: The target probability; must lie in `[0, 1]`.
- `initial_guess`: A length-1 vector giving the Nelder-Mead starting
  point.

# Keyword Arguments
- `postprocess`: Applied to the solved quantile before it is returned
  (e.g. to snap it onto a discrete grid). Defaults to `identity`.
- `check_nan`: Reject a `NaN` `p` with an `ArgumentError` when `true`
  (the default). With `check_nan = false` a `NaN` `p` skips validation
  and the solve errors at the convergence check instead; it never
  returns a value for a `NaN` target.
- `solver`: The Optim.jl solver passed to `solve`. Defaults to
  `NelderMead()`.
- `solve_kwargs...`: Passed through to `solve`, merged over the defaults
  `reltol = 1e-8`, `abstol = 1e-8`, `maxiters = 10000` (explicit values
  win).

# Returns
- The quantile `q` such that `cdf(d, q) ≈ p`, after `postprocess`.

Requires Optimization.jl and OptimizationOptimJL.jl to be loaded (this
method lives in the `ConvolvedDistributionsOptimizationExt` extension).

# Examples
```@example
using ConvolvedDistributions, Distributions
using Optimization, OptimizationOptimJL

d = Normal(0.0, 1.0)
ConvolvedDistributions.quantile_by_optimization(d, 0.5, [0.0])
```

See also: [`cdf`](@ref)
"
function quantile_by_optimization end

# Declared here so the name is public and documented from the core
# package; default methods for Convolved/Difference/Product/Ratio sit
# with each type, since none needs the solver dependency.

@doc "

Called as `quantile_initial_guess(d, p)`, gives the `initial_guess` for
[`quantile_by_optimization`](@ref)'s Nelder-Mead solve, as a length-1
vector.

Each of `Convolved`, `Difference`, `Product`, and `Ratio` ships a default
method. A downstream package overrides it for a more specific type to
supply a domain-specific starting guess without forking the quantile
machinery. The override needs the concrete parametrised component type
and an explicit `p::Real`: `Convolved`'s type parameters are invariant,
and an untyped `p` is ambiguous with the generic fallback.

Validates `p` and throws `ArgumentError` for an out-of-range or `NaN` `p`
before building any guess; an override should preserve that behaviour.

# Examples
```@example
using ConvolvedDistributions, Distributions

d = convolved(Gamma(2.0, 1.5), Uniform(0.0, 2.0))
ConvolvedDistributions.quantile_initial_guess(
    d::ConvolvedDistributions.Convolved{
        Tuple{Gamma{Float64}, Uniform{Float64}}},
    p::Real) = [3.0]
ConvolvedDistributions.quantile_initial_guess(d, 0.3)
```

See also: [`quantile_by_optimization`](@ref)
"
function quantile_initial_guess end

# `quantile_initial_guess(d, p)` is a call argument, evaluated before
# `quantile_by_optimization`'s body -- so its own `p`-range check never
# gets a chance to run first. Each `quantile_initial_guess` method builds
# its guess from a component's own `quantile(comp, p)` (or `1 - p`),
# which throws its own family-specific error for an out-of-range or `NaN`
# `p` (e.g. a bare `DomainError` from deep inside `Gamma`'s quantile), so
# each needs this same guard to surface the clean `ArgumentError` instead.
# Shared with `quantile_by_optimization`'s own check (the
# `ConvolvedDistributionsOptimizationExt` extension), so the condition and
# message live in one place.
function _validate_quantile_p(p::Real; check_nan::Bool = true)
    check_nan && isnan(p) &&
        throw(ArgumentError("p must be in [0, 1], got $p"))
    (p < 0 || p > 1) && throw(ArgumentError("p must be in [0, 1], got $p"))
    return nothing
end
