|                                                                                     | v0.3.1            | v0.3.0            | v0.2.0            | cbca7d5b2b367c...   |
|:------------------------------------------------------------------------------------|:-----------------:|:-----------------:|:-----------------:|:-------------------:|
| Baseline/Gamma/cdf                                                                  | 3.76 ± 0.43 μs    | 3.75 ± 0.44 μs    | 3.74 ± 0.44 μs    | 3.76 ± 0.45 μs      |
| Baseline/Gamma/logpdf                                                               | 2.78 ± 0.45 μs    | 2.78 ± 0.4 μs     | 2.81 ± 0.39 μs    | 2.79 ± 0.4 μs       |
| Baseline/Normal/cdf                                                                 | 1.64 ± 0.36 μs    | 1.67 ± 0.38 μs    | 1.92 ± 0.37 μs    | 1.61 ± 0.41 μs      |
| Baseline/Normal/logpdf                                                              | 0.679 ± 0.4 μs    | 0.736 ± 0.4 μs    | 0.732 ± 0.4 μs    | 1.06 ± 0.042 μs     |
| Convolved/analytic/cdf batched                                                      | 2.89 ± 0.41 μs    | 2.89 ± 0.41 μs    | 2.89 ± 0.4 μs     | 2.7 ± 0.41 μs       |
| Convolved/analytic/cdf scalar                                                       | 24.5 ± 0.05 ns    | 24.7 ± 0.11 ns    | 25.1 ± 0.08 ns    | 24.6 ± 0.24 ns      |
| Convolved/analytic/construction                                                     | 3.48 ± 0.001 ns   | 3.48 ± 0.01 ns    | 3.48 ± 0.001 ns   | 3.48 ± 0.01 ns      |
| Convolved/analytic/logpdf batched                                                   | 0.687 ± 0.4 μs    | 0.747 ± 0.4 μs    | 0.7 ± 0.41 μs     | 1.09 ± 0.042 μs     |
| Convolved/analytic/logpdf broadcast                                                 | 2.35 ± 0.39 μs    | 2.36 ± 0.4 μs     | 2.36 ± 0.39 μs    | 2.36 ± 0.39 μs      |
| Convolved/analytic/logpdf scalar                                                    | 27.2 ± 0.22 ns    | 27.2 ± 0.23 ns    | 27.2 ± 0.14 ns    | 27.3 ± 0.14 ns      |
| Convolved/analytic/mean                                                             | 3.13 ± 0.009 ns   | 3.48 ± 0 ns       | 3.13 ± 0.009 ns   | 3.15 ± 0.001 ns     |
| Convolved/analytic/pdf batched                                                      | 0.709 ± 0.41 μs   | 0.771 ± 0.41 μs   | 0.769 ± 0.41 μs   | 1.09 ± 0.037 μs     |
| Convolved/analytic/pdf scalar                                                       | 30.8 ± 0.091 ns   | 30.8 ± 0.2 ns     | 30.8 ± 0.1 ns     | 30.9 ± 0.21 ns      |
| Convolved/analytic/rand                                                             | 1.24 ± 0.4 μs     | 1.25 ± 0.4 μs     | 1.24 ± 0.4 μs     | 1.26 ± 0.061 μs     |
| Convolved/numeric/cdf batched                                                       | 0.836 ± 0.0035 ms | 0.835 ± 0.0041 ms | 0.839 ± 0.0053 ms | 0.842 ± 0.0039 ms   |
| Convolved/numeric/cdf scalar                                                        | 15.7 ± 0.05 μs    | 15.5 ± 0.05 μs    | 15.5 ± 0.04 μs    | 15.4 ± 0.05 μs      |
| Convolved/numeric/construction                                                      | 3.48 ± 0.001 ns   | 3.48 ± 0.001 ns   | 3.48 ± 0.001 ns   | 3.48 ± 0.01 ns      |
| Convolved/numeric/logpdf batched                                                    | 0.651 ± 0.0082 ms | 0.651 ± 0.0082 ms | 0.655 ± 0.0081 ms | 0.652 ± 0.0082 ms   |
| Convolved/numeric/logpdf broadcast                                                  | 1.21 ± 0.013 ms   | 1.24 ± 0.013 ms   | 1.23 ± 0.013 ms   | 1.21 ± 0.011 ms     |
| Convolved/numeric/logpdf scalar                                                     | 11.2 ± 0.03 μs    | 11.2 ± 0.03 μs    | 11.2 ± 0.03 μs    | 11.4 ± 0.051 μs     |
| Convolved/numeric/mean                                                              | 6.29 ± 0.001 ns   | 6.88 ± 0.03 ns    | 5.98 ± 0.02 ns    | 6.08 ± 0.03 ns      |
| Convolved/numeric/pdf batched                                                       | 0.652 ± 0.0083 ms | 0.65 ± 0.0082 ms  | 0.65 ± 0.0079 ms  | 0.651 ± 0.0082 ms   |
| Convolved/numeric/pdf scalar                                                        | 11.2 ± 0.03 μs    | 11.2 ± 0.04 μs    | 11.2 ± 0.031 μs   | 11.3 ± 0.059 μs     |
| Convolved/numeric/rand                                                              | 2.78 ± 0.42 μs    | 2.78 ± 0.41 μs    | 2.78 ± 0.4 μs     | 2.76 ± 0.42 μs      |
| Difference/analytic/cdf broadcast                                                   | 3.56 ± 0.42 μs    | 3.59 ± 0.4 μs     | 3.58 ± 0.41 μs    | 3.54 ± 0.13 μs      |
| Difference/analytic/cdf scalar                                                      | 12.4 ± 0.05 ns    | 12.3 ± 0.011 ns   | 12.4 ± 0.061 ns   | 12.5 ± 0.19 ns      |
| Difference/analytic/construction                                                    | 4.19 ± 0.009 ns   | 3.84 ± 0.009 ns   | 3.5 ± 0.001 ns    | 3.85 ± 0.01 ns      |
| Difference/analytic/logpdf broadcast                                                | 1.54 ± 0.36 μs    | 1.55 ± 0.36 μs    | 1.56 ± 0.36 μs    | 1.52 ± 0.39 μs      |
| Difference/analytic/logpdf scalar                                                   | 17.3 ± 0.31 ns    | 17.4 ± 0.33 ns    | 17.3 ± 0.17 ns    | 17.3 ± 0.22 ns      |
| Difference/analytic/mean                                                            | 3.48 ± 0 ns       | 3.14 ± 0.01 ns    | 3.48 ± 0 ns       | 3.15 ± 0.001 ns     |
| Difference/analytic/rand                                                            | 1.2 ± 0.4 μs      | 1.24 ± 0.39 μs    | 1.21 ± 0.39 μs    | 1.26 ± 0.066 μs     |
| Difference/numeric/cdf broadcast                                                    | 1.3 ± 0.022 ms    | 1.31 ± 0.02 ms    | 1.28 ± 0.022 ms   | 1.31 ± 0.021 ms     |
| Difference/numeric/cdf scalar                                                       | 19.4 ± 0.071 μs   | 19.5 ± 0.08 μs    | 19.2 ± 0.08 μs    | 19.5 ± 0.1 μs       |
| Difference/numeric/construction                                                     | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns    | 3.84 ± 0.009 ns   | 3.5 ± 0.001 ns      |
| Difference/numeric/logpdf broadcast                                                 | 1.51 ± 0.022 ms   | 1.52 ± 0.021 ms   | 1.5 ± 0.022 ms    | 1.51 ± 0.02 ms      |
| Difference/numeric/logpdf scalar                                                    | 15.1 ± 0.08 μs    | 15.1 ± 0.08 μs    | 15.1 ± 0.11 μs    | 15 ± 0.12 μs        |
| Difference/numeric/mean                                                             | 6.03 ± 0.021 ns   | 6.94 ± 0.031 ns   | 6.06 ± 0.06 ns    | 6.14 ± 0.02 ns      |
| Difference/numeric/rand                                                             | 2.78 ± 0.42 μs    | 2.8 ± 0.44 μs     | 2.8 ± 0.42 μs     | 2.77 ± 0.4 μs       |
| Product/analytic/cdf broadcast                                                      | 5.1 ± 0.06 μs     | 5.11 ± 0.073 μs   | 5.11 ± 0.08 μs    | 5.1 ± 0.06 μs       |
| Product/analytic/cdf scalar                                                         | 29.1 ± 0.19 ns    | 29.1 ± 0.18 ns    | 29 ± 0.14 ns      | 29 ± 0.12 ns        |
| Product/analytic/construction                                                       | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns      |
| Product/analytic/logpdf broadcast                                                   | 2.19 ± 0.41 μs    | 2.19 ± 0.4 μs     | 2.2 ± 0.39 μs     | 2.18 ± 0.39 μs      |
| Product/analytic/logpdf scalar                                                      | 24.4 ± 0.19 ns    | 24.2 ± 0.26 ns    | 24.4 ± 0.21 ns    | 24.3 ± 0.16 ns      |
| Product/analytic/mean                                                               | 10.3 ± 0.07 ns    | 11.4 ± 0.07 ns    | 10.2 ± 0.02 ns    | 10.4 ± 0.039 ns     |
| Product/analytic/rand                                                               | 1.73 ± 0.37 μs    | 1.73 ± 0.37 μs    | 1.74 ± 0.38 μs    | 1.71 ± 0.36 μs      |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.024 ms   | 1.99 ± 0.024 ms   | 1.98 ± 0.024 ms   | 1.97 ± 0.019 ms     |
| Product/numeric/cdf scalar                                                          | 23.3 ± 0.1 μs     | 23.2 ± 0.09 μs    | 23.3 ± 0.1 μs     | 23.3 ± 0.13 μs      |
| Product/numeric/construction                                                        | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns    | 3.5 ± 0.001 ns      |
| Product/numeric/logpdf broadcast                                                    | 1.61 ± 0.022 ms   | 1.63 ± 0.022 ms   | 1.61 ± 0.022 ms   | 1.62 ± 0.02 ms      |
| Product/numeric/logpdf scalar                                                       | 15.9 ± 0.08 μs    | 15.9 ± 0.12 μs    | 16.1 ± 0.08 μs    | 15.9 ± 0.12 μs      |
| Product/numeric/mean                                                                | 6.14 ± 0.02 ns    | 7.02 ± 0.04 ns    | 6.29 ± 0.01 ns    | 6.24 ± 0.02 ns      |
| Product/numeric/rand                                                                | 2.77 ± 0.42 μs    | 2.8 ± 0.41 μs     | 2.8 ± 0.41 μs     | 2.76 ± 0.4 μs       |
| Quantile/Convolved analytic/grid                                                    | 0.586 ± 0.02 ms   | 0.596 ± 0.11 ms   | 0.592 ± 0.11 ms   | 0.692 ± 0.1 ms      |
| Quantile/Convolved analytic/median                                                  | 27.1 ± 5.3 μs     | 27.5 ± 4.9 μs     | 27.3 ± 5 μs       | 27.1 ± 0.85 μs      |
| Quantile/Convolved numeric/median                                                   | 0.293 ± 0.0098 ms | 0.291 ± 0.01 ms   | 0.291 ± 0.01 ms   | 0.287 ± 0.0086 ms   |
| Quantile/Difference numeric/median                                                  | 0.347 ± 0.01 ms   | 0.349 ± 0.012 ms  | 0.346 ± 0.012 ms  | 0.347 ± 0.01 ms     |
| Quantile/Product numeric/median                                                     | 0.5 ± 0.012 ms    | 0.503 ± 0.011 ms  | 0.503 ± 0.012 ms  | 0.501 ± 0.012 ms    |
| Timeseries/Convolved delay                                                          | 0.278 ± 0.13 μs   | 0.371 ± 0.13 μs   | 0.356 ± 0.12 μs   | 0.374 ± 0.012 μs    |
| Timeseries/Gamma delay                                                              | 0.252 ± 0.13 μs   | 0.372 ± 0.13 μs   | 0.254 ± 0.12 μs   | 0.376 ± 0.013 μs    |
| Timeseries/Poisson delay                                                            | 1.34 ± 0.032 μs   | 1.35 ± 0.044 μs   | 1.34 ± 0.045 μs   | 1.35 ± 0.038 μs     |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                |                   |                   |                   | 6.84 ± 0.18 μs      |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        |                   |                   |                   | 0.597 ± 0.092 μs    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 |                   |                   |                   | 2.45 ± 0.35 ms      |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  |                   |                   |                   | 16.2 ± 0.53 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              |                   |                   |                   | 0.242 ± 0.011 ms    |
| AD gradients/Timeseries convolve time-varying Poisson delays/Enzyme reverse         |                   |                   |                   | 9.16 ± 0.42 μs      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     |                   |                   |                   | 0.123 ± 0.0065 ms   |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 |                   |                   |                   | 0.969 ± 0.12 μs     |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    |                   |                   |                   | 6.16 ± 0.26 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              |                   |                   |                   | 5.66 ± 0.66 μs      |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        |                   |                   |                   | 0.0723 ± 0.0003 ms  |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    |                   |                   |                   | 28.3 ± 3.1 μs       |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 |                   |                   |                   | 2.35 ± 0.33 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                |                   |                   |                   | 0.0497 ± 0.02 μs    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        |                   |                   |                   | 0.0665 ± 0.00078 ms |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            |                   |                   |                   | 0.92 ± 0.041 ms     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            |                   |                   |                   | 0.536 ± 0.0096 ms   |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         |                   |                   |                   | 0.622 ± 0.094 μs    |
| AD gradients/Timeseries convolve time-varying PMF matrix/Enzyme reverse             |                   |                   |                   | 9.38 ± 0.45 μs      |
| AD gradients/Timeseries convolve time-varying PMF matrix/Mooncake forward           |                   |                   |                   | 7.44 ± 1.5 μs       |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   |                   |                   |                   | 0.645 ± 0.039 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          |                   |                   |                   | 4.17 ± 0.62 ms      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              |                   |                   |                   | 6.59 ± 0.82 μs      |
| AD gradients/Timeseries convolve time-varying Poisson delays/ForwardDiff            |                   |                   |                   | 2.74 ± 0.35 μs      |
| AD gradients/Timeseries convolve time-varying PMF matrix/ForwardDiff                |                   |                   |                   | 1.15 ± 0.18 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             |                   |                   |                   | 2.47 ± 0.092 μs     |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     |                   |                   |                   | 7.67 ± 0.15 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 |                   |                   |                   | 0.0495 ± 0.021 μs   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            |                   |                   |                   | 0.643 ± 0.0083 ms   |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      |                   |                   |                   | 3.26 ± 0.081 μs     |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            |                   |                   |                   | 9.95 ± 0.36 μs      |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   |                   |                   |                   | 0.594 ± 0.027 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     |                   |                   |                   | 0.485 ± 0.055 ms    |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 |                   |                   |                   | 17.4 ± 0.63 μs      |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   |                   |                   |                   | 5.84 ± 0.31 μs      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               |                   |                   |                   | 0.671 ± 0.0075 ms   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 |                   |                   |                   | 0.126 ± 0.00062 ms  |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              |                   |                   |                   | 8.15 ± 0.077 μs     |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                |                   |                   |                   | 6.82 ± 0.18 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              |                   |                   |                   | 0.144 ± 0.0012 ms   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 |                   |                   |                   | 0.212 ± 0.01 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     |                   |                   |                   | 0.086 ± 0.006 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              |                   |                   |                   | 0.119 ± 0.0011 ms   |
| AD gradients/Timeseries convolve time-varying Poisson delays/ReverseDiff (tape)     |                   |                   |                   | 0.0625 ± 0.012 ms   |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   |                   |                   |                   | 27.9 ± 3.2 μs       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   |                   |                   |                   | 0.598 ± 0.027 ms    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                |                   |                   |                   | 6.11 ± 0.28 μs      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 |                   |                   |                   | 0.151 ± 0.0013 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     |                   |                   |                   | 0.147 ± 0.0077 ms   |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              |                   |                   |                   | 5.42 ± 0.68 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              |                   |                   |                   | 4.72 ± 0.21 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              |                   |                   |                   | 6.99 ± 0.16 μs      |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              |                   |                   |                   | 0.206 ± 0.01 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) |                   |                   |                   | 2.19 ± 0.32 ms      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               |                   |                   |                   | 0.951 ± 0.035 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 |                   |                   |                   | 0.123 ± 0.0011 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 |                   |                   |                   | 0.251 ± 0.011 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            |                   |                   |                   | 0.992 ± 0.028 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   |                   |                   |                   | 0.553 ± 0.011 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     |                   |                   |                   | 0.0724 ± 0.00049 ms |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             |                   |                   |                   | 4.58 ± 0.64 ms      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    |                   |                   |                   | 0.151 ± 0.00071 ms  |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            |                   |                   |                   | 6.26 ± 0.22 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                |                   |                   |                   | 17.7 ± 1.3 μs       |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   |                   |                   |                   | 0.623 ± 0.066 μs    |
| AD gradients/Timeseries convolve time-varying PMF matrix/Enzyme forward             |                   |                   |                   | 7.04 ± 0.14 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  |                   |                   |                   | 3.19 ± 0.084 μs     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   |                   |                   |                   | 0.261 ± 0.0063 ms   |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            |                   |                   |                   | 2.51 ± 0.11 μs      |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        |                   |                   |                   | 0.0893 ± 0.00032 ms |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              |                   |                   |                   | 21.4 ± 0.71 μs      |
| AD gradients/Timeseries convolve time-varying Poisson delays/Mooncake reverse       |                   |                   |                   | 0.0899 ± 0.0099 ms  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      |                   |                   |                   | 7.68 ± 0.1 μs       |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    |                   |                   |                   | 0.577 ± 0.057 μs    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) |                   |                   |                   | 2.51 ± 0.36 ms      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             |                   |                   |                   | 4.74 ± 0.68 ms      |
| AD gradients/Timeseries convolve time-varying Poisson delays/Enzyme forward         |                   |                   |                   | 8.97 ± 0.3 μs       |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 |                   |                   |                   | 0.148 ± 0.00069 ms  |
| AD gradients/Timeseries convolve time-varying PMF matrix/Mooncake reverse           |                   |                   |                   | 0.0391 ± 0.0091 ms  |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     |                   |                   |                   | 0.0928 ± 0.00067 ms |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          |                   |                   |                   | 27.7 ± 0.74 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     |                   |                   |                   | 0.59 ± 0.093 μs     |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               |                   |                   |                   | 4.74 ± 0.22 μs      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               |                   |                   |                   | 1.07 ± 0.03 ms      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            |                   |                   |                   | 17.7 ± 0.94 μs      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               |                   |                   |                   | 0.574 ± 0.0096 ms   |
| AD gradients/Timeseries convolve time-varying PMF matrix/ReverseDiff (tape)         |                   |                   |                   | 16.9 ± 0.64 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                |                   |                   |                   | 0.0767 ± 0.021 μs   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     |                   |                   |                   | 0.481 ± 0.052 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     |                   |                   |                   | 0.0618 ± 0.0039 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    |                   |                   |                   | 0.127 ± 0.00056 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        |                   |                   |                   | 0.0542 ± 0.00049 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   |                   |                   |                   | 0.605 ± 0.028 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          |                   |                   |                   | 4.25 ± 0.61 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   |                   |                   |                   | 0.567 ± 0.057 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               |                   |                   |                   | 5.37 ± 0.65 μs      |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     |                   |                   |                   | 3.13 ± 0.079 μs     |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   |                   |                   |                   | 0.298 ± 0.0082 ms   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  |                   |                   |                   | 7.66 ± 0.12 μs      |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   |                   |                   |                   | 0.39 ± 0.0085 ms    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 |                   |                   |                   | 6.81 ± 0.18 μs      |
| AD gradients/Timeseries convolve time-varying Poisson delays/Mooncake forward       |                   |                   |                   | 18.6 ± 0.68 μs      |
| time_to_load                                                                        | 0.897 ± 0.015 s   | 0.896 ± 0.0098 s  | 0.878 ± 0.016 s   | 0.924 ± 0.012 s     |

|                                                                                     | v0.3.1                    | v0.3.0                    | v0.2.0                    | cbca7d5b2b367c...         |
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

