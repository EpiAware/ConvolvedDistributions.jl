|                                                                                                 | v0.2.0              | 0cd7be783425e6...   | v0.2.0 / 0cd7be783425e6... |
|:------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0624 ± 0.0036 ms  | 0.0626 ± 0.0035 ms  | 0.996 ± 0.08               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.48 ± 0.048 ms     | 0.475 ± 0.044 ms    | 1.01 ± 0.14                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0541 ± 0.00043 ms | 0.0536 ± 0.00044 ms | 1.01 ± 0.012               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.255 ± 0.0073 ms   | 0.253 ± 0.0069 ms   | 1.01 ± 0.04                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.596 ± 0.03 ms     | 0.583 ± 0.032 ms    | 1.02 ± 0.076               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 2.26 ± 0.27 ms      | 2.2 ± 0.28 ms       | 1.03 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.086 ± 0.0068 ms   | 0.0858 ± 0.0065 ms  | 1 ± 0.11                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.476 ± 0.048 ms    | 0.473 ± 0.04 ms     | 1.01 ± 0.13                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.066 ± 0.00078 ms  | 0.066 ± 0.00077 ms  | 1 ± 0.017                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.526 ± 0.014 ms    | 0.532 ± 0.014 ms    | 0.989 ± 0.037              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.597 ± 0.028 ms    | 0.575 ± 0.028 ms    | 1.04 ± 0.071               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 2.56 ± 0.32 ms      | 2.5 ± 0.33 ms       | 1.02 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.0728 ± 0.00053 ms | 0.073 ± 0.00048 ms  | 0.998 ± 0.0098             |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.131 ± 0.0076 ms   | 0.125 ± 0.0071 ms   | 1.04 ± 0.085               |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.0696 ± 0.00018 ms | 0.0691 ± 0.0002 ms  | 1.01 ± 0.0039              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.291 ± 0.0092 ms   | 0.292 ± 0.0091 ms   | 0.997 ± 0.044              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.563 ± 0.027 ms    | 0.56 ± 0.029 ms     | 1 ± 0.071                  |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 2.52 ± 0.31 ms      | 2.46 ± 0.3 ms       | 1.03 ± 0.18                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 7.13 ± 0.13 μs      | 7.09 ± 0.11 μs      | 1.01 ± 0.024               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.0464 ± 0.0096 μs  | 0.047 ± 0.0075 μs   | 0.986 ± 0.26               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.53 ± 0.039 μs     | 0.551 ± 0.041 μs    | 0.962 ± 0.1                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 5.09 ± 0.64 μs      | 4.92 ± 0.69 μs      | 1.03 ± 0.19                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 4.53 ± 0.26 μs      | 4.36 ± 0.2 μs       | 1.04 ± 0.077               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.55 ± 0.1 μs       | 2.51 ± 0.12 μs      | 1.02 ± 0.063               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.0915 ± 0.00072 ms | 0.0916 ± 0.00067 ms | 0.999 ± 0.011              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.149 ± 0.0079 ms   | 0.146 ± 0.0071 ms   | 1.02 ± 0.073               |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.0855 ± 0.00028 ms | 0.086 ± 0.00025 ms  | 0.995 ± 0.0044             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.377 ± 0.0094 ms   | 0.377 ± 0.0095 ms   | 1 ± 0.035                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.613 ± 0.032 ms    | 0.604 ± 0.031 ms    | 1.01 ± 0.074               |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 2.43 ± 0.29 ms      | 2.34 ± 0.3 ms       | 1.04 ± 0.18                |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 8.05 ± 0.088 μs     | 8.03 ± 0.075 μs     | 1 ± 0.014                  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 3.34 ± 0.068 μs     | 3.35 ± 0.058 μs     | 0.997 ± 0.026              |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.619 ± 0.081 μs    | 0.608 ± 0.082 μs    | 1.02 ± 0.19                |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 5.66 ± 0.26 μs      | 5.64 ± 0.24 μs      | 1 ± 0.063                  |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 27.2 ± 3.1 μs       | 27.5 ± 3 μs         | 0.989 ± 0.16               |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 17.5 ± 0.51 μs      | 16.7 ± 0.45 μs      | 1.05 ± 0.042               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.12 ± 0.0011 ms    | 0.121 ± 0.0011 ms   | 0.99 ± 0.013               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.218 ± 0.012 ms    | 0.207 ± 0.011 ms    | 1.05 ± 0.083               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.117 ± 0.00044 ms  | 0.117 ± 0.00047 ms  | 0.997 ± 0.0055             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.504 ± 0.01 ms     | 0.502 ± 0.011 ms    | 1 ± 0.03                   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.851 ± 0.028 ms    | 0.852 ± 0.026 ms    | 0.998 ± 0.045              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 4.33 ± 0.56 ms      | 4.17 ± 0.57 ms      | 1.04 ± 0.19                |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 7.16 ± 0.12 μs      | 7.11 ± 0.24 μs      | 1.01 ± 0.037               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.0474 ± 0.011 μs   | 0.0469 ± 0.0081 μs  | 1.01 ± 0.29                |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.542 ± 0.042 μs    | 0.537 ± 0.042 μs    | 1.01 ± 0.11                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 5.09 ± 0.65 μs      | 5.06 ± 0.69 μs      | 1 ± 0.19                   |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 4.62 ± 0.23 μs      | 4.48 ± 0.25 μs      | 1.03 ± 0.077               |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.57 ± 0.11 μs      | 2.48 ± 0.075 μs     | 1.03 ± 0.054               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.145 ± 0.0013 ms   | 0.145 ± 0.0016 ms   | 1 ± 0.015                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.239 ± 0.013 ms    | 0.239 ± 0.011 ms    | 1 ± 0.071                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.139 ± 0.0007 ms   | 0.139 ± 0.00075 ms  | 0.998 ± 0.0074             |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.624 ± 0.0095 ms   | 0.623 ± 0.0093 ms   | 1 ± 0.021                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.928 ± 0.023 ms    | 0.933 ± 0.045 ms    | 0.994 ± 0.053              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 4.24 ± 0.56 ms      | 4.09 ± 0.55 ms      | 1.04 ± 0.19                |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 8.01 ± 0.088 μs     | 7.97 ± 0.085 μs     | 1.01 ± 0.015               |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 3.19 ± 0.074 μs     | 3.21 ± 0.094 μs     | 0.992 ± 0.037              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.565 ± 0.08 μs     | 0.566 ± 0.082 μs    | 1 ± 0.2                    |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 5.4 ± 0.29 μs       | 5.39 ± 0.29 μs      | 1 ± 0.077                  |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 27.2 ± 3.1 μs       | 27.8 ± 3 μs         | 0.981 ± 0.15               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 18.3 ± 0.56 μs      | 17.6 ± 0.51 μs      | 1.04 ± 0.044               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 7.19 ± 0.13 μs      | 7.17 ± 0.25 μs      | 1 ± 0.04                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.0691 ± 0.011 μs   | 0.0691 ± 0.01 μs    | 1 ± 0.22                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.611 ± 0.045 μs    | 0.65 ± 0.041 μs     | 0.94 ± 0.091               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 5.38 ± 0.64 μs      | 5.23 ± 0.74 μs      | 1.03 ± 0.19                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 6.57 ± 0.79 μs      | 6.65 ± 0.57 μs      | 0.987 ± 0.15               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 10.2 ± 0.38 μs      | 10.2 ± 0.35 μs      | 0.996 ± 0.051              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.124 ± 0.0012 ms   | 0.123 ± 0.0011 ms   | 1 ± 0.013                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.212 ± 0.012 ms    | 0.212 ± 0.011 ms    | 1 ± 0.077                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.119 ± 0.00053 ms  | 0.118 ± 0.00053 ms  | 1 ± 0.0063                 |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.53 ± 0.01 ms      | 0.533 ± 0.011 ms    | 0.995 ± 0.029              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.905 ± 0.037 ms    | 0.883 ± 0.037 ms    | 1.02 ± 0.06                |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 4.81 ± 0.55 ms      | 4.71 ± 0.57 ms      | 1.02 ± 0.17                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.15 ± 0.0015 ms    | 0.15 ± 0.0014 ms    | 1 ± 0.014                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.254 ± 0.012 ms    | 0.248 ± 0.012 ms    | 1.02 ± 0.069               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.143 ± 0.00071 ms  | 0.143 ± 0.00073 ms  | 1 ± 0.0072                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.649 ± 0.0085 ms   | 0.648 ± 0.0086 ms   | 1 ± 0.019                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.972 ± 0.021 ms    | 0.966 ± 0.035 ms    | 1.01 ± 0.043               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 4.71 ± 0.56 ms      | 4.64 ± 0.56 ms      | 1.02 ± 0.17                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 8.07 ± 0.1 μs       | 8.01 ± 0.085 μs     | 1.01 ± 0.016               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 3.33 ± 0.073 μs     | 3.26 ± 0.093 μs     | 1.02 ± 0.037               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.579 ± 0.078 μs    | 0.569 ± 0.076 μs    | 1.02 ± 0.19                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 5.65 ± 0.53 μs      | 5.61 ± 0.28 μs      | 1.01 ± 0.11                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 17.5 ± 1.2 μs       | 18.1 ± 1.4 μs       | 0.968 ± 0.1                |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 22 ± 0.65 μs        | 21.3 ± 0.59 μs      | 1.03 ± 0.042               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 7.29 ± 0.12 μs      | 7.27 ± 0.092 μs     | 1 ± 0.021                  |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 8.01 ± 0.077 μs     | 8.08 ± 0.05 μs      | 0.99 ± 0.011               |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.941 ± 0.089 μs    | 0.959 ± 0.1 μs      | 0.981 ± 0.14               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 6.09 ± 0.91 μs      | 6.09 ± 0.94 μs      | 1 ± 0.21                   |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 17.6 ± 1.1 μs       | 17.6 ± 0.88 μs      | 1 ± 0.082                  |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 28.9 ± 0.67 μs      | 28.7 ± 0.62 μs      | 1 ± 0.032                  |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.634 ± 0.0093 ms   | 0.634 ± 0.0091 ms   | 0.999 ± 0.02               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.844 ± 0.02 ms     | 0.821 ± 0.018 ms    | 1.03 ± 0.033               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.541 ± 0.0096 ms   | 0.541 ± 0.0094 ms   | 0.999 ± 0.025              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 2.56 ± 0.0091 ms    | 2.6 ± 0.0094 ms     | 0.985 ± 0.005              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 1.83 ± 0.051 ms     | 1.81 ± 0.05 ms      | 1.01 ± 0.04                |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 9.05 ± 1.3 ms       | 8.97 ± 1.3 ms       | 1.01 ± 0.2                 |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 10.6 ± 0.14 μs      | 10.6 ± 0.17 μs      | 1 ± 0.021                  |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 13.8 ± 0.2 μs       | 14.7 ± 0.26 μs      | 0.938 ± 0.021              |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 3.22 ± 0.039 μs     | 3.22 ± 0.05 μs      | 1 ± 0.02                   |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 12 ± 0.42 μs        | 11.9 ± 0.43 μs      | 1.01 ± 0.051               |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 21 ± 2.7 μs         | 21.1 ± 2.4 μs       | 0.996 ± 0.17               |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.0347 ± 0.00084 ms | 0.0339 ± 0.00063 ms | 1.03 ± 0.031               |
| Baseline/Gamma/cdf                                                                              | 4.94 ± 0.36 μs      | 3.59 ± 0.37 μs      | 1.37 ± 0.18                |
| Baseline/Gamma/logpdf                                                                           | 2.89 ± 0.33 μs      | 2.88 ± 0.33 μs      | 1.01 ± 0.16                |
| Baseline/Normal/cdf                                                                             | 1.48 ± 0.3 μs       | 1.46 ± 0.3 μs       | 1.01 ± 0.29                |
| Baseline/Normal/logpdf                                                                          | 1.05 ± 0.024 μs     | 1.05 ± 0.029 μs     | 0.993 ± 0.036              |
| Convolved/analytic/cdf batched                                                                  | 2.67 ± 0.35 μs      | 2.68 ± 0.33 μs      | 0.995 ± 0.18               |
| Convolved/analytic/cdf scalar                                                                   | 28.2 ± 0.22 ns      | 28 ± 0.14 ns        | 1.01 ± 0.0094              |
| Convolved/analytic/construction                                                                 | 4.03 ± 0.01 ns      | 3.1 ± 0.01 ns       | 1.3 ± 0.0053               |
| Convolved/analytic/logpdf batched                                                               | 1.07 ± 0.032 μs     | 1.08 ± 0.027 μs     | 0.997 ± 0.039              |
| Convolved/analytic/logpdf broadcast                                                             | 2.51 ± 0.34 μs      | 2.56 ± 0.34 μs      | 0.98 ± 0.18                |
| Convolved/analytic/logpdf scalar                                                                | 28 ± 0.41 ns        | 27.9 ± 0.16 ns      | 1 ± 0.016                  |
| Convolved/analytic/mean                                                                         | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/analytic/pdf batched                                                                  | 1.11 ± 0.027 μs     | 1.12 ± 0.033 μs     | 0.994 ± 0.038              |
| Convolved/analytic/pdf scalar                                                                   | 29.9 ± 0.16 ns      | 29.9 ± 0.23 ns      | 0.998 ± 0.0094             |
| Convolved/analytic/rand                                                                         | 1.14 ± 0.032 μs     | 1.13 ± 0.032 μs     | 1.01 ± 0.041               |
| Convolved/numeric/cdf batched                                                                   | 0.831 ± 0.0022 ms   | 0.833 ± 0.0034 ms   | 0.998 ± 0.0049             |
| Convolved/numeric/cdf scalar                                                                    | 15.7 ± 0.069 μs     | 15.7 ± 0.069 μs     | 1 ± 0.0062                 |
| Convolved/numeric/construction                                                                  | 3.41 ± 0.01 ns      | 3.1 ± 0.01 ns       | 1.1 ± 0.0048               |
| Convolved/numeric/logpdf batched                                                                | 0.744 ± 0.0043 ms   | 0.745 ± 0.0037 ms   | 0.998 ± 0.0076             |
| Convolved/numeric/logpdf broadcast                                                              | 1.34 ± 0.0091 ms    | 1.35 ± 0.0088 ms    | 0.999 ± 0.0094             |
| Convolved/numeric/logpdf scalar                                                                 | 12.5 ± 0.04 μs      | 12.5 ± 0.041 μs     | 1 ± 0.0046                 |
| Convolved/numeric/mean                                                                          | 6.61 ± 0.031 ns     | 6.66 ± 0.011 ns     | 0.992 ± 0.0049             |
| Convolved/numeric/pdf batched                                                                   | 0.743 ± 0.0058 ms   | 0.744 ± 0.0052 ms   | 0.999 ± 0.01               |
| Convolved/numeric/pdf scalar                                                                    | 12.5 ± 0.031 μs     | 12.5 ± 0.04 μs      | 0.999 ± 0.004              |
| Convolved/numeric/rand                                                                          | 2.79 ± 0.35 μs      | 2.8 ± 0.35 μs       | 0.997 ± 0.18               |
| Difference/analytic/cdf broadcast                                                               | 3.37 ± 0.34 μs      | 3.35 ± 0.023 μs     | 1.01 ± 0.1                 |
| Difference/analytic/cdf scalar                                                                  | 10.8 ± 0.02 ns      | 10.8 ± 0.02 ns      | 0.998 ± 0.0026             |
| Difference/analytic/construction                                                                | 4.33 ± 0.92 ns      | 3.11 ± 0.01 ns      | 1.39 ± 0.3                 |
| Difference/analytic/logpdf broadcast                                                            | 1.51 ± 0.3 μs       | 1.51 ± 0.31 μs      | 0.998 ± 0.28               |
| Difference/analytic/logpdf scalar                                                               | 17 ± 0.1 ns         | 17 ± 0.16 ns        | 1 ± 0.011                  |
| Difference/analytic/mean                                                                        | 3.41 ± 0.001 ns     | 2.79 ± 0.01 ns      | 1.22 ± 0.0044              |
| Difference/analytic/rand                                                                        | 1.14 ± 0.037 μs     | 1.12 ± 0.045 μs     | 1.01 ± 0.052               |
| Difference/numeric/cdf broadcast                                                                | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 0.999 ± 0.018              |
| Difference/numeric/cdf scalar                                                                   | 19.4 ± 0.09 μs      | 19.4 ± 0.1 μs       | 0.998 ± 0.0069             |
| Difference/numeric/construction                                                                 | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Difference/numeric/logpdf broadcast                                                             | 1.65 ± 0.015 ms     | 1.65 ± 0.015 ms     | 1 ± 0.013                  |
| Difference/numeric/logpdf scalar                                                                | 16.8 ± 0.081 μs     | 16.7 ± 0.07 μs      | 1 ± 0.0064                 |
| Difference/numeric/mean                                                                         | 6.54 ± 0.03 ns      | 6.59 ± 0.031 ns     | 0.992 ± 0.0065             |
| Difference/numeric/rand                                                                         | 2.8 ± 0.35 μs       | 2.8 ± 0.35 μs       | 1 ± 0.18                   |
| Product/analytic/cdf broadcast                                                                  | 4.9 ± 0.2 μs        | 4.91 ± 0.21 μs      | 0.999 ± 0.059              |
| Product/analytic/cdf scalar                                                                     | 29.7 ± 0.08 ns      | 29.7 ± 0.11 ns      | 0.998 ± 0.0046             |
| Product/analytic/construction                                                                   | 3.11 ± 0.01 ns      | 3.72 ± 0.001 ns     | 0.836 ± 0.0027             |
| Product/analytic/logpdf broadcast                                                               | 2.24 ± 0.33 μs      | 2.2 ± 0.33 μs       | 1.02 ± 0.21                |
| Product/analytic/logpdf scalar                                                                  | 24 ± 0.08 ns        | 24 ± 0.11 ns        | 1 ± 0.0057                 |
| Product/analytic/mean                                                                           | 10.8 ± 0.03 ns      | 10.8 ± 0.031 ns     | 1 ± 0.004                  |
| Product/analytic/rand                                                                           | 1.78 ± 0.32 μs      | 1.78 ± 0.32 μs      | 0.999 ± 0.25               |
| Product/numeric/cdf broadcast                                                                   | 1.97 ± 0.015 ms     | 1.98 ± 0.015 ms     | 0.995 ± 0.011              |
| Product/numeric/cdf scalar                                                                      | 23.1 ± 0.11 μs      | 23.2 ± 0.091 μs     | 0.998 ± 0.0062             |
| Product/numeric/construction                                                                    | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Product/numeric/logpdf broadcast                                                                | 1.77 ± 0.014 ms     | 1.77 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                                   | 17.5 ± 0.08 μs      | 17.5 ± 0.06 μs      | 1 ± 0.0057                 |
| Product/numeric/mean                                                                            | 6.76 ± 0.23 ns      | 6.72 ± 0.031 ns     | 1.01 ± 0.035               |
| Product/numeric/rand                                                                            | 2.8 ± 0.35 μs       | 2.81 ± 0.35 μs      | 0.995 ± 0.18               |
| Quantile/Convolved analytic/grid                                                                | 0.624 ± 0.1 ms      | 0.607 ± 0.1 ms      | 1.03 ± 0.24                |
| Quantile/Convolved analytic/median                                                              | 23.5 ± 0.85 μs      | 22.6 ± 0.81 μs      | 1.04 ± 0.053               |
| Quantile/Convolved numeric/median                                                               | 0.292 ± 0.011 ms    | 0.293 ± 0.012 ms    | 0.996 ± 0.055              |
| Quantile/Difference numeric/median                                                              | 0.34 ± 0.011 ms     | 0.341 ± 0.011 ms    | 0.997 ± 0.044              |
| Quantile/Product numeric/median                                                                 | 0.498 ± 0.013 ms    | 0.5 ± 0.013 ms      | 0.995 ± 0.037              |
| Timeseries/Convolved delay                                                                      | 0.752 ± 0.008 ms    | 0.754 ± 0.0079 ms   | 0.998 ± 0.015              |
| Timeseries/Gamma delay                                                                          | 1.83 ± 0.035 μs     | 1.86 ± 0.017 μs     | 0.985 ± 0.021              |
| Timeseries/Poisson delay                                                                        | 1.27 ± 0.025 μs     | 1.27 ± 0.014 μs     | 0.996 ± 0.023              |
| time_to_load                                                                                    | 0.852 ± 0.002 s     | 0.864 ± 0.011 s     | 0.986 ± 0.012              |

|                                                                                                 | v0.2.0                    | 0cd7be783425e6...         | v0.2.0 / 0cd7be783425e6... |
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

