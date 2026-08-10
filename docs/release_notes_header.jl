# PACKAGE-OWNED — scaffold writes this once and never overwrites it.
#
# Header content for the release notes page. The managed `make.jl` prepends
# this to the project-root NEWS.md when both exist.

const RELEASE_NOTES_HEADER = """
```@meta
EditURL = "https://github.com/EpiAware/ConvolvedDistributions.jl/releases"
```

# Release notes

Every release of this package is published as a GitHub release.
The most recent are reproduced below, as they were written there.

"""
