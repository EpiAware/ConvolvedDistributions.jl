|                                                                                                 | v0.2.0              | 9e2ef2d37777d3...   | v0.2.0 / 9e2ef2d37777d3... |
|:------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0632 ± 0.0036 ms  | 0.0619 ± 0.0035 ms  | 1.02 ± 0.082               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.468 ± 0.045 ms    | 0.463 ± 0.046 ms    | 1.01 ± 0.14                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0542 ± 0.00046 ms | 0.0535 ± 0.00037 ms | 1.01 ± 0.011               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.252 ± 0.0069 ms   | 0.254 ± 0.0067 ms   | 0.992 ± 0.038              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.594 ± 0.027 ms    | 0.587 ± 0.021 ms    | 1.01 ± 0.058               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 2.22 ± 0.28 ms      | 2.25 ± 0.28 ms      | 0.99 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.0864 ± 0.007 ms   | 0.0871 ± 0.0067 ms  | 0.992 ± 0.11               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.467 ± 0.045 ms    | 0.464 ± 0.046 ms    | 1.01 ± 0.14                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.0663 ± 0.00071 ms | 0.0658 ± 0.00061 ms | 1.01 ± 0.014               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.523 ± 0.013 ms    | 0.523 ± 0.013 ms    | 1 ± 0.035                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.591 ± 0.027 ms    | 0.59 ± 0.022 ms     | 1 ± 0.059                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 2.55 ± 0.33 ms      | 2.58 ± 0.33 ms      | 0.987 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.0729 ± 0.00051 ms | 0.073 ± 0.00046 ms  | 0.999 ± 0.0094             |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.125 ± 0.0064 ms   | 0.122 ± 0.0062 ms   | 1.03 ± 0.074               |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.0697 ± 0.00015 ms | 0.0691 ± 0.00013 ms | 1.01 ± 0.0029              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.292 ± 0.009 ms    | 0.292 ± 0.0088 ms   | 0.999 ± 0.043              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.56 ± 0.027 ms     | 0.557 ± 0.023 ms    | 1 ± 0.064                  |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 2.54 ± 0.31 ms      | 2.5 ± 0.29 ms       | 1.02 ± 0.17                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 7.18 ± 0.1 μs       | 7.23 ± 0.31 μs      | 0.994 ± 0.045              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.0471 ± 0.015 μs   | 0.0465 ± 0.011 μs   | 1.01 ± 0.4                 |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.536 ± 0.043 μs    | 0.549 ± 0.041 μs    | 0.977 ± 0.11               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 5 ± 0.68 μs         | 4.99 ± 0.69 μs      | 1 ± 0.19                   |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 4.53 ± 0.22 μs      | 4.63 ± 0.25 μs      | 0.978 ± 0.07               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.5 ± 0.096 μs      | 2.53 ± 0.078 μs     | 0.987 ± 0.049              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.093 ± 0.00074 ms  | 0.0932 ± 0.00069 ms | 0.998 ± 0.011              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.146 ± 0.0073 ms   | 0.145 ± 0.0075 ms   | 1.01 ± 0.073               |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.0856 ± 0.00019 ms | 0.0856 ± 0.00024 ms | 1 ± 0.0036                 |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.377 ± 0.0094 ms   | 0.377 ± 0.0092 ms   | 1 ± 0.035                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.605 ± 0.029 ms    | 0.605 ± 0.025 ms    | 1 ± 0.063                  |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 2.39 ± 0.3 ms       | 2.36 ± 0.29 ms      | 1.01 ± 0.18                |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 8.13 ± 0.064 μs     | 8.15 ± 0.08 μs      | 0.998 ± 0.013              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 3.35 ± 0.059 μs     | 3.35 ± 0.051 μs     | 1 ± 0.023                  |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.611 ± 0.081 μs    | 0.606 ± 0.079 μs    | 1.01 ± 0.19                |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 5.66 ± 0.21 μs      | 5.69 ± 0.23 μs      | 0.996 ± 0.055              |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 27.5 ± 3.2 μs       | 27.9 ± 3 μs         | 0.988 ± 0.16               |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 17.1 ± 0.41 μs      | 17.4 ± 0.42 μs      | 0.983 ± 0.033              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.12 ± 0.00092 ms   | 0.12 ± 0.001 ms     | 1 ± 0.012                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.207 ± 0.011 ms    | 0.207 ± 0.011 ms    | 0.998 ± 0.077              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.117 ± 0.00039 ms  | 0.118 ± 0.00045 ms  | 0.996 ± 0.0051             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.503 ± 0.011 ms    | 0.506 ± 0.01 ms     | 0.995 ± 0.03               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.84 ± 0.027 ms     | 0.833 ± 0.019 ms    | 1.01 ± 0.04                |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 4.29 ± 0.52 ms      | 4.27 ± 0.52 ms      | 1 ± 0.17                   |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 7.23 ± 0.16 μs      | 7.17 ± 0.095 μs     | 1.01 ± 0.026               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.0469 ± 0.017 μs   | 0.0478 ± 0.011 μs   | 0.982 ± 0.41               |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.547 ± 0.044 μs    | 0.53 ± 0.043 μs     | 1.03 ± 0.12                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 5.07 ± 0.65 μs      | 5.09 ± 0.69 μs      | 0.997 ± 0.19               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 4.46 ± 0.23 μs      | 4.58 ± 0.2 μs       | 0.974 ± 0.066              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.54 ± 0.077 μs     | 2.6 ± 0.16 μs       | 0.979 ± 0.066              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.145 ± 0.0016 ms   | 0.144 ± 0.0015 ms   | 1.01 ± 0.015               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.256 ± 0.013 ms    | 0.237 ± 0.011 ms    | 1.08 ± 0.075               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.139 ± 0.00059 ms  | 0.138 ± 0.00066 ms  | 1.01 ± 0.0064              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.624 ± 0.009 ms    | 0.629 ± 0.0091 ms   | 0.992 ± 0.02               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.953 ± 0.026 ms    | 0.911 ± 0.019 ms    | 1.05 ± 0.036               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 4.15 ± 0.52 ms      | 4.2 ± 0.54 ms       | 0.988 ± 0.18               |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 8.1 ± 0.08 μs       | 8.1 ± 0.08 μs       | 1 ± 0.014                  |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 3.19 ± 0.068 μs     | 3.2 ± 0.12 μs       | 0.998 ± 0.042              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.573 ± 0.08 μs     | 0.571 ± 0.08 μs     | 1 ± 0.2                    |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 5.33 ± 0.25 μs      | 5.45 ± 0.33 μs      | 0.978 ± 0.075              |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 27.6 ± 3.2 μs       | 27.8 ± 3.2 μs       | 0.993 ± 0.16               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 18.2 ± 0.62 μs      | 18.3 ± 0.57 μs      | 0.997 ± 0.046              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 7.28 ± 0.15 μs      | 7.23 ± 0.09 μs      | 1.01 ± 0.024               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.0704 ± 0.016 μs   | 0.0697 ± 0.013 μs   | 1.01 ± 0.3                 |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.601 ± 0.042 μs    | 0.599 ± 0.043 μs    | 1 ± 0.1                    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 5.27 ± 0.57 μs      | 5.23 ± 0.55 μs      | 1.01 ± 0.15                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 6.56 ± 0.73 μs      | 6.39 ± 0.83 μs      | 1.03 ± 0.18                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 10.2 ± 0.32 μs      | 10.4 ± 0.42 μs      | 0.983 ± 0.05               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.124 ± 0.0011 ms   | 0.123 ± 0.00088 ms  | 1.01 ± 0.011               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.213 ± 0.011 ms    | 0.209 ± 0.011 ms    | 1.02 ± 0.074               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.118 ± 0.00048 ms  | 0.118 ± 0.00044 ms  | 1 ± 0.0055                 |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.529 ± 0.01 ms     | 0.531 ± 0.01 ms     | 0.996 ± 0.027              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.897 ± 0.037 ms    | 0.866 ± 0.018 ms    | 1.04 ± 0.048               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 4.78 ± 0.57 ms      | 4.79 ± 0.57 ms      | 0.997 ± 0.17               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.15 ± 0.0014 ms    | 0.149 ± 0.0011 ms   | 1 ± 0.012                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.251 ± 0.013 ms    | 0.245 ± 0.011 ms    | 1.03 ± 0.072               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.143 ± 0.00062 ms  | 0.142 ± 0.00047 ms  | 1.01 ± 0.0055              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.648 ± 0.0085 ms   | 0.648 ± 0.0088 ms   | 1 ± 0.019                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.969 ± 0.025 ms    | 0.953 ± 0.018 ms    | 1.02 ± 0.033               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 4.64 ± 0.57 ms      | 4.62 ± 0.56 ms      | 1 ± 0.17                   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 8.16 ± 0.077 μs     | 8.12 ± 0.073 μs     | 1.01 ± 0.013               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 3.28 ± 0.074 μs     | 3.25 ± 0.05 μs      | 1.01 ± 0.028               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.576 ± 0.078 μs    | 0.575 ± 0.079 μs    | 1 ± 0.19                   |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 5.7 ± 0.29 μs       | 5.64 ± 0.27 μs      | 1.01 ± 0.07                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 17.7 ± 1.5 μs       | 17.4 ± 0.9 μs       | 1.02 ± 0.1                 |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 22.1 ± 0.63 μs      | 21.9 ± 0.66 μs      | 1.01 ± 0.042               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 7.44 ± 0.12 μs      | 7.41 ± 0.085 μs     | 1.01 ± 0.02                |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 7.66 ± 0.088 μs     | 7.72 ± 0.065 μs     | 0.992 ± 0.014              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.954 ± 0.11 μs     | 0.961 ± 0.13 μs     | 0.993 ± 0.17               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 6.09 ± 0.9 μs       | 6.17 ± 0.29 μs      | 0.988 ± 0.15               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 17.8 ± 0.98 μs      | 17.5 ± 0.89 μs      | 1.02 ± 0.076               |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 29.2 ± 0.65 μs      | 29 ± 0.59 μs        | 1.01 ± 0.03                |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.635 ± 0.0088 ms   | 0.634 ± 0.009 ms    | 1 ± 0.02                   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.824 ± 0.015 ms    | 0.791 ± 0.014 ms    | 1.04 ± 0.027               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.54 ± 0.0095 ms    | 0.553 ± 0.0095 ms   | 0.978 ± 0.024              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 2.56 ± 0.009 ms     | 2.57 ± 0.0094 ms    | 0.997 ± 0.0051             |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 1.8 ± 0.037 ms      | 1.78 ± 0.031 ms     | 1.01 ± 0.027               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 9.05 ± 1.2 ms       | 9.03 ± 1.1 ms       | 1 ± 0.19                   |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 10.7 ± 0.14 μs      | 10.7 ± 0.14 μs      | 1 ± 0.019                  |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 13.9 ± 0.17 μs      | 13.8 ± 0.23 μs      | 1.01 ± 0.021               |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 3.22 ± 0.035 μs     | 3.28 ± 0.045 μs     | 0.983 ± 0.017              |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 11.9 ± 0.39 μs      | 12 ± 0.43 μs        | 0.989 ± 0.048              |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 20.9 ± 2.4 μs       | 21 ± 2.5 μs         | 0.998 ± 0.16               |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.034 ± 0.00064 ms  | 0.0349 ± 0.00085 ms | 0.974 ± 0.03               |
| Baseline/Gamma/cdf                                                                              | 3.56 ± 0.38 μs      | 3.56 ± 0.39 μs      | 1 ± 0.15                   |
| Baseline/Gamma/logpdf                                                                           | 2.9 ± 0.33 μs       | 2.89 ± 0.33 μs      | 1.01 ± 0.16                |
| Baseline/Normal/cdf                                                                             | 1.48 ± 0.31 μs      | 1.47 ± 0.31 μs      | 1 ± 0.29                   |
| Baseline/Normal/logpdf                                                                          | 1.05 ± 0.022 μs     | 1.05 ± 0.025 μs     | 0.999 ± 0.032              |
| Convolved/analytic/cdf batched                                                                  | 2.65 ± 0.35 μs      | 2.66 ± 0.34 μs      | 0.995 ± 0.18               |
| Convolved/analytic/cdf scalar                                                                   | 28.2 ± 0.1 ns       | 28.3 ± 0.28 ns      | 0.997 ± 0.01               |
| Convolved/analytic/construction                                                                 | 3.1 ± 0.01 ns       | 4.02 ± 0.92 ns      | 0.771 ± 0.18               |
| Convolved/analytic/logpdf batched                                                               | 1.08 ± 0.029 μs     | 1.08 ± 0.033 μs     | 1 ± 0.041                  |
| Convolved/analytic/logpdf broadcast                                                             | 2.57 ± 0.34 μs      | 2.51 ± 0.34 μs      | 1.02 ± 0.19                |
| Convolved/analytic/logpdf scalar                                                                | 28.1 ± 0.2 ns       | 28 ± 0.3 ns         | 1 ± 0.013                  |
| Convolved/analytic/mean                                                                         | 3.41 ± 0.001 ns     | 3.1 ± 0.01 ns       | 1.1 ± 0.0036               |
| Convolved/analytic/pdf batched                                                                  | 1.12 ± 0.03 μs      | 1.12 ± 0.031 μs     | 0.995 ± 0.038              |
| Convolved/analytic/pdf scalar                                                                   | 29.8 ± 0.15 ns      | 29.9 ± 0.08 ns      | 0.999 ± 0.0058             |
| Convolved/analytic/rand                                                                         | 1.12 ± 0.032 μs     | 1.13 ± 0.028 μs     | 0.999 ± 0.038              |
| Convolved/numeric/cdf batched                                                                   | 0.832 ± 0.0026 ms   | 0.833 ± 0.0025 ms   | 0.999 ± 0.0043             |
| Convolved/numeric/cdf scalar                                                                    | 15.6 ± 0.07 μs      | 15.7 ± 0.07 μs      | 0.997 ± 0.0063             |
| Convolved/numeric/construction                                                                  | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/numeric/logpdf batched                                                                | 0.736 ± 0.0058 ms   | 0.739 ± 0.0059 ms   | 0.995 ± 0.011              |
| Convolved/numeric/logpdf broadcast                                                              | 1.35 ± 0.0088 ms    | 1.35 ± 0.0086 ms    | 1 ± 0.0091                 |
| Convolved/numeric/logpdf scalar                                                                 | 12.6 ± 0.04 μs      | 12.6 ± 0.04 μs      | 0.999 ± 0.0045             |
| Convolved/numeric/mean                                                                          | 6.86 ± 0.08 ns      | 6.61 ± 0.031 ns     | 1.04 ± 0.013               |
| Convolved/numeric/pdf batched                                                                   | 0.732 ± 0.0068 ms   | 0.738 ± 0.0058 ms   | 0.992 ± 0.012              |
| Convolved/numeric/pdf scalar                                                                    | 12.5 ± 0.04 μs      | 12.5 ± 0.04 μs      | 0.999 ± 0.0045             |
| Convolved/numeric/rand                                                                          | 2.8 ± 0.36 μs       | 2.79 ± 0.35 μs      | 1 ± 0.18                   |
| Difference/analytic/cdf broadcast                                                               | 3.36 ± 0.34 μs      | 3.4 ± 0.35 μs       | 0.988 ± 0.14               |
| Difference/analytic/cdf scalar                                                                  | 10.8 ± 0.03 ns      | 10.8 ± 0.019 ns     | 1 ± 0.0033                 |
| Difference/analytic/construction                                                                | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 1 ± 0.0042                 |
| Difference/analytic/logpdf broadcast                                                            | 1.5 ± 0.32 μs       | 1.53 ± 0.31 μs      | 0.985 ± 0.29               |
| Difference/analytic/logpdf scalar                                                               | 17 ± 0.07 ns        | 16.9 ± 0.29 ns      | 1.01 ± 0.018               |
| Difference/analytic/mean                                                                        | 3.1 ± 0.01 ns       | 3.41 ± 0.001 ns     | 0.909 ± 0.0029             |
| Difference/analytic/rand                                                                        | 1.12 ± 0.032 μs     | 1.12 ± 0.034 μs     | 1 ± 0.042                  |
| Difference/numeric/cdf broadcast                                                                | 1.35 ± 0.018 ms     | 1.34 ± 0.018 ms     | 1 ± 0.019                  |
| Difference/numeric/cdf scalar                                                                   | 19.5 ± 0.1 μs       | 19.3 ± 0.081 μs     | 1.01 ± 0.0067              |
| Difference/numeric/construction                                                                 | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 1 ± 0.0042                 |
| Difference/numeric/logpdf broadcast                                                             | 1.66 ± 0.015 ms     | 1.65 ± 0.015 ms     | 1 ± 0.013                  |
| Difference/numeric/logpdf scalar                                                                | 16.8 ± 0.079 μs     | 16.8 ± 0.061 μs     | 1 ± 0.0059                 |
| Difference/numeric/mean                                                                         | 6.55 ± 0.04 ns      | 6.54 ± 0.03 ns      | 1 ± 0.0076                 |
| Difference/numeric/rand                                                                         | 2.81 ± 0.35 μs      | 2.79 ± 0.36 μs      | 1.01 ± 0.18                |
| Product/analytic/cdf broadcast                                                                  | 4.89 ± 0.21 μs      | 4.9 ± 0.21 μs       | 0.997 ± 0.061              |
| Product/analytic/cdf scalar                                                                     | 29.6 ± 0.18 ns      | 29.7 ± 0.21 ns      | 0.997 ± 0.0094             |
| Product/analytic/construction                                                                   | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1 ± 0.0046                 |
| Product/analytic/logpdf broadcast                                                               | 2.3 ± 0.34 μs       | 2.19 ± 0.34 μs      | 1.05 ± 0.23                |
| Product/analytic/logpdf scalar                                                                  | 24 ± 0.09 ns        | 23.9 ± 0.12 ns      | 1 ± 0.0063                 |
| Product/analytic/mean                                                                           | 10.8 ± 0.05 ns      | 10.8 ± 0.039 ns     | 1 ± 0.0059                 |
| Product/analytic/rand                                                                           | 1.78 ± 0.33 μs      | 1.78 ± 0.32 μs      | 1 ± 0.26                   |
| Product/numeric/cdf broadcast                                                                   | 1.97 ± 0.015 ms     | 1.97 ± 0.015 ms     | 0.999 ± 0.011              |
| Product/numeric/cdf scalar                                                                      | 23.1 ± 0.1 μs       | 23.1 ± 0.09 μs      | 1 ± 0.0058                 |
| Product/numeric/construction                                                                    | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 1 ± 0.0042                 |
| Product/numeric/logpdf broadcast                                                                | 1.77 ± 0.014 ms     | 1.77 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                                   | 17.6 ± 0.081 μs     | 17.6 ± 0.07 μs      | 1 ± 0.0061                 |
| Product/numeric/mean                                                                            | 6.73 ± 0.2 ns       | 6.81 ± 0.24 ns      | 0.988 ± 0.046              |
| Product/numeric/rand                                                                            | 2.81 ± 0.35 μs      | 2.81 ± 0.35 μs      | 0.999 ± 0.18               |
| Quantile/Convolved analytic/grid                                                                | 0.6 ± 0.094 ms      | 0.608 ± 0.1 ms      | 0.987 ± 0.23               |
| Quantile/Convolved analytic/median                                                              | 23 ± 0.79 μs        | 22.8 ± 0.69 μs      | 1.01 ± 0.046               |
| Quantile/Convolved numeric/median                                                               | 0.291 ± 0.011 ms    | 0.291 ± 0.011 ms    | 0.999 ± 0.054              |
| Quantile/Difference numeric/median                                                              | 0.339 ± 0.01 ms     | 0.338 ± 0.0098 ms   | 1 ± 0.042                  |
| Quantile/Product numeric/median                                                                 | 0.497 ± 0.012 ms    | 0.498 ± 0.011 ms    | 0.999 ± 0.033              |
| Timeseries/Convolved delay                                                                      | 0.745 ± 0.0078 ms   | 0.751 ± 0.0083 ms   | 0.992 ± 0.015              |
| Timeseries/Gamma delay                                                                          | 1.83 ± 0.024 μs     | 1.83 ± 0.024 μs     | 1 ± 0.019                  |
| Timeseries/Poisson delay                                                                        | 1.26 ± 0.026 μs     | 1.27 ± 0.024 μs     | 0.994 ± 0.028              |
| time_to_load                                                                                    | 0.839 ± 0.0027 s    | 0.846 ± 0.0036 s    | 0.992 ± 0.0052             |

|                                                                                                 | v0.2.0                    | 9e2ef2d37777d3...         | v0.2.0 / 9e2ef2d37777d3... |
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

