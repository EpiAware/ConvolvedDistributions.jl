|                                                                                     | v0.3.1            | v0.3.0            | v0.2.0            | cfcda7ac7beea8...   |
|:------------------------------------------------------------------------------------|:-----------------:|:-----------------:|:-----------------:|:-------------------:|
| Baseline/Gamma/cdf                                                                  | 2.44 ± 0.23 μs    | 2.41 ± 0.23 μs    | 2.36 ± 0.22 μs    | 2.4 ± 0.23 μs       |
| Baseline/Gamma/logpdf                                                               | 1.97 ± 0.25 μs    | 1.98 ± 0.26 μs    | 1.98 ± 0.26 μs    | 1.97 ± 0.24 μs      |
| Baseline/Normal/cdf                                                                 | 1.23 ± 0.24 μs    | 1.19 ± 0.23 μs    | 1.19 ± 0.22 μs    | 1.16 ± 0.22 μs      |
| Baseline/Normal/logpdf                                                              | 0.505 ± 0.27 μs   | 0.499 ± 0.26 μs   | 0.501 ± 0.26 μs   | 0.756 ± 0.017 μs    |
| Convolved/analytic/cdf batched                                                      | 2 ± 0.24 μs       | 2 ± 0.24 μs       | 1.99 ± 0.24 μs    | 1.97 ± 0.24 μs      |
| Convolved/analytic/cdf scalar                                                       | 16.5 ± 0.025 ns   | 16.5 ± 0.045 ns   | 16.5 ± 0.031 ns   | 16.5 ± 0.027 ns     |
| Convolved/analytic/construction                                                     | 2.24 ± 0.004 ns   | 2.54 ± 0.018 ns   | 2.24 ± 0.004 ns   | 2.25 ± 0.009 ns     |
| Convolved/analytic/logpdf batched                                                   | 0.493 ± 0.058 μs  | 0.497 ± 0.053 μs  | 0.494 ± 0.045 μs  | 0.764 ± 0.016 μs    |
| Convolved/analytic/logpdf broadcast                                                 | 1.79 ± 0.24 μs    | 1.79 ± 0.24 μs    | 1.83 ± 0.26 μs    | 1.84 ± 0.24 μs      |
| Convolved/analytic/logpdf scalar                                                    | 16 ± 0.069 ns     | 16 ± 0.074 ns     | 16 ± 0.036 ns     | 16 ± 0.039 ns       |
| Convolved/analytic/mean                                                             | 1.97 ± 0.003 ns   | 2.25 ± 0.007 ns   | 2.24 ± 0.003 ns   | 2.25 ± 0.008 ns     |
| Convolved/analytic/pdf batched                                                      | 0.512 ± 0.27 μs   | 0.511 ± 0.26 μs   | 0.51 ± 0.26 μs    | 0.779 ± 0.016 μs    |
| Convolved/analytic/pdf scalar                                                       | 16.3 ± 0.025 ns   | 16.2 ± 0.024 ns   | 16.2 ± 0.023 ns   | 16.3 ± 0.044 ns     |
| Convolved/analytic/rand                                                             | 0.834 ± 0.26 μs   | 0.805 ± 0.26 μs   | 0.782 ± 0.26 μs   | 0.985 ± 0.017 μs    |
| Convolved/numeric/cdf batched                                                       | 0.562 ± 0.0045 ms | 0.564 ± 0.0045 ms | 0.565 ± 0.0044 ms | 0.871 ± 0.0013 ms   |
| Convolved/numeric/cdf scalar                                                        | 12.2 ± 0.048 μs   | 12.2 ± 0.038 μs   | 12.3 ± 0.057 μs   | 12.2 ± 0.042 μs     |
| Convolved/numeric/construction                                                      | 2.25 ± 0.004 ns   | 2.53 ± 0.008 ns   | 2.25 ± 0.003 ns   | 2.25 ± 0.004 ns     |
| Convolved/numeric/logpdf batched                                                    | 0.445 ± 0.0066 ms | 0.444 ± 0.0052 ms | 0.444 ± 0.0061 ms | 0.445 ± 0.0058 ms   |
| Convolved/numeric/logpdf broadcast                                                  | 0.771 ± 0.0087 ms | 0.768 ± 0.0086 ms | 0.769 ± 0.0087 ms | 0.771 ± 0.0088 ms   |
| Convolved/numeric/logpdf scalar                                                     | 7.15 ± 0.065 μs   | 7.13 ± 0.018 μs   | 7.14 ± 0.057 μs   | 7.14 ± 0.046 μs     |
| Convolved/numeric/mean                                                              | 4.1 ± 0.01 ns     | 4.21 ± 0.009 ns   | 4.11 ± 0.01 ns    | 4.09 ± 0.012 ns     |
| Convolved/numeric/pdf batched                                                       | 0.444 ± 0.0058 ms | 0.444 ± 0.0053 ms | 0.444 ± 0.0054 ms | 0.444 ± 0.005 ms    |
| Convolved/numeric/pdf scalar                                                        | 7.15 ± 0.067 μs   | 7.12 ± 0.018 μs   | 7.13 ± 0.03 μs    | 7.13 ± 0.041 μs     |
| Convolved/numeric/rand                                                              | 2.21 ± 0.28 μs    | 2.22 ± 0.28 μs    | 2.22 ± 0.28 μs    | 2.19 ± 0.28 μs      |
| Difference/analytic/cdf broadcast                                                   | 2.64 ± 0.25 μs    | 2.63 ± 0.27 μs    | 2.65 ± 0.25 μs    | 2.74 ± 0.25 μs      |
| Difference/analytic/cdf scalar                                                      | 9.16 ± 0.015 ns   | 9.16 ± 0.014 ns   | 9.16 ± 0.016 ns   | 9.04 ± 0.014 ns     |
| Difference/analytic/construction                                                    | 2.54 ± 0.026 ns   | 2.52 ± 0.005 ns   | 2.81 ± 0.012 ns   | 2.25 ± 0.006 ns     |
| Difference/analytic/logpdf broadcast                                                | 1.14 ± 0.26 μs    | 1.15 ± 0.24 μs    | 1.16 ± 0.25 μs    | 1.26 ± 0.056 μs     |
| Difference/analytic/logpdf scalar                                                   | 11.1 ± 0.034 ns   | 11.1 ± 0.019 ns   | 11.1 ± 0.023 ns   | 11.1 ± 0.031 ns     |
| Difference/analytic/mean                                                            | 2.26 ± 0.012 ns   | 1.96 ± 0.003 ns   | 2.24 ± 0.003 ns   | 2.25 ± 0.005 ns     |
| Difference/analytic/rand                                                            | 0.723 ± 0.27 μs   | 0.715 ± 0.19 μs   | 0.718 ± 0.21 μs   | 0.985 ± 0.017 μs    |
| Difference/numeric/cdf broadcast                                                    | 1.09 ± 0.014 ms   | 1.09 ± 0.014 ms   | 1.09 ± 0.014 ms   | 1.1 ± 0.012 ms      |
| Difference/numeric/cdf scalar                                                       | 15.5 ± 0.06 μs    | 15.5 ± 0.051 μs   | 15.5 ± 0.061 μs   | 15.5 ± 0.066 μs     |
| Difference/numeric/construction                                                     | 2.25 ± 0.005 ns   | 2.52 ± 0.004 ns   | 2.81 ± 0.016 ns   | 2.26 ± 0.28 ns      |
| Difference/numeric/logpdf broadcast                                                 | 0.953 ± 0.016 ms  | 0.952 ± 0.016 ms  | 0.951 ± 0.016 ms  | 0.954 ± 0.013 ms    |
| Difference/numeric/logpdf scalar                                                    | 9.56 ± 0.083 μs   | 9.54 ± 0.048 μs   | 9.54 ± 0.062 μs   | 9.55 ± 0.07 μs      |
| Difference/numeric/mean                                                             | 4.1 ± 0.011 ns    | 4.49 ± 0.008 ns   | 4.2 ± 0.007 ns    | 4.11 ± 0.049 ns     |
| Difference/numeric/rand                                                             | 2.22 ± 0.28 μs    | 2.11 ± 0.28 μs    | 2.21 ± 0.28 μs    | 2.18 ± 0.27 μs      |
| Product/analytic/cdf broadcast                                                      | 3.68 ± 0.28 μs    | 3.69 ± 0.28 μs    | 3.69 ± 0.27 μs    | 3.7 ± 0.27 μs       |
| Product/analytic/cdf scalar                                                         | 17.6 ± 0.049 ns   | 17.6 ± 0.065 ns   | 17.6 ± 0.039 ns   | 17.6 ± 0.043 ns     |
| Product/analytic/construction                                                       | 2.52 ± 0.28 ns    | 2.25 ± 0.044 ns   | 2.25 ± 0.003 ns   | 2.53 ± 0.008 ns     |
| Product/analytic/logpdf broadcast                                                   | 1.45 ± 0.22 μs    | 1.45 ± 0.22 μs    | 1.45 ± 0.22 μs    | 1.48 ± 0.21 μs      |
| Product/analytic/logpdf scalar                                                      | 13.6 ± 0.02 ns    | 13.6 ± 0.021 ns   | 13.6 ± 0.02 ns    | 13.6 ± 0.02 ns      |
| Product/analytic/mean                                                               | 7.53 ± 0.56 ns    | 6.98 ± 0.011 ns   | 7.53 ± 0.55 ns    | 7.53 ± 0.56 ns      |
| Product/analytic/rand                                                               | 3.29 ± 0.29 μs    | 3.29 ± 0.29 μs    | 3.29 ± 0.28 μs    | 3.28 ± 0.27 μs      |
| Product/numeric/cdf broadcast                                                       | 1.21 ± 0.016 ms   | 1.21 ± 0.016 ms   | 1.21 ± 0.017 ms   | 1.22 ± 0.013 ms     |
| Product/numeric/cdf scalar                                                          | 14.6 ± 0.069 μs   | 14.6 ± 0.063 μs   | 14.8 ± 0.11 μs    | 14.7 ± 0.078 μs     |
| Product/numeric/construction                                                        | 2.54 ± 0.027 ns   | 2.52 ± 0.004 ns   | 2.25 ± 0.009 ns   | 2.25 ± 0.009 ns     |
| Product/numeric/logpdf broadcast                                                    | 1.02 ± 0.013 ms   | 1.02 ± 0.014 ms   | 1.03 ± 0.015 ms   | 1.03 ± 0.013 ms     |
| Product/numeric/logpdf scalar                                                       | 10.2 ± 0.067 μs   | 10.1 ± 0.054 μs   | 10.1 ± 0.053 μs   | 10.1 ± 0.068 μs     |
| Product/numeric/mean                                                                | 4.2 ± 0.008 ns    | 4.2 ± 0.008 ns    | 4.1 ± 0.009 ns    | 4.2 ± 0.007 ns      |
| Product/numeric/rand                                                                | 2.22 ± 0.28 μs    | 2.23 ± 0.28 μs    | 2.22 ± 0.28 μs    | 2.15 ± 0.28 μs      |
| Quantile/Convolved analytic/grid                                                    | 0.433 ± 0.015 ms  | 0.427 ± 0.015 ms  | 0.429 ± 0.016 ms  | 0.504 ± 0.059 ms    |
| Quantile/Convolved analytic/median                                                  | 20.3 ± 3.2 μs     | 20.1 ± 3.3 μs     | 20.2 ± 3.3 μs     | 20.3 ± 0.62 μs      |
| Quantile/Convolved numeric/median                                                   | 0.232 ± 0.0059 ms | 0.232 ± 0.0059 ms | 0.232 ± 0.0058 ms | 0.23 ± 0.004 ms     |
| Quantile/Difference numeric/median                                                  | 0.267 ± 0.0061 ms | 0.268 ± 0.006 ms  | 0.268 ± 0.0062 ms | 0.267 ± 0.0056 ms   |
| Quantile/Product numeric/median                                                     | 0.316 ± 0.0066 ms | 0.315 ± 0.0067 ms | 0.316 ± 0.0067 ms | 0.317 ± 0.0058 ms   |
| Timeseries/Convolved delay                                                          | 0.174 ± 0.081 μs  | 0.166 ± 0.079 μs  | 0.167 ± 0.078 μs  | 0.255 ± 0.0056 μs   |
| Timeseries/Gamma delay                                                              | 0.173 ± 0.081 μs  | 0.166 ± 0.078 μs  | 0.167 ± 0.079 μs  | 0.254 ± 0.0065 μs   |
| Timeseries/Poisson delay                                                            | 1.1 ± 0.16 μs     | 1.1 ± 0.16 μs     | 1.1 ± 0.15 μs     | 1.04 ± 0.14 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                |                   |                   |                   | 5.35 ± 0.097 μs     |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        |                   |                   |                   | 0.446 ± 0.057 μs    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 |                   |                   |                   | 1.91 ± 0.15 ms      |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  |                   |                   |                   | 13.1 ± 0.62 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              |                   |                   |                   | 0.163 ± 0.0052 ms   |
| AD gradients/Timeseries convolve time-varying Poisson delays/Enzyme reverse         |                   |                   |                   | 7.42 ± 0.22 μs      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     |                   |                   |                   | 0.0869 ± 0.0029 ms  |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 |                   |                   |                   | 0.689 ± 0.071 μs    |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    |                   |                   |                   | 4.36 ± 0.37 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              |                   |                   |                   | 4.27 ± 0.53 μs      |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        |                   |                   |                   | 0.0481 ± 0.00013 ms |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    |                   |                   |                   | 19.9 ± 2.6 μs       |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 |                   |                   |                   | 1.85 ± 0.14 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                |                   |                   |                   | 0.0378 ± 0.0067 μs  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        |                   |                   |                   | 0.0443 ± 0.00067 ms |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            |                   |                   |                   | 0.561 ± 0.072 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            |                   |                   |                   | 0.361 ± 0.0053 ms   |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         |                   |                   |                   | 0.468 ± 0.055 μs    |
| AD gradients/Timeseries convolve time-varying PMF matrix/Enzyme reverse             |                   |                   |                   | 8.49 ± 1.4 μs       |
| AD gradients/Timeseries convolve time-varying PMF matrix/Mooncake forward           |                   |                   |                   | 6.11 ± 0.79 μs      |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   |                   |                   |                   | 0.417 ± 0.051 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          |                   |                   |                   | 3.25 ± 0.26 ms      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              |                   |                   |                   | 5.06 ± 0.84 μs      |
| AD gradients/Timeseries convolve time-varying Poisson delays/ForwardDiff            |                   |                   |                   | 1.99 ± 0.35 μs      |
| AD gradients/Timeseries convolve time-varying PMF matrix/ForwardDiff                |                   |                   |                   | 0.808 ± 0.091 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             |                   |                   |                   | 2.05 ± 0.13 μs      |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     |                   |                   |                   | 6.04 ± 0.048 μs     |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 |                   |                   |                   | 0.0367 ± 0.0044 μs  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            |                   |                   |                   | 0.461 ± 0.0052 ms   |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      |                   |                   |                   | 2.69 ± 0.051 μs     |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            |                   |                   |                   | 8.49 ± 0.35 μs      |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   |                   |                   |                   | 0.394 ± 0.057 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     |                   |                   |                   | 0.383 ± 0.022 ms    |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 |                   |                   |                   | 13.9 ± 0.79 μs      |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   |                   |                   |                   | 4.15 ± 0.38 μs      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               |                   |                   |                   | 0.479 ± 0.0052 ms   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 |                   |                   |                   | 0.0839 ± 0.00034 ms |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              |                   |                   |                   | 0.889 ± 0.031 μs    |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                |                   |                   |                   | 5.34 ± 0.074 μs     |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              |                   |                   |                   | 0.104 ± 0.00071 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 |                   |                   |                   | 0.149 ± 0.0057 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     |                   |                   |                   | 0.0585 ± 0.0016 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              |                   |                   |                   | 0.0817 ± 0.00065 ms |
| AD gradients/Timeseries convolve time-varying Poisson delays/ReverseDiff (tape)     |                   |                   |                   | 0.0527 ± 0.0072 ms  |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   |                   |                   |                   | 19.7 ± 2.3 μs       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   |                   |                   |                   | 0.41 ± 0.064 ms     |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                |                   |                   |                   | 4.32 ± 0.38 μs      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 |                   |                   |                   | 0.107 ± 0.00077 ms  |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     |                   |                   |                   | 0.104 ± 0.0029 ms   |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              |                   |                   |                   | 3.93 ± 0.5 μs       |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              |                   |                   |                   | 3.45 ± 0.22 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              |                   |                   |                   | 5.37 ± 0.062 μs     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              |                   |                   |                   | 0.145 ± 0.0057 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) |                   |                   |                   | 1.72 ± 0.15 ms      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               |                   |                   |                   | 0.587 ± 0.073 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 |                   |                   |                   | 0.0853 ± 0.00062 ms |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 |                   |                   |                   | 0.174 ± 0.0058 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            |                   |                   |                   | 0.597 ± 0.07 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   |                   |                   |                   | 0.378 ± 0.006 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     |                   |                   |                   | 0.0503 ± 0.00028 ms |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             |                   |                   |                   | 3.62 ± 0.23 ms      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    |                   |                   |                   | 0.102 ± 0.00032 ms  |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            |                   |                   |                   | 4.59 ± 0.58 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                |                   |                   |                   | 12.5 ± 0.68 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   |                   |                   |                   | 0.465 ± 0.029 μs    |
| AD gradients/Timeseries convolve time-varying PMF matrix/Enzyme forward             |                   |                   |                   | 5.5 ± 0.099 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  |                   |                   |                   | 2.71 ± 0.054 μs     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   |                   |                   |                   | 0.179 ± 0.0033 ms   |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            |                   |                   |                   | 2.06 ± 0.12 μs      |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        |                   |                   |                   | 0.0604 ± 0.00015 ms |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              |                   |                   |                   | 16.8 ± 0.93 μs      |
| AD gradients/Timeseries convolve time-varying Poisson delays/Mooncake reverse       |                   |                   |                   | 0.0631 ± 0.0075 ms  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      |                   |                   |                   | 6.07 ± 0.052 μs     |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    |                   |                   |                   | 0.425 ± 0.025 μs    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) |                   |                   |                   | 1.92 ± 0.15 ms      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             |                   |                   |                   | 3.64 ± 0.26 ms      |
| AD gradients/Timeseries convolve time-varying Poisson delays/Enzyme forward         |                   |                   |                   | 7.23 ± 0.31 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 |                   |                   |                   | 0.0999 ± 0.00036 ms |
| AD gradients/Timeseries convolve time-varying PMF matrix/Mooncake reverse           |                   |                   |                   | 28.4 ± 5.2 μs       |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     |                   |                   |                   | 0.0663 ± 0.00044 ms |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          |                   |                   |                   | 23.6 ± 0.66 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     |                   |                   |                   | 0.434 ± 0.057 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               |                   |                   |                   | 3.49 ± 0.24 μs      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               |                   |                   |                   | 0.617 ± 0.073 ms    |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            |                   |                   |                   | 13 ± 0.75 μs        |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               |                   |                   |                   | 0.378 ± 0.0051 ms   |
| AD gradients/Timeseries convolve time-varying PMF matrix/ReverseDiff (tape)         |                   |                   |                   | 13.9 ± 0.74 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                |                   |                   |                   | 0.0537 ± 0.0075 μs  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     |                   |                   |                   | 0.381 ± 0.023 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     |                   |                   |                   | 0.0443 ± 0.0014 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    |                   |                   |                   | 0.0843 ± 0.00031 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        |                   |                   |                   | 0.0348 ± 0.00025 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   |                   |                   |                   | 0.418 ± 0.063 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          |                   |                   |                   | 3.26 ± 0.26 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   |                   |                   |                   | 0.426 ± 0.027 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               |                   |                   |                   | 3.95 ± 0.5 μs       |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     |                   |                   |                   | 2.62 ± 0.049 μs     |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   |                   |                   |                   | 0.203 ± 0.0022 ms   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  |                   |                   |                   | 6.04 ± 0.053 μs     |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   |                   |                   |                   | 0.269 ± 0.005 ms    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 |                   |                   |                   | 5.33 ± 0.13 μs      |
| AD gradients/Timeseries convolve time-varying Poisson delays/Mooncake forward       |                   |                   |                   | 13.7 ± 0.56 μs      |
| time_to_load                                                                        | 0.739 ± 0.0021 s  | 0.729 ± 0.0088 s  | 0.73 ± 0.003 s    | 0.723 ± 0.0057 s    |

|                                                                                     | v0.3.1                    | v0.3.0                    | v0.2.0                    | cfcda7ac7beea8...         |
|:------------------------------------------------------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
| Baseline/Gamma/cdf                                                                  | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Baseline/Gamma/logpdf                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Baseline/Normal/cdf                                                                 | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Baseline/Normal/logpdf                                                              | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Convolved/analytic/cdf batched                                                      | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Convolved/analytic/cdf scalar                                                       | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/analytic/construction                                                     | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/analytic/logpdf batched                                                   | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Convolved/analytic/logpdf broadcast                                                 | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Convolved/analytic/logpdf scalar                                                    | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/analytic/mean                                                             | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/analytic/pdf batched                                                      | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Convolved/analytic/pdf scalar                                                       | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/analytic/rand                                                             | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Convolved/numeric/cdf batched                                                       | 24  allocs: 8.32 kB       | 24  allocs: 8.32 kB       | 24  allocs: 8.32 kB       | 24  allocs: 8.32 kB       |
| Convolved/numeric/cdf scalar                                                        | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       |
| Convolved/numeric/construction                                                      | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/numeric/logpdf batched                                                    | 25  allocs: 8.41 kB       | 25  allocs: 8.41 kB       | 25  allocs: 8.41 kB       | 25  allocs: 8.41 kB       |
| Convolved/numeric/logpdf broadcast                                                  | 0.338 k allocs: 29.8 kB   | 0.338 k allocs: 29.8 kB   | 0.338 k allocs: 29.8 kB   | 0.338 k allocs: 29.8 kB   |
| Convolved/numeric/logpdf scalar                                                     | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       |
| Convolved/numeric/mean                                                              | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Convolved/numeric/pdf batched                                                       | 23  allocs: 7.5 kB        | 23  allocs: 7.5 kB        | 23  allocs: 7.5 kB        | 23  allocs: 7.5 kB        |
| Convolved/numeric/pdf scalar                                                        | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       | 3  allocs: 0.172 kB       |
| Convolved/numeric/rand                                                              | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Difference/analytic/cdf broadcast                                                   | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Difference/analytic/cdf scalar                                                      | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Difference/analytic/construction                                                    | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Difference/analytic/logpdf broadcast                                                | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Difference/analytic/logpdf scalar                                                   | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Difference/analytic/mean                                                            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Difference/analytic/rand                                                            | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Difference/numeric/cdf broadcast                                                    | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB |
| Difference/numeric/cdf scalar                                                       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       |
| Difference/numeric/construction                                                     | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Difference/numeric/logpdf broadcast                                                 | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB |
| Difference/numeric/logpdf scalar                                                    | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       |
| Difference/numeric/mean                                                             | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Difference/numeric/rand                                                             | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Product/analytic/cdf broadcast                                                      | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Product/analytic/cdf scalar                                                         | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Product/analytic/construction                                                       | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Product/analytic/logpdf broadcast                                                   | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Product/analytic/logpdf scalar                                                      | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Product/analytic/mean                                                               | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Product/analytic/rand                                                               | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Product/numeric/cdf broadcast                                                       | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB |
| Product/numeric/cdf scalar                                                          | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       |
| Product/numeric/construction                                                        | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Product/numeric/logpdf broadcast                                                    | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB | 0.402 k allocs: 0.0467 MB |
| Product/numeric/logpdf scalar                                                       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       | 4  allocs: 0.469 kB       |
| Product/numeric/mean                                                                | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            | 0  allocs: 0 B            |
| Product/numeric/rand                                                                | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       | 2  allocs: 0.906 kB       |
| Quantile/Convolved analytic/grid                                                    | 6.03 k allocs: 0.353 MB   | 6.03 k allocs: 0.353 MB   | 6.03 k allocs: 0.353 MB   | 6.03 k allocs: 0.353 MB   |
| Quantile/Convolved analytic/median                                                  | 0.281 k allocs: 17.1 kB   | 0.281 k allocs: 17.1 kB   | 0.281 k allocs: 17.1 kB   | 0.281 k allocs: 17.1 kB   |
| Quantile/Convolved numeric/median                                                   | 0.355 k allocs: 21.1 kB   | 0.355 k allocs: 21.1 kB   | 0.355 k allocs: 21.1 kB   | 0.355 k allocs: 21.1 kB   |
| Quantile/Difference numeric/median                                                  | 0.318 k allocs: 23.2 kB   | 0.318 k allocs: 23.2 kB   | 0.318 k allocs: 23.2 kB   | 0.318 k allocs: 23.2 kB   |
| Quantile/Product numeric/median                                                     | 0.397 k allocs: 28.4 kB   | 0.397 k allocs: 28.4 kB   | 0.397 k allocs: 28.4 kB   | 0.397 k allocs: 28.4 kB   |
| Timeseries/Convolved delay                                                          | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       |
| Timeseries/Gamma delay                                                              | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       |
| Timeseries/Poisson delay                                                            | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                |                           |                           |                           | 0.032 k allocs: 1.3 kB    |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        |                           |                           |                           | 7  allocs: 0.266 kB       |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 |                           |                           |                           | 31.1 k allocs: 1.29 MB    |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  |                           |                           |                           | 0.238 k allocs: 9.92 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              |                           |                           |                           | 0.159 k allocs: 23.2 kB   |
| AD gradients/Timeseries convolve time-varying Poisson delays/Enzyme reverse         |                           |                           |                           | 0.104 k allocs: 5.53 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     |                           |                           |                           | 0.147 k allocs: 18.8 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 |                           |                           |                           | 11  allocs: 0.547 kB      |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    |                           |                           |                           | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              |                           |                           |                           | 0.07 k allocs: 3.33 kB    |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        |                           |                           |                           | 21  allocs: 1.03 kB       |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    |                           |                           |                           | 0.289 k allocs: 0.0329 MB |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 |                           |                           |                           | 30.2 k allocs: 1.26 MB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                |                           |                           |                           | 2  allocs: 0.0938 kB      |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        |                           |                           |                           | 0.081 k allocs: 7.2 kB    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            |                           |                           |                           | 2.46 k allocs: 1.03 MB    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            |                           |                           |                           | 0.178 k allocs: 17 kB     |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         |                           |                           |                           | 7  allocs: 0.266 kB       |
| AD gradients/Timeseries convolve time-varying PMF matrix/Enzyme reverse             |                           |                           |                           | 0.13 k allocs: 6.89 kB    |
| AD gradients/Timeseries convolve time-varying PMF matrix/Mooncake forward           |                           |                           |                           | 0.088 k allocs: 5.52 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   |                           |                           |                           | 2.37 k allocs: 0.633 MB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          |                           |                           |                           | 0.0532 M allocs: 2.07 MB  |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              |                           |                           |                           | 0.093 k allocs: 5.09 kB   |
| AD gradients/Timeseries convolve time-varying Poisson delays/ForwardDiff            |                           |                           |                           | 0.037 k allocs: 2.44 kB   |
| AD gradients/Timeseries convolve time-varying PMF matrix/ForwardDiff                |                           |                           |                           | 16  allocs: 1.14 kB       |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             |                           |                           |                           | 0.041 k allocs: 1.7 kB    |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     |                           |                           |                           | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 |                           |                           |                           | 2  allocs: 0.0938 kB      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            |                           |                           |                           | 0.178 k allocs: 17 kB     |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      |                           |                           |                           | 24  allocs: 1.03 kB       |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            |                           |                           |                           | 0.127 k allocs: 5.25 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   |                           |                           |                           | 2.35 k allocs: 0.639 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     |                           |                           |                           | 1.35 k allocs: 0.168 MB   |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 |                           |                           |                           | 0.268 k allocs: 10.9 kB   |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   |                           |                           |                           | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               |                           |                           |                           | 0.178 k allocs: 17 kB     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 |                           |                           |                           | 27  allocs: 2.61 kB       |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              |                           |                           |                           | 10  allocs: 0.5 kB        |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                |                           |                           |                           | 0.032 k allocs: 1.3 kB    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              |                           |                           |                           | 0.096 k allocs: 8.14 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 |                           |                           |                           | 0.159 k allocs: 23.1 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     |                           |                           |                           | 0.151 k allocs: 22.6 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              |                           |                           |                           | 0.096 k allocs: 8.14 kB   |
| AD gradients/Timeseries convolve time-varying Poisson delays/ReverseDiff (tape)     |                           |                           |                           | 1.02 k allocs: 0.0418 MB  |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   |                           |                           |                           | 0.289 k allocs: 0.0331 MB |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   |                           |                           |                           | 2.07 k allocs: 0.665 MB   |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                |                           |                           |                           | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 |                           |                           |                           | 0.096 k allocs: 8.14 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     |                           |                           |                           | 0.147 k allocs: 18.8 kB   |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              |                           |                           |                           | 0.07 k allocs: 3.33 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              |                           |                           |                           | 0.078 k allocs: 3.71 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              |                           |                           |                           | 0.033 k allocs: 1.2 kB    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              |                           |                           |                           | 0.159 k allocs: 23.1 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) |                           |                           |                           | 28.5 k allocs: 1.2 MB     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               |                           |                           |                           | 2.57 k allocs: 1.15 MB    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 |                           |                           |                           | 0.096 k allocs: 8.14 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 |                           |                           |                           | 0.159 k allocs: 23.2 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            |                           |                           |                           | 2.46 k allocs: 1.03 MB    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   |                           |                           |                           | 0.519 k allocs: 0.0521 MB |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     |                           |                           |                           | 0.078 k allocs: 3.41 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             |                           |                           |                           | 0.058 M allocs: 2.44 MB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    |                           |                           |                           | 27  allocs: 2.61 kB       |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            |                           |                           |                           | 0.068 k allocs: 3.58 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                |                           |                           |                           | 0.27 k allocs: 12.5 kB    |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   |                           |                           |                           | 7  allocs: 0.484 kB       |
| AD gradients/Timeseries convolve time-varying PMF matrix/Enzyme forward             |                           |                           |                           | 0.043 k allocs: 2.17 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  |                           |                           |                           | 24  allocs: 1.02 kB       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   |                           |                           |                           | 0.264 k allocs: 27.2 kB   |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            |                           |                           |                           | 0.041 k allocs: 1.7 kB    |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        |                           |                           |                           | 21  allocs: 1.03 kB       |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              |                           |                           |                           | 0.298 k allocs: 12 kB     |
| AD gradients/Timeseries convolve time-varying Poisson delays/Mooncake reverse       |                           |                           |                           | 0.865 k allocs: 0.0638 MB |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      |                           |                           |                           | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    |                           |                           |                           | 7  allocs: 0.484 kB       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) |                           |                           |                           | 0.0327 M allocs: 1.23 MB  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             |                           |                           |                           | 0.058 M allocs: 2.44 MB   |
| AD gradients/Timeseries convolve time-varying Poisson delays/Enzyme forward         |                           |                           |                           | 0.102 k allocs: 4.61 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 |                           |                           |                           | 27  allocs: 2.61 kB       |
| AD gradients/Timeseries convolve time-varying PMF matrix/Mooncake reverse           |                           |                           |                           | 0.345 k allocs: 28.9 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     |                           |                           |                           | 0.078 k allocs: 3.41 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          |                           |                           |                           | 0.462 k allocs: 18.2 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     |                           |                           |                           | 7  allocs: 0.266 kB       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               |                           |                           |                           | 0.078 k allocs: 3.71 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               |                           |                           |                           | 2.57 k allocs: 1.15 MB    |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            |                           |                           |                           | 0.198 k allocs: 16.1 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               |                           |                           |                           | 0.178 k allocs: 17 kB     |
| AD gradients/Timeseries convolve time-varying PMF matrix/ReverseDiff (tape)         |                           |                           |                           | 0.273 k allocs: 12.2 kB   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                |                           |                           |                           | 2  allocs: 0.0938 kB      |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     |                           |                           |                           | 1.36 k allocs: 0.169 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     |                           |                           |                           | 0.088 k allocs: 11.6 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    |                           |                           |                           | 27  allocs: 2.61 kB       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        |                           |                           |                           | 0.04 k allocs: 4.7 kB     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   |                           |                           |                           | 2.08 k allocs: 0.666 MB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          |                           |                           |                           | 0.0532 M allocs: 2.07 MB  |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   |                           |                           |                           | 7  allocs: 0.484 kB       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               |                           |                           |                           | 0.07 k allocs: 3.33 kB    |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     |                           |                           |                           | 24  allocs: 1.02 kB       |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   |                           |                           |                           | 0.142 k allocs: 7.5 kB    |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  |                           |                           |                           | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   |                           |                           |                           | 0.142 k allocs: 7.5 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 |                           |                           |                           | 0.032 k allocs: 1.3 kB    |
| AD gradients/Timeseries convolve time-varying Poisson delays/Mooncake forward       |                           |                           |                           | 0.238 k allocs: 11.6 kB   |
| time_to_load                                                                        | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   |

