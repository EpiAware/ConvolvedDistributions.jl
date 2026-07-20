|                                                                                                 | v0.2.0              | a8054b08f54da9...   | v0.2.0 / a8054b08f54da9... |
|:------------------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0449 ± 0.002 ms   | 0.0448 ± 0.0015 ms  | 1 ± 0.056                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.378 ± 0.021 ms    | 0.382 ± 0.025 ms    | 0.989 ± 0.084              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0349 ± 0.00044 ms | 0.035 ± 0.00031 ms  | 0.999 ± 0.015              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.18 ± 0.013 ms     | 0.179 ± 0.0038 ms   | 1.01 ± 0.075               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.425 ± 0.069 ms    | 0.418 ± 0.061 ms    | 1.02 ± 0.22                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 1.73 ± 0.18 ms      | 1.74 ± 0.15 ms      | 0.998 ± 0.13               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.0586 ± 0.0028 ms  | 0.0581 ± 0.0019 ms  | 1.01 ± 0.057               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.38 ± 0.029 ms     | 0.384 ± 0.024 ms    | 0.99 ± 0.098               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.045 ± 0.00092 ms  | 0.0446 ± 0.00094 ms | 1.01 ± 0.03                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.379 ± 0.0082 ms   | 0.377 ± 0.0078 ms   | 1 ± 0.03                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.403 ± 0.07 ms     | 0.415 ± 0.054 ms    | 0.97 ± 0.21                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 1.94 ± 0.18 ms      | 1.93 ± 0.15 ms      | 1 ± 0.12                   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.0505 ± 0.00077 ms | 0.0514 ± 0.0039 ms  | 0.984 ± 0.076              |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.0875 ± 0.0039 ms  | 0.0927 ± 0.0062 ms  | 0.943 ± 0.076              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.0481 ± 0.00021 ms | 0.048 ± 0.00078 ms  | 1 ± 0.017                  |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.202 ± 0.0051 ms   | 0.203 ± 0.0055 ms   | 0.996 ± 0.037              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.393 ± 0.056 ms    | 0.396 ± 0.058 ms    | 0.992 ± 0.2                |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 1.92 ± 0.16 ms      | 1.9 ± 0.22 ms       | 1.01 ± 0.14                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 5.32 ± 0.2 μs       | 5.36 ± 0.17 μs      | 0.993 ± 0.049              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.0369 ± 0.0055 μs  | 0.0366 ± 0.0047 μs  | 1.01 ± 0.2                 |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.423 ± 0.025 μs    | 0.437 ± 0.048 μs    | 0.967 ± 0.12               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 4.1 ± 0.55 μs       | 4.02 ± 0.54 μs      | 1.02 ± 0.19                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 3.57 ± 0.36 μs      | 3.5 ± 0.31 μs       | 1.02 ± 0.14                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.1 ± 0.13 μs       | 2.08 ± 0.13 μs      | 1.01 ± 0.087               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.0664 ± 0.00075 ms | 0.0668 ± 0.00074 ms | 0.995 ± 0.016              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.1 ± 0.004 ms      | 0.102 ± 0.0045 ms   | 0.986 ± 0.058              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.0605 ± 0.00015 ms | 0.0606 ± 0.00049 ms | 0.998 ± 0.0085             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.27 ± 0.0059 ms    | 0.271 ± 0.0066 ms   | 0.999 ± 0.033              |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.416 ± 0.059 ms    | 0.426 ± 0.052 ms    | 0.976 ± 0.18               |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 1.86 ± 0.17 ms      | 1.84 ± 0.15 ms      | 1.01 ± 0.12                |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 6.09 ± 0.079 μs     | 6.12 ± 0.052 μs     | 0.994 ± 0.015              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 2.71 ± 0.078 μs     | 2.7 ± 0.072 μs      | 1 ± 0.039                  |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.47 ± 0.059 μs     | 0.471 ± 0.059 μs    | 0.997 ± 0.18               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 4.42 ± 0.44 μs      | 4.39 ± 0.38 μs      | 1.01 ± 0.13                |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 20 ± 3.2 μs         | 19.9 ± 2.6 μs       | 1 ± 0.21                   |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 13.2 ± 0.72 μs      | 13.2 ± 0.73 μs      | 0.997 ± 0.078              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.0822 ± 0.0023 ms  | 0.0824 ± 0.0032 ms  | 0.997 ± 0.048              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.143 ± 0.0055 ms   | 0.152 ± 0.0063 ms   | 0.937 ± 0.053              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.084 ± 0.00084 ms  | 0.0833 ± 0.00035 ms | 1.01 ± 0.011               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.363 ± 0.008 ms    | 0.365 ± 0.0063 ms   | 0.995 ± 0.028              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.571 ± 0.082 ms    | 0.593 ± 0.072 ms    | 0.963 ± 0.18               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 3.3 ± 0.33 ms       | 3.28 ± 0.27 ms      | 1 ± 0.13                   |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 5.32 ± 0.16 μs      | 5.35 ± 0.2 μs       | 0.993 ± 0.046              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.038 ± 0.005 μs    | 0.0377 ± 0.0054 μs  | 1.01 ± 0.2                 |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.441 ± 0.027 μs    | 0.431 ± 0.034 μs    | 1.02 ± 0.1                 |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 4.07 ± 0.57 μs      | 4.09 ± 0.57 μs      | 0.994 ± 0.2                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 3.49 ± 0.39 μs      | 3.53 ± 0.29 μs      | 0.988 ± 0.14               |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.08 ± 0.12 μs      | 2.08 ± 0.13 μs      | 0.999 ± 0.083              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.104 ± 0.0021 ms   | 0.104 ± 0.0016 ms   | 0.999 ± 0.026              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.164 ± 0.0071 ms   | 0.164 ± 0.0058 ms   | 0.997 ± 0.056              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.0996 ± 0.0028 ms  | 0.0995 ± 0.00039 ms | 1 ± 0.028                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.464 ± 0.0073 ms   | 0.463 ± 0.0066 ms   | 1 ± 0.021                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.604 ± 0.086 ms    | 0.598 ± 0.069 ms    | 1.01 ± 0.18                |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 3.3 ± 0.39 ms       | 3.25 ± 0.26 ms      | 1.01 ± 0.15                |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 6.07 ± 0.082 μs     | 6.04 ± 0.052 μs     | 1 ± 0.016                  |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 2.62 ± 0.069 μs     | 2.62 ± 0.076 μs     | 0.997 ± 0.039              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.458 ± 0.052 μs    | 0.451 ± 0.056 μs    | 1.02 ± 0.17                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 4.25 ± 0.4 μs       | 4.2 ± 0.39 μs       | 1.01 ± 0.13                |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 19.8 ± 2.4 μs       | 20.1 ± 3.1 μs       | 0.984 ± 0.19               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 14 ± 0.84 μs        | 14.2 ± 0.89 μs      | 0.993 ± 0.086              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 5.36 ± 0.16 μs      | 5.38 ± 0.18 μs      | 0.996 ± 0.044              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.0533 ± 0.0059 μs  | 0.0536 ± 0.0056 μs  | 0.995 ± 0.15               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.474 ± 0.029 μs    | 0.469 ± 0.031 μs    | 1.01 ± 0.09                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 4.43 ± 0.56 μs      | 4.24 ± 0.5 μs       | 1.05 ± 0.18                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 5.19 ± 0.87 μs      | 5.18 ± 0.95 μs      | 1 ± 0.25                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 8.24 ± 0.43 μs      | 8.32 ± 0.67 μs      | 0.99 ± 0.095               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.0917 ± 0.0098 ms  | 0.0854 ± 0.001 ms   | 1.07 ± 0.12                |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.149 ± 0.012 ms    | 0.149 ± 0.0066 ms   | 0.998 ± 0.091              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.0844 ± 0.00092 ms | 0.0843 ± 0.0024 ms  | 1 ± 0.03                   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.382 ± 0.015 ms    | 0.379 ± 0.0068 ms   | 1.01 ± 0.043               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.584 ± 0.084 ms    | 0.643 ± 0.075 ms    | 0.908 ± 0.17               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 3.69 ± 0.4 ms       | 3.66 ± 0.35 ms      | 1.01 ± 0.15                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.107 ± 0.0029 ms   | 0.107 ± 0.003 ms    | 0.998 ± 0.039              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.173 ± 0.007 ms    | 0.175 ± 0.0089 ms   | 0.992 ± 0.064              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.101 ± 0.00064 ms  | 0.104 ± 0.0051 ms   | 0.975 ± 0.048              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.48 ± 0.0074 ms    | 0.48 ± 0.0069 ms    | 1 ± 0.021                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.619 ± 0.081 ms    | 0.635 ± 0.077 ms    | 0.974 ± 0.17               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 3.67 ± 0.32 ms      | 3.65 ± 0.29 ms      | 1.01 ± 0.12                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 6.1 ± 0.064 μs      | 6.11 ± 0.09 μs      | 0.999 ± 0.018              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 2.99 ± 0.071 μs     | 2.69 ± 0.16 μs      | 1.11 ± 0.069               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.443 ± 0.055 μs    | 0.433 ± 0.042 μs    | 1.02 ± 0.16                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 4.44 ± 0.4 μs       | 4.39 ± 0.43 μs      | 1.01 ± 0.13                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 12.9 ± 1 μs         | 12.8 ± 0.88 μs      | 1 ± 0.11                   |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 16.8 ± 0.83 μs      | 16.5 ± 0.95 μs      | 1.02 ± 0.077               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 5.35 ± 0.086 μs     | 5.36 ± 0.068 μs     | 0.999 ± 0.02               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 0.947 ± 0.092 μs    | 0.895 ± 0.056 μs    | 1.06 ± 0.12                |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.698 ± 0.05 μs     | 0.693 ± 0.067 μs    | 1.01 ± 0.12                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 4.79 ± 0.7 μs       | 4.94 ± 0.68 μs      | 0.969 ± 0.2                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 13.5 ± 1.4 μs       | 13.6 ± 1.5 μs       | 0.996 ± 0.15               |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 23.6 ± 0.93 μs      | 23.4 ± 0.82 μs      | 1.01 ± 0.053               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.424 ± 0.0063 ms   | 0.422 ± 0.0059 ms   | 1.01 ± 0.02                |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.559 ± 0.0092 ms   | 0.536 ± 0.012 ms    | 1.04 ± 0.028               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.375 ± 0.0062 ms   | 0.374 ± 0.0061 ms   | 1 ± 0.023                  |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 1.74 ± 0.016 ms     | 1.75 ± 0.0059 ms    | 0.998 ± 0.01               |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 1.3 ± 0.13 ms       | 1.31 ± 0.11 ms      | 0.99 ± 0.13                |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 6.84 ± 0.62 ms      | 6.8 ± 0.57 ms       | 1 ± 0.13                   |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 7.72 ± 0.17 μs      | 7.69 ± 0.11 μs      | 1 ± 0.026                  |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 5.38 ± 0.17 μs      | 5.44 ± 0.2 μs       | 0.989 ± 0.049              |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 2.35 ± 0.057 μs     | 2.62 ± 0.24 μs      | 0.896 ± 0.083              |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 8.76 ± 0.19 μs      | 8.7 ± 0.23 μs       | 1.01 ± 0.034               |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 15.6 ± 2.2 μs       | 15.7 ± 2 μs         | 0.993 ± 0.19               |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 28.4 ± 1.9 μs       | 27.6 ± 0.86 μs      | 1.03 ± 0.075               |
| Baseline/Gamma/cdf                                                                              | 2.49 ± 0.23 μs      | 2.42 ± 0.24 μs      | 1.03 ± 0.14                |
| Baseline/Gamma/logpdf                                                                           | 1.99 ± 0.25 μs      | 1.97 ± 0.24 μs      | 1.01 ± 0.18                |
| Baseline/Normal/cdf                                                                             | 1.17 ± 0.22 μs      | 1.17 ± 0.22 μs      | 1 ± 0.27                   |
| Baseline/Normal/logpdf                                                                          | 0.758 ± 0.022 μs    | 0.765 ± 0.028 μs    | 0.99 ± 0.047               |
| Convolved/analytic/cdf batched                                                                  | 2 ± 0.26 μs         | 2.14 ± 0.25 μs      | 0.936 ± 0.16               |
| Convolved/analytic/cdf scalar                                                                   | 16.6 ± 0.46 ns      | 16.5 ± 0.047 ns     | 1 ± 0.028                  |
| Convolved/analytic/construction                                                                 | 2.25 ± 0.27 ns      | 2.54 ± 0.019 ns     | 0.887 ± 0.11               |
| Convolved/analytic/logpdf batched                                                               | 0.767 ± 0.024 μs    | 0.766 ± 0.019 μs    | 1 ± 0.04                   |
| Convolved/analytic/logpdf broadcast                                                             | 1.85 ± 0.28 μs      | 1.78 ± 0.24 μs      | 1.04 ± 0.21                |
| Convolved/analytic/logpdf scalar                                                                | 16 ± 0.044 ns       | 16 ± 0.044 ns       | 0.999 ± 0.0039             |
| Convolved/analytic/mean                                                                         | 2.25 ± 0.007 ns     | 2.25 ± 0.006 ns     | 1 ± 0.0041                 |
| Convolved/analytic/pdf batched                                                                  | 0.78 ± 0.022 μs     | 0.781 ± 0.018 μs    | 0.999 ± 0.037              |
| Convolved/analytic/pdf scalar                                                                   | 16.3 ± 0.066 ns     | 16.3 ± 0.055 ns     | 1 ± 0.0053                 |
| Convolved/analytic/rand                                                                         | 0.98 ± 0.029 μs     | 0.986 ± 0.022 μs    | 0.994 ± 0.036              |
| Convolved/numeric/cdf batched                                                                   | 0.564 ± 0.0063 ms   | 0.564 ± 0.0056 ms   | 0.999 ± 0.015              |
| Convolved/numeric/cdf scalar                                                                    | 12.3 ± 0.065 μs     | 12.3 ± 0.089 μs     | 0.997 ± 0.0089             |
| Convolved/numeric/construction                                                                  | 2.25 ± 0.28 ns      | 2.54 ± 0.019 ns     | 0.888 ± 0.11               |
| Convolved/numeric/logpdf batched                                                                | 0.446 ± 0.011 ms    | 0.444 ± 0.0067 ms   | 1 ± 0.03                   |
| Convolved/numeric/logpdf broadcast                                                              | 0.775 ± 0.013 ms    | 0.773 ± 0.012 ms    | 1 ± 0.023                  |
| Convolved/numeric/logpdf scalar                                                                 | 7.19 ± 0.092 μs     | 7.15 ± 0.037 μs     | 1.01 ± 0.014               |
| Convolved/numeric/mean                                                                          | 4.11 ± 0.11 ns      | 4.2 ± 0.011 ns      | 0.978 ± 0.026              |
| Convolved/numeric/pdf batched                                                                   | 0.444 ± 0.0076 ms   | 0.443 ± 0.0058 ms   | 1 ± 0.022                  |
| Convolved/numeric/pdf scalar                                                                    | 7.18 ± 0.095 μs     | 7.14 ± 0.05 μs      | 1.01 ± 0.015               |
| Convolved/numeric/rand                                                                          | 2.22 ± 0.28 μs      | 2.09 ± 0.28 μs      | 1.06 ± 0.2                 |
| Difference/analytic/cdf broadcast                                                               | 2.82 ± 0.24 μs      | 2.66 ± 0.27 μs      | 1.06 ± 0.14                |
| Difference/analytic/cdf scalar                                                                  | 9.05 ± 0.023 ns     | 9.06 ± 0.024 ns     | 0.999 ± 0.0037             |
| Difference/analytic/construction                                                                | 2.6 ± 0.24 ns       | 2.27 ± 0.27 ns      | 1.14 ± 0.17                |
| Difference/analytic/logpdf broadcast                                                            | 1.26 ± 0.062 μs     | 1.18 ± 0.064 μs     | 1.06 ± 0.078               |
| Difference/analytic/logpdf scalar                                                               | 11.4 ± 0.34 ns      | 11.1 ± 0.025 ns     | 1.03 ± 0.031               |
| Difference/analytic/mean                                                                        | 1.97 ± 0.055 ns     | 1.97 ± 0.004 ns     | 1 ± 0.028                  |
| Difference/analytic/rand                                                                        | 0.978 ± 0.021 μs    | 0.983 ± 0.022 μs    | 0.995 ± 0.031              |
| Difference/numeric/cdf broadcast                                                                | 1.1 ± 0.021 ms      | 1.1 ± 0.013 ms      | 0.999 ± 0.022              |
| Difference/numeric/cdf scalar                                                                   | 15.5 ± 0.14 μs      | 15.5 ± 0.061 μs     | 0.999 ± 0.01               |
| Difference/numeric/construction                                                                 | 2.54 ± 0.024 ns     | 2.25 ± 0.007 ns     | 1.13 ± 0.011               |
| Difference/numeric/logpdf broadcast                                                             | 0.958 ± 0.012 ms    | 0.956 ± 0.0087 ms   | 1 ± 0.016                  |
| Difference/numeric/logpdf scalar                                                                | 9.61 ± 0.28 μs      | 9.57 ± 0.13 μs      | 1 ± 0.032                  |
| Difference/numeric/mean                                                                         | 4.21 ± 0.12 ns      | 4.21 ± 0.015 ns     | 1 ± 0.028                  |
| Difference/numeric/rand                                                                         | 2.18 ± 0.28 μs      | 2.19 ± 0.27 μs      | 0.996 ± 0.18               |
| Product/analytic/cdf broadcast                                                                  | 3.73 ± 0.28 μs      | 3.69 ± 0.27 μs      | 1.01 ± 0.11                |
| Product/analytic/cdf scalar                                                                     | 17.6 ± 0.054 ns     | 17.6 ± 0.047 ns     | 1 ± 0.0041                 |
| Product/analytic/construction                                                                   | 2.25 ± 0.007 ns     | 2.52 ± 0.007 ns     | 0.892 ± 0.0037             |
| Product/analytic/logpdf broadcast                                                               | 1.48 ± 0.22 μs      | 1.45 ± 0.22 μs      | 1.03 ± 0.22                |
| Product/analytic/logpdf scalar                                                                  | 13.6 ± 0.032 ns     | 13.6 ± 0.031 ns     | 1 ± 0.0033                 |
| Product/analytic/mean                                                                           | 7.54 ± 0.56 ns      | 7.83 ± 0.56 ns      | 0.963 ± 0.099              |
| Product/analytic/rand                                                                           | 3.3 ± 0.29 μs       | 3.29 ± 0.29 μs      | 1 ± 0.13                   |
| Product/numeric/cdf broadcast                                                                   | 1.22 ± 0.015 ms     | 1.22 ± 0.015 ms     | 1 ± 0.017                  |
| Product/numeric/cdf scalar                                                                      | 14.7 ± 0.1 μs       | 14.7 ± 0.12 μs      | 0.999 ± 0.011              |
| Product/numeric/construction                                                                    | 2.52 ± 0.013 ns     | 2.25 ± 0.009 ns     | 1.12 ± 0.0073              |
| Product/numeric/logpdf broadcast                                                                | 1.03 ± 0.014 ms     | 1.03 ± 0.013 ms     | 1 ± 0.019                  |
| Product/numeric/logpdf scalar                                                                   | 10.2 ± 0.17 μs      | 10.1 ± 0.077 μs     | 1 ± 0.018                  |
| Product/numeric/mean                                                                            | 4.1 ± 0.011 ns      | 4.21 ± 0.12 ns      | 0.975 ± 0.028              |
| Product/numeric/rand                                                                            | 2.22 ± 0.28 μs      | 2.19 ± 0.28 μs      | 1.01 ± 0.18                |
| Quantile/Convolved analytic/grid                                                                | 0.421 ± 0.054 ms    | 0.421 ± 0.059 ms    | 0.999 ± 0.19               |
| Quantile/Convolved analytic/median                                                              | 16.4 ± 0.71 μs      | 16.3 ± 0.61 μs      | 1.01 ± 0.058               |
| Quantile/Convolved numeric/median                                                               | 0.228 ± 0.0067 ms   | 0.227 ± 0.0066 ms   | 1 ± 0.042                  |
| Quantile/Difference numeric/median                                                              | 0.265 ± 0.007 ms    | 0.264 ± 0.0066 ms   | 1 ± 0.036                  |
| Quantile/Product numeric/median                                                                 | 0.313 ± 0.0092 ms   | 0.313 ± 0.0078 ms   | 1 ± 0.038                  |
| Timeseries/Convolved delay                                                                      | 0.621 ± 0.012 ms    | 0.619 ± 0.0071 ms   | 1 ± 0.023                  |
| Timeseries/Gamma delay                                                                          | 1.27 ± 0.046 μs     | 1.27 ± 0.045 μs     | 0.998 ± 0.051              |
| Timeseries/Poisson delay                                                                        | 1.1 ± 0.18 μs       | 1.06 ± 0.14 μs      | 1.03 ± 0.22                |
| time_to_load                                                                                    | 0.735 ± 0.0012 s    | 0.75 ± 0.0056 s     | 0.979 ± 0.0075             |

|                                                                                                 | v0.2.0                    | a8054b08f54da9...         | v0.2.0 / a8054b08f54da9... |
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

