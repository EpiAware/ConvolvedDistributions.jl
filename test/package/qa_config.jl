# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# QA configuration values the managed `quality.jl` testset reads. Fill in the
# package-specific inputs the shared helpers need; the standard testset logic
# stays in `quality.jl` (managed). Edit freely.

using ConvolvedDistributions

const QA_CONFIG = (
    # The module under test.
    mod = ConvolvedDistributions,

    # Path to the isolated JET environment (see test/jet/Project.toml).
    jet_env = joinpath(@__DIR__, "..", "jet"),

    # Per-check Aqua relaxations, e.g. (; ambiguities = false). Empty = all on.
    aqua = (;),

    # ExplicitImports `ignore`: symbols an extension legitimately imports
    # non-publicly (kit-check order dependence; see EpiAwarePackageTools
    # issue on deterministic ExplicitImports scope).
    # - _gamma_cdf: EpiAwareADTools-internal AD-safe gamma CDF helper the
    #   native Gamma/Weibull analytic-pair closed forms (#77,
    #   src/analytic_pairs.jl) call directly so the per-backend AD rules
    #   keyed on it fire, mirroring CensoredDistributions' own use of it.
    ei_ignore = (:_gamma_cdf,),

    # Docstring `crossref_ignore`: upstream names docstrings link to via
    # `[`name`](@ref)`, e.g. (:pdf, :cdf, :logpdf).
    crossref_ignore = (),

    # Extra docstring-format options, e.g.
    # (; exported_only_examples = true, require_field_docs = true).
    docstring = (;),

    # README section-structure check. `path` is the package root (its
    # README.md). Override `required`/`order` to extend or relax the standard
    # section set, e.g.
    #   (; required = vcat(STANDARD_README_SECTIONS, [("Benchmarks",)]))
    # Empty `(;)` uses the standard structure in standard order.
    readme = (; path = joinpath(@__DIR__, "..", "..")),

    # Package extensions to ambiguity-check. Each entry:
    #   (; name = :MyPkgSomeTriggerExt,
    #      triggers = ("SomeTrigger",),       # packages to load first
    #      prefixes = ("MyPkg", "SomeTrigger"),
    #      expect_phantoms = false,    # true if a third party adds phantoms
    #      broken = false)             # true to quarantine a known ambiguity
    # Only extensions whose triggers are main-test-env deps are listed; the
    # Enzyme/Mooncake/ReverseDiff extensions are exercised by the dedicated
    # AD harness (test/ad), which proves gradient correctness directly.
    extensions = (
        (; name = :ConvolvedDistributionsIntegralsExt,
            triggers = ("Integrals",),
            prefixes = ("ConvolvedDistributions", "Integrals")),
        (; name = :ConvolvedDistributionsOptimizationExt,
            triggers = ("Optimization", "OptimizationOptimJL"),
            prefixes = ("ConvolvedDistributions",))
    )
)
