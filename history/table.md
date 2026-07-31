|                                                                                     | v0.2.0              | fd7619e7352292...   | v0.2.0 / fd7619e7352292... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0627 ± 0.0036 ms  | 0.0631 ± 0.0034 ms  | 0.993 ± 0.078              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.471 ± 0.045 ms    | 0.47 ± 0.047 ms     | 1 ± 0.14                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0527 ± 0.00043 ms | 0.053 ± 0.00043 ms  | 0.995 ± 0.011              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.254 ± 0.0073 ms   | 0.253 ± 0.0069 ms   | 1 ± 0.04                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.605 ± 0.03 ms     | 0.579 ± 0.029 ms    | 1.05 ± 0.073               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.26 ± 0.27 ms      | 2.22 ± 0.28 ms      | 1.02 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0864 ± 0.0064 ms  | 0.087 ± 0.0073 ms   | 0.993 ± 0.11               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.47 ± 0.046 ms     | 0.47 ± 0.045 ms     | 1 ± 0.14                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0663 ± 0.00075 ms | 0.0697 ± 0.00071 ms | 0.951 ± 0.015              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.523 ± 0.014 ms    | 0.521 ± 0.013 ms    | 1 ± 0.037                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.599 ± 0.03 ms     | 0.578 ± 0.027 ms    | 1.04 ± 0.071               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.57 ± 0.33 ms      | 2.61 ± 0.32 ms      | 0.988 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0727 ± 0.00042 ms | 0.0729 ± 0.00048 ms | 0.997 ± 0.0088             |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.124 ± 0.0067 ms   | 0.123 ± 0.007 ms    | 1.01 ± 0.079               |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.068 ± 0.00017 ms  | 0.0684 ± 0.00016 ms | 0.994 ± 0.0034             |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.291 ± 0.0089 ms   | 0.292 ± 0.009 ms    | 0.998 ± 0.043              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.571 ± 0.035 ms    | 0.568 ± 0.032 ms    | 1 ± 0.084                  |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.51 ± 0.31 ms      | 2.45 ± 0.3 ms       | 1.02 ± 0.18                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.22 ± 0.09 μs      | 7.22 ± 0.21 μs      | 1 ± 0.031                  |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0474 ± 0.016 μs   | 0.0467 ± 0.0059 μs  | 1.01 ± 0.36                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.524 ± 0.046 μs    | 0.535 ± 0.04 μs     | 0.979 ± 0.11               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.06 ± 0.77 μs      | 5.12 ± 0.72 μs      | 0.988 ± 0.21               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.42 ± 0.19 μs      | 4.49 ± 0.27 μs      | 0.985 ± 0.074              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.68 ± 0.17 μs      | 2.57 ± 0.081 μs     | 1.04 ± 0.072               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0932 ± 0.00059 ms | 0.0935 ± 0.00074 ms | 0.997 ± 0.01               |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.146 ± 0.0072 ms   | 0.146 ± 0.0082 ms   | 1 ± 0.074                  |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0842 ± 0.00021 ms | 0.0843 ± 0.00021 ms | 0.998 ± 0.0035             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.377 ± 0.0091 ms   | 0.376 ± 0.0093 ms   | 1 ± 0.035                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.606 ± 0.028 ms    | 0.603 ± 0.034 ms    | 1.01 ± 0.073               |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.4 ± 0.29 ms       | 2.36 ± 0.3 ms       | 1.02 ± 0.18                |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.13 ± 0.077 μs     | 8.14 ± 0.067 μs     | 0.998 ± 0.012              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.39 ± 0.1 μs       | 3.36 ± 0.071 μs     | 1.01 ± 0.038               |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.604 ± 0.082 μs    | 0.611 ± 0.083 μs    | 0.988 ± 0.19               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.83 ± 0.47 μs      | 5.68 ± 0.36 μs      | 1.03 ± 0.1                 |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.6 ± 3.3 μs       | 27.5 ± 2.9 μs       | 1 ± 0.16                   |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.6 ± 0.57 μs      | 16.8 ± 0.41 μs      | 1.05 ± 0.043               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.00097 ms  | 0.12 ± 0.00096 ms   | 0.992 ± 0.011              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.208 ± 0.011 ms    | 0.209 ± 0.01 ms     | 0.999 ± 0.071              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.118 ± 0.00056 ms  | 0.118 ± 0.00046 ms  | 0.998 ± 0.0062             |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.503 ± 0.01 ms     | 0.504 ± 0.01 ms     | 0.998 ± 0.029              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.859 ± 0.031 ms    | 0.842 ± 0.033 ms    | 1.02 ± 0.055               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.29 ± 0.51 ms      | 4.23 ± 0.52 ms      | 1.01 ± 0.17                |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.2 ± 0.088 μs      | 7.24 ± 0.18 μs      | 0.995 ± 0.027              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0474 ± 0.014 μs   | 0.0477 ± 0.0058 μs  | 0.995 ± 0.32               |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.521 ± 0.045 μs    | 0.53 ± 0.039 μs     | 0.984 ± 0.11               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.09 ± 0.77 μs      | 5.16 ± 0.8 μs       | 0.987 ± 0.21               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.42 ± 0.19 μs      | 4.64 ± 0.28 μs      | 0.953 ± 0.072              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.66 ± 0.16 μs      | 2.58 ± 0.1 μs       | 1.03 ± 0.075               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.145 ± 0.0013 ms   | 0.145 ± 0.0014 ms   | 1 ± 0.013                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.239 ± 0.012 ms    | 0.24 ± 0.011 ms     | 0.994 ± 0.069              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.14 ± 0.00085 ms   | 0.139 ± 0.00066 ms  | 1.01 ± 0.0077              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.626 ± 0.0099 ms   | 0.624 ± 0.0094 ms   | 1 ± 0.022                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.921 ± 0.031 ms    | 0.9 ± 0.022 ms      | 1.02 ± 0.043               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.27 ± 0.54 ms      | 4.17 ± 0.55 ms      | 1.02 ± 0.19                |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.1 ± 0.083 μs      | 8.09 ± 0.087 μs     | 1 ± 0.015                  |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.2 ± 0.056 μs      | 3.21 ± 0.15 μs      | 0.996 ± 0.049              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.573 ± 0.084 μs    | 0.56 ± 0.083 μs     | 1.02 ± 0.21                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.52 ± 0.38 μs      | 5.48 ± 0.49 μs      | 1.01 ± 0.11                |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 26.8 ± 3.1 μs       | 27.8 ± 3.1 μs       | 0.963 ± 0.16               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.3 ± 0.58 μs      | 18.1 ± 0.49 μs      | 1.01 ± 0.042               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.26 ± 0.098 μs     | 7.28 ± 0.19 μs      | 0.997 ± 0.03               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0705 ± 0.015 μs   | 0.0717 ± 0.0061 μs  | 0.983 ± 0.23               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.621 ± 0.043 μs    | 0.603 ± 0.042 μs    | 1.03 ± 0.1                 |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.27 ± 0.59 μs      | 5.31 ± 0.58 μs      | 0.993 ± 0.16               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.42 ± 0.71 μs      | 6.48 ± 0.78 μs      | 0.99 ± 0.16                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.6 ± 0.42 μs      | 10.4 ± 0.31 μs      | 1.01 ± 0.05                |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.001 ms    | 0.123 ± 0.00096 ms  | 0.996 ± 0.011              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.212 ± 0.011 ms    | 0.211 ± 0.011 ms    | 1 ± 0.074                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.119 ± 0.00046 ms  | 0.119 ± 0.00046 ms  | 1 ± 0.0055                 |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.53 ± 0.01 ms      | 0.53 ± 0.01 ms      | 1 ± 0.027                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.891 ± 0.029 ms    | 0.879 ± 0.031 ms    | 1.01 ± 0.049               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.81 ± 0.56 ms      | 4.8 ± 0.58 ms       | 1 ± 0.17                   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.151 ± 0.0013 ms   | 0.149 ± 0.0013 ms   | 1.01 ± 0.012               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.248 ± 0.012 ms    | 0.247 ± 0.011 ms    | 1 ± 0.067                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00057 ms  | 0.143 ± 0.00056 ms  | 1 ± 0.0056                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.65 ± 0.0084 ms    | 0.649 ± 0.0085 ms   | 1 ± 0.018                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.965 ± 0.028 ms    | 0.95 ± 0.02 ms      | 1.02 ± 0.037               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.7 ± 0.56 ms       | 4.66 ± 0.55 ms      | 1.01 ± 0.17                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.15 ± 0.077 μs     | 8.13 ± 0.09 μs      | 1 ± 0.015                  |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.32 ± 0.052 μs     | 3.3 ± 0.083 μs      | 1.01 ± 0.03                |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.582 ± 0.083 μs    | 0.574 ± 0.083 μs    | 1.01 ± 0.21                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.77 ± 0.39 μs      | 5.74 ± 0.4 μs       | 1.01 ± 0.098               |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.1 ± 0.73 μs      | 18.2 ± 1.4 μs       | 0.943 ± 0.084              |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22.1 ± 0.61 μs      | 21.6 ± 0.54 μs      | 1.02 ± 0.038               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.43 ± 0.083 μs     | 7.45 ± 0.1 μs       | 0.997 ± 0.018              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.6 ± 0.055 μs      | 7.58 ± 0.068 μs     | 1 ± 0.012                  |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.937 ± 0.12 μs     | 0.954 ± 0.086 μs    | 0.982 ± 0.15               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.17 ± 0.35 μs      | 6.25 ± 1.1 μs       | 0.987 ± 0.18               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.5 ± 0.94 μs      | 17.7 ± 0.94 μs      | 0.993 ± 0.075              |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 28.8 ± 0.62 μs      | 28.8 ± 0.56 μs      | 0.999 ± 0.029              |
| Baseline/Gamma/cdf                                                                  | 3.57 ± 0.37 μs      | 3.53 ± 0.016 μs     | 1.01 ± 0.1                 |
| Baseline/Gamma/logpdf                                                               | 2.89 ± 0.33 μs      | 2.85 ± 0.016 μs     | 1.01 ± 0.12                |
| Baseline/Normal/cdf                                                                 | 1.46 ± 0.34 μs      | 1.45 ± 0.31 μs      | 1.01 ± 0.32                |
| Baseline/Normal/logpdf                                                              | 1.06 ± 0.025 μs     | 1.06 ± 0.024 μs     | 0.999 ± 0.032              |
| Convolved/analytic/cdf batched                                                      | 2.67 ± 0.34 μs      | 2.66 ± 0.34 μs      | 1.01 ± 0.18                |
| Convolved/analytic/cdf scalar                                                       | 28.2 ± 0.12 ns      | 28.1 ± 0.33 ns      | 1 ± 0.013                  |
| Convolved/analytic/construction                                                     | 3.41 ± 0.0032 ns    | 3.1 ± 0.01 ns       | 1.1 ± 0.0037               |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.026 μs     | 1.08 ± 0.024 μs     | 1 ± 0.033                  |
| Convolved/analytic/logpdf broadcast                                                 | 2.56 ± 0.34 μs      | 2.46 ± 0.04 μs      | 1.04 ± 0.14                |
| Convolved/analytic/logpdf scalar                                                    | 28.1 ± 0.35 ns      | 27.8 ± 0.21 ns      | 1.01 ± 0.015               |
| Convolved/analytic/mean                                                             | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       | 0.903 ± 0.0044             |
| Convolved/analytic/pdf batched                                                      | 1.11 ± 0.024 μs     | 1.12 ± 0.033 μs     | 0.993 ± 0.036              |
| Convolved/analytic/pdf scalar                                                       | 29.8 ± 0.09 ns      | 29.8 ± 0.29 ns      | 1 ± 0.01                   |
| Convolved/analytic/rand                                                             | 1.13 ± 0.029 μs     | 1.13 ± 0.033 μs     | 0.997 ± 0.038              |
| Convolved/numeric/cdf batched                                                       | 0.83 ± 0.0035 ms    | 0.829 ± 0.0021 ms   | 1 ± 0.0049                 |
| Convolved/numeric/cdf scalar                                                        | 15.7 ± 0.08 μs      | 15.6 ± 0.06 μs      | 1.01 ± 0.0064              |
| Convolved/numeric/construction                                                      | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Convolved/numeric/logpdf batched                                                    | 0.732 ± 0.0059 ms   | 0.734 ± 0.0056 ms   | 0.998 ± 0.011              |
| Convolved/numeric/logpdf broadcast                                                  | 1.35 ± 0.0089 ms    | 1.35 ± 0.0092 ms    | 0.999 ± 0.0095             |
| Convolved/numeric/logpdf scalar                                                     | 12.5 ± 0.04 μs      | 12.5 ± 0.04 μs      | 1 ± 0.0045                 |
| Convolved/numeric/mean                                                              | 6.58 ± 0.04 ns      | 6.58 ± 0.03 ns      | 1 ± 0.0076                 |
| Convolved/numeric/pdf batched                                                       | 0.732 ± 0.0061 ms   | 0.732 ± 0.0064 ms   | 0.999 ± 0.012              |
| Convolved/numeric/pdf scalar                                                        | 12.5 ± 0.031 μs     | 12.5 ± 0.041 μs     | 1 ± 0.0041                 |
| Convolved/numeric/rand                                                              | 2.81 ± 0.36 μs      | 2.79 ± 0.36 μs      | 1.01 ± 0.18                |
| Difference/analytic/cdf broadcast                                                   | 3.37 ± 0.35 μs      | 3.35 ± 0.022 μs     | 1.01 ± 0.11                |
| Difference/analytic/cdf scalar                                                      | 11 ± 0.08 ns        | 10.8 ± 0.02 ns      | 1.01 ± 0.0076              |
| Difference/analytic/construction                                                    | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 1 ± 0.0042                 |
| Difference/analytic/logpdf broadcast                                                | 1.53 ± 0.31 μs      | 1.47 ± 0.07 μs      | 1.04 ± 0.21                |
| Difference/analytic/logpdf scalar                                                   | 16.8 ± 0.081 ns     | 17 ± 0.081 ns       | 0.985 ± 0.0067             |
| Difference/analytic/mean                                                            | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 1 ± 0.0046                 |
| Difference/analytic/rand                                                            | 1.13 ± 0.034 μs     | 1.13 ± 0.036 μs     | 1 ± 0.044                  |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 0.999 ± 0.019              |
| Difference/numeric/cdf scalar                                                       | 19.4 ± 0.09 μs      | 19.4 ± 0.1 μs       | 1 ± 0.007                  |
| Difference/numeric/construction                                                     | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1 ± 0.0046                 |
| Difference/numeric/logpdf broadcast                                                 | 1.65 ± 0.015 ms     | 1.65 ± 0.016 ms     | 0.999 ± 0.013              |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.071 μs     | 16.7 ± 0.08 μs      | 1 ± 0.0064                 |
| Difference/numeric/mean                                                             | 6.64 ± 0.07 ns      | 6.54 ± 0.03 ns      | 1.02 ± 0.012               |
| Difference/numeric/rand                                                             | 2.81 ± 0.36 μs      | 2.8 ± 0.36 μs       | 1 ± 0.18                   |
| Product/analytic/cdf broadcast                                                      | 4.9 ± 0.21 μs       | 4.89 ± 0.033 μs     | 1 ± 0.044                  |
| Product/analytic/cdf scalar                                                         | 29.6 ± 0.24 ns      | 29.7 ± 0.09 ns      | 0.998 ± 0.0087             |
| Product/analytic/construction                                                       | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Product/analytic/logpdf broadcast                                                   | 2.23 ± 0.33 μs      | 2.24 ± 0.086 μs     | 0.995 ± 0.15               |
| Product/analytic/logpdf scalar                                                      | 24 ± 0.13 ns        | 24 ± 0.12 ns        | 0.998 ± 0.0074             |
| Product/analytic/mean                                                               | 10.9 ± 0.031 ns     | 10.8 ± 0.04 ns      | 1.01 ± 0.0047              |
| Product/analytic/rand                                                               | 1.96 ± 0.31 μs      | 1.78 ± 0.31 μs      | 1.1 ± 0.26                 |
| Product/numeric/cdf broadcast                                                       | 1.97 ± 0.015 ms     | 1.97 ± 0.016 ms     | 1 ± 0.011                  |
| Product/numeric/cdf scalar                                                          | 23.1 ± 0.1 μs       | 23.1 ± 0.09 μs      | 1 ± 0.0058                 |
| Product/numeric/construction                                                        | 3.72 ± 0 ns         | 3.11 ± 0.01 ns      | 1.2 ± 0.0039               |
| Product/numeric/logpdf broadcast                                                    | 1.77 ± 0.015 ms     | 1.77 ± 0.016 ms     | 0.997 ± 0.012              |
| Product/numeric/logpdf scalar                                                       | 17.5 ± 0.089 μs     | 17.6 ± 0.08 μs      | 0.998 ± 0.0068             |
| Product/numeric/mean                                                                | 6.71 ± 0.031 ns     | 6.71 ± 0.031 ns     | 1 ± 0.0065                 |
| Product/numeric/rand                                                                | 2.82 ± 0.35 μs      | 2.8 ± 0.35 μs       | 1.01 ± 0.18                |
| Quantile/Convolved analytic/grid                                                    | 0.613 ± 0.11 ms     | 0.611 ± 0.11 ms     | 1 ± 0.25                   |
| Quantile/Convolved analytic/median                                                  | 22.5 ± 0.82 μs      | 22.9 ± 0.79 μs      | 0.981 ± 0.049              |
| Quantile/Convolved numeric/median                                                   | 0.291 ± 0.011 ms    | 0.29 ± 0.011 ms     | 1 ± 0.053                  |
| Quantile/Difference numeric/median                                                  | 0.34 ± 0.01 ms      | 0.34 ± 0.0098 ms    | 1 ± 0.041                  |
| Quantile/Product numeric/median                                                     | 0.497 ± 0.012 ms    | 0.497 ± 0.012 ms    | 1 ± 0.035                  |
| Timeseries/Convolved delay                                                          | 0.357 ± 0.0086 μs   | 0.36 ± 0.01 μs      | 0.991 ± 0.037              |
| Timeseries/Gamma delay                                                              | 0.355 ± 0.01 μs     | 0.36 ± 0.011 μs     | 0.987 ± 0.042              |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.025 μs     | 1.27 ± 0.023 μs     | 1 ± 0.027                  |
| time_to_load                                                                        | 0.88 ± 0.0055 s     | 0.887 ± 0.019 s     | 0.992 ± 0.022              |

|                                                                                     | v0.2.0                    | fd7619e7352292...         | v0.2.0 / fd7619e7352292... |
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

