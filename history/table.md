|                                                                                     | v0.2.0              | ed45181cd3e0da...   | v0.2.0 / ed45181cd3e0da... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0627 ± 0.0034 ms  | 0.063 ± 0.0033 ms   | 0.995 ± 0.076              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.482 ± 0.041 ms    | 0.477 ± 0.043 ms    | 1.01 ± 0.13                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.054 ± 0.00046 ms  | 0.0536 ± 0.00046 ms | 1.01 ± 0.012               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.254 ± 0.0077 ms   | 0.256 ± 0.0079 ms   | 0.992 ± 0.043              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.619 ± 0.039 ms    | 0.592 ± 0.03 ms     | 1.05 ± 0.085               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.25 ± 0.28 ms      | 2.28 ± 0.3 ms       | 0.987 ± 0.18               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0866 ± 0.0034 ms  | 0.0866 ± 0.0064 ms  | 1 ± 0.084                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.475 ± 0.045 ms    | 0.474 ± 0.042 ms    | 1 ± 0.13                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0661 ± 0.00075 ms | 0.066 ± 0.00081 ms  | 1 ± 0.017                  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.528 ± 0.014 ms    | 0.534 ± 0.014 ms    | 0.989 ± 0.036              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.602 ± 0.039 ms    | 0.59 ± 0.028 ms     | 1.02 ± 0.083               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.62 ± 0.31 ms      | 2.6 ± 0.35 ms       | 1.01 ± 0.18                |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.073 ± 0.00057 ms  | 0.0732 ± 0.00051 ms | 0.998 ± 0.01               |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.126 ± 0.0069 ms   | 0.127 ± 0.0069 ms   | 0.996 ± 0.077              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0697 ± 0.00015 ms | 0.0692 ± 0.0002 ms  | 1.01 ± 0.0036              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.292 ± 0.009 ms    | 0.293 ± 0.0092 ms   | 0.998 ± 0.044              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.582 ± 0.043 ms    | 0.569 ± 0.034 ms    | 1.02 ± 0.098               |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.53 ± 0.32 ms      | 2.57 ± 0.3 ms       | 0.984 ± 0.17               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.32 ± 0.34 μs      | 7.29 ± 0.17 μs      | 1.01 ± 0.053               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0503 ± 0.0079 μs  | 0.0477 ± 0.0093 μs  | 1.06 ± 0.26                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.544 ± 0.041 μs    | 0.544 ± 0.041 μs    | 1 ± 0.11                   |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.11 ± 0.77 μs      | 5.21 ± 0.68 μs      | 0.981 ± 0.2                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.71 ± 0.31 μs      | 4.62 ± 0.31 μs      | 1.02 ± 0.096               |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.54 ± 0.095 μs     | 2.54 ± 0.11 μs      | 0.997 ± 0.058              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0936 ± 0.0007 ms  | 0.0937 ± 0.00077 ms | 0.999 ± 0.011              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.151 ± 0.0075 ms   | 0.147 ± 0.0081 ms   | 1.02 ± 0.076               |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0854 ± 0.0002 ms  | 0.0856 ± 0.00024 ms | 0.998 ± 0.0037             |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.377 ± 0.0092 ms   | 0.379 ± 0.0094 ms   | 0.995 ± 0.035              |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.628 ± 0.048 ms    | 0.613 ± 0.035 ms    | 1.02 ± 0.098               |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.4 ± 0.3 ms        | 2.47 ± 0.3 ms       | 0.975 ± 0.17               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.15 ± 0.087 μs     | 8.19 ± 0.09 μs      | 0.996 ± 0.015              |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.41 ± 0.11 μs      | 3.37 ± 0.089 μs     | 1.01 ± 0.042               |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.62 ± 0.088 μs     | 0.614 ± 0.082 μs    | 1.01 ± 0.2                 |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.78 ± 0.5 μs       | 5.71 ± 0.35 μs      | 1.01 ± 0.11                |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 28.4 ± 3.2 μs       | 27.4 ± 3.1 μs       | 1.04 ± 0.17                |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.3 ± 0.53 μs      | 17.2 ± 0.56 μs      | 1.01 ± 0.045               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.12 ± 0.0013 ms    | 0.12 ± 0.0012 ms    | 0.996 ± 0.014              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.209 ± 0.012 ms    | 0.208 ± 0.011 ms    | 1.01 ± 0.077               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.117 ± 0.00047 ms  | 0.117 ± 0.00048 ms  | 1 ± 0.0058                 |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.502 ± 0.011 ms    | 0.502 ± 0.01 ms     | 1 ± 0.03                   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.859 ± 0.046 ms    | 0.848 ± 0.035 ms    | 1.01 ± 0.068               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.33 ± 0.6 ms       | 4.48 ± 0.58 ms      | 0.966 ± 0.18               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.34 ± 0.34 μs      | 7.27 ± 0.18 μs      | 1.01 ± 0.053               |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0496 ± 0.0068 μs  | 0.0477 ± 0.0073 μs  | 1.04 ± 0.21                |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.579 ± 0.04 μs     | 0.539 ± 0.042 μs    | 1.07 ± 0.11                |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.19 ± 0.77 μs      | 5.11 ± 0.7 μs       | 1.02 ± 0.2                 |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.62 ± 0.29 μs      | 4.63 ± 0.31 μs      | 0.999 ± 0.091              |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.55 ± 0.088 μs     | 2.55 ± 0.093 μs     | 1 ± 0.05                   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.145 ± 0.0016 ms   | 0.145 ± 0.0014 ms   | 1 ± 0.014                  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.238 ± 0.012 ms    | 0.238 ± 0.011 ms    | 1 ± 0.07                   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.139 ± 0.00071 ms  | 0.138 ± 0.00064 ms  | 1.01 ± 0.007               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.623 ± 0.0094 ms   | 0.624 ± 0.0095 ms   | 0.999 ± 0.021              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.92 ± 0.037 ms     | 0.926 ± 0.033 ms    | 0.993 ± 0.053              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.23 ± 0.56 ms      | 4.29 ± 0.59 ms      | 0.985 ± 0.19               |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.09 ± 0.1 μs       | 8.11 ± 0.12 μs      | 0.998 ± 0.019              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.21 ± 0.078 μs     | 3.22 ± 0.088 μs     | 0.995 ± 0.036              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.571 ± 0.084 μs    | 0.574 ± 0.083 μs    | 0.995 ± 0.2                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.64 ± 0.41 μs      | 5.49 ± 0.35 μs      | 1.03 ± 0.099               |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 28.1 ± 3.2 μs       | 27.8 ± 3.3 μs       | 1.01 ± 0.16                |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.6 ± 0.66 μs      | 18.3 ± 0.66 μs      | 1.01 ± 0.051               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.38 ± 0.34 μs      | 7.35 ± 0.22 μs      | 1.01 ± 0.056               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0711 ± 0.0062 μs  | 0.0706 ± 0.014 μs   | 1.01 ± 0.21                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.622 ± 0.041 μs    | 0.604 ± 0.042 μs    | 1.03 ± 0.099               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.32 ± 0.61 μs      | 5.35 ± 0.58 μs      | 0.994 ± 0.16               |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.6 ± 0.74 μs       | 6.67 ± 0.74 μs      | 0.99 ± 0.16                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.3 ± 0.42 μs      | 10.4 ± 0.44 μs      | 0.998 ± 0.059              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.0012 ms   | 0.124 ± 0.0014 ms   | 0.999 ± 0.015              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.212 ± 0.01 ms     | 0.211 ± 0.011 ms    | 1 ± 0.07                   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.118 ± 0.00055 ms  | 0.119 ± 0.0005 ms   | 0.996 ± 0.0063             |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.531 ± 0.0099 ms   | 0.531 ± 0.01 ms     | 1 ± 0.027                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.896 ± 0.039 ms    | 0.896 ± 0.036 ms    | 1 ± 0.059                  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.81 ± 0.57 ms      | 4.89 ± 0.57 ms      | 0.985 ± 0.16               |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.152 ± 0.0015 ms   | 0.152 ± 0.0014 ms   | 1 ± 0.014                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.249 ± 0.012 ms    | 0.25 ± 0.012 ms     | 0.994 ± 0.069              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.142 ± 0.00069 ms  | 0.141 ± 0.00061 ms  | 1 ± 0.0065                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.649 ± 0.0086 ms   | 0.657 ± 0.009 ms    | 0.989 ± 0.019              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.973 ± 0.04 ms     | 0.972 ± 0.037 ms    | 1 ± 0.056                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.68 ± 0.56 ms      | 4.74 ± 0.56 ms      | 0.987 ± 0.17               |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.14 ± 0.097 μs     | 8.2 ± 0.11 μs       | 0.992 ± 0.018              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.32 ± 0.12 μs      | 3.3 ± 0.098 μs      | 1.01 ± 0.046               |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.587 ± 0.082 μs    | 0.618 ± 0.079 μs    | 0.95 ± 0.18                |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.86 ± 0.47 μs      | 5.76 ± 0.36 μs      | 1.02 ± 0.1                 |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 18.1 ± 1.4 μs       | 18.1 ± 1.6 μs       | 1 ± 0.12                   |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22.2 ± 0.73 μs      | 21.8 ± 0.65 μs      | 1.02 ± 0.045               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.48 ± 0.12 μs      | 7.44 ± 0.13 μs      | 1.01 ± 0.023               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.7 ± 0.072 μs      | 7.16 ± 0.088 μs     | 1.08 ± 0.017               |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.944 ± 0.043 μs    | 0.944 ± 0.053 μs    | 1 ± 0.073                  |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.17 ± 0.92 μs      | 6.23 ± 0.89 μs      | 0.99 ± 0.21                |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.9 ± 1 μs         | 17.8 ± 1.1 μs       | 1.01 ± 0.085               |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 29 ± 0.73 μs        | 29 ± 0.73 μs        | 1 ± 0.036                  |
| Baseline/Gamma/cdf                                                                  | 3.65 ± 0.37 μs      | 3.55 ± 0.39 μs      | 1.03 ± 0.15                |
| Baseline/Gamma/logpdf                                                               | 2.88 ± 0.33 μs      | 2.88 ± 0.37 μs      | 1 ± 0.17                   |
| Baseline/Normal/cdf                                                                 | 1.49 ± 0.31 μs      | 1.48 ± 0.33 μs      | 1.01 ± 0.31                |
| Baseline/Normal/logpdf                                                              | 1.06 ± 0.03 μs      | 1.06 ± 0.024 μs     | 0.997 ± 0.036              |
| Convolved/analytic/cdf batched                                                      | 2.67 ± 0.34 μs      | 2.65 ± 0.36 μs      | 1.01 ± 0.19                |
| Convolved/analytic/cdf scalar                                                       | 28.5 ± 0.17 ns      | 28 ± 0.31 ns        | 1.02 ± 0.013               |
| Convolved/analytic/construction                                                     | 3.1 ± 0.01 ns       | 3.41 ± 0.011 ns     | 0.911 ± 0.0042             |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.031 μs     | 1.09 ± 0.031 μs     | 0.996 ± 0.04               |
| Convolved/analytic/logpdf broadcast                                                 | 2.57 ± 0.35 μs      | 2.56 ± 0.36 μs      | 1.01 ± 0.2                 |
| Convolved/analytic/logpdf scalar                                                    | 27.7 ± 0.091 ns     | 28.3 ± 0.28 ns      | 0.978 ± 0.01               |
| Convolved/analytic/mean                                                             | 2.79 ± 0.01 ns      | 2.79 ± 0.01 ns      | 1 ± 0.0051                 |
| Convolved/analytic/pdf batched                                                      | 1.12 ± 0.032 μs     | 1.12 ± 0.029 μs     | 0.996 ± 0.038              |
| Convolved/analytic/pdf scalar                                                       | 29.9 ± 0.14 ns      | 29.8 ± 0.11 ns      | 1 ± 0.006                  |
| Convolved/analytic/rand                                                             | 1.13 ± 0.036 μs     | 1.14 ± 0.035 μs     | 0.993 ± 0.044              |
| Convolved/numeric/cdf batched                                                       | 1.12 ± 0.0033 ms    | 0.829 ± 0.0026 ms   | 1.35 ± 0.0057              |
| Convolved/numeric/cdf scalar                                                        | 15.6 ± 0.069 μs     | 15.6 ± 0.06 μs      | 1 ± 0.0059                 |
| Convolved/numeric/construction                                                      | 3.41 ± 0.001 ns     | 3.1 ± 0.01 ns       | 1.1 ± 0.0036               |
| Convolved/numeric/logpdf batched                                                    | 0.733 ± 0.0059 ms   | 0.744 ± 0.0054 ms   | 0.985 ± 0.011              |
| Convolved/numeric/logpdf broadcast                                                  | 1.35 ± 0.0093 ms    | 1.35 ± 0.0094 ms    | 1 ± 0.0099                 |
| Convolved/numeric/logpdf scalar                                                     | 12.5 ± 0.04 μs      | 12.5 ± 0.04 μs      | 1 ± 0.0045                 |
| Convolved/numeric/mean                                                              | 6.61 ± 0.021 ns     | 6.61 ± 0.05 ns      | 1 ± 0.0082                 |
| Convolved/numeric/pdf batched                                                       | 0.737 ± 0.0079 ms   | 0.743 ± 0.0041 ms   | 0.992 ± 0.012              |
| Convolved/numeric/pdf scalar                                                        | 12.5 ± 0.06 μs      | 12.5 ± 0.049 μs     | 1 ± 0.0062                 |
| Convolved/numeric/rand                                                              | 2.8 ± 0.37 μs       | 2.84 ± 0.37 μs      | 0.986 ± 0.18               |
| Difference/analytic/cdf broadcast                                                   | 3.36 ± 0.35 μs      | 3.38 ± 0.36 μs      | 0.996 ± 0.15               |
| Difference/analytic/cdf scalar                                                      | 10.8 ± 0.011 ns     | 10.8 ± 0.011 ns     | 1 ± 0.0014                 |
| Difference/analytic/construction                                                    | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Difference/analytic/logpdf broadcast                                                | 1.52 ± 0.32 μs      | 1.53 ± 0.32 μs      | 0.995 ± 0.3                |
| Difference/analytic/logpdf scalar                                                   | 17 ± 0.31 ns        | 17 ± 0.24 ns        | 0.999 ± 0.023              |
| Difference/analytic/mean                                                            | 3.1 ± 0.01 ns       | 2.79 ± 0.01 ns      | 1.11 ± 0.0053              |
| Difference/analytic/rand                                                            | 1.14 ± 0.039 μs     | 1.14 ± 0.042 μs     | 0.995 ± 0.05               |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 1 ± 0.019                  |
| Difference/numeric/cdf scalar                                                       | 19.5 ± 0.099 μs     | 19.4 ± 0.099 μs     | 1 ± 0.0072                 |
| Difference/numeric/construction                                                     | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 0.912 ± 0.004              |
| Difference/numeric/logpdf broadcast                                                 | 1.66 ± 0.016 ms     | 1.65 ± 0.019 ms     | 1 ± 0.015                  |
| Difference/numeric/logpdf scalar                                                    | 16.7 ± 0.071 μs     | 16.8 ± 0.081 μs     | 0.998 ± 0.0064             |
| Difference/numeric/mean                                                             | 6.59 ± 0.06 ns      | 6.59 ± 0.031 ns     | 1 ± 0.01                   |
| Difference/numeric/rand                                                             | 2.79 ± 0.36 μs      | 2.85 ± 0.37 μs      | 0.979 ± 0.18               |
| Product/analytic/cdf broadcast                                                      | 4.9 ± 0.21 μs       | 4.91 ± 0.22 μs      | 0.999 ± 0.061              |
| Product/analytic/cdf scalar                                                         | 29.7 ± 0.07 ns      | 29.7 ± 0.091 ns     | 0.999 ± 0.0039             |
| Product/analytic/construction                                                       | 3.41 ± 0.01 ns      | 3.72 ± 0.001 ns     | 0.917 ± 0.0027             |
| Product/analytic/logpdf broadcast                                                   | 2.22 ± 0.35 μs      | 2.19 ± 0.35 μs      | 1.02 ± 0.23                |
| Product/analytic/logpdf scalar                                                      | 23.9 ± 0.081 ns     | 24 ± 0.15 ns        | 0.995 ± 0.0071             |
| Product/analytic/mean                                                               | 10.8 ± 0.03 ns      | 10.9 ± 0.031 ns     | 0.993 ± 0.004              |
| Product/analytic/rand                                                               | 1.77 ± 0.33 μs      | 1.79 ± 0.33 μs      | 0.988 ± 0.26               |
| Product/numeric/cdf broadcast                                                       | 1.97 ± 0.017 ms     | 1.98 ± 0.017 ms     | 0.999 ± 0.012              |
| Product/numeric/cdf scalar                                                          | 23.2 ± 0.11 μs      | 23.1 ± 0.1 μs       | 1 ± 0.0065                 |
| Product/numeric/construction                                                        | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 1.1 ± 0.0048               |
| Product/numeric/logpdf broadcast                                                    | 1.78 ± 0.016 ms     | 1.77 ± 0.015 ms     | 1 ± 0.012                  |
| Product/numeric/logpdf scalar                                                       | 17.5 ± 0.07 μs      | 17.5 ± 0.081 μs     | 1 ± 0.0061                 |
| Product/numeric/mean                                                                | 6.71 ± 0.039 ns     | 6.71 ± 0.05 ns      | 1 ± 0.0094                 |
| Product/numeric/rand                                                                | 2.8 ± 0.35 μs       | 2.87 ± 0.36 μs      | 0.977 ± 0.17               |
| Quantile/Convolved analytic/grid                                                    | 0.601 ± 0.11 ms     | 0.611 ± 0.11 ms     | 0.984 ± 0.25               |
| Quantile/Convolved analytic/median                                                  | 22.3 ± 0.72 μs      | 22.8 ± 0.96 μs      | 0.978 ± 0.052              |
| Quantile/Convolved numeric/median                                                   | 0.291 ± 0.011 ms    | 0.291 ± 0.012 ms    | 0.999 ± 0.056              |
| Quantile/Difference numeric/median                                                  | 0.341 ± 0.01 ms     | 0.341 ± 0.011 ms    | 1 ± 0.044                  |
| Quantile/Product numeric/median                                                     | 0.497 ± 0.012 ms    | 0.498 ± 0.012 ms    | 0.998 ± 0.035              |
| Timeseries/Convolved delay                                                          | 0.355 ± 0.0085 μs   | 0.358 ± 0.012 μs    | 0.99 ± 0.041               |
| Timeseries/Gamma delay                                                              | 0.355 ± 0.011 μs    | 0.359 ± 0.011 μs    | 0.988 ± 0.043              |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.024 μs     | 1.27 ± 0.029 μs     | 0.998 ± 0.03               |
| time_to_load                                                                        | 0.907 ± 0.0097 s    | 0.937 ± 0.031 s     | 0.969 ± 0.034              |

|                                                                                     | v0.2.0                    | ed45181cd3e0da...         | v0.2.0 / ed45181cd3e0da... |
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

