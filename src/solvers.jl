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

@doc "
Solver that attempts analytical solutions when available, falling back to
numerical integration.

Stores a numerical integration solver for use when no analytical solution
exists for a given distribution pair.

# See also
- [`NumericSolver`](@ref): force the quadrature path.
- [`GaussLegendre`](@ref): the default fallback quadrature solver.
"
struct AnalyticalSolver{S} <: AbstractSolverMethod
    "Fallback solver for when no analytical solution exists."
    solver::S
end

@doc "
Solver that always uses numerical integration.

Forces numerical computation even when analytical solutions are available,
useful for testing and validation.

The `solver` field contains the numerical integration solver to use.

# See also
- [`AnalyticalSolver`](@ref): the default, preferring closed forms.
- [`GaussLegendre`](@ref): the default quadrature solver.
"
struct NumericSolver{S} <: AbstractSolverMethod
    "Numerical integration solver to use."
    solver::S
end

AnalyticalSolver() = AnalyticalSolver(GaussLegendre(; n = 64))
NumericSolver() = NumericSolver(GaussLegendre(; n = 64))
