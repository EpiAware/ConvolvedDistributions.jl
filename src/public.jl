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

# Solver-method dispatch (#77): the per-quantity multiple-dispatch
# extension points a downstream package (or this one) adds an analytic
# pair method to, plus the shared uniform-window CDF arithmetic a new
# delay family plugs its partial first moment into.
public convolved_cdf, convolved_logcdf, convolved_ccdf, convolved_logccdf,
       convolved_pdf, convolved_logpdf, convolved_quantile,
       convolved_minimum, uniform_window_cdf

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
