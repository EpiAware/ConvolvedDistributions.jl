|                                                                                     | v0.2.0              | d2738bf9448a76...   | v0.2.0 / d2738bf9448a76... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0754 ± 0.0036 ms  | 0.0627 ± 0.0035 ms  | 1.2 ± 0.088                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.477 ± 0.045 ms    | 0.467 ± 0.049 ms    | 1.02 ± 0.14                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0538 ± 0.00042 ms | 0.0542 ± 0.00038 ms | 0.993 ± 0.01               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.254 ± 0.0079 ms   | 0.254 ± 0.0066 ms   | 0.999 ± 0.04               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.591 ± 0.029 ms    | 0.582 ± 0.025 ms    | 1.02 ± 0.066               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.25 ± 0.29 ms      | 2.26 ± 0.28 ms      | 0.993 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.087 ± 0.0072 ms   | 0.0863 ± 0.0068 ms  | 1.01 ± 0.12                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.467 ± 0.045 ms    | 0.473 ± 0.046 ms    | 0.987 ± 0.13               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0658 ± 0.0008 ms  | 0.0664 ± 0.00073 ms | 0.99 ± 0.016               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.522 ± 0.014 ms    | 0.531 ± 0.014 ms    | 0.983 ± 0.038              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.586 ± 0.026 ms    | 0.58 ± 0.026 ms     | 1.01 ± 0.064               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.59 ± 0.34 ms      | 2.62 ± 0.33 ms      | 0.987 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0738 ± 0.00049 ms | 0.0731 ± 0.00053 ms | 1.01 ± 0.0099              |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.124 ± 0.007 ms    | 0.126 ± 0.0072 ms   | 0.981 ± 0.079              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0693 ± 0.00014 ms | 0.0697 ± 0.00016 ms | 0.995 ± 0.003              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.291 ± 0.0092 ms   | 0.292 ± 0.0092 ms   | 0.998 ± 0.044              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.558 ± 0.027 ms    | 0.562 ± 0.031 ms    | 0.993 ± 0.073              |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.5 ± 0.31 ms       | 2.56 ± 0.32 ms      | 0.978 ± 0.17               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.27 ± 0.12 μs      | 7.23 ± 0.1 μs       | 1.01 ± 0.021               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0477 ± 0.011 μs   | 0.0473 ± 0.011 μs   | 1.01 ± 0.33                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.539 ± 0.047 μs    | 0.548 ± 0.041 μs    | 0.984 ± 0.11               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.06 ± 0.71 μs      | 5.14 ± 0.71 μs      | 0.984 ± 0.19               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.56 ± 0.25 μs      | 4.62 ± 0.24 μs      | 0.989 ± 0.074              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.57 ± 0.13 μs      | 2.57 ± 0.15 μs      | 0.999 ± 0.078              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0945 ± 0.00077 ms | 0.0936 ± 0.00077 ms | 1.01 ± 0.012               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.146 ± 0.0069 ms   | 0.147 ± 0.0072 ms   | 0.994 ± 0.068              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0858 ± 0.00024 ms | 0.0855 ± 0.0002 ms  | 1 ± 0.0037                 |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.377 ± 0.0095 ms   | 0.377 ± 0.0095 ms   | 1 ± 0.036                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.604 ± 0.027 ms    | 0.606 ± 0.032 ms    | 0.998 ± 0.069              |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.4 ± 0.31 ms       | 2.46 ± 0.31 ms      | 0.976 ± 0.17               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.16 ± 0.08 μs      | 8.15 ± 0.066 μs     | 1 ± 0.013                  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.39 ± 0.1 μs       | 3.38 ± 0.046 μs     | 1 ± 0.033                  |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.612 ± 0.083 μs    | 0.608 ± 0.078 μs    | 1.01 ± 0.19                |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.73 ± 0.43 μs      | 5.64 ± 0.33 μs      | 1.02 ± 0.097               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.8 ± 3 μs         | 27.4 ± 2.9 μs       | 1.02 ± 0.15                |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.3 ± 0.48 μs      | 17.3 ± 0.42 μs      | 1 ± 0.037                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.0011 ms   | 0.119 ± 0.001 ms    | 0.996 ± 0.013              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.208 ± 0.011 ms    | 0.207 ± 0.011 ms    | 1 ± 0.076                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.118 ± 0.00043 ms  | 0.117 ± 0.00041 ms  | 1 ± 0.0051                 |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.505 ± 0.01 ms     | 0.503 ± 0.01 ms     | 1 ± 0.029                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.845 ± 0.031 ms    | 0.849 ± 0.032 ms    | 0.995 ± 0.052              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.32 ± 0.59 ms      | 4.34 ± 0.54 ms      | 0.994 ± 0.18               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.3 ± 0.24 μs       | 7.33 ± 0.28 μs      | 0.997 ± 0.05               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0474 ± 0.021 μs   | 0.0477 ± 0.012 μs   | 0.994 ± 0.5                |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.559 ± 0.041 μs    | 0.539 ± 0.04 μs     | 1.04 ± 0.11                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.09 ± 0.71 μs      | 5.24 ± 0.69 μs      | 0.972 ± 0.19               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.63 ± 0.31 μs      | 4.77 ± 0.33 μs      | 0.972 ± 0.093              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.55 ± 0.071 μs     | 2.58 ± 0.078 μs     | 0.991 ± 0.041              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.144 ± 0.0015 ms   | 0.144 ± 0.0013 ms   | 1 ± 0.014                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.239 ± 0.012 ms    | 0.24 ± 0.011 ms     | 0.996 ± 0.067              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.139 ± 0.00063 ms  | 0.139 ± 0.0006 ms   | 1 ± 0.0063                 |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.625 ± 0.0096 ms   | 0.622 ± 0.0092 ms   | 1.01 ± 0.021               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.914 ± 0.027 ms    | 0.913 ± 0.022 ms    | 1 ± 0.039                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.28 ± 0.6 ms       | 4.27 ± 0.53 ms      | 1 ± 0.19                   |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.1 ± 0.09 μs       | 8.12 ± 0.084 μs     | 0.997 ± 0.015              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.19 ± 0.1 μs       | 3.19 ± 0.093 μs     | 1 ± 0.043                  |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.583 ± 0.083 μs    | 0.573 ± 0.082 μs    | 1.02 ± 0.21                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.51 ± 0.4 μs       | 5.45 ± 0.46 μs      | 1.01 ± 0.11                |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 27.9 ± 3.2 μs       | 27.9 ± 3.3 μs       | 1 ± 0.17                   |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.4 ± 0.58 μs      | 18.7 ± 0.53 μs      | 0.987 ± 0.042              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.34 ± 0.27 μs      | 7.33 ± 0.29 μs      | 1 ± 0.054                  |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0703 ± 0.013 μs   | 0.0712 ± 0.014 μs   | 0.988 ± 0.27               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.611 ± 0.041 μs    | 0.608 ± 0.043 μs    | 1 ± 0.098                  |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.36 ± 0.55 μs      | 5.34 ± 0.54 μs      | 1 ± 0.14                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.86 ± 0.68 μs      | 6.8 ± 0.72 μs       | 1.01 ± 0.15                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.3 ± 0.34 μs      | 10.4 ± 0.4 μs       | 0.99 ± 0.05                |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.124 ± 0.0011 ms   | 0.123 ± 0.001 ms    | 1.01 ± 0.013               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.212 ± 0.011 ms    | 0.212 ± 0.011 ms    | 0.997 ± 0.075              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.118 ± 0.0005 ms   | 0.119 ± 0.00053 ms  | 0.999 ± 0.0062             |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.532 ± 0.011 ms    | 0.533 ± 0.011 ms    | 0.998 ± 0.029              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.877 ± 0.031 ms    | 0.879 ± 0.029 ms    | 0.998 ± 0.049              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.87 ± 0.57 ms      | 4.87 ± 0.56 ms      | 1 ± 0.16                   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.149 ± 0.0013 ms   | 0.15 ± 0.0014 ms    | 0.999 ± 0.013              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.247 ± 0.012 ms    | 0.247 ± 0.012 ms    | 1 ± 0.067                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00069 ms  | 0.143 ± 0.00062 ms  | 1 ± 0.0065                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.651 ± 0.0092 ms   | 0.65 ± 0.0087 ms    | 1 ± 0.019                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.955 ± 0.027 ms    | 0.956 ± 0.032 ms    | 0.998 ± 0.044              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.67 ± 0.58 ms      | 4.72 ± 0.58 ms      | 0.99 ± 0.17                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.13 ± 0.087 μs     | 8.25 ± 0.09 μs      | 0.985 ± 0.015              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.33 ± 0.12 μs      | 3.32 ± 0.12 μs      | 1 ± 0.051                  |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.575 ± 0.082 μs    | 0.581 ± 0.081 μs    | 0.989 ± 0.2                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.73 ± 0.4 μs       | 5.72 ± 0.43 μs      | 1 ± 0.1                    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.7 ± 1.6 μs       | 18.2 ± 1.6 μs       | 0.972 ± 0.12               |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22.3 ± 0.62 μs      | 22.5 ± 0.61 μs      | 0.992 ± 0.039              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.43 ± 0.12 μs      | 7.44 ± 0.11 μs      | 0.999 ± 0.022              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.16 ± 0.083 μs     | 7.52 ± 0.08 μs      | 0.952 ± 0.015              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.944 ± 0.047 μs    | 0.932 ± 0.11 μs     | 1.01 ± 0.13                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.09 ± 0.92 μs      | 6.14 ± 1 μs         | 0.992 ± 0.22               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.5 ± 0.98 μs      | 18 ± 0.96 μs        | 0.974 ± 0.075              |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 29 ± 0.66 μs        | 29.4 ± 0.66 μs      | 0.989 ± 0.032              |
| Baseline/Gamma/cdf                                                                  | 3.6 ± 0.38 μs       | 3.56 ± 0.37 μs      | 1.01 ± 0.15                |
| Baseline/Gamma/logpdf                                                               | 2.89 ± 0.33 μs      | 2.89 ± 0.33 μs      | 1 ± 0.16                   |
| Baseline/Normal/cdf                                                                 | 1.46 ± 0.31 μs      | 1.48 ± 0.31 μs      | 0.99 ± 0.29                |
| Baseline/Normal/logpdf                                                              | 1.05 ± 0.026 μs     | 1.05 ± 0.025 μs     | 1.01 ± 0.035               |
| Convolved/analytic/cdf batched                                                      | 2.67 ± 0.33 μs      | 2.65 ± 0.33 μs      | 1.01 ± 0.18                |
| Convolved/analytic/cdf scalar                                                       | 28.3 ± 0.14 ns      | 28.2 ± 0.14 ns      | 1 ± 0.0071                 |
| Convolved/analytic/construction                                                     | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.026 μs     | 1.08 ± 0.022 μs     | 1 ± 0.032                  |
| Convolved/analytic/logpdf broadcast                                                 | 2.57 ± 0.32 μs      | 2.53 ± 0.34 μs      | 1.01 ± 0.19                |
| Convolved/analytic/logpdf scalar                                                    | 27.7 ± 0.1 ns       | 0.0326 ± 0.0001 μs  | 0.851 ± 0.0041             |
| Convolved/analytic/mean                                                             | 3.1 ± 0.01 ns       | 3.41 ± 0.01 ns      | 0.911 ± 0.004              |
| Convolved/analytic/pdf batched                                                      | 1.12 ± 0.036 μs     | 1.11 ± 0.031 μs     | 1 ± 0.043                  |
| Convolved/analytic/pdf scalar                                                       | 29.8 ± 0.079 ns     | 0.0421 ± 7.1e-05 μs | 0.709 ± 0.0022             |
| Convolved/analytic/rand                                                             | 1.12 ± 0.034 μs     | 1.14 ± 0.063 μs     | 0.986 ± 0.062              |
| Convolved/numeric/cdf batched                                                       | 0.832 ± 0.0041 ms   | 0.833 ± 0.0028 ms   | 0.999 ± 0.0059             |
| Convolved/numeric/cdf scalar                                                        | 15.6 ± 0.061 μs     | 15.7 ± 0.07 μs      | 0.998 ± 0.0059             |
| Convolved/numeric/construction                                                      | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/numeric/logpdf batched                                                    | 0.733 ± 0.0058 ms   | 0.733 ± 0.0059 ms   | 1 ± 0.011                  |
| Convolved/numeric/logpdf broadcast                                                  | 1.35 ± 0.009 ms     | 1.35 ± 0.0098 ms    | 0.998 ± 0.0098             |
| Convolved/numeric/logpdf scalar                                                     | 12.6 ± 0.04 μs      | 12.5 ± 0.041 μs     | 1 ± 0.0046                 |
| Convolved/numeric/mean                                                              | 6.66 ± 0.03 ns      | 6.66 ± 0.011 ns     | 1 ± 0.0048                 |
| Convolved/numeric/pdf batched                                                       | 0.733 ± 0.0055 ms   | 0.734 ± 0.0058 ms   | 0.999 ± 0.011              |
| Convolved/numeric/pdf scalar                                                        | 12.5 ± 0.04 μs      | 12.5 ± 0.041 μs     | 1 ± 0.0046                 |
| Convolved/numeric/rand                                                              | 2.79 ± 0.35 μs      | 2.79 ± 0.36 μs      | 0.999 ± 0.18               |
| Difference/analytic/cdf broadcast                                                   | 3.38 ± 0.34 μs      | 3.39 ± 0.35 μs      | 0.997 ± 0.14               |
| Difference/analytic/cdf scalar                                                      | 10.8 ± 0.011 ns     | 10.8 ± 0.01 ns      | 1 ± 0.0014                 |
| Difference/analytic/construction                                                    | 4.64 ± 0.87 ns      | 3.72 ± 0.01 ns      | 1.25 ± 0.23                |
| Difference/analytic/logpdf broadcast                                                | 1.52 ± 0.32 μs      | 1.51 ± 0.31 μs      | 1.01 ± 0.3                 |
| Difference/analytic/logpdf scalar                                                   | 16.7 ± 0.08 ns      | 17 ± 0.11 ns        | 0.985 ± 0.0079             |
| Difference/analytic/mean                                                            | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Difference/analytic/rand                                                            | 1.13 ± 0.033 μs     | 1.13 ± 0.037 μs     | 1 ± 0.044                  |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 1 ± 0.019                  |
| Difference/numeric/cdf scalar                                                       | 19.5 ± 0.091 μs     | 19.4 ± 0.09 μs      | 1 ± 0.0066                 |
| Difference/numeric/construction                                                     | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1 ± 0.0046                 |
| Difference/numeric/logpdf broadcast                                                 | 1.66 ± 0.016 ms     | 1.65 ± 0.015 ms     | 1 ± 0.013                  |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.071 μs     | 16.7 ± 0.1 μs       | 1.01 ± 0.0074              |
| Difference/numeric/mean                                                             | 6.58 ± 0.039 ns     | 6.54 ± 0.03 ns      | 1.01 ± 0.0075              |
| Difference/numeric/rand                                                             | 2.79 ± 0.36 μs      | 2.8 ± 0.35 μs       | 0.995 ± 0.18               |
| Product/analytic/cdf broadcast                                                      | 4.91 ± 0.047 μs     | 4.92 ± 0.19 μs      | 0.998 ± 0.04               |
| Product/analytic/cdf scalar                                                         | 29.7 ± 0.59 ns      | 29.8 ± 0.5 ns       | 0.997 ± 0.026              |
| Product/analytic/construction                                                       | 3.42 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Product/analytic/logpdf broadcast                                                   | 2.17 ± 0.35 μs      | 2.17 ± 0.32 μs      | 1 ± 0.22                   |
| Product/analytic/logpdf scalar                                                      | 23.9 ± 0.11 ns      | 29.3 ± 0.07 ns      | 0.815 ± 0.0042             |
| Product/analytic/mean                                                               | 10.9 ± 0.051 ns     | 10.9 ± 0.04 ns      | 1 ± 0.006                  |
| Product/analytic/rand                                                               | 1.79 ± 0.33 μs      | 1.79 ± 0.3 μs       | 1 ± 0.25                   |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.017 ms     | 1.97 ± 0.014 ms     | 1 ± 0.011                  |
| Product/numeric/cdf scalar                                                          | 23.2 ± 0.12 μs      | 23.1 ± 0.1 μs       | 1 ± 0.0068                 |
| Product/numeric/construction                                                        | 3.72 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.2 ± 0.005                |
| Product/numeric/logpdf broadcast                                                    | 1.78 ± 0.015 ms     | 1.78 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                       | 17.6 ± 0.071 μs     | 17.6 ± 0.08 μs      | 0.999 ± 0.0061             |
| Product/numeric/mean                                                                | 6.73 ± 0.051 ns     | 6.71 ± 0.049 ns     | 1 ± 0.011                  |
| Product/numeric/rand                                                                | 2.8 ± 0.36 μs       | 2.8 ± 0.34 μs       | 1 ± 0.18                   |
| Quantile/Convolved analytic/grid                                                    | 0.612 ± 0.1 ms      | 0.597 ± 0.095 ms    | 1.03 ± 0.23                |
| Quantile/Convolved analytic/median                                                  | 23 ± 0.82 μs        | 22.8 ± 0.77 μs      | 1.01 ± 0.05                |
| Quantile/Convolved numeric/median                                                   | 0.291 ± 0.011 ms    | 0.291 ± 0.011 ms    | 1 ± 0.055                  |
| Quantile/Difference numeric/median                                                  | 0.34 ± 0.01 ms      | 0.339 ± 0.011 ms    | 1 ± 0.044                  |
| Quantile/Product numeric/median                                                     | 0.498 ± 0.013 ms    | 0.496 ± 0.012 ms    | 1 ± 0.035                  |
| Timeseries/Convolved delay                                                          | 0.357 ± 0.0093 μs   | 0.359 ± 0.0084 μs   | 0.996 ± 0.035              |
| Timeseries/Gamma delay                                                              | 0.355 ± 0.017 μs    | 0.358 ± 0.011 μs    | 0.993 ± 0.057              |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.031 μs     | 1.27 ± 0.025 μs     | 0.997 ± 0.031              |
| time_to_load                                                                        | 0.887 ± 0.014 s     | 0.937 ± 0.013 s     | 0.946 ± 0.019              |

|                                                                                     | v0.2.0                    | d2738bf9448a76...         | v0.2.0 / d2738bf9448a76... |
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

