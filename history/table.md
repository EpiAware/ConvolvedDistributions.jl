|                                                                                                 | v0.2.0              | 6cf8b6e73d8eab...   | v0.2.0 / 6cf8b6e73d8eab... |
|:------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0629 ± 0.0035 ms  | 0.0625 ± 0.0038 ms  | 1.01 ± 0.083               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.48 ± 0.045 ms     | 0.497 ± 0.046 ms    | 0.967 ± 0.13               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0541 ± 0.00046 ms | 0.0524 ± 0.00053 ms | 1.03 ± 0.014               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.254 ± 0.0076 ms   | 0.253 ± 0.0079 ms   | 1 ± 0.043                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.616 ± 0.039 ms    | 0.6 ± 0.038 ms      | 1.03 ± 0.092               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 2.27 ± 0.29 ms      | 2.3 ± 0.29 ms       | 0.988 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.0866 ± 0.0065 ms  | 0.0863 ± 0.0065 ms  | 1 ± 0.11                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.481 ± 0.047 ms    | 0.49 ± 0.046 ms     | 0.981 ± 0.13               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.066 ± 0.0008 ms   | 0.0661 ± 0.00085 ms | 0.998 ± 0.018              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.527 ± 0.014 ms    | 0.527 ± 0.014 ms    | 0.999 ± 0.038              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.588 ± 0.028 ms    | 0.593 ± 0.036 ms    | 0.99 ± 0.076               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 2.59 ± 0.34 ms      | 2.6 ± 0.33 ms       | 0.994 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.073 ± 0.00055 ms  | 0.0728 ± 0.00062 ms | 1 ± 0.011                  |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.127 ± 0.0075 ms   | 0.13 ± 0.0071 ms    | 0.981 ± 0.079              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.0697 ± 0.00014 ms | 0.0686 ± 0.00016 ms | 1.02 ± 0.0031              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.292 ± 0.0087 ms   | 0.294 ± 0.0091 ms   | 0.993 ± 0.043              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.566 ± 0.033 ms    | 0.57 ± 0.04 ms      | 0.994 ± 0.091              |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 2.51 ± 0.29 ms      | 2.55 ± 0.32 ms      | 0.987 ± 0.17               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 7.25 ± 0.11 μs      | 7.33 ± 0.32 μs      | 0.988 ± 0.046              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.0474 ± 0.017 μs   | 0.0484 ± 0.0074 μs  | 0.979 ± 0.38               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.525 ± 0.041 μs    | 0.554 ± 0.048 μs    | 0.947 ± 0.11               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 5.02 ± 0.59 μs      | 5.15 ± 0.74 μs      | 0.974 ± 0.18               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 4.48 ± 0.22 μs      | 4.6 ± 0.27 μs       | 0.974 ± 0.075              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.49 ± 0.097 μs     | 2.54 ± 0.085 μs     | 0.981 ± 0.05               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.0929 ± 0.00074 ms | 0.0929 ± 0.00076 ms | 1 ± 0.011                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.149 ± 0.0083 ms   | 0.149 ± 0.0074 ms   | 0.996 ± 0.074              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.0854 ± 0.00021 ms | 0.084 ± 0.00032 ms  | 1.02 ± 0.0046              |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.377 ± 0.0092 ms   | 0.377 ± 0.0093 ms   | 1 ± 0.035                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.61 ± 0.035 ms     | 0.615 ± 0.042 ms    | 0.993 ± 0.088              |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 2.39 ± 0.29 ms      | 2.46 ± 0.29 ms      | 0.972 ± 0.17               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 8.17 ± 0.073 μs     | 8.24 ± 0.1 μs       | 0.991 ± 0.015              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 3.37 ± 0.075 μs     | 3.43 ± 0.1 μs       | 0.982 ± 0.037              |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.61 ± 0.081 μs     | 0.618 ± 0.083 μs    | 0.987 ± 0.19               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 5.72 ± 0.25 μs      | 5.71 ± 0.29 μs      | 1 ± 0.067                  |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 28.3 ± 3.2 μs       | 28.3 ± 3.4 μs       | 0.999 ± 0.17               |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 17.3 ± 0.52 μs      | 17.7 ± 0.5 μs       | 0.978 ± 0.04               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.119 ± 0.0011 ms   | 0.119 ± 0.0012 ms   | 0.994 ± 0.014              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.209 ± 0.011 ms    | 0.21 ± 0.011 ms     | 0.996 ± 0.075              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.117 ± 0.00045 ms  | 0.118 ± 0.00048 ms  | 0.996 ± 0.0056             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.502 ± 0.011 ms    | 0.504 ± 0.011 ms    | 0.996 ± 0.031              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.855 ± 0.039 ms    | 0.857 ± 0.037 ms    | 0.998 ± 0.062              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 4.33 ± 0.53 ms      | 4.4 ± 0.55 ms       | 0.985 ± 0.17               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 7.23 ± 0.12 μs      | 7.28 ± 0.32 μs      | 0.992 ± 0.047              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.0473 ± 0.016 μs   | 0.0476 ± 0.0063 μs  | 0.994 ± 0.36               |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.523 ± 0.044 μs    | 0.564 ± 0.044 μs    | 0.929 ± 0.11               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 5.03 ± 0.57 μs      | 5.17 ± 0.74 μs      | 0.973 ± 0.18               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 4.49 ± 0.21 μs      | 4.68 ± 0.26 μs      | 0.961 ± 0.07               |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.58 ± 0.1 μs       | 2.58 ± 0.09 μs      | 1 ± 0.053                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.145 ± 0.0016 ms   | 0.146 ± 0.0014 ms   | 0.99 ± 0.015               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.238 ± 0.012 ms    | 0.242 ± 0.012 ms    | 0.983 ± 0.07               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.139 ± 0.00069 ms  | 0.14 ± 0.00074 ms   | 0.999 ± 0.0073             |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.624 ± 0.0091 ms   | 0.625 ± 0.0096 ms   | 0.998 ± 0.021              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.964 ± 0.039 ms    | 0.947 ± 0.05 ms     | 1.02 ± 0.068               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 4.26 ± 0.54 ms      | 4.33 ± 0.73 ms      | 0.984 ± 0.21               |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 8.08 ± 0.086 μs     | 8.18 ± 0.11 μs      | 0.988 ± 0.017              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 3.17 ± 0.063 μs     | 3.19 ± 0.071 μs     | 0.993 ± 0.03               |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.558 ± 0.078 μs    | 0.571 ± 0.081 μs    | 0.978 ± 0.2                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 5.35 ± 0.24 μs      | 5.54 ± 0.28 μs      | 0.966 ± 0.065              |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 27.6 ± 3.2 μs       | 27.7 ± 3.3 μs       | 0.996 ± 0.17               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 18 ± 0.54 μs        | 18.5 ± 0.63 μs      | 0.973 ± 0.044              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 7.29 ± 0.12 μs      | 7.37 ± 0.32 μs      | 0.989 ± 0.046              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.071 ± 0.017 μs    | 0.071 ± 0.0078 μs   | 1 ± 0.27                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.611 ± 0.042 μs    | 0.61 ± 0.047 μs     | 1 ± 0.1                    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 5.21 ± 0.51 μs      | 5.36 ± 0.53 μs      | 0.972 ± 0.14               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 6.51 ± 0.8 μs       | 6.79 ± 0.73 μs      | 0.959 ± 0.16               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 10.2 ± 0.35 μs      | 10.3 ± 0.41 μs      | 0.995 ± 0.052              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.123 ± 0.0011 ms   | 0.123 ± 0.0011 ms   | 1 ± 0.013                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.213 ± 0.011 ms    | 0.212 ± 0.012 ms    | 1 ± 0.076                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.119 ± 0.00044 ms  | 0.118 ± 0.00053 ms  | 1 ± 0.0058                 |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.531 ± 0.01 ms     | 0.53 ± 0.011 ms     | 1 ± 0.028                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.898 ± 0.039 ms    | 0.902 ± 0.039 ms    | 0.996 ± 0.061              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 4.83 ± 0.56 ms      | 4.91 ± 0.57 ms      | 0.982 ± 0.16               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.15 ± 0.0014 ms    | 0.15 ± 0.0015 ms    | 1 ± 0.013                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.251 ± 0.012 ms    | 0.252 ± 0.013 ms    | 0.997 ± 0.069              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.143 ± 0.00072 ms  | 0.143 ± 0.00072 ms  | 1 ± 0.0072                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.649 ± 0.009 ms    | 0.648 ± 0.0089 ms   | 1 ± 0.02                   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.974 ± 0.032 ms    | 0.993 ± 0.05 ms     | 0.981 ± 0.059              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 4.71 ± 0.58 ms      | 4.83 ± 0.59 ms      | 0.975 ± 0.17               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 8.12 ± 0.097 μs     | 8.23 ± 0.12 μs      | 0.987 ± 0.018              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 3.28 ± 0.066 μs     | 3.31 ± 0.12 μs      | 0.989 ± 0.04               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.574 ± 0.083 μs    | 0.584 ± 0.085 μs    | 0.984 ± 0.2                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 5.64 ± 0.27 μs      | 5.76 ± 0.31 μs      | 0.978 ± 0.071              |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 17.5 ± 0.91 μs      | 18.2 ± 1.5 μs       | 0.963 ± 0.095              |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 21.9 ± 0.63 μs      | 22.7 ± 0.67 μs      | 0.964 ± 0.04               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 7.37 ± 0.12 μs      | 7.45 ± 0.12 μs      | 0.99 ± 0.022               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 8.17 ± 0.073 μs     | 8.18 ± 0.083 μs     | 0.999 ± 0.014              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.93 ± 0.04 μs      | 0.943 ± 0.08 μs     | 0.986 ± 0.094              |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 6.11 ± 0.94 μs      | 6.04 ± 0.94 μs      | 1.01 ± 0.22                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 18 ± 1.1 μs         | 18 ± 1.1 μs         | 1 ± 0.085                  |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 28.8 ± 0.63 μs      | 29.1 ± 0.68 μs      | 0.988 ± 0.032              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.636 ± 0.009 ms    | 0.634 ± 0.0092 ms   | 1 ± 0.02                   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.825 ± 0.016 ms    | 0.835 ± 0.02 ms     | 0.987 ± 0.03               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.54 ± 0.0093 ms    | 0.54 ± 0.0092 ms    | 0.999 ± 0.024              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 2.56 ± 0.0095 ms    | 2.57 ± 0.01 ms      | 0.997 ± 0.0054             |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 1.82 ± 0.049 ms     | 1.84 ± 0.055 ms     | 0.989 ± 0.04               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 9.2 ± 1.2 ms        | 9.34 ± 1.3 ms       | 0.986 ± 0.19               |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 10.7 ± 0.13 μs      | 10.8 ± 0.2 μs       | 0.989 ± 0.022              |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 13.9 ± 0.2 μs       | 14.9 ± 0.21 μs      | 0.929 ± 0.019              |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 3.23 ± 0.041 μs     | 3.21 ± 0.044 μs     | 1.01 ± 0.019               |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 11.8 ± 0.42 μs      | 11.8 ± 0.44 μs      | 0.999 ± 0.051              |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 20.9 ± 2.7 μs       | 21.7 ± 2.8 μs       | 0.962 ± 0.17               |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.0335 ± 0.00062 ms | 0.0347 ± 0.00083 ms | 0.964 ± 0.029              |
| Baseline/Gamma/cdf                                                                              | 3.59 ± 0.39 μs      | 3.58 ± 0.38 μs      | 1 ± 0.15                   |
| Baseline/Gamma/logpdf                                                                           | 2.92 ± 0.33 μs      | 2.91 ± 0.33 μs      | 1 ± 0.16                   |
| Baseline/Normal/cdf                                                                             | 1.47 ± 0.31 μs      | 1.48 ± 0.31 μs      | 0.993 ± 0.29               |
| Baseline/Normal/logpdf                                                                          | 1.05 ± 0.026 μs     | 1.05 ± 0.026 μs     | 0.999 ± 0.035              |
| Convolved/analytic/cdf batched                                                                  | 2.67 ± 0.34 μs      | 2.64 ± 0.35 μs      | 1.01 ± 0.19                |
| Convolved/analytic/cdf scalar                                                                   | 28 ± 0.31 ns        | 28.2 ± 0.25 ns      | 0.992 ± 0.014              |
| Convolved/analytic/construction                                                                 | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/analytic/logpdf batched                                                               | 1.08 ± 0.23 μs      | 1.08 ± 0.032 μs     | 0.996 ± 0.22               |
| Convolved/analytic/logpdf broadcast                                                             | 2.55 ± 0.34 μs      | 2.55 ± 0.36 μs      | 1 ± 0.19                   |
| Convolved/analytic/logpdf scalar                                                                | 27.8 ± 0.15 ns      | 28.1 ± 0.059 ns     | 0.989 ± 0.0058             |
| Convolved/analytic/mean                                                                         | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/analytic/pdf batched                                                                  | 1.12 ± 0.032 μs     | 1.12 ± 0.028 μs     | 1 ± 0.038                  |
| Convolved/analytic/pdf scalar                                                                   | 29.9 ± 0.18 ns      | 29.9 ± 0.11 ns      | 1 ± 0.0071                 |
| Convolved/analytic/rand                                                                         | 1.12 ± 0.028 μs     | 1.12 ± 0.029 μs     | 1 ± 0.036                  |
| Convolved/numeric/cdf batched                                                                   | 0.829 ± 0.0043 ms   | 0.831 ± 0.0026 ms   | 0.998 ± 0.006              |
| Convolved/numeric/cdf scalar                                                                    | 15.7 ± 0.07 μs      | 15.6 ± 0.07 μs      | 1 ± 0.0063                 |
| Convolved/numeric/construction                                                                  | 3.41 ± 0.001 ns     | 3.41 ± 0.01 ns      | 1 ± 0.0029                 |
| Convolved/numeric/logpdf batched                                                                | 0.733 ± 0.0061 ms   | 0.731 ± 0.0055 ms   | 1 ± 0.011                  |
| Convolved/numeric/logpdf broadcast                                                              | 1.34 ± 0.0086 ms    | 1.35 ± 0.0085 ms    | 0.997 ± 0.0089             |
| Convolved/numeric/logpdf scalar                                                                 | 12.5 ± 0.049 μs     | 12.6 ± 0.04 μs      | 0.998 ± 0.005              |
| Convolved/numeric/mean                                                                          | 6.61 ± 0.03 ns      | 6.61 ± 0.049 ns     | 1 ± 0.0087                 |
| Convolved/numeric/pdf batched                                                                   | 0.734 ± 0.0049 ms   | 0.736 ± 0.006 ms    | 0.997 ± 0.011              |
| Convolved/numeric/pdf scalar                                                                    | 12.5 ± 0.041 μs     | 12.5 ± 0.04 μs      | 0.998 ± 0.0046             |
| Convolved/numeric/rand                                                                          | 2.79 ± 0.35 μs      | 2.81 ± 0.36 μs      | 0.992 ± 0.18               |
| Difference/analytic/cdf broadcast                                                               | 3.37 ± 0.35 μs      | 3.4 ± 0.36 μs       | 0.991 ± 0.15               |
| Difference/analytic/cdf scalar                                                                  | 10.8 ± 0.021 ns     | 10.8 ± 0.03 ns      | 1 ± 0.0034                 |
| Difference/analytic/construction                                                                | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 0.912 ± 0.004              |
| Difference/analytic/logpdf broadcast                                                            | 1.5 ± 0.31 μs       | 1.52 ± 0.31 μs      | 0.989 ± 0.29               |
| Difference/analytic/logpdf scalar                                                               | 17 ± 0.08 ns        | 16.9 ± 0.26 ns      | 1 ± 0.016                  |
| Difference/analytic/mean                                                                        | 2.79 ± 0.01 ns      | 3.41 ± 0.001 ns     | 0.821 ± 0.0029             |
| Difference/analytic/rand                                                                        | 1.12 ± 0.041 μs     | 1.12 ± 0.033 μs     | 0.995 ± 0.047              |
| Difference/numeric/cdf broadcast                                                                | 1.36 ± 0.018 ms     | 1.35 ± 0.018 ms     | 1 ± 0.019                  |
| Difference/numeric/cdf scalar                                                                   | 19.5 ± 0.089 μs     | 19.4 ± 0.1 μs       | 1 ± 0.0069                 |
| Difference/numeric/construction                                                                 | 3.11 ± 0.01 ns      | 3.42 ± 0.011 ns     | 0.909 ± 0.0041             |
| Difference/numeric/logpdf broadcast                                                             | 1.65 ± 0.016 ms     | 1.65 ± 0.016 ms     | 1 ± 0.014                  |
| Difference/numeric/logpdf scalar                                                                | 16.8 ± 0.08 μs      | 16.8 ± 0.08 μs      | 1 ± 0.0068                 |
| Difference/numeric/mean                                                                         | 6.59 ± 0.04 ns      | 6.54 ± 0.03 ns      | 1.01 ± 0.0077              |
| Difference/numeric/rand                                                                         | 2.8 ± 0.37 μs       | 2.81 ± 0.38 μs      | 0.998 ± 0.19               |
| Product/analytic/cdf broadcast                                                                  | 4.93 ± 0.21 μs      | 4.91 ± 0.2 μs       | 1 ± 0.06                   |
| Product/analytic/cdf scalar                                                                     | 29.7 ± 0.58 ns      | 29.7 ± 0.14 ns      | 0.999 ± 0.02               |
| Product/analytic/construction                                                                   | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 1 ± 0.0042                 |
| Product/analytic/logpdf broadcast                                                               | 2.19 ± 0.35 μs      | 2.27 ± 0.35 μs      | 0.961 ± 0.21               |
| Product/analytic/logpdf scalar                                                                  | 24 ± 0.1 ns         | 24 ± 0.08 ns        | 1 ± 0.0054                 |
| Product/analytic/mean                                                                           | 10.8 ± 0.041 ns     | 10.8 ± 0.031 ns     | 1 ± 0.0048                 |
| Product/analytic/rand                                                                           | 1.78 ± 0.32 μs      | 1.78 ± 0.33 μs      | 0.997 ± 0.26               |
| Product/numeric/cdf broadcast                                                                   | 1.98 ± 0.014 ms     | 1.97 ± 0.015 ms     | 1 ± 0.011                  |
| Product/numeric/cdf scalar                                                                      | 23.1 ± 0.1 μs       | 23.1 ± 0.1 μs       | 1 ± 0.0061                 |
| Product/numeric/construction                                                                    | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 0.912 ± 0.004              |
| Product/numeric/logpdf broadcast                                                                | 1.77 ± 0.014 ms     | 1.77 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                                   | 17.6 ± 0.07 μs      | 17.6 ± 0.07 μs      | 1 ± 0.0056                 |
| Product/numeric/mean                                                                            | 6.71 ± 0.041 ns     | 6.73 ± 0.22 ns      | 0.997 ± 0.033              |
| Product/numeric/rand                                                                            | 2.81 ± 0.35 μs      | 2.82 ± 0.35 μs      | 0.996 ± 0.18               |
| Quantile/Convolved analytic/grid                                                                | 0.608 ± 0.098 ms    | 0.614 ± 0.1 ms      | 0.991 ± 0.23               |
| Quantile/Convolved analytic/median                                                              | 22.9 ± 0.87 μs      | 22.8 ± 0.83 μs      | 1.01 ± 0.053               |
| Quantile/Convolved numeric/median                                                               | 0.291 ± 0.011 ms    | 0.29 ± 0.011 ms     | 1 ± 0.054                  |
| Quantile/Difference numeric/median                                                              | 0.341 ± 0.011 ms    | 0.339 ± 0.011 ms    | 1 ± 0.044                  |
| Quantile/Product numeric/median                                                                 | 0.499 ± 0.013 ms    | 0.498 ± 0.012 ms    | 1 ± 0.036                  |
| Timeseries/Convolved delay                                                                      | 0.75 ± 0.008 ms     | 0.746 ± 0.0082 ms   | 1.01 ± 0.015               |
| Timeseries/Gamma delay                                                                          | 3.13 ± 0.031 μs     | 1.83 ± 0.033 μs     | 1.71 ± 0.035               |
| Timeseries/Poisson delay                                                                        | 1.28 ± 0.03 μs      | 1.27 ± 0.029 μs     | 1.01 ± 0.033               |
| time_to_load                                                                                    | 0.883 ± 0.0045 s    | 0.919 ± 0.006 s     | 0.961 ± 0.008              |

|                                                                                                 | v0.2.0                    | 6cf8b6e73d8eab...         | v0.2.0 / 6cf8b6e73d8eab... |
|:------------------------------------------------------------------------------------------------|:-------------------------:|:-------------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.088 k allocs: 11.6 kB   | 0.088 k allocs: 11.6 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 1.35 k allocs: 0.168 MB   | 1.35 k allocs: 0.168 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.04 k allocs: 4.7 kB     | 0.04 k allocs: 4.7 kB     | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.264 k allocs: 27.2 kB   | 0.264 k allocs: 27.2 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 2.08 k allocs: 0.666 MB   | 2.08 k allocs: 0.666 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 28.5 k allocs: 1.2 MB     | 28.5 k allocs: 1.2 MB     | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.151 k allocs: 22.6 kB   | 0.151 k allocs: 22.6 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 1.36 k allocs: 0.169 MB   | 1.36 k allocs: 0.169 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.081 k allocs: 7.2 kB    | 0.081 k allocs: 7.2 kB    | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.519 k allocs: 0.0521 MB | 0.519 k allocs: 0.0521 MB | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 2.07 k allocs: 0.665 MB   | 2.07 k allocs: 0.665 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 0.0327 M allocs: 1.23 MB  | 0.0327 M allocs: 1.23 MB  | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 2.35 k allocs: 0.639 MB   | 2.35 k allocs: 0.639 MB   | 1                          |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 31.1 k allocs: 1.29 MB    | 31.1 k allocs: 1.29 MB    | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 1                          |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 2.37 k allocs: 0.633 MB   | 2.37 k allocs: 0.633 MB   | 1                          |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 30.2 k allocs: 1.26 MB    | 30.2 k allocs: 1.26 MB    | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 24  allocs: 1.03 kB       | 24  allocs: 1.03 kB       | 1                          |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 1                          |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 0.289 k allocs: 0.0329 MB | 0.289 k allocs: 0.0329 MB | 1                          |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 0.238 k allocs: 9.92 kB   | 0.238 k allocs: 9.92 kB   | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 1                          |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 1                          |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 1                          |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 1                          |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 1                          |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 1                          |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 1                          |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 1                          |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 0.289 k allocs: 0.0331 MB | 0.289 k allocs: 0.0331 MB | 1                          |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 0.268 k allocs: 10.9 kB   | 0.268 k allocs: 10.9 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 0.093 k allocs: 5.09 kB   | 0.093 k allocs: 5.09 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 0.127 k allocs: 5.25 kB   | 0.127 k allocs: 5.25 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 1                          |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 1                          |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 0.27 k allocs: 12.5 kB    | 0.27 k allocs: 12.5 kB    | 1                          |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 0.298 k allocs: 12 kB     | 0.298 k allocs: 12 kB     | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 0.033 k allocs: 1.2 kB    | 0.033 k allocs: 1.2 kB    | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 10  allocs: 0.5 kB        | 10  allocs: 0.5 kB        | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 11  allocs: 0.547 kB      | 11  allocs: 0.547 kB      | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 0.068 k allocs: 3.58 kB   | 0.068 k allocs: 3.58 kB   | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 0.198 k allocs: 16.1 kB   | 0.198 k allocs: 16.1 kB   | 1                          |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 0.462 k allocs: 18.2 kB   | 0.462 k allocs: 18.2 kB   | 1                          |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.247 k allocs: 13.6 kB   | 0.247 k allocs: 13.6 kB   | 1                          |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.373 k allocs: 0.0585 MB | 0.373 k allocs: 0.0585 MB | 1                          |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.087 k allocs: 5.36 kB   | 0.087 k allocs: 5.36 kB   | 1                          |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 0.5 k allocs: 27.9 kB     | 0.5 k allocs: 27.9 kB     | 1                          |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 2.31 k allocs: 1.59 MB    | 2.31 k allocs: 1.59 MB    | 1                          |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 0.0943 M allocs: 3.69 MB  | 0.0943 M allocs: 3.69 MB  | 1                          |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 0.04 k allocs: 1.62 kB    | 0.04 k allocs: 1.62 kB    | 1                          |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 0.034 k allocs: 1.7 kB    | 0.034 k allocs: 1.7 kB    | 1                          |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 11  allocs: 0.703 kB      | 11  allocs: 0.703 kB      | 1                          |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 0.082 k allocs: 4.23 kB   | 0.082 k allocs: 4.23 kB   | 1                          |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 0.184 k allocs: 17 kB     | 0.184 k allocs: 17 kB     | 1                          |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.449 k allocs: 18 kB     | 0.449 k allocs: 18 kB     | 1                          |
| Baseline/Gamma/cdf                                                                              | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Baseline/Gamma/logpdf                                                                           | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Baseline/Normal/cdf                                                                             | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Baseline/Normal/logpdf                                                                          | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/cdf batched                                                                  | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/cdf scalar                                                                   | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/construction                                                                 | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/logpdf batched                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/logpdf broadcast                                                             | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/logpdf scalar                                                                | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/mean                                                                         | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/pdf batched                                                                  | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/analytic/pdf scalar                                                                   | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/analytic/rand                                                                         | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Convolved/numeric/cdf batched                                                                   | 24  allocs: 8.32 kB       | 24  allocs: 8.32 kB       | 1                          |
| Convolved/numeric/cdf scalar                                                                    | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 1                          |
| Convolved/numeric/construction                                                                  | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/numeric/logpdf batched                                                                | 25  allocs: 8.41 kB       | 25  allocs: 8.41 kB       | 1                          |
| Convolved/numeric/logpdf broadcast                                                              | 0.338 k allocs: 29.8 kB   | 0.338 k allocs: 29.8 kB   | 1                          |
| Convolved/numeric/logpdf scalar                                                                 | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 1                          |
| Convolved/numeric/mean                                                                          | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Convolved/numeric/pdf batched                                                                   | 23  allocs: 7.5 kB        | 23  allocs: 7.5 kB        | 1                          |
| Convolved/numeric/pdf scalar                                                                    | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 1                          |
| Convolved/numeric/rand                                                                          | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/analytic/cdf broadcast                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/analytic/cdf scalar                                                                  | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/construction                                                                | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/logpdf broadcast                                                            | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/analytic/logpdf scalar                                                               | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/mean                                                                        | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/analytic/rand                                                                        | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Difference/numeric/cdf broadcast                                                                | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Difference/numeric/cdf scalar                                                                   | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Difference/numeric/construction                                                                 | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/numeric/logpdf broadcast                                                             | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Difference/numeric/logpdf scalar                                                                | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Difference/numeric/mean                                                                         | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Difference/numeric/rand                                                                         | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/analytic/cdf broadcast                                                                  | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/analytic/cdf scalar                                                                     | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/construction                                                                   | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/logpdf broadcast                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/analytic/logpdf scalar                                                                  | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/mean                                                                           | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/analytic/rand                                                                           | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Product/numeric/cdf broadcast                                                                   | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Product/numeric/cdf scalar                                                                      | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Product/numeric/construction                                                                    | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/numeric/logpdf broadcast                                                                | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 1                          |
| Product/numeric/logpdf scalar                                                                   | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 1                          |
| Product/numeric/mean                                                                            | 0  allocs: 0 B            | 0  allocs: 0 B            |                            |
| Product/numeric/rand                                                                            | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 1                          |
| Quantile/Convolved analytic/grid                                                                | 5.71 k allocs: 0.324 MB   | 5.71 k allocs: 0.324 MB   | 1                          |
| Quantile/Convolved analytic/median                                                              | 0.265 k allocs: 15.6 kB   | 0.265 k allocs: 15.6 kB   | 1                          |
| Quantile/Convolved numeric/median                                                               | 0.339 k allocs: 19.6 kB   | 0.339 k allocs: 19.6 kB   | 1                          |
| Quantile/Difference numeric/median                                                              | 0.302 k allocs: 21.8 kB   | 0.302 k allocs: 21.8 kB   | 1                          |
| Quantile/Product numeric/median                                                                 | 0.381 k allocs: 27 kB     | 0.381 k allocs: 27 kB     | 1                          |
| Timeseries/Convolved delay                                                                      | 0.226 k allocs: 24.1 kB   | 0.226 k allocs: 24.1 kB   | 1                          |
| Timeseries/Gamma delay                                                                          | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 1                          |
| Timeseries/Poisson delay                                                                        | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 1                          |
| time_to_load                                                                                    | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 1                          |

