# [Contributing](@id contributing)

This page details the guidelines to follow when contributing to ConvolvedDistributions.jl.

## Getting started

Before contributing, please:
1. New to Julia development? Start from the [EpiAware site](https://epiaware.org/)
2. **Install Task** for the development workflows below:
   - **macOS**: `brew install go-task/tap/go-task`
   - **Linux**: Download from [releases](https://github.com/go-task/task/releases) or use your package manager
   - **Windows**: `winget install Task.Task` or download from releases
3. Check out the [developer documentation](@ref developer) for advanced workflows
4. Review the project structure and development commands below

## Project structure

ConvolvedDistributions.jl uses several environments for different purposes.

```
ConvolvedDistributions.jl/
├── Project.toml            # Main package environment
├── src/                    # Package source
│   ├── ConvolvedDistributions.jl  # Module file: exports and centralised imports
│   ├── docstrings.jl       # DocStringExtensions @template registration
│   ├── interface.jl        # AbstractConvolvedDistribution family supertype
│   ├── Convolved.jl        # convolved and the Convolved type
│   ├── Difference.jl       # difference and the Difference type
│   ├── convolve_with_vector.jl  # timeseries form of convolved
│   ├── solvers.jl          # AnalyticalSolver / NumericSolver method types
│   ├── integration.jl      # shared Gauss-Legendre quadrature layer
│   ├── TestUtils.jl        # interface-contract verifiers for the family
│   └── public.jl           # public (non-exported) bindings
├── ext/                    # Package extensions (AD rules, Integrals,
│                           # Optimization quantile, SurvivalDistributions)
├── test/
│   ├── Project.toml        # Test environment
│   ├── runtests.jl         # Main test entry (TestItemRunner)
│   ├── distributions/      # Unit tests (Convolved, Difference, quantile,
│   │                       # timeseries convolution)
│   ├── integration/        # Quadrature-layer tests
│   ├── package/            # Quality gates plus the family interface test
│   ├── ad/                 # AD gradient harness (own environment)
│   ├── jet/                # JET static analysis (isolated environment)
│   ├── formatter/          # JuliaFormatter check (isolated environment)
│   └── ADFixtures/         # AD gradient scenario registry
├── docs/
│   ├── Project.toml        # Documentation environment
│   ├── make.jl             # Documentation build script
│   ├── pages.jl            # Documentation navigation tree
│   └── src/                # Documentation source files
└── benchmark/
    ├── Project.toml        # Benchmark environment
    └── benchmarks.jl       # Benchmark suite definition
```

Files carrying a `MANAGED by EpiAwarePackageTools.scaffold` header are owned by the shared kit and rewritten on every sync.
See [EpiAwarePackageTools](https://github.com/EpiAware/EpiAwarePackageTools.jl) for which files are managed and which are yours to edit.

## Development commands

This project includes a Taskfile for the development workflows.

### Quick start with tasks

```bash
# Discover all available tasks
task --list

# Common development workflow
task setup      # One-time environment setup (all sub-environments)
task dev        # Format + pre-commit + fast tests + fast docs
task precommit  # Pre-commit validation

# Individual workflows
task test-fast  # Quick testing (skips quality checks)
task docs       # Full documentation build
task benchmark  # Run benchmarks
```

### Detailed commands

For advanced usage, or when tasks don't cover a specific need, use the underlying Julia commands:

```bash
# Full test suite (recommended for CI and final checks)
julia --project=. -e 'using Pkg; Pkg.test()'

# Run tests directly (faster during development)
julia --project=test test/runtests.jl

# Skip quality tests for faster development iteration
julia --project=test test/runtests.jl skip_quality

# Run only the quality tests
julia --project=test test/runtests.jl quality_only

# Build complete documentation (includes Literate tutorial processing)
julia --project=docs docs/make.jl

# Execute the benchmark suite
task benchmark
```

## Testing strategy

### Test organisation

- **Unit tests**: In `test/distributions/` (`Convolved.jl`, `Difference.jl`, `quantile.jl`, `convolve_with_vector.jl`) plus the quadrature-layer tests in `test/integration/`
- **Quality tests**: Located in `test/package/`, tagged `:quality`, alongside the family interface test (`interface.jl`)
- **AD gradient tests**: Located in `test/ad/`, tagged `:ad`, with their own environment and dedicated per-backend CI

Tests are `@testitem`s discovered with [TestItemRunner](https://github.com/julia-vscode/TestItemRunner.jl).
The main entry (`test/runtests.jl`) accepts `skip_quality`, `quality_only`, and `readme_only` arguments to scope discovery, and excludes `:ad`-tagged items (they run from `test/ad/runtests.jl`).

### Quality gates

The quality gates in `test/package/` guard the package's health:

- **Aqua.jl**: Common package issues (stale deps, ambiguities, piracy)
- **ExplicitImports.jl**: No implicit or stale imports, and import centralisation
- **JET.jl**: Static analysis for type stability (run from the isolated `test/jet` environment)
- **JuliaFormatter**: Formatting check (run from the isolated `test/formatter` environment)
- **Docstring format**: Every docstring matches the [`src/docstrings.jl`](https://github.com/EpiAware/ConvolvedDistributions.jl/blob/main/src/docstrings.jl) template
- **Doctest** and **README section** checks, plus an extension-ambiguity check

Run them all with `task test-quality`, or a single isolated gate directly:

```bash
task test-jet         # JET static analysis
task test-formatting  # JuliaFormatter check
```

### AD gradient harness

The convolution and difference log densities must differentiate cleanly across every backend the ecosystem uses.
The harness in `test/ad/` sweeps the scenarios registered in `test/ADFixtures/` across six backends: ForwardDiff, ReverseDiff, Enzyme (reverse and forward), and Mooncake (reverse and forward), each an `@testitem` tagged for per-backend CI selection.
The scenarios cover both the analytic and numeric (quadrature) paths of `Convolved`, `Difference`, and `Product`, plus the timeseries convolution.

```bash
task test-ad                          # all backends
task test-ad-backend TAG=enzyme_reverse  # a single backend
```

Each scenario carries a ForwardDiff reference gradient the other backends are checked against.
When you add functionality touching the density or quadrature paths, add a matching scenario to `test/ADFixtures/src/ADFixtures.jl` so the sweep covers it.

## Documentation

### Literate.jl tutorials

The tutorials are [Literate.jl](https://fredrikekre.github.io/Literate.jl/) scripts located in `docs/src/getting-started/tutorials/`.
These are converted to markdown during the documentation build.

Tutorials are plain Julia `.jl` files using Literate's `#` comment lines for markdown.
You can run them directly in the REPL or as scripts.

1. **Adding a new tutorial**:
   - Create a `.jl` file in `docs/src/getting-started/tutorials/`
   - Register it in `docs/docs_config.jl` and add the generated `.md` file to `docs/pages.jl`
2. **Tutorial format**:
   ```julia
   # # Tutorial title
   #
   # Introduction text.

   using ConvolvedDistributions, Distributions

   # ## Section

   convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
   ```

### Documentation structure

- `docs/src/getting-started/`: User-facing documentation
- `docs/src/lib/`: API documentation (auto-generated)
- `docs/src/developer/`: Developer and contributor documentation

## Style guide

This project follows the [SciML style guide](https://github.com/SciML/SciMLStyle).

Key points:
- Use descriptive variable names
- Follow Julia naming conventions (snake_case for variables, CamelCase for types)
- Write docstrings for exported functions
- Keep lines under 80 characters where possible
- Use consistent indentation (4 spaces)

### Documentation standards

All docstrings use the DocStringExtensions.jl `@template` conventions registered in `src/docstrings.jl`.
That file is `include`d near the top of the module, before any docstrings are defined, so the templates apply everywhere.
The `DocStringExtensions` import itself lives in the module file (`src/ConvolvedDistributions.jl`) rather than in `docstrings.jl`, because the kit's import-centralisation gate requires every import to sit in the module file.

**Functions**: Use `$(TYPEDSIGNATURES)` for automatic signature generation:
```julia
@doc "
$(TYPEDSIGNATURES)

Brief description of the function.

# Arguments
- `param1`: Description (no type annotations needed)
- `param2`: Description

# Keyword Arguments
- `kwarg1`: Description
"
function my_function(param1, param2; kwarg1 = default)
    # implementation
end
```

**Structs**: Use `$(TYPEDEF)` with inline field documentation, which `$(TYPEDFIELDS)` renders:
```julia
@doc "
$(TYPEDEF)

Description of the struct.
"
struct MyStruct
    "Description of field1"
    field1::Type1
    "Description of field2"
    field2::Type2
end
```

**Key rules**:
- **Never use `@doc raw"`** - it bypasses the template system
- **Don't repeat type information** in argument descriptions, since `$(TYPEDSIGNATURES)` shows them
- **Use `@doc "` (not `@doc """`)** to allow macro expansion, unless the docstring carries LaTeX math
- **Document argument purpose**, not types

## Benchmarks

The suite in `benchmark/benchmarks.jl` reads the cost of the convolution and difference operations on both the analytic and numeric quadrature paths.

```bash
task benchmark                 # benchmark the current state
task benchmark-compare         # compare main vs current
task benchmark -- --filter=Convolved   # filter to specific benchmarks
```

Benchmark results recorded on `main` are rendered on the Benchmarks documentation page.

## Code quality

### Pre-commit checklist

Before submitting a pull request:

1. **Run pre-commit checks** (recommended):
   ```bash
   task precommit
   ```
2. **Or run individual checks**:
   ```bash
   task test        # Full test suite
   task docs-fast   # Build documentation
   ```

## Adding new features

1. **Write tests first**: Add a test file under `test/distributions/` (or `test/integration/` for quadrature work)
2. **Implement the feature**: Add the type and constructor in `src/`, following [Adding a new combination](@ref extending)
3. **Add an AD scenario**: Register a gradient scenario in `test/ADFixtures/`
4. **Document the feature**: Add docstrings and update documentation if needed
5. **Test thoroughly**: Run the full test suite

## Getting help

- **Questions**: Open a GitHub discussion
- **Bugs**: File a GitHub issue with a minimal reproducible example
- **Feature requests**: Open a GitHub issue with rationale and use case
- **General Julia help**: See [Julia Discourse](https://discourse.julialang.org/) or [Julia Slack](https://julialang.org/slack/)

Thank you for contributing to ConvolvedDistributions.jl!
