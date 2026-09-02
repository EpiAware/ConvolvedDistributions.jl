# Handoff: duck-typing for difference/product/ratio + ratio tutorial + verifier docs

> Written 2026-08-28 by the implementing agent for the next agent to pick up.
> **PR is already created and CI is green except one codecov check.** The remaining
> work is small and well-scoped.

---

## 1. What was asked (in the user's own words)

> "We recently added ducktyping for convolved. We need to do the same for all the
> other package features i.e product, difference etc etc. Please use subagents with a
> review → implement → review loop and follow the convolved implementation closely.
> Make a single PR. Monitor it to make sure the CI passes and fix as needed. Try to
> be as DRY as possible with as little duplication as you can get. Make sure up to
> date vs main. Ah — we also need a subagent to make a small doc in the style of the
> other package docs for Ratio (Z = X / Y), which is the only one that doesn't have
> one — make a PR for that please. I also don't see any docs for testing if a
> distribution will work for the package — I thought we had an interface for this?
> CI exists for a reason. Reminder to use subagents heavily to avoid getting stuck."

Summary of the request:
1. **Port duck-typing** (accept components that implement the Distributions.jl
   univariate interface *without* subtyping `UnivariateDistribution`) from just
   `convolved`/`Convolved` to the other three family members: `difference`/`Difference`,
   `product`/`Product`, `ratio`/`Ratio`. Follow the existing `Convolved` implementation
   (PR #216 / #215) closely. Use a review → implement → review loop with subagents.
2. **One single PR** for the port.
3. **DRY** — minimal duplication.
4. Make sure the branch is up to date with `main`.
5. **New Ratio tutorial** (`docs/src/getting-started/tutorials/ratio-distributions.jl`)
   in the style of the existing product/difference tutorials.
6. **Docs for the verification interface** (`TestUtils.test_component_interface`) —
   there was none.
7. **Monitor CI and fix as needed.**

---

## 2. Current state — DONE

### PR
- **https://github.com/EpiAware/ConvolvedDistributions.jl/pull/229**
  - Branch: `feat/duck-typed-components` (worktree at
    `/home/seabbs/code/EpiAware/convd-ducktype`), base `main` (up-to-date at `f90331a`).
  - 13 files changed, +623/−54 (13 source/test/docs files, `ratio-distributions.jl` new).

### What the PR does
- **Untyped struct params + inner constructors** for `Difference`, `Product`, `Ratio`
  (`X::X, Y::Y` with `where {X, Y}`), so components no longer need to subtype
  `UnivariateDistribution`.
- **Shared `Number`-rejection guard** — `_check_component`/`_check_components` moved to
  `src/interface.jl` (single DRY definition); `Convolved.jl` delegates with a comment
  pointing at the shared implementation.
- **Widened `_Discrete*` aliases** to `<:Any` so discrete duck leaves (those defining
  `Base.eltype <: Integer`) reach the exact lattice/divisor fold.
- **`_has_mixed_fold` kept bounded to real `UnivariateDistribution` components** so
  `is_exact` and the executed route cannot drift for duck+continuous pairs.
- **Untyped `difference_pair`/`product_pair`/`ratio_pair` fallbacks** so duck pairs
  route to numeric quadrature (mirrors `convolve_pair`).
- **Ratio's atom-at-zero denominator check guarded with `hasmethod(insupport)`** so a
  discrete duck that doesn't define `Distributions.insupport` is admitted rather than
  throwing a raw `MethodError` at construction.
- **New tutorial** `docs/src/getting-started/tutorials/ratio-distributions.jl`
  (mirrors product/difference tutorial structure; Gamma/Gamma ⇒ scaled BetaPrime
  closed form; analytic-vs-numeric CDF residual plot). Registered in
  `docs/pages.jl`, `docs/docs_config.jl` (heavy list + stub), FAQ.
- **"Verifying a duck-typed component"** section in `docs/src/developer/extending.md`
  documenting `test_component_interface` tiers, the `Base.eltype` requirement for
  discrete leaves, `strict = true`, and the `insupport` caveat for ratio denominators.
- **Tests**: duck-typed testitems across `Difference.jl`/`Product.jl`/`Ratio.jl`
  mirroring the Convolved coverage (construction, moments, Number rejection, verifier
  strict + non-strict, integration-slot duck numerically equal to real-`Uniform`
  reference, thin-leaf fails-on-the-call, discrete duck exact lattice/divisor fold,
  mixed duck+continuous falls back to quadrature, ratio denominator atom-at-zero).

### Local validation (already done)
- `Pkg.test(test_args=["skip_quality"])`: **8772 pass / 0 fail** (baseline main: 8630).
- `Pkg.test(test_args=["quality_only"])`: 106 pass (incl. doctests, Aqua, formatting).
- Full AD suite all 7 backends green locally.
- Full docs build executed the ratio tutorial end-to-end and rendered it; the only
  build failure was the *pre-existing* external linkcheck rate-limit (429/503) on
  `github.com`/`modifieddistributions.epiaware.org` — unrelated to this PR.
- Fresh-context reviewer raised 4 P2s — all fixed (insupport guard, mixed-fold
  docstring caveat, extra test cases, FAQ reword).

---

## 3. CI status (PR #229) — one check left

| Check | Status |
|---|---|
| test / test (1, ubuntu|macos|windows) | ✅ pass |
| test / test (pre, ubuntu|macos|windows) | ✅ pass |
| coverage / coverage (full suite + quality) | ✅ pass |
| codecov/project | ✅ pass |
| **codecov/patch** | ❌ **fail** (91.67% vs auto, 2 missed lines) |
| ad / all 7 backends | ✅ pass |
| pre-commit | ✅ pass |
| Documenter / Documentation + documenter/deploy (preview) | ✅ pass |
| downgrade-compat | ✅ pass |
| Benchmark (main) + Benchmark (pr) | ✅ pass |
| sync | ✅ pass |
| codecov/compare | ✅ pass |

**The only remaining fix: `codecov/patch`.**

### Details of the codecov/patch failure
- Report: `patch: 6 files, 24 lines, 22 hit, 2 miss, coverage 91.67%` vs base auto
  target (base overall 93.16%). The auto target for the patch is presumably the base
  patch coverage; 91.67% < target ⇒ fail. Threshold is 1% (`codecov.yml`).
- The 2 missed patch lines have not been conclusively pinned. From the coverage report
  (`src/interface.jl` shows line 407/408 = `_check_component`'s `c isa Number &&` and
  `throw` as 0-hit), the likely candidates are the newly-added guard paths in:
  - `src/interface.jl` — `_check_component`/`_check_components` Number-rejection throw
    branch (lines ~407–408, 416) and the `foreach` loop (~425–426);
  - `src/Difference.jl` 114–115, `src/Product.jl` 126–127 — `_check_component` call sites
    (instrumentation/line-mapping quirk — these constructors ARE exercised by tests);
  - `src/Ratio.jl` 136–137 (`_check_denominator`), 171/173–175 (`_has_atom_at_zero`
    guard branches).
- The `hasmethod(insupport)` guard branches in `_has_atom_at_zero` (the `is_discrete ||`
    return false and `hasmethod(...) || return false` lines) are the most likely real
    misses — they're exercised by the Ratio tests only on one side of each branch.
- Note codecov uses `after_n_builds: 8` + `wait_for_ci: true`; the status recomputes as
  the 8 flags upload. All 8 have uploaded (sessions: 8).

## 4. What to do next (pick up here)

1. **Pin the 2 missed lines.** Either
   - run local line coverage again:
     `julia --project=. --code-coverage=user -e 'using Pkg; Pkg.test(test_args=["skip_quality"])'`
     then inspect `src/*.jl.*cov` files, or
   - query the codecov API for the PR patch misses:
     `curl -s "https://api.codecov.io/api/v2/github/EpiAware/repos/ConvolvedDistributions.jl/commits/<HEAD_SHA>"` and inspect `report.files[].line_coverage`.
2. **Add a test** that exercises the missed branch(es). Cheapest candidates:
   - a `@test_throws ArgumentError difference(g, 2.0)` / `product(...)` / `ratio(...)`
     Number-rejection for each family (may already exist — verify which line is missed
     before adding);
   - a discrete duck WITHOUT `insupport` as a ratio denominator (already added —
     `NoInsupportDuckPoisson` in `test/distributions/Ratio.jl`) exercises the
     `hasmethod(insupport) || return false` guard; make sure both sides of each
     `_has_atom_at_zero` branch are hit;
   - a real `DiscreteUnivariateDistribution` denominator with atom at zero exercises
     the `y isa DiscreteUnivariateDistribution` path (already in Ratio tests via
     `Poisson`/`Geometric` — verify).
3. Push the test-only fix (no src change unless a branch is genuinely unreachable).
4. **Re-run CI and confirm `codecov/patch` flips to pass.** If it stays red purely
   because the *auto* target is stricter than 1% below base, a `codecov.yml` patch
   `target: auto` with `threshold: 1%` should already tolerate a 1.5-point drop — the
   2 misses are ~8 points, so test coverage is genuinely needed.
5. Paste the final CI screenshot into the PR. Ask the user for merge approval once all
   green (or merge directly if that's the house convention — recent PRs merge via
   standard merge queue/approval).

## 5. Recurring conventions that worked (keep for future EpiAware work)

- **Worktree + branch per feature**: `git worktree add -b feat/... ../convd-ducktype HEAD`
  keeps `main` clean; run tests in the worktree.
- **Subagent review loop**: ship each change through a fresh-context `reviewer` subagent
  (no shell, review-only) then fix P2s locally; cheap models with precise specs
  (drafters) work well for docs.
- **Test-discipline**: `@testitem`s + TestItemRunner; run the whole suite with
  `Pkg.test(test_args=["skip_quality"])`; run `Pkg.test(test_args=["quality_only"])`
  after touching docstrings; run the AD suite with
  `julia --project=test/ad test/ad/runtests.jl <backend>`.
- **Runic** for formatting: `julia --project=test/formatter -e 'using Runic; Runic.main(["-i", "src","test","docs","benchmark","ext"])'`.
- Docs full build executes heavy tutorials in subprocesses; external linkcheck
  rate-limits (429/503) are environmental, not the PR's fault.
- CI on this org is a large matrix (3 OS × 2 Julia + 7 AD backends + docs + benchmarks)
  and the queue is often slow; poll with `gh pr checks` in loops.

## 6. Key file map (this PR)

```
src/interface.jl          # + _check_component/_check_components (shared guard)
src/Convolved.jl          # thin: delegates Number guard to interface.jl
src/Difference.jl         # untyped struct/ctors, _Discrete<:Any, docstrings
src/Product.jl            # same + _check_mixed_atom_at_zero untyped
src/Ratio.jl              # same + _check_denominator/_has_atom_at_zero + insupport guard
src/solver_dispatch.jl    # unttyped difference_pair/product_pair/ratio_pair fallbacks
test/distributions/Difference.jl  # duck testitems
test/distributions/Product.jl     # duck testitems
test/distributions/Ratio.jl       # duck testitems
docs/src/getting-started/tutorials/ratio-distributions.jl   # NEW tutorial
docs/src/developer/extending.md   # "Verifying a duck-typed component" section
docs/pages.jl + docs/docs_config.jl + docs/src/getting-started/faq.md  # tutorial registration
```
