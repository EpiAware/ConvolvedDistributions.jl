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

# The numeric quadrature paths (`_panel_integrate`/`gl_integrate` in
# src/Convolved.jl, src/Difference.jl, src/Product.jl) always reduce
# against the module's own fixed rules (`_CONVOLVED_GL`/`_PANEL_GL`); they
# never read `d.method.solver`. A caller who supplies a non-default payload
# (a higher-node `GaussLegendre`, or an Integrals.jl algorithm) would
# therefore have it silently accepted and ignored, believing they raised
# the precision when they have not (#92). Reject rather than pretend, so
# the payload is honoured-or-rejected, not accepted-and-ignored: only the
# exact default rule is currently a legal payload. Honouring a real payload
# in the panelled quadrature paths is left to a follow-up (the payload
# would need to interact with panel splitting, not just replace a single
# rule), tracked separately from this predicate/strict-mode issue.
_default_solver_payload() = GaussLegendre(; n = 64)

function _check_solver_payload(::Type{T}, solver) where {T <: AbstractSolverMethod}
    solver == _default_solver_payload() && return nothing
    throw(ArgumentError(
        "$(nameof(T))'s solver payload ($(solver)) is not consulted by " *
        "Convolved/Difference/Product's evaluation paths yet -- only the " *
        "default $(_default_solver_payload()) is accepted (a non-default " *
        "payload would otherwise be silently accepted and ignored); see " *
        "issue #92"))
end

@doc "
Solver that attempts analytical solutions when available, falling back to
numerical integration.

Stores a numerical integration solver for use when no analytical solution
exists for a given distribution pair. Only the default solver payload is
currently accepted (see [`NumericSolver`](@ref) for why).

# See also
- [`NumericSolver`](@ref): force the quadrature path.
- [`GaussLegendre`](@ref): the default fallback quadrature solver.
"
struct AnalyticalSolver{S} <: AbstractSolverMethod
    "Fallback solver for when no analytical solution exists."
    solver::S

    function AnalyticalSolver(solver::S) where {S}
        _check_solver_payload(AnalyticalSolver, solver)
        return new{S}(solver)
    end
end

@doc "
Solver that always uses numerical integration.

Forces numerical computation even when analytical solutions are available,
useful for testing and validation.

The `solver` field contains the numerical integration solver to use. Only
the default payload (`GaussLegendre(; n = 64)`) is currently accepted: the
built-in quadrature paths do not yet read this field, so a different
payload would be silently ignored rather than raising the precision a
caller asks for (#92).

# See also
- [`AnalyticalSolver`](@ref): the default, preferring closed forms.
- [`GaussLegendre`](@ref): the default quadrature solver.
"
struct NumericSolver{S} <: AbstractSolverMethod
    "Numerical integration solver to use."
    solver::S

    function NumericSolver(solver::S) where {S}
        _check_solver_payload(NumericSolver, solver)
        return new{S}(solver)
    end
end

AnalyticalSolver() = AnalyticalSolver(_default_solver_payload())
NumericSolver() = NumericSolver(_default_solver_payload())
