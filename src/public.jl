# Public API declarations for Julia 1.11+ (public but not exported). These form
# the surface ComposedDistributions re-exports downstream, so keep it clean.

# Convolution / difference / product distribution types, and the multi-base
# algebraic-combination family supertype they subtype. `Product` is public,
# not exported, so it never clashes with Distributions' deprecated exported
# `Product`; construct via the exported `product` verb.
public Convolved, Product, AbstractConvolvedDistribution

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

# Shared numeric quantile (inverse-CDF) inversion (#112): the stub lives
# in the core package so the name is public and documented from here,
# but the method itself is added by the ConvolvedDistributionsOptimizationExt
# extension. Other EpiAware packages needing the same numeric inversion
# (e.g. CensoredDistributions) reuse this instead of their own copy.
public quantile_by_optimization

# The time-varying `convolve_series` extension point: how one delay's lag
# masses are read. Defaults to the delay's own single-delay method, so a
# delay type only adds one when its masses differ from that.
public delay_masses

# The AD-safe CDF/PDF-family hooks this package used to own
# (`_cdf_ad_safe` and friends) now live in EpiAwareADTools.jl under
# underscore-free names (`cdf_ad_safe`, `logcdf_ad_safe`, `ccdf_ad_safe`,
# `logccdf_ad_safe`, `pdf_ad_safe`, plus the tape-strip pair `primal` /
# `primal_distribution`). Wrapper packages extend those names by depending
# on EpiAwareADTools directly; they are deliberately not re-exported here.
