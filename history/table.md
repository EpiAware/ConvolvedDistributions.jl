|                                                                                     | v0.2.0              | d20eef3e4842a5...   | v0.2.0 / d20eef3e4842a5... |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:--------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0607 ± 0.0041 ms  | 0.0608 ± 0.0041 ms  | 0.999 ± 0.095              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.487 ± 0.05 ms     | 0.487 ± 0.053 ms    | 1 ± 0.15                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0542 ± 0.00054 ms | 0.0543 ± 0.00053 ms | 0.997 ± 0.014              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.262 ± 0.0061 ms   | 0.265 ± 0.0062 ms   | 0.989 ± 0.033              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.614 ± 0.034 ms    | 0.607 ± 0.027 ms    | 1.01 ± 0.072               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.25 ± 0.33 ms      | 2.23 ± 0.33 ms      | 1.01 ± 0.21                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0866 ± 0.0064 ms  | 0.0875 ± 0.0087 ms  | 0.99 ± 0.12                |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.488 ± 0.051 ms    | 0.487 ± 0.049 ms    | 1 ± 0.15                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0664 ± 0.00073 ms | 0.0666 ± 0.00075 ms | 0.997 ± 0.016              |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.561 ± 0.012 ms    | 0.559 ± 0.012 ms    | 1 ± 0.03                   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.611 ± 0.035 ms    | 0.607 ± 0.027 ms    | 1.01 ± 0.073               |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.57 ± 0.41 ms      | 2.56 ± 0.39 ms      | 1 ± 0.22                   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0723 ± 0.00062 ms | 0.073 ± 0.00059 ms  | 0.992 ± 0.012              |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.125 ± 0.0076 ms   | 0.126 ± 0.0071 ms   | 0.986 ± 0.082              |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0724 ± 0.00029 ms | 0.0722 ± 0.00027 ms | 1 ± 0.0055                 |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.298 ± 0.0084 ms   | 0.306 ± 0.0086 ms   | 0.973 ± 0.039              |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.607 ± 0.032 ms    | 0.614 ± 0.027 ms    | 0.989 ± 0.067              |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.52 ± 0.36 ms      | 2.47 ± 0.37 ms      | 1.02 ± 0.21                |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 6.83 ± 0.18 μs      | 7.16 ± 0.42 μs      | 0.954 ± 0.061              |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0508 ± 0.012 μs   | 0.0515 ± 0.0095 μs  | 0.986 ± 0.3                |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.581 ± 0.052 μs    | 0.59 ± 0.048 μs     | 0.985 ± 0.12               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.36 ± 0.64 μs      | 5.5 ± 0.63 μs       | 0.974 ± 0.16               |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.87 ± 0.25 μs      | 4.98 ± 0.34 μs      | 0.978 ± 0.084              |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.62 ± 0.17 μs      | 2.71 ± 0.11 μs      | 0.966 ± 0.075              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0927 ± 0.00076 ms | 0.0929 ± 0.00082 ms | 0.998 ± 0.012              |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.147 ± 0.0079 ms   | 0.149 ± 0.0083 ms   | 0.991 ± 0.077              |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0896 ± 0.00034 ms | 0.0895 ± 0.00037 ms | 1 ± 0.0056                 |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.391 ± 0.0087 ms   | 0.399 ± 0.0089 ms   | 0.979 ± 0.031              |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.653 ± 0.035 ms    | 0.665 ± 0.039 ms    | 0.982 ± 0.078              |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.43 ± 0.35 ms      | 2.39 ± 0.36 ms      | 1.02 ± 0.21                |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 7.73 ± 0.11 μs      | 7.97 ± 0.13 μs      | 0.97 ± 0.021               |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.25 ± 0.083 μs     | 3.45 ± 0.16 μs      | 0.944 ± 0.05               |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.648 ± 0.1 μs      | 0.65 ± 0.096 μs     | 0.996 ± 0.22               |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 6.08 ± 0.18 μs      | 6.31 ± 0.2 μs       | 0.963 ± 0.042              |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 29.8 ± 3.6 μs       | 29.3 ± 3.6 μs       | 1.02 ± 0.18                |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.1 ± 0.64 μs      | 17.9 ± 0.64 μs      | 0.955 ± 0.05               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.0012 ms   | 0.119 ± 0.0012 ms   | 0.999 ± 0.014              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.206 ± 0.01 ms     | 0.205 ± 0.01 ms     | 1.01 ± 0.071               |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.126 ± 0.00062 ms  | 0.126 ± 0.00071 ms  | 1 ± 0.0075                 |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.537 ± 0.01 ms     | 0.539 ± 0.01 ms     | 0.998 ± 0.027              |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.923 ± 0.042 ms    | 0.92 ± 0.032 ms     | 1 ± 0.057                  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.31 ± 0.67 ms      | 4.27 ± 0.72 ms      | 1.01 ± 0.23                |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 6.92 ± 0.41 μs      | 7.05 ± 0.21 μs      | 0.981 ± 0.065              |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0516 ± 0.014 μs   | 0.0512 ± 0.0084 μs  | 1.01 ± 0.32                |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.579 ± 0.054 μs    | 0.587 ± 0.046 μs    | 0.985 ± 0.12               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.44 ± 0.77 μs      | 5.48 ± 0.65 μs      | 0.993 ± 0.18               |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.98 ± 0.34 μs      | 4.89 ± 0.31 μs      | 1.02 ± 0.095               |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.58 ± 0.12 μs      | 2.66 ± 0.17 μs      | 0.972 ± 0.077              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.144 ± 0.0014 ms   | 0.145 ± 0.0014 ms   | 0.993 ± 0.014              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.243 ± 0.01 ms     | 0.241 ± 0.01 ms     | 1.01 ± 0.061               |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.148 ± 0.00082 ms  | 0.148 ± 0.00082 ms  | 0.998 ± 0.0078             |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.645 ± 0.0085 ms   | 0.647 ± 0.0084 ms   | 0.997 ± 0.018              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 1 ± 0.037 ms        | 1.01 ± 0.024 ms     | 0.995 ± 0.043              |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.26 ± 0.66 ms      | 4.19 ± 0.71 ms      | 1.02 ± 0.23                |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 7.7 ± 0.13 μs       | 7.9 ± 0.14 μs       | 0.974 ± 0.023              |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.18 ± 0.14 μs      | 3.3 ± 0.098 μs      | 0.963 ± 0.052              |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.615 ± 0.097 μs    | 0.64 ± 0.099 μs     | 0.96 ± 0.21                |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.87 ± 0.34 μs      | 6.1 ± 0.34 μs       | 0.962 ± 0.077              |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 29.4 ± 3.5 μs       | 29.2 ± 3.5 μs       | 1.01 ± 0.17                |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.6 ± 0.81 μs      | 18.8 ± 0.73 μs      | 0.987 ± 0.058              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.06 ± 0.4 μs       | 7.15 ± 0.24 μs      | 0.987 ± 0.065              |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0785 ± 0.018 μs   | 0.0784 ± 0.013 μs   | 1 ± 0.29                   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.635 ± 0.055 μs    | 0.642 ± 0.05 μs     | 0.99 ± 0.12                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.7 ± 0.65 μs       | 5.81 ± 0.66 μs      | 0.98 ± 0.16                |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 7.15 ± 0.9 μs       | 6.91 ± 0.93 μs      | 1.04 ± 0.19                |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.1 ± 0.44 μs      | 10.2 ± 0.51 μs      | 0.986 ± 0.066              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.0012 ms   | 0.124 ± 0.0012 ms   | 0.996 ± 0.013              |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.213 ± 0.01 ms     | 0.215 ± 0.011 ms    | 0.995 ± 0.07               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.127 ± 0.00071 ms  | 0.127 ± 0.00068 ms  | 0.999 ± 0.0077             |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.567 ± 0.01 ms     | 0.563 ± 0.0099 ms   | 1.01 ± 0.025               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.971 ± 0.043 ms    | 0.964 ± 0.031 ms    | 1.01 ± 0.055               |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.82 ± 0.7 ms       | 4.68 ± 0.69 ms      | 1.03 ± 0.21                |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.152 ± 0.0016 ms   | 0.152 ± 0.0014 ms   | 0.998 ± 0.014              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.25 ± 0.011 ms     | 0.252 ± 0.011 ms    | 0.991 ± 0.062              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.151 ± 0.00087 ms  | 0.151 ± 0.00086 ms  | 1 ± 0.0081                 |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.675 ± 0.0078 ms   | 0.674 ± 0.0073 ms   | 1 ± 0.016                  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 1.04 ± 0.038 ms     | 1.05 ± 0.027 ms     | 0.996 ± 0.044              |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.73 ± 0.67 ms      | 4.65 ± 0.68 ms      | 1.02 ± 0.21                |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 7.72 ± 0.13 μs      | 8 ± 0.13 μs         | 0.965 ± 0.023              |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.26 ± 0.15 μs      | 3.33 ± 0.095 μs     | 0.979 ± 0.054              |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.606 ± 0.096 μs    | 0.62 ± 0.1 μs       | 0.977 ± 0.22               |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 6.09 ± 0.36 μs      | 6.27 ± 0.18 μs      | 0.972 ± 0.064              |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 18.2 ± 2.1 μs       | 18.1 ± 1.6 μs       | 1 ± 0.15                   |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22.2 ± 0.84 μs      | 22.4 ± 0.77 μs      | 0.99 ± 0.051               |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 6.96 ± 0.15 μs      | 7.19 ± 0.14 μs      | 0.968 ± 0.029              |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 8.09 ± 0.11 μs      | 8.09 ± 0.13 μs      | 1 ± 0.021                  |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.98 ± 0.064 μs     | 0.984 ± 0.06 μs     | 0.995 ± 0.089              |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.42 ± 0.39 μs      | 6.63 ± 0.45 μs      | 0.968 ± 0.088              |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 18.3 ± 1.2 μs       | 18.1 ± 1 μs         | 1.01 ± 0.087               |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 28.8 ± 0.88 μs      | 0.0331 ± 0.00093 ms | 0.868 ± 0.036              |
| Baseline/Gamma/cdf                                                                  | 3.86 ± 0.45 μs      | 3.73 ± 0.45 μs      | 1.04 ± 0.17                |
| Baseline/Gamma/logpdf                                                               | 2.78 ± 0.43 μs      | 2.79 ± 0.41 μs      | 0.997 ± 0.21               |
| Baseline/Normal/cdf                                                                 | 1.66 ± 0.34 μs      | 1.57 ± 0.37 μs      | 1.06 ± 0.33                |
| Baseline/Normal/logpdf                                                              | 1.06 ± 0.045 μs     | 1.06 ± 0.042 μs     | 1 ± 0.057                  |
| Convolved/analytic/cdf batched                                                      | 2.62 ± 0.68 μs      | 2.61 ± 0.4 μs       | 1 ± 0.3                    |
| Convolved/analytic/cdf scalar                                                       | 24.5 ± 0.16 ns      | 24.5 ± 0.11 ns      | 1 ± 0.008                  |
| Convolved/analytic/construction                                                     | 3.48 ± 0.01 ns      | 3.48 ± 0.001 ns     | 1 ± 0.0029                 |
| Convolved/analytic/logpdf batched                                                   | 1.1 ± 0.038 μs      | 1.11 ± 0.042 μs     | 0.99 ± 0.051               |
| Convolved/analytic/logpdf broadcast                                                 | 2.34 ± 0.41 μs      | 2.35 ± 0.41 μs      | 0.997 ± 0.25               |
| Convolved/analytic/logpdf scalar                                                    | 27.2 ± 0.21 ns      | 27.3 ± 0.2 ns       | 0.998 ± 0.011              |
| Convolved/analytic/mean                                                             | 3.13 ± 0.01 ns      | 3.14 ± 0.01 ns      | 0.997 ± 0.0045             |
| Convolved/analytic/pdf batched                                                      | 1.1 ± 0.044 μs      | 1.1 ± 0.038 μs      | 1 ± 0.053                  |
| Convolved/analytic/pdf scalar                                                       | 30.8 ± 0.1 ns       | 30.8 ± 0.16 ns      | 0.999 ± 0.0062             |
| Convolved/analytic/rand                                                             | 1.26 ± 0.067 μs     | 1.26 ± 0.068 μs     | 1 ± 0.076                  |
| Convolved/numeric/cdf batched                                                       | 0.841 ± 0.0044 ms   | 0.841 ± 0.005 ms    | 1 ± 0.0079                 |
| Convolved/numeric/cdf scalar                                                        | 16.1 ± 0.12 μs      | 15.4 ± 0.06 μs      | 1.05 ± 0.0088              |
| Convolved/numeric/construction                                                      | 3.48 ± 0.001 ns     | 3.48 ± 0.001 ns     | 1 ± 0.00041                |
| Convolved/numeric/logpdf batched                                                    | 0.653 ± 0.0085 ms   | 0.652 ± 0.0082 ms   | 1 ± 0.018                  |
| Convolved/numeric/logpdf broadcast                                                  | 1.2 ± 0.011 ms      | 1.2 ± 0.011 ms      | 1 ± 0.012                  |
| Convolved/numeric/logpdf scalar                                                     | 11.2 ± 0.03 μs      | 11.2 ± 0.06 μs      | 1 ± 0.006                  |
| Convolved/numeric/mean                                                              | 5.99 ± 0.06 ns      | 5.98 ± 0.03 ns      | 1 ± 0.011                  |
| Convolved/numeric/pdf batched                                                       | 0.653 ± 0.0087 ms   | 0.65 ± 0.0086 ms    | 1 ± 0.019                  |
| Convolved/numeric/pdf scalar                                                        | 11.2 ± 0.03 μs      | 11.2 ± 0.06 μs      | 1 ± 0.006                  |
| Convolved/numeric/rand                                                              | 2.76 ± 0.43 μs      | 2.76 ± 0.42 μs      | 1 ± 0.22                   |
| Difference/analytic/cdf broadcast                                                   | 3.56 ± 0.43 μs      | 3.55 ± 0.42 μs      | 1 ± 0.17                   |
| Difference/analytic/cdf scalar                                                      | 12.4 ± 0.019 ns     | 12.4 ± 0.021 ns     | 1 ± 0.0023                 |
| Difference/analytic/construction                                                    | 3.5 ± 0.001 ns      | 3.84 ± 0.001 ns     | 0.914 ± 0.00035            |
| Difference/analytic/logpdf broadcast                                                | 1.52 ± 0.37 μs      | 1.53 ± 0.37 μs      | 0.999 ± 0.34               |
| Difference/analytic/logpdf scalar                                                   | 17.3 ± 0.15 ns      | 17.3 ± 0.4 ns       | 1 ± 0.025                  |
| Difference/analytic/mean                                                            | 3.13 ± 0.01 ns      | 3.14 ± 0.01 ns      | 0.997 ± 0.0045             |
| Difference/analytic/rand                                                            | 1.27 ± 0.067 μs     | 1.26 ± 0.069 μs     | 1.01 ± 0.077               |
| Difference/numeric/cdf broadcast                                                    | 1.32 ± 0.023 ms     | 1.31 ± 0.023 ms     | 1.01 ± 0.025               |
| Difference/numeric/cdf scalar                                                       | 20.2 ± 0.071 μs     | 19.5 ± 0.11 μs      | 1.04 ± 0.0069              |
| Difference/numeric/construction                                                     | 3.84 ± 0.001 ns     | 3.5 ± 0.001 ns      | 1.09 ± 0.00042             |
| Difference/numeric/logpdf broadcast                                                 | 1.51 ± 0.022 ms     | 1.51 ± 0.021 ms     | 1 ± 0.02                   |
| Difference/numeric/logpdf scalar                                                    | 15.2 ± 0.071 μs     | 15.1 ± 0.12 μs      | 1.01 ± 0.0094              |
| Difference/numeric/mean                                                             | 6.03 ± 0.011 ns     | 6.04 ± 0.02 ns      | 0.998 ± 0.0038             |
| Difference/numeric/rand                                                             | 2.77 ± 0.42 μs      | 2.76 ± 0.42 μs      | 1 ± 0.22                   |
| Product/analytic/cdf broadcast                                                      | 5.1 ± 0.062 μs      | 5.1 ± 0.058 μs      | 1 ± 0.017                  |
| Product/analytic/cdf scalar                                                         | 29 ± 0.11 ns        | 29 ± 0.15 ns        | 1 ± 0.0064                 |
| Product/analytic/construction                                                       | 3.84 ± 0.01 ns      | 3.84 ± 0.001 ns     | 1 ± 0.0026                 |
| Product/analytic/logpdf broadcast                                                   | 2.19 ± 0.41 μs      | 2.19 ± 0.4 μs       | 1 ± 0.26                   |
| Product/analytic/logpdf scalar                                                      | 24.3 ± 0.5 ns       | 24.4 ± 0.2 ns       | 0.999 ± 0.022              |
| Product/analytic/mean                                                               | 10.2 ± 0.02 ns      | 10.2 ± 0.039 ns     | 0.999 ± 0.0043             |
| Product/analytic/rand                                                               | 1.71 ± 0.38 μs      | 1.7 ± 0.36 μs       | 1.01 ± 0.31                |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.022 ms     | 1.97 ± 0.021 ms     | 1 ± 0.015                  |
| Product/numeric/cdf scalar                                                          | 24.2 ± 0.21 μs      | 23.3 ± 0.14 μs      | 1.04 ± 0.011               |
| Product/numeric/construction                                                        | 3.5 ± 0.001 ns      | 3.84 ± 0.01 ns      | 0.914 ± 0.0024             |
| Product/numeric/logpdf broadcast                                                    | 1.62 ± 0.023 ms     | 1.62 ± 0.02 ms      | 1 ± 0.019                  |
| Product/numeric/logpdf scalar                                                       | 15.9 ± 0.11 μs      | 15.9 ± 0.13 μs      | 1 ± 0.011                  |
| Product/numeric/mean                                                                | 6.29 ± 0.01 ns      | 6.13 ± 0.02 ns      | 1.03 ± 0.0037              |
| Product/numeric/rand                                                                | 2.76 ± 0.42 μs      | 2.77 ± 0.42 μs      | 0.999 ± 0.22               |
| Quantile/Convolved analytic/grid                                                    | 0.593 ± 0.095 ms    | 0.594 ± 0.1 ms      | 0.998 ± 0.24               |
| Quantile/Convolved analytic/median                                                  | 22.4 ± 0.95 μs      | 22.4 ± 0.96 μs      | 1 ± 0.06                   |
| Quantile/Convolved numeric/median                                                   | 0.285 ± 0.0088 ms   | 0.282 ± 0.0087 ms   | 1.01 ± 0.044               |
| Quantile/Difference numeric/median                                                  | 0.343 ± 0.01 ms     | 0.341 ± 0.0097 ms   | 1.01 ± 0.041               |
| Quantile/Product numeric/median                                                     | 0.501 ± 0.012 ms    | 0.497 ± 0.012 ms    | 1.01 ± 0.034               |
| Timeseries/Convolved delay                                                          | 0.38 ± 0.014 μs     | 0.376 ± 0.014 μs    | 1.01 ± 0.052               |
| Timeseries/Gamma delay                                                              | 0.379 ± 0.015 μs    | 0.376 ± 0.015 μs    | 1.01 ± 0.056               |
| Timeseries/Poisson delay                                                            | 1.35 ± 0.042 μs     | 1.35 ± 0.034 μs     | 1 ± 0.04                   |
| time_to_load                                                                        | 0.901 ± 0.012 s     | 0.902 ± 0.013 s     | 0.998 ± 0.019              |

|                                                                                     | v0.2.0                    | d20eef3e4842a5...         | v0.2.0 / d20eef3e4842a5... |
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

