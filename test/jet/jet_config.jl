# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# Optional JET configuration for the isolated runner (test/jet/runtests.jl). If
# this file defines `JET_REPORT_FILTER` (a `report -> Bool` predicate; a report
# is KEPT when it returns `true`), the runner switches from `test_package` to
# `report_package` + filter and fails only on reports the predicate keeps.
#
# The common need is a DynamicPPL `@model` package: JET emits a false
# `UndefVarErrorReport` for every `~`-assigned local (and `MethodErrorReport`s
# through the `:=` tracker), because the tilde macro hides the assignment from
# JET's static analysis. Uncomment the line below to drop exactly those:
#
# const JET_REPORT_FILTER = dynamicppl_model_filter
#
# Or write your own predicate. Leaving this file with no `JET_REPORT_FILTER`
# keeps the strict default (fail on any report).

# `_convolved_general_quantile` (src/solver_dispatch.jl) is `Convolved`'s
# numeric quantile fallback for three-or-more components: declared with
# no methods in core, since the Nelder-Mead implementation needs
# Optimization.jl and lives in the extension (S2.4). JET analyses core
# alone, so it correctly (but expectedly) reports that call as a
# possible `MethodError` -- calling `quantile` on such a pair genuinely
# errors without the extension loaded, by design, exactly as `quantile`
# itself required the extension for every case before this rewrite. Drop
# only that report; everything else stays strict.
function _no_quantile_extension_filter(report)
    !occursin("_convolved_general_quantile", sprint(show, report))
end

const JET_REPORT_FILTER = _no_quantile_extension_filter
