# Public API declarations for Julia 1.11+ (public but not exported). These form
# the surface ComposedDistributions re-exports downstream, so keep it clean.

# Convolution / difference / product distribution types, and the multi-base
# algebraic-combination family supertype they subtype. `Product` is public,
# not exported, so it never clashes with Distributions' deprecated exported
# `Product`; construct via the exported `product` verb.
public Convolved, Product, AbstractConvolvedDistribution

# A caller-supplied PMF wrapper (masses + grid width) for repeated
# `convolve_series`/`pdf` reuse without rebuilding; this package does not
# discretise continuous delays itself (#68).
public DelayPMF

# Interface-contract verifiers (`TestUtils.test_convolved_interface`,
# `TestUtils.test_abstract_membership`) for downstream family members.
public TestUtils

# Solver-method supertype. `AnalyticalSolver` and `NumericSolver` are exported
# in the main module.
public AbstractSolverMethod

# Queryable evaluation path (#92): reports which route (`:analytic` or
# `:numeric`) a Convolved/Difference/Product will take for its density and
# CDF, without evaluating either, and the boolean convenience form.
public evaluation_path, has_closed_form

# Pluggable integration: the default solver, the entry point, and the
# quadrature helper. `GaussLegendre` stays unexported to avoid clashing with
# `Integrals.GaussLegendre` when both are loaded; the Integrals.jl extension
# adds an `integrate` method.
public GaussLegendre, integrate, gl_integrate

# The AD-safe CDF/PDF-family hooks this package used to own
# (`_cdf_ad_safe` and friends) now live in EpiAwareADTools.jl under
# underscore-free names (`cdf_ad_safe`, `logcdf_ad_safe`, `ccdf_ad_safe`,
# `logccdf_ad_safe`, `pdf_ad_safe`, plus the tape-strip pair `primal` /
# `primal_distribution`). Wrapper packages extend those names by depending
# on EpiAwareADTools directly; they are deliberately not re-exported here.
