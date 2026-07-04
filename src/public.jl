# Public API declarations for Julia 1.11+ (public but not exported). These form
# the surface ComposedDistributions re-exports downstream, so keep it clean.

# Convolution / difference distribution types.
public Convolved

# Solver-method supertype. `AnalyticalSolver` and `NumericSolver` are exported
# in the main module.
public AbstractSolverMethod

# Pluggable integration: the default solver, the entry point, and the
# quadrature helper. `GaussLegendre` stays unexported to avoid clashing with
# `Integrals.GaussLegendre` when both are loaded; the Integrals.jl extension
# adds an `integrate` method.
public GaussLegendre, integrate, gl_integrate
