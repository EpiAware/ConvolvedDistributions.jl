# [Getting started with Julia](@id julia)

This guide helps you set up Julia for working with ConvolvedDistributions.jl, whether you are using the package for analysis or contributing to its development.
It is aimed at people familiar with other technical computing languages (R, Python, MATLAB) but new to Julia workflows.

!!! note
    If you are familiar with other languages for technical computing, these
    [noteworthy differences](https://docs.julialang.org/en/v1/manual/noteworthy-differences/)
    may be useful.

## What this guide is and isn't

This isn't a guide to learning Julia programming.
Instead, we give practical setup advice to get you working with ConvolvedDistributions.jl quickly.

**To learn Julia programming, we recommend:**
- [Julia Documentation - getting started](https://docs.julialang.org/en/v1/manual/getting-started/)
- [Julia learning resources](https://julialang.org/learning/)
- [Julia Discourse](https://discourse.julialang.org/) - community forum
- [Modern Julia Workflows](https://modernjuliaworkflows.org/) - best practices for Julia development

## Julia installation with juliaup

1. **Download juliaup**: This is the official cross-platform installer and updater for Julia.
   Go to the [juliaup GitHub repository](https://github.com/JuliaLang/juliaup) for installation instructions.

2. **Verify installation**: Open a terminal and type `julia` to start the Julia REPL.
   You should see a Julia prompt `julia>`.

**Why juliaup?** Easy version management, automatic updates, and simple switching between Julia versions for different projects.

👉 **Learn more**: [juliaup GitHub repository](https://github.com/JuliaLang/juliaup) for detailed usage instructions.

## Editor setup: VSCode with Julia extension

**Recommended setup:**

1. Install [Visual Studio Code](https://code.visualstudio.com/)
2. Install the Julia extension from the VS Code Extensions marketplace (search for "Julia")

**Key features:**
- **Integrated REPL**: Execute code directly from the editor
- **Test Explorer**: Run individual tests from the sidebar with coverage visualisation
- **Debugging**: Set breakpoints, inspect variables, step through code
- **Plot viewer**: Dedicated pane for visualisations
- **Symbol navigation**: Go to definitions, find references

👉 **Learn more**: [Julia VSCode documentation](https://www.julia-vscode.org/docs/stable/)

## Julia environments

Julia uses [**environments**](https://docs.julialang.org/en/v1/manual/code-loading/#Environments-1) to manage project dependencies.
Each project can have isolated packages and versions.

**Key concepts:**
- `Project.toml`: Lists project dependencies
- `Manifest.toml`: Records exact versions (like a lockfile)
- Environments can be [stacked](https://docs.julialang.org/en/v1/manual/code-loading/#Environment-stacks) so that global packages are available to projects

👉 **Learn more**: [Julia Pkg documentation](https://pkgdocs.julialang.org/v1/environments/)

### Using environments from the REPL

```julia-repl
julia> ]                    # Enter package mode
(@v1.11) pkg> activate .    # Activate current directory as environment
(myproject) pkg> add SomePackage   # Add package to project
(myproject) pkg> status     # See what's installed
```

**Common commands:**
- `activate .` - activate current directory as environment
- `activate --temp` - create temporary environment for experiments
- `instantiate` - install all dependencies listed in Project.toml

## Recommended packages for your global Julia environment

Install these in your Julia version environment (e.g. `@v1.11`) to make them available across projects:

```julia-repl
julia> ]
(@v1.11) pkg> add Revise OhMyREPL BenchmarkTools TestEnv
```

**Recommended packages:**
- **Revise**: Automatic code reloading - essential for development
- **OhMyREPL**: Better REPL with syntax highlighting
- **BenchmarkTools**: Performance measurement
- **TestEnv**: Easy switching to test environments

## startup.jl configuration

Automatically load tools by creating `~/.julia/config/startup.jl`:

```julia
atreplinit() do repl
    # Load Revise for automatic code reloading
    try
        @eval using Revise
    catch e
        @warn "error while importing Revise" e
    end

    # Load OhMyREPL for a better REPL experience
    try
        @eval using OhMyREPL
    catch e
        @warn "error while importing OhMyREPL" e
    end

    # Pkg convenience functions
    try
        @eval using Pkg
        @eval st() = Pkg.status()
        @eval up() = Pkg.update()
    catch e
        @warn "error while importing Pkg" e
    end
end
```

## Working with ConvolvedDistributions.jl

### Installing and using the package

The package is not yet registered, so add it by URL (see [Installation](@ref installation)):

```julia-repl
julia> ]
(@v1.11) pkg> add https://github.com/EpiAware/ConvolvedDistributions.jl

julia> using ConvolvedDistributions, Distributions

# Start using the package
julia> d = convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
julia> cdf(d, 5.0)
julia> z = difference(Normal(5.0, 1.0), Normal(2.0, 1.0))
julia> mean(z)
```

### Working with the tutorials

The [tutorials](@ref getting-started) are Literate.jl scripts that can be run directly in the REPL or as standalone Julia scripts.
See the [FAQ](@ref faq) for instructions on running them.

### Development workflow (for contributors)

If you want to contribute to the package, see the [Contributing guide](@ref contributing) and [Developer FAQ](@ref developer-faq) for detailed guidance.

```bash
# Clone and enter package directory
git clone https://github.com/EpiAware/ConvolvedDistributions.jl.git
cd ConvolvedDistributions.jl

# Start Julia in the package environment
julia --project=.
```

```julia-repl
julia> using ConvolvedDistributions  # Load package (reloads automatically with Revise)

# Make changes to source code - they reload automatically
# Test changes interactively
julia> convolved(Gamma(2.0, 1.0), LogNormal(0.5, 0.4))
```

### Running tests

```julia-repl
julia> ]
(ConvolvedDistributions) pkg> test    # Run all tests

# Or from the command line
julia --project=. -e 'using Pkg; Pkg.test()'
```

### Quick environment switching

```julia-repl
julia> using TestEnv
julia> TestEnv.activate()    # Switch to the test environment with the package available
```

## Common issues and solutions

**Package not found:**
```julia-repl
julia> ]
pkg> activate .        # Ensure the correct environment
pkg> instantiate       # Install missing dependencies
```

**Changes not reflecting:**
- Ensure Revise is loaded in startup.jl
- Or restart Julia and reload your package

**Environment conflicts:**
```julia-repl
julia> ]
pkg> resolve    # Resolve version conflicts
pkg> update     # Update to compatible versions
```

## Next steps

With this setup, you are ready to:
- Work through the [Getting started](@ref getting-started) overview to learn ConvolvedDistributions.jl
- Explore the [API documentation](@ref public-api)
- [Contribute to the project](@ref contributing) if you are interested

## Additional resources

**Community and help:**
- [Julia Discourse](https://discourse.julialang.org/) - main community forum
- [Julia Slack](https://julialang.org/slack/) - real-time chat
- [JuliaCon](https://juliacon.org/) - annual conference with talks

**Package development:**
- [PkgTemplates.jl](https://github.com/JuliaCI/PkgTemplates.jl) - package templates with best practices
- [Julia Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/) - optimisation guide
- [JuliaHub](https://juliahub.com/) - discover packages and documentation
