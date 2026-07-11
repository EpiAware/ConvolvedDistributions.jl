|                                                                                                 | da71dd1faf1eb4...   |
|:------------------------------------------------------------------------------------------------|:-------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0628 ± 0.0036 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.46 ± 0.046 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0523 ± 0.00042 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.253 ± 0.0065 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.583 ± 0.023 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 2.2 ± 0.28 ms       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.0665 ± 0.0072 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.444 ± 0.047 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.0656 ± 0.00062 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.525 ± 0.014 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.584 ± 0.023 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 2.58 ± 0.33 ms      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.0732 ± 0.00045 ms |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.122 ± 0.0057 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.0684 ± 0.00013 ms |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.292 ± 0.0094 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.559 ± 0.021 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 2.47 ± 0.31 ms      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 7.18 ± 0.088 μs     |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.0494 ± 0.0076 μs  |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.577 ± 0.043 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 5.2 ± 0.73 μs       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 4.56 ± 0.22 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.6 ± 0.14 μs       |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.0936 ± 0.00061 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.144 ± 0.007 ms    |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.0843 ± 0.0002 ms  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.38 ± 0.0099 ms    |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.606 ± 0.02 ms     |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 2.36 ± 0.29 ms      |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 8.16 ± 0.067 μs     |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 3.38 ± 0.053 μs     |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.613 ± 0.08 μs     |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 5.76 ± 0.24 μs      |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 27.3 ± 2.8 μs       |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 16.8 ± 0.38 μs      |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.119 ± 0.0011 ms   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.205 ± 0.011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.118 ± 0.00049 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.502 ± 0.011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.884 ± 0.025 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 4.23 ± 0.54 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 7.25 ± 0.1 μs       |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.0464 ± 0.006 μs   |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.527 ± 0.037 μs    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 5.16 ± 0.71 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 4.55 ± 0.21 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.61 ± 0.15 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.145 ± 0.0013 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.24 ± 0.011 ms     |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.139 ± 0.00082 ms  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.628 ± 0.0095 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.906 ± 0.014 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 4.14 ± 0.54 ms      |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 8.13 ± 0.07 μs      |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 3.23 ± 0.059 μs     |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.575 ± 0.082 μs    |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 5.5 ± 0.28 μs       |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 27.4 ± 2.8 μs       |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 18.1 ± 0.47 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 7.28 ± 0.095 μs     |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.0703 ± 0.0074 μs  |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.607 ± 0.043 μs    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 5.39 ± 0.55 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 6.44 ± 0.85 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 10.3 ± 0.28 μs      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.122 ± 0.001 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.21 ± 0.011 ms     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.118 ± 0.00035 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.531 ± 0.011 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.865 ± 0.013 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 4.71 ± 0.57 ms      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.151 ± 0.0013 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.248 ± 0.011 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.144 ± 0.00059 ms  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.649 ± 0.0082 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.954 ± 0.015 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 4.6 ± 0.59 ms       |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 8.14 ± 0.074 μs     |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 3.31 ± 0.056 μs     |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.58 ± 0.08 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 5.81 ± 0.27 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 17.2 ± 0.84 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 21.8 ± 0.53 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 7.44 ± 0.095 μs     |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 7.56 ± 0.065 μs     |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.985 ± 0.13 μs     |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 6.15 ± 0.92 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 18.1 ± 0.8 μs       |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 28.9 ± 0.57 μs      |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.633 ± 0.0093 ms   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.793 ± 0.013 ms    |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.542 ± 0.0097 ms   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 2.57 ± 0.0093 ms    |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 1.79 ± 0.034 ms     |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 9.01 ± 1.3 ms       |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 10.7 ± 0.17 μs      |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 13.4 ± 0.21 μs      |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 3.23 ± 0.033 μs     |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 12 ± 0.44 μs        |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 21.4 ± 2.6 μs       |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.034 ± 0.00071 ms  |
| Baseline/Gamma/cdf                                                                              | 3.61 ± 0.38 μs      |
| Baseline/Gamma/logpdf                                                                           | 2.87 ± 0.33 μs      |
| Baseline/Normal/cdf                                                                             | 1.47 ± 0.3 μs       |
| Baseline/Normal/logpdf                                                                          | 1.05 ± 0.023 μs     |
| Convolved/analytic/cdf batched                                                                  | 2.66 ± 0.34 μs      |
| Convolved/analytic/cdf scalar                                                                   | 28.2 ± 0.13 ns      |
| Convolved/analytic/construction                                                                 | 3.1 ± 0.01 ns       |
| Convolved/analytic/logpdf batched                                                               | 1.08 ± 0.028 μs     |
| Convolved/analytic/logpdf broadcast                                                             | 2.53 ± 0.33 μs      |
| Convolved/analytic/logpdf scalar                                                                | 27.8 ± 0.25 ns      |
| Convolved/analytic/mean                                                                         | 3.1 ± 0.01 ns       |
| Convolved/analytic/pdf batched                                                                  | 1.13 ± 0.033 μs     |
| Convolved/analytic/pdf scalar                                                                   | 29.8 ± 0.07 ns      |
| Convolved/analytic/rand                                                                         | 1.12 ± 0.027 μs     |
| Convolved/numeric/cdf batched                                                                   | 0.827 ± 0.0043 ms   |
| Convolved/numeric/cdf scalar                                                                    | 15.6 ± 0.06 μs      |
| Convolved/numeric/construction                                                                  | 3.1 ± 0.01 ns       |
| Convolved/numeric/logpdf batched                                                                | 0.733 ± 0.0063 ms   |
| Convolved/numeric/logpdf broadcast                                                              | 1.34 ± 0.0091 ms    |
| Convolved/numeric/logpdf scalar                                                                 | 12.6 ± 0.031 μs     |
| Convolved/numeric/mean                                                                          | 6.66 ± 0.011 ns     |
| Convolved/numeric/pdf batched                                                                   | 0.734 ± 0.0069 ms   |
| Convolved/numeric/pdf scalar                                                                    | 12.6 ± 0.039 μs     |
| Convolved/numeric/rand                                                                          | 2.8 ± 0.35 μs       |
| Difference/analytic/cdf broadcast                                                               | 3.36 ± 0.35 μs      |
| Difference/analytic/cdf scalar                                                                  | 10.8 ± 0.019 ns     |
| Difference/analytic/construction                                                                | 3.11 ± 0.01 ns      |
| Difference/analytic/logpdf broadcast                                                            | 1.5 ± 0.31 μs       |
| Difference/analytic/logpdf scalar                                                               | 17 ± 0.091 ns       |
| Difference/analytic/mean                                                                        | 2.79 ± 0.01 ns      |
| Difference/analytic/rand                                                                        | 1.12 ± 0.033 μs     |
| Difference/numeric/cdf broadcast                                                                | 1.34 ± 0.018 ms     |
| Difference/numeric/cdf scalar                                                                   | 19.4 ± 0.09 μs      |
| Difference/numeric/construction                                                                 | 3.11 ± 0.01 ns      |
| Difference/numeric/logpdf broadcast                                                             | 1.65 ± 0.016 ms     |
| Difference/numeric/logpdf scalar                                                                | 16.8 ± 0.07 μs      |
| Difference/numeric/mean                                                                         | 6.59 ± 0.031 ns     |
| Difference/numeric/rand                                                                         | 2.79 ± 0.36 μs      |
| Product/analytic/cdf broadcast                                                                  | 4.91 ± 0.2 μs       |
| Product/analytic/cdf scalar                                                                     | 29.7 ± 0.6 ns       |
| Product/analytic/construction                                                                   | 3.72 ± 0.001 ns     |
| Product/analytic/logpdf broadcast                                                               | 2.27 ± 0.33 μs      |
| Product/analytic/logpdf scalar                                                                  | 24 ± 0.09 ns        |
| Product/analytic/mean                                                                           | 10.8 ± 0.041 ns     |
| Product/analytic/rand                                                                           | 1.78 ± 0.32 μs      |
| Product/numeric/cdf broadcast                                                                   | 1.97 ± 0.015 ms     |
| Product/numeric/cdf scalar                                                                      | 23.1 ± 0.099 μs     |
| Product/numeric/construction                                                                    | 3.11 ± 0.01 ns      |
| Product/numeric/logpdf broadcast                                                                | 1.77 ± 0.014 ms     |
| Product/numeric/logpdf scalar                                                                   | 17.5 ± 0.071 μs     |
| Product/numeric/mean                                                                            | 6.73 ± 0.041 ns     |
| Product/numeric/rand                                                                            | 2.8 ± 0.34 μs       |
| Quantile/Convolved analytic/grid                                                                | 0.618 ± 0.099 ms    |
| Quantile/Convolved analytic/median                                                              | 23.3 ± 0.82 μs      |
| Quantile/Convolved numeric/median                                                               | 0.291 ± 0.012 ms    |
| Quantile/Difference numeric/median                                                              | 0.338 ± 0.011 ms    |
| Quantile/Product numeric/median                                                                 | 0.498 ± 0.012 ms    |
| Timeseries/Convolved delay                                                                      | 0.746 ± 0.008 ms    |
| Timeseries/Gamma delay                                                                          | 1.84 ± 0.03 μs      |
| Timeseries/Poisson delay                                                                        | 1.29 ± 0.025 μs     |
| time_to_load                                                                                    | 0.837 ± 0.0036 s    |

|                                                                                                 | da71dd1faf1eb4...         |
|:------------------------------------------------------------------------------------------------|:-------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.088 k allocs: 11.6 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 1.35 k allocs: 0.168 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.04 k allocs: 4.7 kB     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.264 k allocs: 27.2 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 2.08 k allocs: 0.666 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 28.5 k allocs: 1.2 MB     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.151 k allocs: 22.6 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 1.36 k allocs: 0.169 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.081 k allocs: 7.2 kB    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.519 k allocs: 0.0521 MB |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 2.07 k allocs: 0.665 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 0.0327 M allocs: 1.23 MB  |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.078 k allocs: 3.41 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.147 k allocs: 18.7 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 21  allocs: 1.03 kB       |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.142 k allocs: 7.5 kB    |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 2.35 k allocs: 0.639 MB   |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 31.1 k allocs: 1.29 MB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 0.032 k allocs: 1.3 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 2  allocs: 0.0938 kB      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 7  allocs: 0.484 kB       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 0.07 k allocs: 3.33 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 0.078 k allocs: 3.71 kB   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 0.041 k allocs: 1.7 kB    |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.078 k allocs: 3.41 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.147 k allocs: 18.7 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 21  allocs: 1.03 kB       |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.142 k allocs: 7.5 kB    |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 2.37 k allocs: 0.633 MB   |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 30.2 k allocs: 1.26 MB    |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 24  allocs: 1.03 kB       |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 7  allocs: 0.266 kB       |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 0.058 k allocs: 2.91 kB   |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 0.289 k allocs: 0.0329 MB |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 0.238 k allocs: 9.92 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.096 k allocs: 8.14 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.159 k allocs: 23 kB     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 27  allocs: 2.61 kB       |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.178 k allocs: 17 kB     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 2.46 k allocs: 1.03 MB    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 0.0532 M allocs: 2.07 MB  |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 0.032 k allocs: 1.3 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 2  allocs: 0.0938 kB      |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 7  allocs: 0.484 kB       |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 0.07 k allocs: 3.33 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 0.078 k allocs: 3.71 kB   |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 0.041 k allocs: 1.7 kB    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.096 k allocs: 8.14 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.159 k allocs: 23.1 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 27  allocs: 2.61 kB       |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.178 k allocs: 17 kB     |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 2.46 k allocs: 1.03 MB    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 0.0532 M allocs: 2.07 MB  |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 0.036 k allocs: 1.11 kB   |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 24  allocs: 1.02 kB       |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 7  allocs: 0.266 kB       |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 0.058 k allocs: 2.91 kB   |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 0.289 k allocs: 0.0331 MB |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 0.268 k allocs: 10.9 kB   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 0.032 k allocs: 1.3 kB    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 2  allocs: 0.0938 kB      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 7  allocs: 0.484 kB       |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 0.07 k allocs: 3.33 kB    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 0.093 k allocs: 5.09 kB   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 0.127 k allocs: 5.25 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.096 k allocs: 8.14 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.159 k allocs: 23.1 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 27  allocs: 2.61 kB       |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.178 k allocs: 17 kB     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 2.57 k allocs: 1.15 MB    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 0.058 M allocs: 2.44 MB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.096 k allocs: 8.14 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.159 k allocs: 23.1 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 27  allocs: 2.61 kB       |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.178 k allocs: 17 kB     |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 2.57 k allocs: 1.15 MB    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 0.058 M allocs: 2.44 MB   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 0.036 k allocs: 1.11 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 24  allocs: 1.02 kB       |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 7  allocs: 0.266 kB       |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 0.27 k allocs: 12.5 kB    |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 0.298 k allocs: 12 kB     |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 0.033 k allocs: 1.2 kB    |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 10  allocs: 0.5 kB        |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 11  allocs: 0.547 kB      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 0.068 k allocs: 3.58 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 0.198 k allocs: 16.1 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 0.462 k allocs: 18.2 kB   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.247 k allocs: 13.6 kB   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 0.373 k allocs: 0.058 MB  |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.087 k allocs: 5.36 kB   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 0.5 k allocs: 27.9 kB     |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 2.31 k allocs: 1.59 MB    |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 0.0943 M allocs: 3.69 MB  |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 0.04 k allocs: 1.62 kB    |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 0.034 k allocs: 1.7 kB    |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 11  allocs: 0.703 kB      |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 0.082 k allocs: 4.23 kB   |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 0.184 k allocs: 17 kB     |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.449 k allocs: 18 kB     |
| Baseline/Gamma/cdf                                                                              | 2  allocs: 0.906 kB       |
| Baseline/Gamma/logpdf                                                                           | 2  allocs: 0.906 kB       |
| Baseline/Normal/cdf                                                                             | 2  allocs: 0.906 kB       |
| Baseline/Normal/logpdf                                                                          | 2  allocs: 0.906 kB       |
| Convolved/analytic/cdf batched                                                                  | 2  allocs: 0.906 kB       |
| Convolved/analytic/cdf scalar                                                                   | 0  allocs: 0 B            |
| Convolved/analytic/construction                                                                 | 0  allocs: 0 B            |
| Convolved/analytic/logpdf batched                                                               | 2  allocs: 0.906 kB       |
| Convolved/analytic/logpdf broadcast                                                             | 2  allocs: 0.906 kB       |
| Convolved/analytic/logpdf scalar                                                                | 0  allocs: 0 B            |
| Convolved/analytic/mean                                                                         | 0  allocs: 0 B            |
| Convolved/analytic/pdf batched                                                                  | 2  allocs: 0.906 kB       |
| Convolved/analytic/pdf scalar                                                                   | 0  allocs: 0 B            |
| Convolved/analytic/rand                                                                         | 2  allocs: 0.906 kB       |
| Convolved/numeric/cdf batched                                                                   | 24  allocs: 8.32 kB       |
| Convolved/numeric/cdf scalar                                                                    | 3  allocs: 0.172 kB       |
| Convolved/numeric/construction                                                                  | 0  allocs: 0 B            |
| Convolved/numeric/logpdf batched                                                                | 25  allocs: 8.41 kB       |
| Convolved/numeric/logpdf broadcast                                                              | 0.338 k allocs: 29.8 kB   |
| Convolved/numeric/logpdf scalar                                                                 | 3  allocs: 0.172 kB       |
| Convolved/numeric/mean                                                                          | 0  allocs: 0 B            |
| Convolved/numeric/pdf batched                                                                   | 23  allocs: 7.5 kB        |
| Convolved/numeric/pdf scalar                                                                    | 3  allocs: 0.172 kB       |
| Convolved/numeric/rand                                                                          | 2  allocs: 0.906 kB       |
| Difference/analytic/cdf broadcast                                                               | 2  allocs: 0.906 kB       |
| Difference/analytic/cdf scalar                                                                  | 0  allocs: 0 B            |
| Difference/analytic/construction                                                                | 0  allocs: 0 B            |
| Difference/analytic/logpdf broadcast                                                            | 2  allocs: 0.906 kB       |
| Difference/analytic/logpdf scalar                                                               | 0  allocs: 0 B            |
| Difference/analytic/mean                                                                        | 0  allocs: 0 B            |
| Difference/analytic/rand                                                                        | 2  allocs: 0.906 kB       |
| Difference/numeric/cdf broadcast                                                                | 0.402 k allocs: 0.0467 MB |
| Difference/numeric/cdf scalar                                                                   | 4  allocs: 0.469 kB       |
| Difference/numeric/construction                                                                 | 0  allocs: 0 B            |
| Difference/numeric/logpdf broadcast                                                             | 0.402 k allocs: 0.0467 MB |
| Difference/numeric/logpdf scalar                                                                | 4  allocs: 0.469 kB       |
| Difference/numeric/mean                                                                         | 0  allocs: 0 B            |
| Difference/numeric/rand                                                                         | 2  allocs: 0.906 kB       |
| Product/analytic/cdf broadcast                                                                  | 2  allocs: 0.906 kB       |
| Product/analytic/cdf scalar                                                                     | 0  allocs: 0 B            |
| Product/analytic/construction                                                                   | 0  allocs: 0 B            |
| Product/analytic/logpdf broadcast                                                               | 2  allocs: 0.906 kB       |
| Product/analytic/logpdf scalar                                                                  | 0  allocs: 0 B            |
| Product/analytic/mean                                                                           | 0  allocs: 0 B            |
| Product/analytic/rand                                                                           | 2  allocs: 0.906 kB       |
| Product/numeric/cdf broadcast                                                                   | 0.402 k allocs: 0.0467 MB |
| Product/numeric/cdf scalar                                                                      | 4  allocs: 0.469 kB       |
| Product/numeric/construction                                                                    | 0  allocs: 0 B            |
| Product/numeric/logpdf broadcast                                                                | 0.402 k allocs: 0.0467 MB |
| Product/numeric/logpdf scalar                                                                   | 4  allocs: 0.469 kB       |
| Product/numeric/mean                                                                            | 0  allocs: 0 B            |
| Product/numeric/rand                                                                            | 2  allocs: 0.906 kB       |
| Quantile/Convolved analytic/grid                                                                | 5.71 k allocs: 0.324 MB   |
| Quantile/Convolved analytic/median                                                              | 0.265 k allocs: 15.6 kB   |
| Quantile/Convolved numeric/median                                                               | 0.339 k allocs: 19.6 kB   |
| Quantile/Difference numeric/median                                                              | 0.302 k allocs: 21.8 kB   |
| Quantile/Product numeric/median                                                                 | 0.381 k allocs: 27 kB     |
| Timeseries/Convolved delay                                                                      | 0.226 k allocs: 24.1 kB   |
| Timeseries/Gamma delay                                                                          | 4  allocs: 0.594 kB       |
| Timeseries/Poisson delay                                                                        | 4  allocs: 0.594 kB       |
| time_to_load                                                                                    | 0.149 k allocs: 11.2 kB   |

