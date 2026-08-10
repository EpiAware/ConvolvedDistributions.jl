# Solver-method types shared by the convolution distributions.
#
# `Convolved`, `Difference`, and `Product` are parameterised on a solver method that
# selects the CDF/PDF backend: prefer an analytic form where one exists, or
# force the numeric Gauss-Legendre quadrature. The default constructors wrap
# the package's lightweight `GaussLegendre` solver.

@doc "
Abstract type for solver methods used in CDF/PDF computation.

Subtypes determine whether analytical solutions are preferred or
numerical integration is forced.

# See also
- [`AnalyticalSolver`](@ref): prefer closed forms, fall back to
  quadrature.
- [`NumericSolver`](@ref): always use quadrature.
"
abstract type AbstractSolverMethod end

# The default solver payload: a fixed 64-node `GaussLegendre` rule. The
# numeric paths of `Convolved`, `Difference`, `Product`, and `Ratio` use
# their native quantile-panelled quadrature when the payload is this
# default, and route through the pluggable `integrate(solver, …)` contract
# otherwise (a custom `GaussLegendre(n)`, or an Integrals.jl algorithm
# when the extension is loaded).
_default_solver_payload() = GaussLegendre(; n = 64)

@doc "
Solver that attempts analytical solutions when available, falling back to
numerical integration.

Stores a numerical integration solver for use when no analytical solution
exists for a given distribution pair. When the numeric path is reached the
stored payload is honoured: the default `GaussLegendre(; n = 64)` keeps the
native quantile-panelled quadrature, a custom `GaussLegendre(n)` raises the
nodal accuracy, and an Integrals.jl algorithm (with the extension loaded)
routes the integration window through `IntegralProblem`/`solve`.

# See also
- [`NumericSolver`](@ref): force the quadrature path.
- [`GaussLegendre`](@ref): the default fallback quadrature solver.
"
struct AnalyticalSolver{S} <: AbstractSolverMethod
    "Fallback solver for when no analytical solution exists."
    solver::S

    AnalyticalSolver(solver::S) where {S} = new{S}(solver)
end

@doc "
Solver that always uses numerical integration.

Forces numerical computation even when analytical solutions are available,
useful for testing and validation.

The `solver` field contains the numerical integration solver to use, and it
is honoured by the numeric path: the default payload
`GaussLegendre(; n = 64)` keeps the native quantile-panelled quadrature, a
custom `GaussLegendre(n)` raises the nodal accuracy, and an Integrals.jl
algorithm (with the extension loaded) routes the integration window
through `IntegralProblem`/`solve`.

# See also
- [`AnalyticalSolver`](@ref): the default, preferring closed forms.
- [`GaussLegendre`](@ref): the default quadrature solver.
"
struct NumericSolver{S} <: AbstractSolverMethod
    "Numerical integration solver to use."
    solver::S

    NumericSolver(solver::S) where {S} = new{S}(solver)
end

AnalyticalSolver() = AnalyticalSolver(_default_solver_payload())
NumericSolver() = NumericSolver(_default_solver_payload())
