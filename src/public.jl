# Public API declarations for Julia 1.11+ (public but not exported). These form
# the surface ComposedDistributions re-exports downstream, so keep it clean.

# Convolution / difference distribution types, and the multi-base
# algebraic-combination family supertype they subtype.
public Convolved, AbstractCombinedDistribution

# The build-once discretised delay PMF type behind the exported
# `discretise_pmf` constructor (`convolve_series`/`pdf` reuse it).
public DelayPMF

# Interface-contract verifiers (`TestUtils.test_combined_interface`,
# `TestUtils.test_abstract_membership`) for downstream family members.
public TestUtils

# Solver-method supertype. `AnalyticalSolver` and `NumericSolver` are exported
# in the main module.
public AbstractSolverMethod

# Pluggable integration: the default solver, the entry point, and the
# quadrature helper. `GaussLegendre` stays unexported to avoid clashing with
# `Integrals.GaussLegendre` when both are loaded; the Integrals.jl extension
# adds an `integrate` method.
public GaussLegendre, integrate, gl_integrate

# AD-safe CDF/PDF-family helpers (src/gamma_ad.jl). ComposedDistributions
# imports `_ccdf_ad_safe` / `_logccdf_ad_safe` (racing-hazard composers) and
# ModifiedDistributions hooks `_pdf_ad_safe` (component densities in the
# quadrature), so the trio is a deliberate, semver-covered surface despite
# the underscore names (kept for parity with the CensoredDistributions
# source).
public _ccdf_ad_safe, _logccdf_ad_safe, _pdf_ad_safe
