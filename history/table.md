|                                                                                                 | v0.2.0              | f75bc819046978...   | v0.2.0 / f75bc819046978... |
|:------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0629 ± 0.0036 ms  | 0.0634 ± 0.0035 ms  | 0.992 ± 0.079              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.482 ± 0.044 ms    | 0.489 ± 0.045 ms    | 0.986 ± 0.13               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0529 ± 0.00045 ms | 0.054 ± 0.00049 ms  | 0.981 ± 0.012              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.256 ± 0.0083 ms   | 0.256 ± 0.0088 ms   | 1 ± 0.047                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.604 ± 0.032 ms    | 0.596 ± 0.035 ms    | 1.01 ± 0.081               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 2.29 ± 0.28 ms      | 2.27 ± 0.28 ms      | 1.01 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.0874 ± 0.0074 ms  | 0.0869 ± 0.0069 ms  | 1.01 ± 0.12                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.481 ± 0.044 ms    | 0.485 ± 0.044 ms    | 0.993 ± 0.13               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.0661 ± 0.0008 ms  | 0.0661 ± 0.00082 ms | 0.999 ± 0.017              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.527 ± 0.015 ms    | 0.53 ± 0.015 ms     | 0.994 ± 0.04               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.595 ± 0.035 ms    | 0.593 ± 0.035 ms    | 1 ± 0.083                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 2.59 ± 0.34 ms      | 2.6 ± 0.33 ms       | 0.995 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.0739 ± 0.00048 ms | 0.0726 ± 0.00056 ms | 1.02 ± 0.01                |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.127 ± 0.0076 ms   | 0.127 ± 0.0065 ms   | 1 ± 0.079                  |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.0683 ± 0.00018 ms | 0.0697 ± 0.00014 ms | 0.98 ± 0.0033              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.292 ± 0.0096 ms   | 0.293 ± 0.0095 ms   | 0.996 ± 0.046              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.558 ± 0.034 ms    | 0.561 ± 0.039 ms    | 0.995 ± 0.092              |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 2.52 ± 0.31 ms      | 2.53 ± 0.31 ms      | 0.999 ± 0.17               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 7.21 ± 0.1 μs       | 7.23 ± 0.12 μs      | 0.996 ± 0.022              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.0472 ± 0.015 μs   | 0.0464 ± 0.015 μs   | 1.02 ± 0.47                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.522 ± 0.044 μs    | 0.559 ± 0.052 μs    | 0.934 ± 0.12               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 5.05 ± 0.68 μs      | 5.19 ± 0.72 μs      | 0.975 ± 0.19               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 4.47 ± 0.19 μs      | 4.62 ± 0.24 μs      | 0.966 ± 0.066              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.59 ± 0.16 μs      | 2.62 ± 0.13 μs      | 0.987 ± 0.079              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.0935 ± 0.00071 ms | 0.0938 ± 0.00072 ms | 0.997 ± 0.011              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.15 ± 0.0076 ms    | 0.15 ± 0.0073 ms    | 0.996 ± 0.07               |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.0843 ± 0.00021 ms | 0.0856 ± 0.00022 ms | 0.985 ± 0.0035             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.376 ± 0.01 ms     | 0.377 ± 0.0098 ms   | 0.997 ± 0.037              |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.604 ± 0.036 ms    | 0.603 ± 0.044 ms    | 1 ± 0.094                  |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 2.41 ± 0.3 ms       | 2.44 ± 0.29 ms      | 0.986 ± 0.17               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 8.19 ± 0.084 μs     | 8.19 ± 0.09 μs      | 1 ± 0.015                  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 3.45 ± 0.12 μs      | 3.5 ± 0.11 μs       | 0.987 ± 0.045              |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.612 ± 0.083 μs    | 0.614 ± 0.082 μs    | 0.997 ± 0.19               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 5.78 ± 0.31 μs      | 5.82 ± 0.3 μs       | 0.993 ± 0.073              |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 27.8 ± 3.2 μs       | 28.1 ± 3.4 μs       | 0.991 ± 0.17               |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 17.6 ± 0.51 μs      | 17.5 ± 0.49 μs      | 1.01 ± 0.041               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.12 ± 0.0014 ms    | 0.119 ± 0.0011 ms   | 1.01 ± 0.015               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.21 ± 0.012 ms     | 0.212 ± 0.012 ms    | 0.991 ± 0.078              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.117 ± 0.00048 ms  | 0.117 ± 0.0005 ms   | 1 ± 0.0059                 |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.503 ± 0.011 ms    | 0.505 ± 0.012 ms    | 0.996 ± 0.033              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.858 ± 0.037 ms    | 0.852 ± 0.042 ms    | 1.01 ± 0.066               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 4.36 ± 0.56 ms      | 4.36 ± 0.6 ms       | 1 ± 0.19                   |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 7.27 ± 0.31 μs      | 7.2 ± 0.12 μs       | 1.01 ± 0.046               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.0477 ± 0.015 μs   | 0.0475 ± 0.013 μs   | 1 ± 0.42                   |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.542 ± 0.046 μs    | 0.552 ± 0.05 μs     | 0.982 ± 0.12               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 5.08 ± 0.66 μs      | 5.17 ± 0.7 μs       | 0.983 ± 0.18               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 4.57 ± 0.26 μs      | 4.58 ± 0.24 μs      | 0.997 ± 0.078              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.56 ± 0.097 μs     | 2.61 ± 0.15 μs      | 0.977 ± 0.067              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.145 ± 0.0016 ms   | 0.146 ± 0.0015 ms   | 0.994 ± 0.015              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.24 ± 0.012 ms     | 0.243 ± 0.012 ms    | 0.988 ± 0.07               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.14 ± 0.00063 ms   | 0.14 ± 0.00083 ms   | 1 ± 0.0075                 |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.624 ± 0.01 ms     | 0.624 ± 0.0097 ms   | 1 ± 0.023                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.931 ± 0.032 ms    | 0.927 ± 0.042 ms    | 1.01 ± 0.057               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 4.25 ± 0.53 ms      | 4.27 ± 0.64 ms      | 0.996 ± 0.19               |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 8.11 ± 0.084 μs     | 8.13 ± 0.1 μs       | 0.997 ± 0.016              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 3.19 ± 0.058 μs     | 3.26 ± 0.1 μs       | 0.978 ± 0.035              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.577 ± 0.083 μs    | 0.576 ± 0.084 μs    | 1 ± 0.21                   |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 5.48 ± 0.28 μs      | 5.44 ± 0.3 μs       | 1.01 ± 0.076               |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 27.1 ± 3.1 μs       | 27.8 ± 6.2 μs       | 0.975 ± 0.24               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 18.2 ± 0.57 μs      | 18.5 ± 0.56 μs      | 0.987 ± 0.043              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 7.36 ± 0.33 μs      | 7.23 ± 0.12 μs      | 1.02 ± 0.048               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.0711 ± 0.016 μs   | 0.0699 ± 0.013 μs   | 1.02 ± 0.3                 |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.616 ± 0.045 μs    | 0.601 ± 0.075 μs    | 1.02 ± 0.15                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 5.33 ± 0.52 μs      | 5.46 ± 0.75 μs      | 0.977 ± 0.16               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 6.58 ± 0.58 μs      | 6.63 ± 0.76 μs      | 0.993 ± 0.14               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 10.3 ± 0.35 μs      | 10.5 ± 0.37 μs      | 0.983 ± 0.048              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.123 ± 0.0011 ms   | 0.123 ± 0.0011 ms   | 0.999 ± 0.012              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.214 ± 0.012 ms    | 0.214 ± 0.011 ms    | 0.999 ± 0.074              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.119 ± 0.00045 ms  | 0.118 ± 0.00055 ms  | 1 ± 0.006                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.532 ± 0.01 ms     | 0.541 ± 0.011 ms    | 0.984 ± 0.028              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.902 ± 0.044 ms    | 0.893 ± 0.045 ms    | 1.01 ± 0.071               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 4.88 ± 0.56 ms      | 4.86 ± 0.56 ms      | 1.01 ± 0.16                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.15 ± 0.0015 ms    | 0.15 ± 0.0013 ms    | 1 ± 0.014                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.254 ± 0.013 ms    | 0.252 ± 0.013 ms    | 1.01 ± 0.073               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.144 ± 0.00063 ms  | 0.142 ± 0.00056 ms  | 1.02 ± 0.006               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.65 ± 0.0099 ms    | 0.65 ± 0.0098 ms    | 1 ± 0.021                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.978 ± 0.036 ms    | 0.973 ± 0.04 ms     | 1 ± 0.055                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 4.76 ± 0.59 ms      | 4.69 ± 0.52 ms      | 1.02 ± 0.17                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 8.18 ± 0.084 μs     | 8.12 ± 0.087 μs     | 1.01 ± 0.015               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 3.35 ± 0.12 μs      | 3.31 ± 0.074 μs     | 1.01 ± 0.044               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.585 ± 0.082 μs    | 0.584 ± 0.081 μs    | 1 ± 0.2                    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 5.67 ± 0.32 μs      | 5.71 ± 0.35 μs      | 0.993 ± 0.083              |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 18.4 ± 1.4 μs       | 17.4 ± 1.1 μs       | 1.06 ± 0.11                |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 22.2 ± 0.64 μs      | 22.2 ± 0.65 μs      | 0.998 ± 0.041              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 7.43 ± 0.12 μs      | 7.4 ± 0.12 μs       | 1 ± 0.023                  |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 7.5 ± 0.07 μs       | 7.35 ± 0.078 μs     | 1.02 ± 0.014               |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.939 ± 0.045 μs    | 0.943 ± 0.093 μs    | 0.996 ± 0.11               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 6.16 ± 0.94 μs      | 6.06 ± 0.96 μs      | 1.02 ± 0.22                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 18.2 ± 1 μs         | 17.9 ± 1.1 μs       | 1.02 ± 0.086               |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 28.9 ± 0.7 μs       | 29.7 ± 0.63 μs      | 0.975 ± 0.031              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.633 ± 0.0096 ms   | 0.637 ± 0.0097 ms   | 0.993 ± 0.021              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.845 ± 0.033 ms    | 0.848 ± 0.019 ms    | 0.997 ± 0.045              |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.543 ± 0.0099 ms   | 0.541 ± 0.0099 ms   | 1 ± 0.026                  |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 2.57 ± 0.0095 ms    | 2.56 ± 0.01 ms      | 1 ± 0.0054                 |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 1.84 ± 0.067 ms     | 1.82 ± 0.065 ms     | 1.01 ± 0.052               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 9.34 ± 1.3 ms       | 9.33 ± 1.4 ms       | 1 ± 0.2                    |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 10.8 ± 0.13 μs      | 10.7 ± 0.15 μs      | 1.02 ± 0.019               |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 13.5 ± 0.14 μs      | 13.7 ± 0.22 μs      | 0.991 ± 0.019              |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 3.23 ± 0.041 μs     | 3.22 ± 0.046 μs     | 1 ± 0.019                  |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 12.1 ± 0.33 μs      | 11.9 ± 0.45 μs      | 1.02 ± 0.048               |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 20.9 ± 2.5 μs       | 21.1 ± 2.7 μs       | 0.99 ± 0.17                |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.0348 ± 0.00081 ms | 0.0348 ± 0.00068 ms | 0.999 ± 0.03               |
| Baseline/Gamma/cdf                                                                              | 3.56 ± 0.37 μs      | 5 ± 0.38 μs         | 0.712 ± 0.091              |
| Baseline/Gamma/logpdf                                                                           | 2.89 ± 0.33 μs      | 2.88 ± 0.33 μs      | 1 ± 0.16                   |
| Baseline/Normal/cdf                                                                             | 1.49 ± 0.3 μs       | 1.49 ± 0.31 μs      | 0.997 ± 0.29               |
| Baseline/Normal/logpdf                                                                          | 1.05 ± 0.027 μs     | 1.05 ± 0.022 μs     | 0.995 ± 0.033              |
| Convolved/analytic/cdf batched                                                                  | 2.67 ± 0.35 μs      | 2.68 ± 0.35 μs      | 0.999 ± 0.19               |
| Convolved/analytic/cdf scalar                                                                   | 28.1 ± 0.29 ns      | 28.2 ± 0.17 ns      | 0.995 ± 0.012              |
| Convolved/analytic/construction                                                                 | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 0.997 ± 0.0045             |
| Convolved/analytic/logpdf batched                                                               | 1.08 ± 0.054 μs     | 1.08 ± 0.029 μs     | 0.997 ± 0.057              |
| Convolved/analytic/logpdf broadcast                                                             | 2.57 ± 0.35 μs      | 2.54 ± 0.35 μs      | 1.01 ± 0.2                 |
| Convolved/analytic/logpdf scalar                                                                | 27.9 ± 0.24 ns      | 27.8 ± 0.15 ns      | 1 ± 0.01                   |
| Convolved/analytic/mean                                                                         | 3.1 ± 0.01 ns       | 3.41 ± 0.001 ns     | 0.909 ± 0.0029             |
| Convolved/analytic/pdf batched                                                                  | 1.12 ± 0.029 μs     | 1.12 ± 0.031 μs     | 0.994 ± 0.038              |
| Convolved/analytic/pdf scalar                                                                   | 29.8 ± 0.18 ns      | 30 ± 0.25 ns        | 0.994 ± 0.01               |
| Convolved/analytic/rand                                                                         | 1.13 ± 0.035 μs     | 1.16 ± 0.035 μs     | 0.967 ± 0.042              |
| Convolved/numeric/cdf batched                                                                   | 0.841 ± 0.0023 ms   | 0.833 ± 0.0026 ms   | 1.01 ± 0.0042              |
| Convolved/numeric/cdf scalar                                                                    | 15.6 ± 0.061 μs     | 15.7 ± 0.06 μs      | 0.996 ± 0.0054             |
| Convolved/numeric/construction                                                                  | 4.02 ± 0.92 ns      | 4.02 ± 0.93 ns      | 1 ± 0.33                   |
| Convolved/numeric/logpdf batched                                                                | 0.735 ± 0.0058 ms   | 0.744 ± 0.0034 ms   | 0.988 ± 0.0091             |
| Convolved/numeric/logpdf broadcast                                                              | 1.35 ± 0.0089 ms    | 1.35 ± 0.0093 ms    | 1 ± 0.0096                 |
| Convolved/numeric/logpdf scalar                                                                 | 12.6 ± 0.039 μs     | 12.5 ± 0.04 μs      | 1 ± 0.0045                 |
| Convolved/numeric/mean                                                                          | 6.61 ± 0.031 ns     | 6.61 ± 0.031 ns     | 1 ± 0.0066                 |
| Convolved/numeric/pdf batched                                                                   | 0.736 ± 0.007 ms    | 0.743 ± 0.0035 ms   | 0.991 ± 0.01               |
| Convolved/numeric/pdf scalar                                                                    | 12.6 ± 0.04 μs      | 12.5 ± 0.03 μs      | 1 ± 0.004                  |
| Convolved/numeric/rand                                                                          | 2.83 ± 0.35 μs      | 2.79 ± 0.35 μs      | 1.01 ± 0.18                |
| Difference/analytic/cdf broadcast                                                               | 3.37 ± 0.35 μs      | 3.38 ± 0.36 μs      | 0.999 ± 0.15               |
| Difference/analytic/cdf scalar                                                                  | 10.8 ± 0.011 ns     | 10.8 ± 0.011 ns     | 1 ± 0.0014                 |
| Difference/analytic/construction                                                                | 3.11 ± 0.01 ns      | 3.72 ± 0 ns         | 0.836 ± 0.0027             |
| Difference/analytic/logpdf broadcast                                                            | 1.51 ± 0.32 μs      | 1.52 ± 0.32 μs      | 0.993 ± 0.29               |
| Difference/analytic/logpdf scalar                                                               | 16.8 ± 0.07 ns      | 17 ± 0.08 ns        | 0.991 ± 0.0062             |
| Difference/analytic/mean                                                                        | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       | 0.903 ± 0.0044             |
| Difference/analytic/rand                                                                        | 1.13 ± 0.043 μs     | 1.14 ± 0.038 μs     | 0.984 ± 0.05               |
| Difference/numeric/cdf broadcast                                                                | 1.34 ± 0.018 ms     | 1.35 ± 0.018 ms     | 0.994 ± 0.019              |
| Difference/numeric/cdf scalar                                                                   | 19.3 ± 0.08 μs      | 19.5 ± 0.09 μs      | 0.992 ± 0.0062             |
| Difference/numeric/construction                                                                 | 3.11 ± 0.01 ns      | 3.72 ± 0 ns         | 0.836 ± 0.0027             |
| Difference/numeric/logpdf broadcast                                                             | 1.66 ± 0.016 ms     | 1.65 ± 0.016 ms     | 1.01 ± 0.014               |
| Difference/numeric/logpdf scalar                                                                | 16.8 ± 0.079 μs     | 16.8 ± 0.08 μs      | 1 ± 0.0067                 |
| Difference/numeric/mean                                                                         | 6.59 ± 0.06 ns      | 6.59 ± 0.042 ns     | 1 ± 0.011                  |
| Difference/numeric/rand                                                                         | 2.83 ± 0.35 μs      | 2.79 ± 0.36 μs      | 1.01 ± 0.18                |
| Product/analytic/cdf broadcast                                                                  | 4.9 ± 0.22 μs       | 4.92 ± 0.21 μs      | 0.997 ± 0.062              |
| Product/analytic/cdf scalar                                                                     | 29.7 ± 0.6 ns       | 29.7 ± 0.061 ns     | 1 ± 0.02                   |
| Product/analytic/construction                                                                   | 3.72 ± 0 ns         | 3.41 ± 0.01 ns      | 1.09 ± 0.0032              |
| Product/analytic/logpdf broadcast                                                               | 2.29 ± 0.34 μs      | 2.24 ± 0.33 μs      | 1.02 ± 0.21                |
| Product/analytic/logpdf scalar                                                                  | 24 ± 0.15 ns        | 24.1 ± 0.071 ns     | 0.997 ± 0.007              |
| Product/analytic/mean                                                                           | 10.8 ± 0.031 ns     | 10.8 ± 0.04 ns      | 0.998 ± 0.0047             |
| Product/analytic/rand                                                                           | 1.79 ± 0.32 μs      | 1.8 ± 0.32 μs       | 0.994 ± 0.25               |
| Product/numeric/cdf broadcast                                                                   | 1.98 ± 0.016 ms     | 1.98 ± 0.016 ms     | 0.997 ± 0.011              |
| Product/numeric/cdf scalar                                                                      | 23.2 ± 0.11 μs      | 23.2 ± 0.1 μs       | 0.998 ± 0.0064             |
| Product/numeric/construction                                                                    | 4.03 ± 0.011 ns     | 3.72 ± 0 ns         | 1.08 ± 0.003               |
| Product/numeric/logpdf broadcast                                                                | 1.77 ± 0.015 ms     | 1.77 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                                   | 17.6 ± 0.07 μs      | 17.5 ± 0.08 μs      | 1.01 ± 0.0061              |
| Product/numeric/mean                                                                            | 6.7 ± 0.04 ns       | 6.71 ± 0.04 ns      | 0.999 ± 0.0084             |
| Product/numeric/rand                                                                            | 2.83 ± 0.36 μs      | 2.8 ± 0.36 μs       | 1.01 ± 0.18                |
| Quantile/Convolved analytic/grid                                                                | 0.624 ± 0.1 ms      | 0.625 ± 0.1 ms      | 0.999 ± 0.23               |
| Quantile/Convolved analytic/median                                                              | 23.1 ± 0.82 μs      | 23.2 ± 0.9 μs       | 0.995 ± 0.052              |
| Quantile/Convolved numeric/median                                                               | 0.292 ± 0.013 ms    | 0.293 ± 0.012 ms    | 0.996 ± 0.06               |
| Quantile/Difference numeric/median                                                              | 0.34 ± 0.012 ms     | 0.343 ± 0.012 ms    | 0.992 ± 0.048              |
| Quantile/Product numeric/median                                                                 | 0.499 ± 0.012 ms    | 0.502 ± 0.013 ms    | 0.995 ± 0.036              |
| Timeseries/Convolved delay                                                                      | 0.746 ± 0.0082 ms   | 0.753 ± 0.0089 ms   | 0.99 ± 0.016               |
| Timeseries/Gamma delay                                                                          | 1.83 ± 0.035 μs     | 1.83 ± 0.038 μs     | 0.995 ± 0.028              |
| Timeseries/Poisson delay                                                                        | 1.27 ± 0.038 μs     | 1.27 ± 0.036 μs     | 0.998 ± 0.041              |
| time_to_load                                                                                    | 0.89 ± 0.0091 s     | 0.912 ± 0.0089 s    | 0.976 ± 0.014              |

|                                                                                                 | v0.2.0                    | f75bc819046978...         | v0.2.0 / f75bc819046978... |
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

