|                                                                                     | v0.2.0              | 5692d45ee2a0a1...   | v0.2.0 / 5692d45ee2a0a1... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0604 ± 0.0041 ms  | 0.0605 ± 0.0041 ms  | 1 ± 0.096                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.476 ± 0.053 ms    | 0.478 ± 0.052 ms    | 0.994 ± 0.15               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0546 ± 0.00047 ms | 0.0541 ± 0.00045 ms | 1.01 ± 0.012               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.262 ± 0.0059 ms   | 0.262 ± 0.0074 ms   | 1 ± 0.036                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.605 ± 0.022 ms    | 0.606 ± 0.024 ms    | 0.999 ± 0.053              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.25 ± 0.33 ms      | 2.24 ± 0.34 ms      | 1.01 ± 0.21                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0866 ± 0.0074 ms  | 0.0866 ± 0.0071 ms  | 1 ± 0.12                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.478 ± 0.051 ms    | 0.477 ± 0.056 ms    | 1 ± 0.16                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0667 ± 0.00063 ms | 0.0663 ± 0.00063 ms | 1.01 ± 0.013               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.557 ± 0.011 ms    | 0.557 ± 0.012 ms    | 1 ± 0.029                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.599 ± 0.022 ms    | 0.6 ± 0.021 ms      | 0.998 ± 0.051              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.56 ± 0.38 ms      | 2.56 ± 0.38 ms      | 1 ± 0.21                   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0742 ± 0.00058 ms | 0.0723 ± 0.00052 ms | 1.03 ± 0.011               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.123 ± 0.0072 ms   | 0.121 ± 0.0079 ms   | 1.01 ± 0.089               |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0725 ± 0.00028 ms | 0.0725 ± 0.00028 ms | 0.999 ± 0.0055             |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.299 ± 0.0085 ms   | 0.298 ± 0.0085 ms   | 1 ± 0.04                   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.596 ± 0.025 ms    | 0.596 ± 0.022 ms    | 0.999 ± 0.056              |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.48 ± 0.36 ms      | 2.51 ± 0.38 ms      | 0.989 ± 0.21               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 6.79 ± 0.3 μs       | 6.78 ± 0.2 μs       | 1 ± 0.054                  |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.051 ± 0.0076 μs   | 0.0513 ± 0.0068 μs  | 0.994 ± 0.2                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.574 ± 0.05 μs     | 0.574 ± 0.05 μs     | 1 ± 0.12                   |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.74 ± 1.7 μs       | 5.47 ± 0.83 μs      | 1.05 ± 0.35                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.77 ± 0.27 μs      | 4.84 ± 0.24 μs      | 0.986 ± 0.074              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.64 ± 0.16 μs      | 2.62 ± 0.17 μs      | 1.01 ± 0.089               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0931 ± 0.00073 ms | 0.0932 ± 0.00064 ms | 0.999 ± 0.01               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.146 ± 0.0078 ms   | 0.146 ± 0.0075 ms   | 1 ± 0.074                  |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0894 ± 0.00036 ms | 0.0896 ± 0.0003 ms  | 0.998 ± 0.0052             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.389 ± 0.0088 ms   | 0.394 ± 0.0089 ms   | 0.989 ± 0.032              |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.64 ± 0.025 ms     | 0.641 ± 0.023 ms    | 0.997 ± 0.053              |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.39 ± 0.35 ms      | 2.4 ± 0.37 ms       | 0.996 ± 0.21               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 7.72 ± 0.12 μs      | 7.7 ± 0.11 μs       | 1 ± 0.021                  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.31 ± 0.13 μs      | 3.26 ± 0.075 μs     | 1.02 ± 0.047               |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.635 ± 0.097 μs    | 0.653 ± 0.1 μs      | 0.972 ± 0.21               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 6.05 ± 0.39 μs      | 6.09 ± 0.37 μs      | 0.992 ± 0.087              |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 28.9 ± 3.5 μs       | 28.7 ± 3.1 μs       | 1.01 ± 0.16                |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.4 ± 0.59 μs      | 17.1 ± 0.58 μs      | 1.02 ± 0.049               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.00098 ms  | 0.119 ± 0.00096 ms  | 1 ± 0.012                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.203 ± 0.011 ms    | 0.204 ± 0.01 ms     | 0.997 ± 0.072              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.126 ± 0.00057 ms  | 0.138 ± 0.00091 ms  | 0.909 ± 0.0073             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.536 ± 0.01 ms     | 0.537 ± 0.01 ms     | 0.998 ± 0.027              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.907 ± 0.023 ms    | 0.908 ± 0.026 ms    | 0.999 ± 0.038              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.3 ± 0.68 ms       | 4.32 ± 0.67 ms      | 0.995 ± 0.22               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 6.82 ± 0.27 μs      | 6.88 ± 0.37 μs      | 0.992 ± 0.066              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0508 ± 0.0067 μs  | 0.0507 ± 0.0068 μs  | 1 ± 0.19                   |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.577 ± 0.047 μs    | 0.573 ± 0.059 μs    | 1.01 ± 0.13                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.41 ± 0.85 μs      | 5.43 ± 0.83 μs      | 0.996 ± 0.22               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.74 ± 0.27 μs      | 4.84 ± 0.32 μs      | 0.979 ± 0.085              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.66 ± 0.18 μs      | 2.54 ± 0.11 μs      | 1.05 ± 0.082               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.145 ± 0.0017 ms   | 0.146 ± 0.0012 ms   | 0.989 ± 0.014              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.238 ± 0.011 ms    | 0.239 ± 0.011 ms    | 0.996 ± 0.064              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.15 ± 0.00078 ms   | 0.148 ± 0.00084 ms  | 1.01 ± 0.0078              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.646 ± 0.0079 ms   | 0.645 ± 0.0081 ms   | 1 ± 0.018                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 1.02 ± 0.019 ms     | 0.976 ± 0.021 ms    | 1.04 ± 0.03                |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.21 ± 0.62 ms      | 4.23 ± 0.66 ms      | 0.995 ± 0.21               |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 7.7 ± 0.12 μs       | 7.67 ± 0.12 μs      | 1 ± 0.022                  |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.13 ± 0.1 μs       | 3.19 ± 0.17 μs      | 0.982 ± 0.06               |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.605 ± 0.098 μs    | 0.612 ± 0.092 μs    | 0.989 ± 0.22               |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.83 ± 0.36 μs      | 5.84 ± 0.4 μs       | 0.997 ± 0.092              |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 28.7 ± 4.4 μs       | 28.9 ± 3.5 μs       | 0.991 ± 0.19               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 17.8 ± 0.61 μs      | 18.3 ± 0.73 μs      | 0.973 ± 0.051              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 6.84 ± 0.28 μs      | 6.93 ± 0.39 μs      | 0.986 ± 0.068              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.078 ± 0.0075 μs   | 0.078 ± 0.01 μs     | 0.999 ± 0.16               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.66 ± 0.054 μs     | 0.632 ± 0.053 μs    | 1.04 ± 0.12                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.75 ± 0.67 μs      | 5.74 ± 0.64 μs      | 1 ± 0.16                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.73 ± 1 μs         | 6.98 ± 0.83 μs      | 0.964 ± 0.18               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.3 ± 0.88 μs      | 10.1 ± 0.4 μs       | 1.02 ± 0.096               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.127 ± 0.0012 ms   | 0.123 ± 0.00098 ms  | 1.03 ± 0.013               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.212 ± 0.011 ms    | 0.211 ± 0.011 ms    | 1.01 ± 0.074               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.127 ± 0.0006 ms   | 0.128 ± 0.00057 ms  | 0.995 ± 0.0065             |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.564 ± 0.0094 ms   | 0.563 ± 0.0099 ms   | 1 ± 0.024                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.948 ± 0.021 ms    | 0.941 ± 0.019 ms    | 1.01 ± 0.03                |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.74 ± 0.68 ms      | 4.76 ± 0.69 ms      | 0.994 ± 0.2                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.151 ± 0.0013 ms   | 0.156 ± 0.0012 ms   | 0.968 ± 0.011              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.247 ± 0.011 ms    | 0.247 ± 0.011 ms    | 1 ± 0.064                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.151 ± 0.0011 ms   | 0.151 ± 0.00088 ms  | 0.999 ± 0.0093             |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.673 ± 0.0073 ms   | 0.673 ± 0.0071 ms   | 1 ± 0.015                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 1.03 ± 0.025 ms     | 1.02 ± 0.021 ms     | 1.01 ± 0.032               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.66 ± 0.67 ms      | 4.67 ± 0.69 ms      | 0.998 ± 0.21               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 7.69 ± 0.13 μs      | 7.72 ± 0.13 μs      | 0.996 ± 0.023              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.26 ± 0.1 μs       | 3.23 ± 0.17 μs      | 1.01 ± 0.062               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.595 ± 0.095 μs    | 0.615 ± 0.094 μs    | 0.967 ± 0.21               |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 6.03 ± 0.39 μs      | 6.1 ± 0.42 μs       | 0.989 ± 0.093              |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.6 ± 1.4 μs       | 17.9 ± 2 μs         | 0.984 ± 0.13               |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 21.7 ± 0.71 μs      | 22.4 ± 0.82 μs      | 0.969 ± 0.048              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 6.94 ± 0.14 μs      | 6.95 ± 0.15 μs      | 0.999 ± 0.03               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.34 ± 0.1 μs       | 7.69 ± 0.13 μs      | 0.955 ± 0.021              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.963 ± 0.058 μs    | 0.961 ± 0.051 μs    | 1 ± 0.08                   |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.36 ± 0.43 μs      | 6.32 ± 0.43 μs      | 1.01 ± 0.097               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.7 ± 1 μs         | 17.9 ± 1 μs         | 0.989 ± 0.079              |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 28 ± 0.78 μs        | 28.2 ± 0.85 μs      | 0.99 ± 0.041               |
| Baseline/Gamma/cdf                                                                  | 3.74 ± 0.42 μs      | 3.72 ± 0.43 μs      | 1 ± 0.16                   |
| Baseline/Gamma/logpdf                                                               | 2.79 ± 0.4 μs       | 2.77 ± 0.4 μs       | 1.01 ± 0.2                 |
| Baseline/Normal/cdf                                                                 | 1.57 ± 0.35 μs      | 1.64 ± 0.37 μs      | 0.955 ± 0.31               |
| Baseline/Normal/logpdf                                                              | 1.06 ± 0.041 μs     | 1.05 ± 0.04 μs      | 1 ± 0.054                  |
| Convolved/analytic/cdf batched                                                      | 2.7 ± 0.41 μs       | 2.69 ± 0.41 μs      | 1 ± 0.22                   |
| Convolved/analytic/cdf scalar                                                       | 24.7 ± 0.11 ns      | 24.7 ± 0.13 ns      | 1 ± 0.0069                 |
| Convolved/analytic/construction                                                     | 3.48 ± 0.01 ns      | 3.48 ± 0.001 ns     | 1 ± 0.0029                 |
| Convolved/analytic/logpdf batched                                                   | 1.09 ± 0.044 μs     | 1.09 ± 0.038 μs     | 1 ± 0.053                  |
| Convolved/analytic/logpdf broadcast                                                 | 2.35 ± 0.41 μs      | 2.35 ± 0.39 μs      | 1 ± 0.24                   |
| Convolved/analytic/logpdf scalar                                                    | 27.2 ± 0.26 ns      | 27.2 ± 0.26 ns      | 1 ± 0.014                  |
| Convolved/analytic/mean                                                             | 3.13 ± 0.01 ns      | 3.14 ± 0.01 ns      | 0.997 ± 0.0045             |
| Convolved/analytic/pdf batched                                                      | 1.1 ± 0.043 μs      | 1.1 ± 0.043 μs      | 1 ± 0.055                  |
| Convolved/analytic/pdf scalar                                                       | 30.8 ± 0.091 ns     | 30.8 ± 0.092 ns     | 1 ± 0.0042                 |
| Convolved/analytic/rand                                                             | 1.25 ± 0.066 μs     | 1.25 ± 0.066 μs     | 1 ± 0.075                  |
| Convolved/numeric/cdf batched                                                       | 0.833 ± 0.0035 ms   | 0.836 ± 0.0034 ms   | 0.997 ± 0.0058             |
| Convolved/numeric/cdf scalar                                                        | 15.5 ± 0.06 μs      | 15.5 ± 0.05 μs      | 1 ± 0.005                  |
| Convolved/numeric/construction                                                      | 3.48 ± 0.001 ns     | 3.48 ± 0.001 ns     | 1 ± 0.00041                |
| Convolved/numeric/logpdf batched                                                    | 0.65 ± 0.0088 ms    | 0.651 ± 0.0085 ms   | 0.998 ± 0.019              |
| Convolved/numeric/logpdf broadcast                                                  | 1.23 ± 0.011 ms     | 1.23 ± 0.011 ms     | 0.999 ± 0.013              |
| Convolved/numeric/logpdf scalar                                                     | 11.2 ± 0.021 μs     | 11.2 ± 0.03 μs      | 1 ± 0.0033                 |
| Convolved/numeric/mean                                                              | 6.06 ± 0.02 ns      | 5.98 ± 0.02 ns      | 1.01 ± 0.0048              |
| Convolved/numeric/pdf batched                                                       | 0.65 ± 0.0087 ms    | 0.65 ± 0.0085 ms    | 0.999 ± 0.019              |
| Convolved/numeric/pdf scalar                                                        | 11.2 ± 0.03 μs      | 11.2 ± 0.03 μs      | 1 ± 0.0038                 |
| Convolved/numeric/rand                                                              | 2.76 ± 0.42 μs      | 2.76 ± 0.43 μs      | 1 ± 0.22                   |
| Difference/analytic/cdf broadcast                                                   | 3.57 ± 0.44 μs      | 3.56 ± 0.43 μs      | 1 ± 0.17                   |
| Difference/analytic/cdf scalar                                                      | 12.4 ± 0.04 ns      | 12.4 ± 0.02 ns      | 0.999 ± 0.0036             |
| Difference/analytic/construction                                                    | 3.5 ± 0.001 ns      | 3.84 ± 0.001 ns     | 0.914 ± 0.00035            |
| Difference/analytic/logpdf broadcast                                                | 1.53 ± 0.37 μs      | 1.52 ± 0.37 μs      | 1.01 ± 0.34                |
| Difference/analytic/logpdf scalar                                                   | 17.2 ± 0.4 ns       | 17.4 ± 0.28 ns      | 0.988 ± 0.028              |
| Difference/analytic/mean                                                            | 3.13 ± 0.01 ns      | 3.49 ± 0.01 ns      | 0.899 ± 0.0039             |
| Difference/analytic/rand                                                            | 1.26 ± 0.065 μs     | 1.26 ± 0.06 μs      | 0.997 ± 0.07               |
| Difference/numeric/cdf broadcast                                                    | 1.31 ± 0.022 ms     | 1.31 ± 0.022 ms     | 1 ± 0.024                  |
| Difference/numeric/cdf scalar                                                       | 19.4 ± 0.1 μs       | 19.4 ± 0.1 μs       | 1 ± 0.0073                 |
| Difference/numeric/construction                                                     | 3.84 ± 0.001 ns     | 3.84 ± 0.001 ns     | 1 ± 0.00037                |
| Difference/numeric/logpdf broadcast                                                 | 1.51 ± 0.021 ms     | 1.52 ± 0.022 ms     | 0.999 ± 0.02               |
| Difference/numeric/logpdf scalar                                                    | 15.2 ± 0.1 μs       | 15 ± 0.13 μs        | 1.01 ± 0.011               |
| Difference/numeric/mean                                                             | 6.29 ± 0.001 ns     | 6.03 ± 0.02 ns      | 1.04 ± 0.0035              |
| Difference/numeric/rand                                                             | 2.77 ± 0.42 μs      | 2.76 ± 0.43 μs      | 1 ± 0.22                   |
| Product/analytic/cdf broadcast                                                      | 5.1 ± 0.045 μs      | 5.1 ± 0.043 μs      | 1 ± 0.012                  |
| Product/analytic/cdf scalar                                                         | 29.1 ± 0.2 ns       | 29.1 ± 0.19 ns      | 1 ± 0.0095                 |
| Product/analytic/construction                                                       | 3.84 ± 0.001 ns     | 3.84 ± 0.001 ns     | 1 ± 0.00037                |
| Product/analytic/logpdf broadcast                                                   | 2.18 ± 0.41 μs      | 2.17 ± 0.39 μs      | 1 ± 0.26                   |
| Product/analytic/logpdf scalar                                                      | 24.3 ± 0.23 ns      | 24.2 ± 0.21 ns      | 1 ± 0.013                  |
| Product/analytic/mean                                                               | 10.2 ± 0.03 ns      | 10.2 ± 0.021 ns     | 1 ± 0.0036                 |
| Product/analytic/rand                                                               | 1.7 ± 0.38 μs       | 1.7 ± 0.38 μs       | 1 ± 0.32                   |
| Product/numeric/cdf broadcast                                                       | 1.97 ± 0.021 ms     | 1.97 ± 0.021 ms     | 0.998 ± 0.015              |
| Product/numeric/cdf scalar                                                          | 23.3 ± 0.12 μs      | 23.3 ± 0.14 μs      | 1 ± 0.0079                 |
| Product/numeric/construction                                                        | 3.5 ± 0.001 ns      | 3.84 ± 0.001 ns     | 0.914 ± 0.00035            |
| Product/numeric/logpdf broadcast                                                    | 1.61 ± 0.021 ms     | 1.62 ± 0.02 ms      | 0.993 ± 0.018              |
| Product/numeric/logpdf scalar                                                       | 15.9 ± 0.09 μs      | 15.9 ± 0.11 μs      | 0.998 ± 0.009              |
| Product/numeric/mean                                                                | 6.14 ± 0.05 ns      | 6.14 ± 0.049 ns     | 1 ± 0.011                  |
| Product/numeric/rand                                                                | 2.76 ± 0.42 μs      | 2.76 ± 0.42 μs      | 1 ± 0.22                   |
| Quantile/Convolved analytic/grid                                                    | 0.589 ± 0.11 ms     | 0.589 ± 0.11 ms     | 1 ± 0.25                   |
| Quantile/Convolved analytic/median                                                  | 22.1 ± 0.88 μs      | 22.1 ± 0.85 μs      | 0.998 ± 0.055              |
| Quantile/Convolved numeric/median                                                   | 0.281 ± 0.0086 ms   | 0.282 ± 0.0086 ms   | 0.998 ± 0.043              |
| Quantile/Difference numeric/median                                                  | 0.342 ± 0.0099 ms   | 0.341 ± 0.0099 ms   | 1 ± 0.041                  |
| Quantile/Product numeric/median                                                     | 0.496 ± 0.012 ms    | 0.496 ± 0.012 ms    | 0.999 ± 0.033              |
| Timeseries/Convolved delay                                                          | 0.374 ± 0.015 μs    | 0.376 ± 0.014 μs    | 0.995 ± 0.054              |
| Timeseries/Gamma delay                                                              | 0.374 ± 0.014 μs    | 0.376 ± 0.014 μs    | 0.995 ± 0.052              |
| Timeseries/Poisson delay                                                            | 1.35 ± 0.024 μs     | 1.35 ± 0.023 μs     | 1 ± 0.025                  |
| time_to_load                                                                        | 0.893 ± 0.0023 s    | 0.874 ± 0.0043 s    | 1.02 ± 0.0057              |

|                                                                                     | v0.2.0                    | 5692d45ee2a0a1...         | v0.2.0 / 5692d45ee2a0a1... |
|:------------------------------------------------------------------------------------|:-------------------------:|:-------------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.088 k allocs: 11.6 kB   | 0.088 k allocs: 11.6 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 1.35 k allocs: 0.168 MB   | 1.35 k allocs: 0.168 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.04 k allocs: 4.7 kB     | 0.04 k allocs: 4.7 kB     | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.264 k allocs: 27.2 kB   | 0.264 k allocs: 27.2 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 2.08 k allocs: 0.666 MB   | 2.08 k allocs: 0.666 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 28.5 k allocs: 1.2 MB     | 28.5 k allocs: 1.2 MB     | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.151 k allocs: 22.6 kB   | 0.151 k allocs: 22.6 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 1.36 k allocs: 0.169 MB   | 1.36 k allocs: 0.169 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.081 k allocs: 7.2 kB    | 0.081 k allocs: 7.2 kB    | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.519 k allocs: 0.0521 MB | 0.519 k allocs: 0.0521 MB | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 2.07 k allocs: 0.665 MB   | 2.07 k allocs: 0.665 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 0.0327 M allocs: 1.23 MB  | 0.0327 M allocs: 1.23 MB  | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 2.35 k allocs: 0.639 MB   | 2.35 k allocs: 0.639 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 31.1 k allocs: 1.29 MB    | 31.1 k allocs: 1.29 MB    | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 2.37 k allocs: 0.633 MB   | 2.37 k allocs: 0.633 MB   | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 30.2 k allocs: 1.26 MB    | 30.2 k allocs: 1.26 MB    | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 24  allocs: 1.03 kB       | 24  allocs: 1.03 kB       | 1                          |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 0.289 k allocs: 0.0329 MB | 0.289 k allocs: 0.0329 MB | 1                          |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 0.238 k allocs: 9.92 kB   | 0.238 k allocs: 9.92 kB   | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 1                          |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 1                          |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 1                          |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 1                          |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 1                          |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 0.289 k allocs: 0.0331 MB | 0.289 k allocs: 0.0331 MB | 1                          |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 0.268 k allocs: 10.9 kB   | 0.268 k allocs: 10.9 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 0.093 k allocs: 5.09 kB   | 0.093 k allocs: 5.09 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 0.127 k allocs: 5.25 kB   | 0.127 k allocs: 5.25 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 0.27 k allocs: 12.5 kB    | 0.27 k allocs: 12.5 kB    | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 0.298 k allocs: 12 kB     | 0.298 k allocs: 12 kB     | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 0.033 k allocs: 1.2 kB    | 0.033 k allocs: 1.2 kB    | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 10  allocs: 0.5 kB        | 10  allocs: 0.5 kB        | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 11  allocs: 0.547 kB      | 11  allocs: 0.547 kB      | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 0.068 k allocs: 3.58 kB   | 0.068 k allocs: 3.58 kB   | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 0.198 k allocs: 16.1 kB   | 0.198 k allocs: 16.1 kB   | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 0.462 k allocs: 18.2 kB   | 0.462 k allocs: 18.2 kB   | 1                          |
| Baseline/Gamma/cdf                                                                  | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Baseline/Gamma/logpdf                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Baseline/Normal/cdf                                                                 | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Baseline/Normal/logpdf                                                              | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/cdf batched                                                      | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/cdf scalar                                                       | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/construction                                                     | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/logpdf batched                                                   | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/logpdf broadcast                                                 | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/logpdf scalar                                                    | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/mean                                                             | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/pdf batched                                                      | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/pdf scalar                                                       | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/rand                                                             | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/numeric/cdf batched                                                       | 24  allocs: 8.32 kB       | 24  allocs: 8.32 kB       | 1                          |
| Convolved/numeric/cdf scalar                                                        | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 1                          |
| Convolved/numeric/construction                                                      | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/numeric/logpdf batched                                                    | 25  allocs: 8.41 kB       | 25  allocs: 8.41 kB       | 1                          |
| Convolved/numeric/logpdf broadcast                                                  | 0.338 k allocs: 29.8 kB   | 0.338 k allocs: 29.8 kB   | 1                          |
| Convolved/numeric/logpdf scalar                                                     | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 1                          |
| Convolved/numeric/mean                                                              | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/numeric/pdf batched                                                       | 23  allocs: 7.5 kB        | 23  allocs: 7.5 kB        | 1                          |
| Convolved/numeric/pdf scalar                                                        | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 1                          |
| Convolved/numeric/rand                                                              | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/analytic/cdf broadcast                                                   | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/analytic/cdf scalar                                                      | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/construction                                                    | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/logpdf broadcast                                                | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/analytic/logpdf scalar                                                   | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/mean                                                            | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/rand                                                            | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/numeric/cdf broadcast                                                    | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Difference/numeric/cdf scalar                                                       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Difference/numeric/construction                                                     | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/numeric/logpdf broadcast                                                 | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Difference/numeric/logpdf scalar                                                    | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Difference/numeric/mean                                                             | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/numeric/rand                                                             | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/analytic/cdf broadcast                                                      | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/analytic/cdf scalar                                                         | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/construction                                                       | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/logpdf broadcast                                                   | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/analytic/logpdf scalar                                                      | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/mean                                                               | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/rand                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/numeric/cdf broadcast                                                       | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Product/numeric/cdf scalar                                                          | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Product/numeric/construction                                                        | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/numeric/logpdf broadcast                                                    | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Product/numeric/logpdf scalar                                                       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Product/numeric/mean                                                                | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/numeric/rand                                                                | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Quantile/Convolved analytic/grid                                                    | 5.71 k allocs: 0.324 MB   | 5.71 k allocs: 0.324 MB   | 1                          |
| Quantile/Convolved analytic/median                                                  | 0.265 k allocs: 15.6 kB   | 0.265 k allocs: 15.6 kB   | 1                          |
| Quantile/Convolved numeric/median                                                   | 0.339 k allocs: 19.6 kB   | 0.339 k allocs: 19.6 kB   | 1                          |
| Quantile/Difference numeric/median                                                  | 0.302 k allocs: 21.8 kB   | 0.302 k allocs: 21.8 kB   | 1                          |
| Quantile/Product numeric/median                                                     | 0.381 k allocs: 27 kB     | 0.381 k allocs: 27 kB     | 1                          |
| Timeseries/Convolved delay                                                          | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 1                          |
| Timeseries/Gamma delay                                                              | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 1                          |
| Timeseries/Poisson delay                                                            | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 1                          |
| time_to_load                                                                        | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 1                          |

