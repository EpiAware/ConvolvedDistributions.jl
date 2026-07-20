|                                                                                     | v0.2.0              | 15782750f545a3...   | v0.2.0 / 15782750f545a3... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0606 ± 0.004 ms   | 0.0608 ± 0.004 ms   | 0.997 ± 0.093              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.482 ± 0.054 ms    | 0.512 ± 0.051 ms    | 0.941 ± 0.14               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0541 ± 0.00051 ms | 0.0542 ± 0.00051 ms | 0.999 ± 0.013              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.263 ± 0.0057 ms   | 0.271 ± 0.0062 ms   | 0.973 ± 0.031              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.616 ± 0.022 ms    | 0.612 ± 0.026 ms    | 1.01 ± 0.056               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.24 ± 0.33 ms      | 2.31 ± 0.34 ms      | 0.969 ± 0.2                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0867 ± 0.0071 ms  | 0.0862 ± 0.0065 ms  | 1.01 ± 0.11                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.477 ± 0.053 ms    | 0.484 ± 0.054 ms    | 0.986 ± 0.16               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0662 ± 0.00073 ms | 0.0663 ± 0.00068 ms | 0.999 ± 0.015              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.56 ± 0.012 ms     | 0.56 ± 0.012 ms     | 1 ± 0.03                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.608 ± 0.023 ms    | 0.604 ± 0.027 ms    | 1.01 ± 0.059               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.58 ± 0.39 ms      | 2.64 ± 0.41 ms      | 0.977 ± 0.21               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0725 ± 0.00057 ms | 0.0724 ± 0.00056 ms | 1 ± 0.011                  |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.122 ± 0.0077 ms   | 0.124 ± 0.0071 ms   | 0.986 ± 0.085              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0724 ± 0.00037 ms | 0.0724 ± 0.00032 ms | 0.999 ± 0.0068             |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.298 ± 0.0085 ms   | 0.299 ± 0.0085 ms   | 0.995 ± 0.04               |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.605 ± 0.021 ms    | 0.599 ± 0.022 ms    | 1.01 ± 0.051               |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.52 ± 0.37 ms      | 2.5 ± 0.37 ms       | 1.01 ± 0.21                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 6.89 ± 0.2 μs       | 6.97 ± 0.26 μs      | 0.988 ± 0.047              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0495 ± 0.0083 μs  | 0.0506 ± 0.012 μs   | 0.978 ± 0.28               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.572 ± 0.054 μs    | 0.572 ± 0.049 μs    | 0.999 ± 0.13               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.33 ± 0.56 μs      | 5.44 ± 0.55 μs      | 0.98 ± 0.14                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.76 ± 0.21 μs      | 4.81 ± 0.26 μs      | 0.991 ± 0.07               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.63 ± 0.15 μs      | 2.64 ± 0.12 μs      | 0.998 ± 0.072              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0926 ± 0.0094 ms  | 0.0926 ± 0.00078 ms | 1 ± 0.1                    |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.146 ± 0.0079 ms   | 0.149 ± 0.0082 ms   | 0.982 ± 0.076              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0894 ± 0.00037 ms | 0.0893 ± 0.00034 ms | 1 ± 0.0056                 |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.391 ± 0.009 ms    | 0.39 ± 0.0089 ms    | 1 ± 0.032                  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.647 ± 0.028 ms    | 0.645 ± 0.027 ms    | 1 ± 0.06                   |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.41 ± 0.36 ms      | 2.41 ± 0.36 ms      | 1 ± 0.21                   |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 7.78 ± 0.12 μs      | 7.87 ± 0.12 μs      | 0.989 ± 0.021              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.31 ± 0.085 μs     | 3.35 ± 0.11 μs      | 0.99 ± 0.042               |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.64 ± 0.092 μs     | 0.644 ± 0.098 μs    | 0.994 ± 0.21               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 6.14 ± 0.24 μs      | 6.16 ± 0.28 μs      | 0.996 ± 0.059              |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 28.4 ± 3.2 μs       | 29 ± 3.3 μs         | 0.98 ± 0.16                |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.4 ± 0.59 μs      | 17.8 ± 0.56 μs      | 0.976 ± 0.045              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.0011 ms   | 0.12 ± 0.0014 ms    | 0.997 ± 0.015              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.204 ± 0.011 ms    | 0.205 ± 0.01 ms     | 0.992 ± 0.072              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.126 ± 0.00063 ms  | 0.126 ± 0.00066 ms  | 1 ± 0.0073                 |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.537 ± 0.01 ms     | 0.537 ± 0.011 ms    | 0.999 ± 0.028              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.915 ± 0.023 ms    | 0.915 ± 0.027 ms    | 1 ± 0.039                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.32 ± 0.65 ms      | 4.34 ± 0.66 ms      | 0.996 ± 0.21               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 6.95 ± 0.33 μs      | 6.99 ± 0.24 μs      | 0.994 ± 0.059              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0505 ± 0.0085 μs  | 0.0527 ± 0.017 μs   | 0.958 ± 0.34               |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.576 ± 0.054 μs    | 0.578 ± 0.051 μs    | 0.996 ± 0.13               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.44 ± 0.72 μs      | 5.4 ± 0.56 μs       | 1.01 ± 0.17                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.87 ± 0.27 μs      | 4.81 ± 0.26 μs      | 1.01 ± 0.079               |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.58 ± 0.1 μs       | 2.78 ± 1.5 μs       | 0.93 ± 0.49                |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.144 ± 0.0014 ms   | 0.144 ± 0.0013 ms   | 1 ± 0.013                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.239 ± 0.011 ms    | 0.24 ± 0.011 ms     | 0.993 ± 0.064              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.149 ± 0.00094 ms  | 0.148 ± 0.00078 ms  | 1 ± 0.0083                 |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.644 ± 0.0088 ms   | 0.646 ± 0.0085 ms   | 0.998 ± 0.019              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.988 ± 0.017 ms    | 0.989 ± 0.022 ms    | 0.999 ± 0.028              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.22 ± 0.65 ms      | 4.28 ± 0.64 ms      | 0.985 ± 0.21               |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 7.7 ± 0.14 μs       | 7.83 ± 0.12 μs      | 0.982 ± 0.023              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.21 ± 0.13 μs      | 3.18 ± 0.095 μs     | 1.01 ± 0.052               |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.624 ± 0.095 μs    | 0.618 ± 0.097 μs    | 1.01 ± 0.22                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.83 ± 0.3 μs       | 5.83 ± 0.29 μs      | 0.999 ± 0.07               |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 28.5 ± 3.3 μs       | 29.1 ± 3.4 μs       | 0.981 ± 0.16               |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.5 ± 0.74 μs      | 18.8 ± 0.66 μs      | 0.984 ± 0.053              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 6.97 ± 0.34 μs      | 7.03 ± 0.24 μs      | 0.991 ± 0.06               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0775 ± 0.019 μs   | 0.0786 ± 0.018 μs   | 0.986 ± 0.34               |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.646 ± 0.11 μs     | 0.662 ± 0.05 μs     | 0.975 ± 0.18               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.67 ± 0.55 μs      | 5.71 ± 0.55 μs      | 0.993 ± 0.13               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.9 ± 0.76 μs       | 6.79 ± 0.81 μs      | 1.02 ± 0.16                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.2 ± 0.42 μs      | 10.3 ± 0.4 μs       | 0.989 ± 0.056              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.0011 ms   | 0.123 ± 0.0011 ms   | 0.998 ± 0.013              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.211 ± 0.011 ms    | 0.214 ± 0.011 ms    | 0.988 ± 0.072              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.127 ± 0.008 ms    | 0.127 ± 0.0006 ms   | 1 ± 0.063                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.562 ± 0.011 ms    | 0.562 ± 0.0099 ms   | 1 ± 0.026                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.949 ± 0.019 ms    | 0.952 ± 0.023 ms    | 0.996 ± 0.031              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.8 ± 0.68 ms       | 4.87 ± 0.7 ms       | 0.986 ± 0.2                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.155 ± 0.0016 ms   | 0.154 ± 0.0014 ms   | 1.01 ± 0.014               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.249 ± 0.011 ms    | 0.251 ± 0.011 ms    | 0.991 ± 0.063              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.151 ± 0.00091 ms  | 0.151 ± 0.00088 ms  | 0.998 ± 0.0084             |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.674 ± 0.0072 ms   | 0.675 ± 0.0079 ms   | 0.999 ± 0.016              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 1.04 ± 0.022 ms     | 1.06 ± 0.024 ms     | 0.983 ± 0.031              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.7 ± 0.67 ms       | 4.77 ± 0.71 ms      | 0.985 ± 0.2                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 7.77 ± 0.14 μs      | 7.83 ± 0.13 μs      | 0.993 ± 0.024              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.25 ± 0.14 μs      | 3.27 ± 0.095 μs     | 0.992 ± 0.051              |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.6 ± 0.089 μs      | 0.607 ± 0.097 μs    | 0.989 ± 0.22               |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 6.16 ± 0.28 μs      | 6.15 ± 0.18 μs      | 1 ± 0.055                  |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.7 ± 1.6 μs       | 17.9 ± 1.4 μs       | 0.99 ± 0.12                |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22.2 ± 0.77 μs      | 22.3 ± 0.74 μs      | 0.999 ± 0.048              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 6.96 ± 0.14 μs      | 7.09 ± 0.13 μs      | 0.982 ± 0.028              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.5 ± 0.1 μs        | 8.14 ± 0.11 μs      | 0.922 ± 0.018              |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.972 ± 0.13 μs     | 0.988 ± 0.14 μs     | 0.984 ± 0.19               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.42 ± 0.32 μs      | 6.47 ± 0.32 μs      | 0.991 ± 0.07               |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 18.3 ± 1.1 μs       | 18.2 ± 1.1 μs       | 1.01 ± 0.085               |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 29.5 ± 0.84 μs      | 29.9 ± 0.82 μs      | 0.987 ± 0.039              |
| Baseline/Gamma/cdf                                                                  | 3.75 ± 0.42 μs      | 3.75 ± 0.46 μs      | 1 ± 0.17                   |
| Baseline/Gamma/logpdf                                                               | 2.77 ± 0.4 μs       | 2.82 ± 0.4 μs       | 0.983 ± 0.2                |
| Baseline/Normal/cdf                                                                 | 1.59 ± 0.4 μs       | 1.6 ± 0.38 μs       | 0.994 ± 0.34               |
| Baseline/Normal/logpdf                                                              | 1.06 ± 0.044 μs     | 1.06 ± 0.044 μs     | 0.999 ± 0.059              |
| Convolved/analytic/cdf batched                                                      | 2.7 ± 0.39 μs       | 2.61 ± 0.42 μs      | 1.03 ± 0.22                |
| Convolved/analytic/cdf scalar                                                       | 24.7 ± 0.13 ns      | 24.5 ± 0.13 ns      | 1.01 ± 0.0076              |
| Convolved/analytic/construction                                                     | 3.48 ± 0.001 ns     | 3.48 ± 0.001 ns     | 1 ± 0.00041                |
| Convolved/analytic/logpdf batched                                                   | 1.1 ± 0.04 μs       | 1.11 ± 0.057 μs     | 0.994 ± 0.063              |
| Convolved/analytic/logpdf broadcast                                                 | 2.36 ± 0.4 μs       | 2.35 ± 0.41 μs      | 1 ± 0.24                   |
| Convolved/analytic/logpdf scalar                                                    | 28.3 ± 0.12 ns      | 27.2 ± 0.2 ns       | 1.04 ± 0.0089              |
| Convolved/analytic/mean                                                             | 3.14 ± 0.01 ns      | 3.48 ± 0.01 ns      | 0.902 ± 0.0039             |
| Convolved/analytic/pdf batched                                                      | 1.1 ± 0.038 μs      | 1.1 ± 0.047 μs      | 0.995 ± 0.055              |
| Convolved/analytic/pdf scalar                                                       | 0.0324 ± 0.00042 μs | 30.8 ± 0.16 ns      | 1.05 ± 0.015               |
| Convolved/analytic/rand                                                             | 1.25 ± 0.067 μs     | 1.26 ± 0.075 μs     | 0.991 ± 0.079              |
| Convolved/numeric/cdf batched                                                       | 0.835 ± 0.005 ms    | 0.846 ± 0.0047 ms   | 0.987 ± 0.0081             |
| Convolved/numeric/cdf scalar                                                        | 15.5 ± 0.05 μs      | 15.4 ± 0.05 μs      | 1 ± 0.0046                 |
| Convolved/numeric/construction                                                      | 3.48 ± 0.001 ns     | 3.48 ± 0.001 ns     | 1 ± 0.00041                |
| Convolved/numeric/logpdf batched                                                    | 0.657 ± 0.0085 ms   | 0.652 ± 0.0088 ms   | 1.01 ± 0.019               |
| Convolved/numeric/logpdf broadcast                                                  | 1.22 ± 0.01 ms      | 1.2 ± 0.011 ms      | 1.01 ± 0.012               |
| Convolved/numeric/logpdf scalar                                                     | 11.2 ± 0.021 μs     | 11.2 ± 0.041 μs     | 1 ± 0.0041                 |
| Convolved/numeric/mean                                                              | 6.29 ± 0.01 ns      | 6.29 ± 0.001 ns     | 1 ± 0.0016                 |
| Convolved/numeric/pdf batched                                                       | 0.653 ± 0.0087 ms   | 0.651 ± 0.0088 ms   | 1 ± 0.019                  |
| Convolved/numeric/pdf scalar                                                        | 11.2 ± 0.03 μs      | 11.2 ± 0.041 μs     | 1 ± 0.0046                 |
| Convolved/numeric/rand                                                              | 2.76 ± 0.42 μs      | 2.76 ± 0.42 μs      | 1 ± 0.22                   |
| Difference/analytic/cdf broadcast                                                   | 3.57 ± 0.44 μs      | 3.56 ± 0.44 μs      | 1 ± 0.17                   |
| Difference/analytic/cdf scalar                                                      | 12.4 ± 0.06 ns      | 12.4 ± 0.011 ns     | 1 ± 0.0049                 |
| Difference/analytic/construction                                                    | 3.5 ± 0.001 ns      | 3.84 ± 0.001 ns     | 0.914 ± 0.00035            |
| Difference/analytic/logpdf broadcast                                                | 1.52 ± 0.37 μs      | 1.52 ± 0.37 μs      | 1 ± 0.34                   |
| Difference/analytic/logpdf scalar                                                   | 17.3 ± 0.17 ns      | 17.4 ± 0.2 ns       | 0.993 ± 0.015              |
| Difference/analytic/mean                                                            | 3.13 ± 0.01 ns      | 3.14 ± 0.01 ns      | 0.997 ± 0.0045             |
| Difference/analytic/rand                                                            | 1.26 ± 0.068 μs     | 1.27 ± 0.068 μs     | 0.988 ± 0.075              |
| Difference/numeric/cdf broadcast                                                    | 1.31 ± 0.022 ms     | 1.31 ± 0.023 ms     | 1 ± 0.025                  |
| Difference/numeric/cdf scalar                                                       | 19.5 ± 0.09 μs      | 19.5 ± 0.09 μs      | 0.998 ± 0.0065             |
| Difference/numeric/construction                                                     | 3.84 ± 0.001 ns     | 3.5 ± 0.001 ns      | 1.09 ± 0.00042             |
| Difference/numeric/logpdf broadcast                                                 | 1.51 ± 0.023 ms     | 1.51 ± 0.022 ms     | 1 ± 0.021                  |
| Difference/numeric/logpdf scalar                                                    | 15.1 ± 0.12 μs      | 15 ± 0.13 μs        | 1.01 ± 0.012               |
| Difference/numeric/mean                                                             | 6.29 ± 0.001 ns     | 6.12 ± 0.02 ns      | 1.03 ± 0.0034              |
| Difference/numeric/rand                                                             | 2.77 ± 0.42 μs      | 2.76 ± 0.42 μs      | 1 ± 0.21                   |
| Product/analytic/cdf broadcast                                                      | 5.1 ± 0.058 μs      | 5.1 ± 0.052 μs      | 1 ± 0.015                  |
| Product/analytic/cdf scalar                                                         | 29.1 ± 0.18 ns      | 29 ± 0.12 ns        | 1 ± 0.0075                 |
| Product/analytic/construction                                                       | 3.84 ± 0.009 ns     | 3.5 ± 0.001 ns      | 1.09 ± 0.0026              |
| Product/analytic/logpdf broadcast                                                   | 2.17 ± 0.4 μs       | 2.18 ± 0.39 μs      | 0.995 ± 0.25               |
| Product/analytic/logpdf scalar                                                      | 24.2 ± 0.24 ns      | 24.3 ± 0.21 ns      | 0.996 ± 0.013              |
| Product/analytic/mean                                                               | 10.2 ± 0.04 ns      | 10.2 ± 0.031 ns     | 1 ± 0.005                  |
| Product/analytic/rand                                                               | 1.7 ± 0.37 μs       | 1.7 ± 0.38 μs       | 1 ± 0.31                   |
| Product/numeric/cdf broadcast                                                       | 2.05 ± 0.02 ms      | 1.97 ± 0.022 ms     | 1.04 ± 0.015               |
| Product/numeric/cdf scalar                                                          | 23.3 ± 0.1 μs       | 23.3 ± 0.13 μs      | 0.999 ± 0.0071             |
| Product/numeric/construction                                                        | 3.5 ± 0.001 ns      | 3.84 ± 0.001 ns     | 0.914 ± 0.00035            |
| Product/numeric/logpdf broadcast                                                    | 1.61 ± 0.022 ms     | 1.62 ± 0.02 ms      | 0.997 ± 0.018              |
| Product/numeric/logpdf scalar                                                       | 15.9 ± 0.071 μs     | 15.9 ± 0.11 μs      | 1 ± 0.0082                 |
| Product/numeric/mean                                                                | 6.29 ± 0.01 ns      | 6.21 ± 0.02 ns      | 1.01 ± 0.0036              |
| Product/numeric/rand                                                                | 2.76 ± 0.4 μs       | 2.76 ± 0.43 μs      | 1 ± 0.21                   |
| Quantile/Convolved analytic/grid                                                    | 0.588 ± 0.096 ms    | 0.589 ± 0.1 ms      | 0.999 ± 0.24               |
| Quantile/Convolved analytic/median                                                  | 22.3 ± 0.94 μs      | 22.1 ± 0.86 μs      | 1.01 ± 0.058               |
| Quantile/Convolved numeric/median                                                   | 0.282 ± 0.0089 ms   | 0.281 ± 0.0087 ms   | 1 ± 0.044                  |
| Quantile/Difference numeric/median                                                  | 0.34 ± 0.0099 ms    | 0.341 ± 0.0097 ms   | 0.999 ± 0.041              |
| Quantile/Product numeric/median                                                     | 0.496 ± 0.012 ms    | 0.497 ± 0.011 ms    | 0.998 ± 0.032              |
| Timeseries/Convolved delay                                                          | 0.378 ± 0.013 μs    | 0.38 ± 0.012 μs     | 0.997 ± 0.048              |
| Timeseries/Gamma delay                                                              | 0.375 ± 0.014 μs    | 0.377 ± 0.013 μs    | 0.995 ± 0.05               |
| Timeseries/Poisson delay                                                            | 1.35 ± 0.028 μs     | 1.35 ± 0.032 μs     | 0.999 ± 0.031              |
| time_to_load                                                                        | 0.882 ± 0.0044 s    | 0.877 ± 0.0036 s    | 1.01 ± 0.0066              |

|                                                                                     | v0.2.0                    | 15782750f545a3...         | v0.2.0 / 15782750f545a3... |
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

