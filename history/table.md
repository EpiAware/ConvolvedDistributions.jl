|                                                                                     | v0.2.0              | 6373a26f5d46eb...   | v0.2.0 / 6373a26f5d46eb... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0626 ± 0.0036 ms  | 0.0632 ± 0.0036 ms  | 0.99 ± 0.08                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.477 ± 0.047 ms    | 0.469 ± 0.047 ms    | 1.02 ± 0.14                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.054 ± 0.00047 ms  | 0.0535 ± 0.00039 ms | 1.01 ± 0.011               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.255 ± 0.0079 ms   | 0.254 ± 0.0065 ms   | 1 ± 0.04                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.601 ± 0.033 ms    | 0.584 ± 0.028 ms    | 1.03 ± 0.075               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.27 ± 0.28 ms      | 2.19 ± 0.28 ms      | 1.04 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.087 ± 0.0068 ms   | 0.0861 ± 0.0068 ms  | 1.01 ± 0.11                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.474 ± 0.046 ms    | 0.467 ± 0.047 ms    | 1.02 ± 0.14                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0663 ± 0.00066 ms | 0.0658 ± 0.00067 ms | 1.01 ± 0.014               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.527 ± 0.014 ms    | 0.527 ± 0.014 ms    | 1 ± 0.037                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.598 ± 0.034 ms    | 0.582 ± 0.028 ms    | 1.03 ± 0.076               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.58 ± 0.34 ms      | 2.56 ± 0.34 ms      | 1.01 ± 0.19                |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.074 ± 0.00058 ms  | 0.0731 ± 0.00047 ms | 1.01 ± 0.01                |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.125 ± 0.0071 ms   | 0.125 ± 0.0075 ms   | 0.997 ± 0.082              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0695 ± 0.00017 ms | 0.0692 ± 0.00016 ms | 1 ± 0.0034                 |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.293 ± 0.0093 ms   | 0.292 ± 0.009 ms    | 1 ± 0.044                  |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.574 ± 0.039 ms    | 0.552 ± 0.023 ms    | 1.04 ± 0.083               |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.52 ± 0.31 ms      | 2.45 ± 0.31 ms      | 1.03 ± 0.18                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.21 ± 0.1 μs       | 7.25 ± 0.22 μs      | 0.994 ± 0.033              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0481 ± 0.016 μs   | 0.0471 ± 0.0074 μs  | 1.02 ± 0.37                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.531 ± 0.041 μs    | 0.544 ± 0.04 μs     | 0.976 ± 0.1                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.17 ± 0.72 μs      | 5.08 ± 0.76 μs      | 1.02 ± 0.21                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.51 ± 0.25 μs      | 4.53 ± 0.27 μs      | 0.997 ± 0.081              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.57 ± 0.092 μs     | 2.54 ± 0.079 μs     | 1.01 ± 0.048               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0937 ± 0.00074 ms | 0.0938 ± 0.00076 ms | 0.999 ± 0.011              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.146 ± 0.0075 ms   | 0.148 ± 0.0083 ms   | 0.991 ± 0.076              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0858 ± 0.00024 ms | 0.0855 ± 0.00026 ms | 1 ± 0.0042                 |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.378 ± 0.0096 ms   | 0.377 ± 0.0094 ms   | 1 ± 0.036                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.614 ± 0.036 ms    | 0.601 ± 0.024 ms    | 1.02 ± 0.072               |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.41 ± 0.3 ms       | 2.36 ± 0.29 ms      | 1.02 ± 0.18                |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.17 ± 0.086 μs     | 8.19 ± 0.08 μs      | 0.998 ± 0.014              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.37 ± 0.068 μs     | 3.36 ± 0.065 μs     | 1 ± 0.028                  |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.616 ± 0.082 μs    | 0.597 ± 0.083 μs    | 1.03 ± 0.2                 |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.76 ± 0.36 μs      | 5.71 ± 0.31 μs      | 1.01 ± 0.084               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.8 ± 3.1 μs       | 27.5 ± 3.1 μs       | 1.01 ± 0.16                |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.6 ± 0.48 μs      | 16.8 ± 0.38 μs      | 1.04 ± 0.037               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.001 ms    | 0.119 ± 0.0012 ms   | 0.998 ± 0.013              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.209 ± 0.011 ms    | 0.209 ± 0.01 ms     | 0.998 ± 0.071              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.117 ± 0.00057 ms  | 0.117 ± 0.00052 ms  | 0.998 ± 0.0066             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.502 ± 0.011 ms    | 0.504 ± 0.01 ms     | 0.997 ± 0.03               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.851 ± 0.04 ms     | 0.83 ± 0.025 ms     | 1.03 ± 0.057               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.31 ± 0.52 ms      | 4.18 ± 0.55 ms      | 1.03 ± 0.18                |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.21 ± 0.16 μs      | 7.22 ± 0.17 μs      | 0.999 ± 0.032              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0479 ± 0.016 μs   | 0.0472 ± 0.0085 μs  | 1.01 ± 0.38                |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.529 ± 0.043 μs    | 0.567 ± 0.042 μs    | 0.933 ± 0.1                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.15 ± 0.75 μs      | 5.05 ± 0.74 μs      | 1.02 ± 0.21                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.53 ± 0.26 μs      | 4.46 ± 0.26 μs      | 1.02 ± 0.083               |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.56 ± 0.082 μs     | 2.53 ± 0.081 μs     | 1.01 ± 0.046               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.145 ± 0.0013 ms   | 0.145 ± 0.0013 ms   | 1 ± 0.013                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.239 ± 0.012 ms    | 0.241 ± 0.011 ms    | 0.993 ± 0.068              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.139 ± 0.00074 ms  | 0.139 ± 0.00073 ms  | 1 ± 0.0075                 |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.623 ± 0.0095 ms   | 0.625 ± 0.0099 ms   | 0.997 ± 0.022              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.92 ± 0.037 ms     | 0.909 ± 0.022 ms    | 1.01 ± 0.048               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.25 ± 0.55 ms      | 4.14 ± 0.53 ms      | 1.03 ± 0.19                |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.1 ± 0.085 μs      | 8.04 ± 0.083 μs     | 1.01 ± 0.015               |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.22 ± 0.085 μs     | 3.19 ± 0.065 μs     | 1.01 ± 0.034               |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.571 ± 0.082 μs    | 0.57 ± 0.084 μs     | 1 ± 0.21                   |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.43 ± 0.4 μs       | 5.42 ± 0.32 μs      | 1 ± 0.094                  |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 27.6 ± 3 μs         | 27.1 ± 3 μs         | 1.02 ± 0.16                |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.5 ± 0.55 μs      | 17.9 ± 0.48 μs      | 1.03 ± 0.041               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.27 ± 0.16 μs      | 7.29 ± 0.18 μs      | 0.998 ± 0.032              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0707 ± 0.017 μs   | 0.0709 ± 0.012 μs   | 0.997 ± 0.29               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.6 ± 0.045 μs      | 0.62 ± 0.041 μs     | 0.968 ± 0.097              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.39 ± 0.77 μs      | 5.33 ± 0.55 μs      | 1.01 ± 0.18                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.6 ± 0.9 μs        | 6.44 ± 0.74 μs      | 1.03 ± 0.18                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.3 ± 0.33 μs      | 10.5 ± 0.31 μs      | 0.983 ± 0.043              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.124 ± 0.0011 ms   | 0.122 ± 0.001 ms    | 1.01 ± 0.012               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.213 ± 0.012 ms    | 0.213 ± 0.011 ms    | 1 ± 0.076                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.118 ± 0.00041 ms  | 0.118 ± 0.00044 ms  | 1 ± 0.0051                 |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.533 ± 0.01 ms     | 0.54 ± 0.01 ms      | 0.987 ± 0.027              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.906 ± 0.039 ms    | 0.872 ± 0.023 ms    | 1.04 ± 0.053               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.81 ± 0.57 ms      | 4.68 ± 0.57 ms      | 1.03 ± 0.18                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.15 ± 0.0014 ms    | 0.15 ± 0.0013 ms    | 0.999 ± 0.013              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.251 ± 0.012 ms    | 0.251 ± 0.011 ms    | 0.998 ± 0.063              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00072 ms  | 0.143 ± 0.0008 ms   | 1 ± 0.0076                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.65 ± 0.0091 ms    | 0.652 ± 0.0081 ms   | 0.998 ± 0.019              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.963 ± 0.032 ms    | 0.977 ± 0.022 ms    | 0.986 ± 0.04               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.73 ± 0.58 ms      | 4.6 ± 0.57 ms       | 1.03 ± 0.18                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.18 ± 0.11 μs      | 8.15 ± 0.077 μs     | 1 ± 0.016                  |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.3 ± 0.091 μs      | 3.29 ± 0.089 μs     | 1 ± 0.039                  |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.584 ± 0.084 μs    | 0.575 ± 0.084 μs    | 1.02 ± 0.21                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.82 ± 0.45 μs      | 5.67 ± 0.33 μs      | 1.03 ± 0.1                 |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.5 ± 1.3 μs       | 17.5 ± 1.3 μs       | 1 ± 0.1                    |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22.3 ± 0.65 μs      | 21.6 ± 0.5 μs       | 1.03 ± 0.038               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.49 ± 0.11 μs      | 7.46 ± 0.1 μs       | 1 ± 0.02                   |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.55 ± 0.083 μs     | 7.89 ± 0.08 μs      | 0.957 ± 0.014              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.95 ± 0.13 μs      | 0.93 ± 0.043 μs     | 1.02 ± 0.15                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.14 ± 0.99 μs      | 6.1 ± 0.41 μs       | 1.01 ± 0.18                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.4 ± 0.89 μs      | 17.6 ± 0.9 μs       | 0.986 ± 0.072              |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 29.2 ± 0.62 μs      | 28.6 ± 0.63 μs      | 1.02 ± 0.031               |
| Baseline/Gamma/cdf                                                                  | 3.58 ± 0.38 μs      | 3.61 ± 0.38 μs      | 0.992 ± 0.15               |
| Baseline/Gamma/logpdf                                                               | 2.91 ± 0.33 μs      | 2.88 ± 0.33 μs      | 1.01 ± 0.16                |
| Baseline/Normal/cdf                                                                 | 1.47 ± 0.31 μs      | 1.47 ± 0.31 μs      | 0.997 ± 0.3                |
| Baseline/Normal/logpdf                                                              | 1.05 ± 0.027 μs     | 1.06 ± 0.02 μs      | 0.996 ± 0.031              |
| Convolved/analytic/cdf batched                                                      | 2.68 ± 0.32 μs      | 2.63 ± 0.33 μs      | 1.02 ± 0.18                |
| Convolved/analytic/cdf scalar                                                       | 28.1 ± 0.091 ns     | 28.2 ± 0.12 ns      | 0.995 ± 0.0053             |
| Convolved/analytic/construction                                                     | 3.41 ± 0.01 ns      | 4.68 ± 0.05 ns      | 0.728 ± 0.0081             |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.029 μs     | 1.09 ± 0.034 μs     | 0.999 ± 0.041              |
| Convolved/analytic/logpdf broadcast                                                 | 2.56 ± 0.35 μs      | 2.56 ± 0.33 μs      | 1 ± 0.19                   |
| Convolved/analytic/logpdf scalar                                                    | 27.8 ± 0.17 ns      | 27.7 ± 0.1 ns       | 1 ± 0.0072                 |
| Convolved/analytic/mean                                                             | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       | 0.903 ± 0.0044             |
| Convolved/analytic/pdf batched                                                      | 1.12 ± 0.035 μs     | 1.12 ± 0.026 μs     | 1 ± 0.039                  |
| Convolved/analytic/pdf scalar                                                       | 29.8 ± 0.17 ns      | 29.8 ± 0.16 ns      | 1 ± 0.0079                 |
| Convolved/analytic/rand                                                             | 1.13 ± 0.037 μs     | 1.12 ± 0.027 μs     | 1.01 ± 0.041               |
| Convolved/numeric/cdf batched                                                       | 0.834 ± 0.0052 ms   | 0.838 ± 0.0019 ms   | 0.994 ± 0.0066             |
| Convolved/numeric/cdf scalar                                                        | 15.7 ± 0.07 μs      | 15.7 ± 0.07 μs      | 1 ± 0.0063                 |
| Convolved/numeric/construction                                                      | 3.1 ± 0.01 ns       | 3.41 ± 0.01 ns      | 0.909 ± 0.004              |
| Convolved/numeric/logpdf batched                                                    | 0.734 ± 0.005 ms    | 0.733 ± 0.0055 ms   | 1 ± 0.01                   |
| Convolved/numeric/logpdf broadcast                                                  | 1.35 ± 0.0088 ms    | 1.35 ± 0.0087 ms    | 1 ± 0.0092                 |
| Convolved/numeric/logpdf scalar                                                     | 12.6 ± 0.04 μs      | 12.5 ± 0.03 μs      | 1 ± 0.004                  |
| Convolved/numeric/mean                                                              | 6.58 ± 0.031 ns     | 6.6 ± 0.039 ns      | 0.997 ± 0.0075             |
| Convolved/numeric/pdf batched                                                       | 0.733 ± 0.0064 ms   | 0.733 ± 0.0055 ms   | 1 ± 0.012                  |
| Convolved/numeric/pdf scalar                                                        | 12.5 ± 0.04 μs      | 12.5 ± 0.04 μs      | 1 ± 0.0045                 |
| Convolved/numeric/rand                                                              | 2.8 ± 0.36 μs       | 2.79 ± 0.36 μs      | 1 ± 0.18                   |
| Difference/analytic/cdf broadcast                                                   | 3.37 ± 0.37 μs      | 3.36 ± 0.35 μs      | 1 ± 0.15                   |
| Difference/analytic/cdf scalar                                                      | 11 ± 0.049 ns       | 10.8 ± 0.01 ns      | 1.02 ± 0.0046              |
| Difference/analytic/construction                                                    | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Difference/analytic/logpdf broadcast                                                | 1.52 ± 0.3 μs       | 1.49 ± 0.35 μs      | 1.02 ± 0.31                |
| Difference/analytic/logpdf scalar                                                   | 16.7 ± 0.08 ns      | 16.7 ± 0.08 ns      | 0.999 ± 0.0068             |
| Difference/analytic/mean                                                            | 3.41 ± 0.001 ns     | 2.79 ± 0.009 ns     | 1.22 ± 0.0039              |
| Difference/analytic/rand                                                            | 1.12 ± 0.043 μs     | 1.13 ± 0.034 μs     | 0.996 ± 0.049              |
| Difference/numeric/cdf broadcast                                                    | 1.36 ± 0.017 ms     | 1.34 ± 0.018 ms     | 1.01 ± 0.018               |
| Difference/numeric/cdf scalar                                                       | 19.3 ± 0.09 μs      | 19.4 ± 0.1 μs       | 0.997 ± 0.0069             |
| Difference/numeric/construction                                                     | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 0.912 ± 0.004              |
| Difference/numeric/logpdf broadcast                                                 | 1.66 ± 0.016 ms     | 1.65 ± 0.016 ms     | 1 ± 0.014                  |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.08 μs      | 16.7 ± 0.07 μs      | 1.01 ± 0.0064              |
| Difference/numeric/mean                                                             | 6.53 ± 0.03 ns      | 6.59 ± 0.06 ns      | 0.991 ± 0.01               |
| Difference/numeric/rand                                                             | 2.8 ± 0.35 μs       | 2.8 ± 0.36 μs       | 0.999 ± 0.18               |
| Product/analytic/cdf broadcast                                                      | 4.9 ± 0.19 μs       | 4.9 ± 0.037 μs      | 1 ± 0.04                   |
| Product/analytic/cdf scalar                                                         | 29.6 ± 0.2 ns       | 29.7 ± 0.071 ns     | 0.997 ± 0.0072             |
| Product/analytic/construction                                                       | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1 ± 0.0046                 |
| Product/analytic/logpdf broadcast                                                   | 2.25 ± 0.33 μs      | 2.28 ± 0.32 μs      | 0.987 ± 0.2                |
| Product/analytic/logpdf scalar                                                      | 24 ± 0.071 ns       | 24 ± 0.1 ns         | 0.998 ± 0.0052             |
| Product/analytic/mean                                                               | 10.8 ± 0.04 ns      | 10.9 ± 0.07 ns      | 0.988 ± 0.0073             |
| Product/analytic/rand                                                               | 1.78 ± 0.31 μs      | 1.77 ± 0.31 μs      | 1 ± 0.25                   |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.015 ms     | 1.98 ± 0.016 ms     | 1 ± 0.011                  |
| Product/numeric/cdf scalar                                                          | 23.2 ± 0.1 μs       | 23.2 ± 0.11 μs      | 1 ± 0.0065                 |
| Product/numeric/construction                                                        | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 1 ± 0.0042                 |
| Product/numeric/logpdf broadcast                                                    | 1.78 ± 0.015 ms     | 1.77 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                       | 17.6 ± 0.08 μs      | 17.6 ± 0.079 μs     | 1 ± 0.0064                 |
| Product/numeric/mean                                                                | 6.73 ± 0.21 ns      | 6.76 ± 0.049 ns     | 0.995 ± 0.032              |
| Product/numeric/rand                                                                | 2.8 ± 0.36 μs       | 2.79 ± 0.35 μs      | 1 ± 0.18                   |
| Quantile/Convolved analytic/grid                                                    | 0.604 ± 0.1 ms      | 0.607 ± 0.1 ms      | 0.996 ± 0.24               |
| Quantile/Convolved analytic/median                                                  | 22.6 ± 0.77 μs      | 22.8 ± 0.79 μs      | 0.991 ± 0.048              |
| Quantile/Convolved numeric/median                                                   | 0.292 ± 0.012 ms    | 0.292 ± 0.012 ms    | 1 ± 0.057                  |
| Quantile/Difference numeric/median                                                  | 0.342 ± 0.01 ms     | 0.339 ± 0.01 ms     | 1.01 ± 0.044               |
| Quantile/Product numeric/median                                                     | 0.501 ± 0.012 ms    | 0.498 ± 0.012 ms    | 1 ± 0.035                  |
| Timeseries/Convolved delay                                                          | 0.356 ± 0.009 μs    | 0.358 ± 0.0091 μs   | 0.993 ± 0.036              |
| Timeseries/Gamma delay                                                              | 0.355 ± 0.011 μs    | 0.358 ± 0.015 μs    | 0.991 ± 0.051              |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.031 μs     | 1.27 ± 0.025 μs     | 1 ± 0.032                  |
| time_to_load                                                                        | 0.879 ± 0.013 s     | 0.865 ± 0.0061 s    | 1.02 ± 0.016               |

|                                                                                     | v0.2.0                    | 6373a26f5d46eb...         | v0.2.0 / 6373a26f5d46eb... |
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

