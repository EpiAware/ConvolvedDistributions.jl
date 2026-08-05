# Shared, type-agnostic exact-discrete-fold helpers (#85, #89).
#
# `Convolved`, `Difference`, and `Product` each compute an exact pmf/cdf
# by summing over the integer lattice when every component is
# integer-lattice discrete (see `_component_support`/`_exact_discrete_route`
# in `src/interface.jl`). These helpers do the actual summation; the
# per-type fold functions (`_convolved_lattice_pdf` etc.) build the
# window and the summand.
#
# This is dedicated code, not a solver plugged into the `integrate` layer
# (`src/integration.jl`): `integrate` is contracted as "integrate a
# function over `[lower, upper]`", and a lattice sum computes a different
# functional (a sum over integer points), not an approximation of that
# integral. Every solver in the `integrate` slot is interchangeable —
# swapping quadrature rules approximates the same quantity — so putting a
# lattice sum there would let a caller pass it for a continuous
# combination and silently get the wrong answer.

# Integer lattice points inside `[lo, hi]`, as primal `Int`s. The bounds
# are window endpoints (see `_finite_window` in `src/Convolved.jl`), i.e.
# quadrature-style hyperparameters, so they are stripped of any AD tracer
# before rounding, exactly as `_panel_breaks` strips its breaks. `(1, 0)`
# is the canonical empty range (any `t1 < t0` pair works; callers check
# `t1 < t0`, not the specific values).
function _lattice_range(lo, hi)
    lop = Float64(primal(lo))
    hip = Float64(primal(hi))
    (isnan(lop) || isnan(hip) || hip < lop) && return (1, 0)
    return (ceil(Int, lop), floor(Int, hip))
end

# As `_lattice_range`, but strictly above `lo` — the discrete CDF's
# saturation cut is inclusive in the closed-form term, so the fold must
# start one lattice point above it (`floor(lo) + 1` is `ceil(lo)` off the
# lattice when `lo` is itself an integer and `lo + 1` on it, which is
# what excluding the cut means).
function _lattice_range_above(lo, hi)
    lop = Float64(primal(lo))
    hip = Float64(primal(hi))
    (isnan(lop) || isnan(hip)) && return (1, 0)
    return (floor(Int, lop) + 1, floor(Int, hip))
end

# Exact fold over the lattice points `t0:t1`, assumed non-empty (callers
# return their own typed zero for an empty range, as the quadrature paths
# do for a degenerate window). The accumulator is seeded from the FIRST
# term, mirroring `_gl_reduce`'s seeding from the first node, so the
# element type comes from the integrand and component `Dual`s / tracked
# reals propagate. Nothing is mutated and no lattice index reaches the
# tape (they are primal `Int`s), so ReverseDiff's `TrackedArray`
# `setindex!` trap (#44) cannot arise.
function _lattice_sum(f::F, t0::Int, t1::Int) where {F}
    acc = f(t0)
    for t in (t0 + 1):t1
        acc += f(t)
    end
    return acc
end
