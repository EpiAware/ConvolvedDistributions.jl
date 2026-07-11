module ConvolvedDistributionsSurvivalDistributionsExt

import EpiAwareADTools: cdf_ad_safe, ccdf_ad_safe,
                        logcdf_ad_safe, logccdf_ad_safe
import Distributions: logcdf
import SurvivalDistributions as SD

# AD-safe CDF family for `SurvivalDistributions.GeneralizedGamma`.
#
# GeneralizedGamma carries an inner `Gamma(nu/gamma, sigma^gamma)` and defines
# `logccdf(d, t) = logccdf(d.G, t^gamma)`. The stock `logccdf(::Gamma)` routes
# through `StatsFuns._gammalogccdf`, which has no `ForwardDiff.Dual` /
# `ReverseDiff.TrackedReal` / Mooncake method, so a convolution whose component
# is a GeneralizedGamma leaf errors under every AD backend when the numeric
# quadrature queries its `cdf` / `logccdf`.
#
# EpiAwareADTools differentiates the regularised lower incomplete gamma via
# its `cdf_ad_safe(::Gamma)` method, whose per-backend rules live in that
# package's AD extensions. Routing the inner Gamma through it at the
# transformed point `t^gamma` makes the GeneralizedGamma CDF family
# differentiate everywhere the plain `Gamma` path does, mirroring the
# `*_ad_safe(::Gamma)` methods. The `t^gamma` transform and the inner
# `shape`/`scale` (functions of `nu`, `gamma`, `sigma`) are elementary, so the
# gradient flows through all three parameters.
#
# `SurvivalDistributions.LogLogistic` needs no special AD routing here: its
# `logccdf` is built from elementary operations (`log1p`/`exp`), so it
# differentiates through the generic elementary `logccdf` fallback under every
# backend without a `*_ad_safe` method.

function _gg_cdf(d::SD.GeneralizedGamma, u::Real)
    return cdf_ad_safe(d.G, u^d.gamma)
end

function cdf_ad_safe(d::SD.GeneralizedGamma, u::Real)
    u <= 0 && return zero(float(u))
    return _gg_cdf(d, u)
end

function ccdf_ad_safe(d::SD.GeneralizedGamma, u::Real)
    u <= 0 && return one(float(u))
    return 1 - _gg_cdf(d, u)
end

function logcdf_ad_safe(d::SD.GeneralizedGamma, u::Real)
    u <= 0 && return oftype(float(u), -Inf)
    return log(_gg_cdf(d, u))
end

function logccdf_ad_safe(d::SD.GeneralizedGamma, u::Real)
    u <= 0 && return zero(float(u))
    return log1p(-_gg_cdf(d, u))
end

# The public `logcdf(::GeneralizedGamma, t)` must be AD-safe too, not just the
# `*_ad_safe` hook methods above. `SurvivalDistributions` defines
# `logccdf(GG, t) = logccdf(d.G, t^gamma)` but no `logcdf`, so a direct
# `logcdf(GeneralizedGamma(θ...), t)` falls through to the generic
# `Distributions.logcdf`, which evaluates the inner Gamma's `logcdf` →
# `StatsFuns._gammalogcdf`. That has no `ForwardDiff.Dual` /
# `ReverseDiff.TrackedReal` / Mooncake method, so under any AD backend it strips
# the `Dual` and throws. Routing `logcdf` through the AD-safe helper makes a
# bare `logcdf` differentiate everywhere. `cdf`/`ccdf`/`logccdf` are owned by
# `SurvivalDistributions` (redefining them here is method-overwriting piracy
# and breaks precompilation), so they are left to the `cdf_ad_safe` /
# `ccdf_ad_safe` / `logccdf_ad_safe` hooks. Only `logcdf` is unclaimed and so
# safely AD-routed at the public method.
logcdf(d::SD.GeneralizedGamma, t::Real) = logcdf_ad_safe(d, t)

end # module
