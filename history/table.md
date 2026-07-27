|                                                                                     | v0.2.0              | 0f9fc102698848...   | v0.2.0 / 0f9fc102698848... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0627 ± 0.0035 ms  | 0.0625 ± 0.0035 ms  | 1 ± 0.08                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.471 ± 0.049 ms    | 0.474 ± 0.045 ms    | 0.994 ± 0.14               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0536 ± 0.00039 ms | 0.0538 ± 0.00037 ms | 0.996 ± 0.01               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.254 ± 0.0069 ms   | 0.254 ± 0.0068 ms   | 1 ± 0.038                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.583 ± 0.027 ms    | 0.613 ± 0.029 ms    | 0.952 ± 0.063              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.17 ± 0.29 ms      | 2.22 ± 0.28 ms      | 0.976 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0868 ± 0.0073 ms  | 0.0864 ± 0.0071 ms  | 1 ± 0.12                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.465 ± 0.047 ms    | 0.469 ± 0.046 ms    | 0.991 ± 0.14               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.066 ± 0.00067 ms  | 0.0659 ± 0.00058 ms | 1 ± 0.013                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.529 ± 0.014 ms    | 0.526 ± 0.014 ms    | 1 ± 0.037                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.58 ± 0.024 ms     | 0.591 ± 0.032 ms    | 0.98 ± 0.067               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.55 ± 0.35 ms      | 2.58 ± 0.33 ms      | 0.987 ± 0.19               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0729 ± 0.00049 ms | 0.0728 ± 0.0005 ms  | 1 ± 0.0096                 |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.122 ± 0.0066 ms   | 0.124 ± 0.007 ms    | 0.991 ± 0.078              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0691 ± 0.00014 ms | 0.0696 ± 0.00015 ms | 0.992 ± 0.0029             |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.291 ± 0.0092 ms   | 0.292 ± 0.0092 ms   | 0.997 ± 0.044              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.551 ± 0.024 ms    | 0.564 ± 0.027 ms    | 0.978 ± 0.064              |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.44 ± 0.3 ms       | 2.48 ± 0.31 ms      | 0.985 ± 0.17               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.29 ± 0.28 μs      | 7.26 ± 0.21 μs      | 1 ± 0.048                  |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.047 ± 0.0055 μs   | 0.047 ± 0.006 μs    | 1 ± 0.17                   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.544 ± 0.039 μs    | 0.545 ± 0.043 μs    | 0.997 ± 0.11               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.07 ± 0.72 μs      | 5.08 ± 0.76 μs      | 0.997 ± 0.21               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.67 ± 0.26 μs      | 4.6 ± 0.29 μs       | 1.02 ± 0.085               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.54 ± 0.092 μs     | 2.48 ± 0.087 μs     | 1.02 ± 0.051               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0918 ± 0.00061 ms | 0.092 ± 0.00064 ms  | 0.998 ± 0.0096             |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.145 ± 0.0077 ms   | 0.146 ± 0.0086 ms   | 0.996 ± 0.079              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0853 ± 0.00019 ms | 0.0857 ± 0.00019 ms | 0.995 ± 0.0031             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.377 ± 0.0094 ms   | 0.377 ± 0.0096 ms   | 1 ± 0.036                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.597 ± 0.024 ms    | 0.614 ± 0.035 ms    | 0.972 ± 0.068              |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.37 ± 0.3 ms       | 2.38 ± 0.31 ms      | 0.993 ± 0.18               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.18 ± 0.07 μs      | 8.17 ± 0.09 μs      | 1 ± 0.014                  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.43 ± 0.09 μs      | 3.35 ± 0.073 μs     | 1.02 ± 0.035               |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.616 ± 0.084 μs    | 0.614 ± 0.084 μs    | 1 ± 0.19                   |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.75 ± 0.39 μs      | 5.75 ± 0.36 μs      | 1 ± 0.092                  |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.8 ± 3 μs         | 28.2 ± 3.3 μs       | 0.986 ± 0.16               |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17 ± 0.41 μs        | 17.3 ± 0.41 μs      | 0.981 ± 0.033              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.12 ± 0.001 ms     | 0.12 ± 0.00097 ms   | 0.995 ± 0.012              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.207 ± 0.012 ms    | 0.206 ± 0.011 ms    | 1.01 ± 0.077               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.117 ± 0.00047 ms  | 0.118 ± 0.00058 ms  | 0.988 ± 0.0063             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.503 ± 0.011 ms    | 0.502 ± 0.011 ms    | 1 ± 0.03                   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.842 ± 0.027 ms    | 0.886 ± 0.035 ms    | 0.951 ± 0.048              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.2 ± 0.52 ms       | 4.28 ± 0.57 ms      | 0.98 ± 0.18                |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.24 ± 0.13 μs      | 7.25 ± 0.15 μs      | 0.999 ± 0.027              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.048 ± 0.006 μs    | 0.048 ± 0.0059 μs   | 1 ± 0.18                   |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.549 ± 0.041 μs    | 0.533 ± 0.04 μs     | 1.03 ± 0.11                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.14 ± 0.72 μs      | 5.07 ± 0.8 μs       | 1.01 ± 0.21                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.54 ± 0.24 μs      | 4.56 ± 0.29 μs      | 0.994 ± 0.083              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.55 ± 0.16 μs      | 2.54 ± 0.1 μs       | 1 ± 0.073                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.145 ± 0.0016 ms   | 0.145 ± 0.0013 ms   | 1 ± 0.014                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.236 ± 0.011 ms    | 0.238 ± 0.011 ms    | 0.994 ± 0.066              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.139 ± 0.00068 ms  | 0.15 ± 0.00056 ms   | 0.927 ± 0.0057             |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.625 ± 0.009 ms    | 0.624 ± 0.0092 ms   | 1 ± 0.021                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.918 ± 0.024 ms    | 0.937 ± 0.039 ms    | 0.979 ± 0.048              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.16 ± 0.55 ms      | 4.21 ± 0.57 ms      | 0.99 ± 0.19                |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.12 ± 0.08 μs      | 8.13 ± 0.09 μs      | 0.998 ± 0.015              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.21 ± 0.094 μs     | 3.2 ± 0.079 μs      | 1 ± 0.038                  |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.583 ± 0.082 μs    | 0.571 ± 0.082 μs    | 1.02 ± 0.21                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.47 ± 0.39 μs      | 5.43 ± 0.41 μs      | 1.01 ± 0.1                 |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 27.8 ± 3 μs         | 28.4 ± 3.2 μs       | 0.979 ± 0.15               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.3 ± 0.52 μs      | 18.3 ± 0.5 μs       | 1 ± 0.04                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.27 ± 0.13 μs      | 7.31 ± 0.17 μs      | 0.995 ± 0.029              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0706 ± 0.0061 μs  | 0.0709 ± 0.0063 μs  | 0.995 ± 0.12               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.613 ± 0.042 μs    | 0.595 ± 0.042 μs    | 1.03 ± 0.1                 |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.33 ± 0.6 μs       | 5.37 ± 0.63 μs      | 0.992 ± 0.16               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.47 ± 0.84 μs      | 6.58 ± 0.74 μs      | 0.984 ± 0.17               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.3 ± 0.36 μs      | 10.1 ± 0.31 μs      | 1.01 ± 0.047               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.001 ms    | 0.123 ± 0.001 ms    | 1.01 ± 0.012               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.21 ± 0.011 ms     | 0.211 ± 0.011 ms    | 0.994 ± 0.074              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.118 ± 0.0004 ms   | 0.118 ± 0.00042 ms  | 0.997 ± 0.0049             |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.532 ± 0.0099 ms   | 0.531 ± 0.011 ms    | 1 ± 0.028                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.872 ± 0.019 ms    | 0.912 ± 0.036 ms    | 0.956 ± 0.044              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.7 ± 0.58 ms       | 4.76 ± 0.58 ms      | 0.988 ± 0.17               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.152 ± 0.0011 ms   | 0.152 ± 0.0014 ms   | 0.999 ± 0.012              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.247 ± 0.013 ms    | 0.248 ± 0.011 ms    | 0.999 ± 0.069              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00059 ms  | 0.143 ± 0.00054 ms  | 1 ± 0.0056                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.651 ± 0.0085 ms   | 0.649 ± 0.0089 ms   | 1 ± 0.019                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.954 ± 0.019 ms    | 0.988 ± 0.038 ms    | 0.966 ± 0.042              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.58 ± 0.57 ms      | 4.64 ± 0.58 ms      | 0.986 ± 0.17               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.15 ± 0.097 μs     | 8.16 ± 0.094 μs     | 0.998 ± 0.017              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.3 ± 0.07 μs       | 3.3 ± 0.087 μs      | 1 ± 0.034                  |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.594 ± 0.082 μs    | 0.573 ± 0.079 μs    | 1.04 ± 0.2                 |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.78 ± 0.33 μs      | 5.75 ± 0.4 μs       | 1.01 ± 0.09                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.6 ± 1.2 μs       | 17.6 ± 1.4 μs       | 1 ± 0.11                   |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 21.8 ± 0.56 μs      | 21.7 ± 0.58 μs      | 1 ± 0.037                  |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.42 ± 0.098 μs     | 7.43 ± 0.1 μs       | 0.998 ± 0.019              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.47 ± 0.068 μs     | 7.48 ± 0.07 μs      | 0.998 ± 0.013              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.943 ± 0.046 μs    | 0.959 ± 0.12 μs     | 0.983 ± 0.13               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.01 ± 0.94 μs      | 6.08 ± 0.92 μs      | 0.987 ± 0.21               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.6 ± 0.91 μs      | 17.9 ± 0.91 μs      | 0.985 ± 0.072              |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 28.8 ± 0.58 μs      | 28.6 ± 0.58 μs      | 1.01 ± 0.029               |
| Baseline/Gamma/cdf                                                                  | 3.54 ± 0.36 μs      | 3.57 ± 0.38 μs      | 0.993 ± 0.15               |
| Baseline/Gamma/logpdf                                                               | 2.88 ± 0.33 μs      | 2.88 ± 0.35 μs      | 1 ± 0.17                   |
| Baseline/Normal/cdf                                                                 | 1.47 ± 0.31 μs      | 1.46 ± 0.32 μs      | 1.01 ± 0.31                |
| Baseline/Normal/logpdf                                                              | 1.05 ± 0.027 μs     | 1.06 ± 0.024 μs     | 0.994 ± 0.034              |
| Convolved/analytic/cdf batched                                                      | 2.66 ± 0.32 μs      | 2.65 ± 0.33 μs      | 1 ± 0.17                   |
| Convolved/analytic/cdf scalar                                                       | 28.3 ± 0.15 ns      | 28.3 ± 0.25 ns      | 1 ± 0.01                   |
| Convolved/analytic/construction                                                     | 3.1 ± 0.01 ns       | 3.41 ± 0.001 ns     | 0.909 ± 0.0029             |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.033 μs     | 1.08 ± 0.029 μs     | 1 ± 0.041                  |
| Convolved/analytic/logpdf broadcast                                                 | 2.57 ± 0.34 μs      | 2.53 ± 0.34 μs      | 1.02 ± 0.19                |
| Convolved/analytic/logpdf scalar                                                    | 28.1 ± 0.1 ns       | 27.8 ± 0.17 ns      | 1.01 ± 0.0072              |
| Convolved/analytic/mean                                                             | 3.1 ± 0.01 ns       | 2.79 ± 0.01 ns      | 1.11 ± 0.0053              |
| Convolved/analytic/pdf batched                                                      | 1.12 ± 0.034 μs     | 1.12 ± 0.03 μs      | 1 ± 0.04                   |
| Convolved/analytic/pdf scalar                                                       | 29.8 ± 0.18 ns      | 29.9 ± 0.14 ns      | 0.998 ± 0.0077             |
| Convolved/analytic/rand                                                             | 1.14 ± 0.034 μs     | 1.12 ± 0.029 μs     | 1.02 ± 0.04                |
| Convolved/numeric/cdf batched                                                       | 0.833 ± 0.0023 ms   | 0.853 ± 0.0018 ms   | 0.976 ± 0.0034             |
| Convolved/numeric/cdf scalar                                                        | 15.7 ± 0.07 μs      | 15.6 ± 0.06 μs      | 1.01 ± 0.0059              |
| Convolved/numeric/construction                                                      | 4.33 ± 0.01 ns      | 3.41 ± 0.001 ns     | 1.27 ± 0.003               |
| Convolved/numeric/logpdf batched                                                    | 0.743 ± 0.005 ms    | 0.733 ± 0.0068 ms   | 1.01 ± 0.012               |
| Convolved/numeric/logpdf broadcast                                                  | 1.34 ± 0.0092 ms    | 1.35 ± 0.009 ms     | 0.997 ± 0.0095             |
| Convolved/numeric/logpdf scalar                                                     | 12.5 ± 0.03 μs      | 12.6 ± 0.04 μs      | 0.998 ± 0.004              |
| Convolved/numeric/mean                                                              | 6.61 ± 0.031 ns     | 6.61 ± 0.03 ns      | 1 ± 0.0065                 |
| Convolved/numeric/pdf batched                                                       | 0.742 ± 0.0051 ms   | 0.733 ± 0.0067 ms   | 1.01 ± 0.012               |
| Convolved/numeric/pdf scalar                                                        | 12.5 ± 0.03 μs      | 12.5 ± 0.04 μs      | 0.997 ± 0.004              |
| Convolved/numeric/rand                                                              | 2.8 ± 0.35 μs       | 2.79 ± 0.35 μs      | 1 ± 0.18                   |
| Difference/analytic/cdf broadcast                                                   | 3.37 ± 0.34 μs      | 3.36 ± 0.35 μs      | 1 ± 0.15                   |
| Difference/analytic/cdf scalar                                                      | 10.8 ± 0.03 ns      | 10.8 ± 0.02 ns      | 1 ± 0.0033                 |
| Difference/analytic/construction                                                    | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 0.912 ± 0.004              |
| Difference/analytic/logpdf broadcast                                                | 1.51 ± 0.31 μs      | 1.51 ± 0.32 μs      | 1 ± 0.29                   |
| Difference/analytic/logpdf scalar                                                   | 17.1 ± 0.09 ns      | 16.8 ± 0.3 ns       | 1.02 ± 0.019               |
| Difference/analytic/mean                                                            | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Difference/analytic/rand                                                            | 1.12 ± 0.033 μs     | 1.13 ± 0.037 μs     | 0.993 ± 0.044              |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.017 ms     | 1.35 ± 0.017 ms     | 1 ± 0.018                  |
| Difference/numeric/cdf scalar                                                       | 19.4 ± 0.091 μs     | 19.4 ± 0.082 μs     | 1 ± 0.0063                 |
| Difference/numeric/construction                                                     | 4.34 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.4 ± 0.0055               |
| Difference/numeric/logpdf broadcast                                                 | 1.65 ± 0.017 ms     | 1.65 ± 0.015 ms     | 1 ± 0.014                  |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.071 μs     | 16.8 ± 0.071 μs     | 1 ± 0.006                  |
| Difference/numeric/mean                                                             | 6.65 ± 0.01 ns      | 6.54 ± 0.03 ns      | 1.02 ± 0.0049              |
| Difference/numeric/rand                                                             | 2.81 ± 0.35 μs      | 2.79 ± 0.36 μs      | 1 ± 0.18                   |
| Product/analytic/cdf broadcast                                                      | 4.9 ± 0.21 μs       | 4.92 ± 0.21 μs      | 0.996 ± 0.06               |
| Product/analytic/cdf scalar                                                         | 29.7 ± 0.1 ns       | 29.7 ± 0.06 ns      | 1 ± 0.004                  |
| Product/analytic/construction                                                       | 3.11 ± 0.01 ns      | 4.02 ± 0.91 ns      | 0.773 ± 0.18               |
| Product/analytic/logpdf broadcast                                                   | 2.18 ± 0.34 μs      | 2.16 ± 0.34 μs      | 1.01 ± 0.23                |
| Product/analytic/logpdf scalar                                                      | 24 ± 0.13 ns        | 24 ± 0.1 ns         | 0.998 ± 0.0069             |
| Product/analytic/mean                                                               | 10.8 ± 0.04 ns      | 10.8 ± 0.031 ns     | 1 ± 0.0047                 |
| Product/analytic/rand                                                               | 1.78 ± 0.33 μs      | 1.77 ± 0.32 μs      | 1.01 ± 0.26                |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.016 ms     | 1.98 ± 0.016 ms     | 0.999 ± 0.011              |
| Product/numeric/cdf scalar                                                          | 24.8 ± 0.12 μs      | 23.1 ± 0.09 μs      | 1.07 ± 0.0066              |
| Product/numeric/construction                                                        | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1 ± 0.0046                 |
| Product/numeric/logpdf broadcast                                                    | 1.77 ± 0.015 ms     | 1.78 ± 0.016 ms     | 0.994 ± 0.012              |
| Product/numeric/logpdf scalar                                                       | 17.5 ± 0.07 μs      | 17.6 ± 0.08 μs      | 0.995 ± 0.006              |
| Product/numeric/mean                                                                | 6.75 ± 0.04 ns      | 6.72 ± 0.031 ns     | 1 ± 0.0075                 |
| Product/numeric/rand                                                                | 2.81 ± 0.35 μs      | 2.81 ± 0.36 μs      | 1 ± 0.18                   |
| Quantile/Convolved analytic/grid                                                    | 0.602 ± 0.1 ms      | 0.615 ± 0.11 ms     | 0.978 ± 0.24               |
| Quantile/Convolved analytic/median                                                  | 22.5 ± 0.8 μs       | 23.1 ± 0.75 μs      | 0.975 ± 0.047              |
| Quantile/Convolved numeric/median                                                   | 0.292 ± 0.011 ms    | 0.291 ± 0.012 ms    | 1.01 ± 0.056               |
| Quantile/Difference numeric/median                                                  | 0.339 ± 0.01 ms     | 0.34 ± 0.011 ms     | 0.999 ± 0.044              |
| Quantile/Product numeric/median                                                     | 0.497 ± 0.012 ms    | 0.5 ± 0.012 ms      | 0.993 ± 0.033              |
| Timeseries/Convolved delay                                                          | 0.358 ± 0.0098 μs   | 0.36 ± 0.0093 μs    | 0.994 ± 0.037              |
| Timeseries/Gamma delay                                                              | 0.358 ± 0.011 μs    | 0.361 ± 0.012 μs    | 0.992 ± 0.045              |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.023 μs     | 1.27 ± 0.025 μs     | 0.995 ± 0.027              |
| time_to_load                                                                        | 0.885 ± 0.0033 s    | 0.883 ± 0.034 s     | 1 ± 0.038                  |

|                                                                                     | v0.2.0                    | 0f9fc102698848...         | v0.2.0 / 0f9fc102698848... |
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

