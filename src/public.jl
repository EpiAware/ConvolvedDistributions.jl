# Public API declarations for Julia 1.11+ (public but not exported). These form
# the surface ComposedDistributions re-exports downstream, so keep it clean.

# Convolution / difference / product / ratio distribution types, and the
# multi-base algebraic-combination family supertype they subtype. `Product`
# is public, not exported, so it never clashes with Distributions' deprecated
# exported `Product`; construct via the exported `product` verb. `Ratio` is
# exported directly (`Distributions` exports no `Ratio`), so it needs no
# `public` declaration here.
public Convolved, Product, AbstractConvolvedDistribution

# Interface-contract verifiers (`TestUtils.test_convolved_interface`,
# `TestUtils.test_abstract_membership`) for downstream family members.
public TestUtils

# Solver-method supertype. `AnalyticalSolver` and `NumericSolver` are exported
# in the main module.
public AbstractSolverMethod

# Queryable evaluation path (#92): reports which route (`:analytic` or
# `:numeric`) a Convolved/Difference/Product/Ratio will take for its density
# and CDF, without evaluating either, and the boolean convenience form.
# `is_exact` (#85, #89) is the orthogonal predicate for whether that route
# carries any quadrature error at all: true for a closed form OR the exact
# discrete lattice/divisor fold (which reports `:numeric` route-wise).
public evaluation_path, has_closed_form, is_exact

# Pluggable integration: the default solver, the entry point, and the
# quadrature helper. `GaussLegendre` stays unexported to avoid clashing with
# `Integrals.GaussLegendre` when both are loaded; the Integrals.jl extension
# adds an `integrate` method.
public GaussLegendre, integrate, gl_integrate

# Solver-method dispatch (#77): the per-quantity multiple-dispatch
# extension points a downstream package (or this one) adds an analytic
# pair method to (on a tuple-typed `components` argument -- see review
# A on #137), plus the shared uniform-window CDF arithmetic a new
# distribution family plugs its `partial_expectation` into.
public convolved_cdf, convolved_logcdf, convolved_ccdf, convolved_logccdf,
       convolved_pdf, convolved_logpdf, convolved_quantile,
       convolved_minimum, uniform_window_cdf, uniform_window_ccdf,
       partial_expectation, upper_partial_expectation

# The same per-quantity dispatch extension points as above, for
# `Difference`: a downstream package adds its own analytic X/Y pair by
# defining a method on a two-element tuple TYPE more specific than
# `(Difference, Tuple, Real, AnalyticalSolver)`.
public difference_cdf, difference_logcdf, difference_ccdf,
       difference_logccdf, difference_pdf, difference_logpdf,
       difference_quantile
# The analytic-closed-form registries `convolved`/`product` consult before
# falling back to pairwise collapse or numeric quadrature: `convolve_pair`
# for a two-component sum, `convolve_power`/`product_power` for a k-fold
# repeat of one distribution. A downstream package adds a method to one of
# these for its own distribution type to register a closed form, rather
# than overloading a private internal.
public convolve_pair, convolve_power, product_power

# The probability generating function primitive (#90), mirroring
# Distributions.jl's mgf/cf: E[s^X] for a discrete distribution, with
# closed forms, a truncated-series fallback, and the structural Convolved
# product. Not exported so it never shadows a downstream `pgf` (there is
# no such name in Distributions.jl itself).
public pgf

# Shared numeric quantile (inverse-CDF) inversion (#112): the stub lives
# in the core package so the name is public and documented from here,
# but the method itself is added by the ConvolvedDistributionsOptimizationExt
# extension. Other EpiAware packages needing the same numeric inversion
# (e.g. CensoredDistributions) reuse this instead of their own copy.
# `quantile_initial_guess` is the paired hook for the Nelder-Mead
# starting point: default methods live with each type in the core
# package, so a downstream package can override the guess without
# forking the solve itself.
public quantile_by_optimization, quantile_initial_guess

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
