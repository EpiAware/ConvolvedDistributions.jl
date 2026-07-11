|                                                                                                 | 45114d9dbc1796...   |
|:------------------------------------------------------------------------------------------------|:-------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.0715 ± 0.00093 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 0.506 ± 0.053 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 0.0659 ± 0.00057 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.302 ± 0.0086 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 0.638 ± 0.019 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 2.69 ± 0.4 ms       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.0975 ± 0.0021 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 0.503 ± 0.05 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.079 ± 0.0014 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.637 ± 0.0092 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 0.636 ± 0.018 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 3.01 ± 0.44 ms      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.11 ± 0.00083 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 0.15 ± 0.001 ms     |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 0.12 ± 0.00042 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.486 ± 0.0089 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.764 ± 0.019 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 4.33 ± 0.79 ms      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 6.9 ± 0.31 μs       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 0.051 ± 0.0067 μs   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 0.581 ± 0.047 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 5.44 ± 0.84 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 4.94 ± 0.37 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 2.55 ± 0.16 μs      |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.112 ± 0.00064 ms  |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 0.159 ± 0.0013 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 0.117 ± 0.00074 ms  |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.516 ± 0.0089 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.785 ± 0.019 ms    |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 4.17 ± 0.65 ms      |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 7.78 ± 0.14 μs      |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 3.37 ± 0.12 μs      |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 0.641 ± 0.097 μs    |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 6.16 ± 0.22 μs      |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 29.6 ± 3.7 μs       |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 17 ± 0.59 μs        |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.112 ± 0.00064 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 0.153 ± 0.00089 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 0.123 ± 0.00044 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.515 ± 0.0088 ms   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.756 ± 0.017 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 4.33 ± 0.66 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 6.91 ± 0.32 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 0.0517 ± 0.0071 μs  |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 0.582 ± 0.046 μs    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 5.43 ± 0.65 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 4.91 ± 0.39 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 2.67 ± 0.26 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.115 ± 0.00073 ms  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 0.165 ± 0.0013 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 0.123 ± 0.00067 ms  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.536 ± 0.0089 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.786 ± 0.015 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 4.2 ± 0.75 ms       |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                                 | 7.75 ± 0.2 μs       |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                                 | 3.21 ± 0.13 μs      |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                                    | 0.609 ± 0.095 μs    |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                               | 5.86 ± 0.41 μs      |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                               | 29.4 ± 3.8 μs       |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                             | 18.5 ± 0.79 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                            | 6.97 ± 0.32 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                            | 0.0775 ± 0.007 μs   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                               | 0.65 ± 0.049 μs     |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward                          | 5.68 ± 0.62 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse                          | 7.03 ± 1 μs         |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)                        | 10.1 ± 0.52 μs      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.118 ± 0.00071 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 0.157 ± 0.001 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 0.126 ± 0.00051 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.542 ± 0.0091 ms   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.8 ± 0.022 ms      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 4.81 ± 0.9 ms       |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.123 ± 0.0021 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 0.174 ± 0.0022 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 0.127 ± 0.00079 ms  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.569 ± 0.0091 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.835 ± 0.02 ms     |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 4.64 ± 0.9 ms       |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                              | 7.8 ± 0.19 μs       |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                              | 3.26 ± 0.12 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                                 | 0.612 ± 0.093 μs    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                            | 6.21 ± 0.43 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                            | 18.9 ± 1.6 μs       |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)                          | 22.3 ± 0.82 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward                          | 6.99 ± 0.27 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse                          | 7.35 ± 0.13 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                             | 0.97 ± 0.059 μs     |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward                        | 6.4 ± 0.46 μs       |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse                        | 18.4 ± 1.2 μs       |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)                      | 28.8 ± 1 μs         |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.957 ± 0.0031 ms   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 1.02 ± 0.0052 ms    |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.807 ± 0.003 ms    |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 3.75 ± 0.012 ms     |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 2.36 ± 0.033 ms     |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 13 ± 1.5 ms         |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme forward                         | 10.3 ± 0.24 μs      |
| AD gradients/Timeseries convolve discretised Gamma delay/Enzyme reverse                         | 14.5 ± 0.26 μs      |
| AD gradients/Timeseries convolve discretised Gamma delay/ForwardDiff                            | 3.32 ± 0.064 μs     |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake forward                       | 12.4 ± 0.48 μs      |
| AD gradients/Timeseries convolve discretised Gamma delay/Mooncake reverse                       | 21.7 ± 2.4 μs       |
| AD gradients/Timeseries convolve discretised Gamma delay/ReverseDiff (tape)                     | 0.0344 ± 0.0011 ms  |
| Baseline/Gamma/cdf                                                                              | 3.73 ± 0.46 μs      |
| Baseline/Gamma/logpdf                                                                           | 2.79 ± 0.42 μs      |
| Baseline/Normal/cdf                                                                             | 1.58 ± 0.4 μs       |
| Baseline/Normal/logpdf                                                                          | 1.06 ± 0.042 μs     |
| Convolved/analytic/cdf batched                                                                  | 2.7 ± 0.42 μs       |
| Convolved/analytic/cdf scalar                                                                   | 24.5 ± 0.099 ns     |
| Convolved/analytic/construction                                                                 | 3.49 ± 0.01 ns      |
| Convolved/analytic/logpdf batched                                                               | 1.09 ± 0.042 μs     |
| Convolved/analytic/logpdf broadcast                                                             | 2.34 ± 0.41 μs      |
| Convolved/analytic/logpdf scalar                                                                | 27.2 ± 0.13 ns      |
| Convolved/analytic/mean                                                                         | 3.13 ± 0.009 ns     |
| Convolved/analytic/pdf batched                                                                  | 1.1 ± 0.039 μs      |
| Convolved/analytic/pdf scalar                                                                   | 30.8 ± 0.16 ns      |
| Convolved/analytic/rand                                                                         | 1.26 ± 0.062 μs     |
| Convolved/numeric/cdf batched                                                                   | 0.922 ± 0.0027 ms   |
| Convolved/numeric/cdf scalar                                                                    | 21 ± 0.09 μs        |
| Convolved/numeric/construction                                                                  | 3.48 ± 0.01 ns      |
| Convolved/numeric/logpdf batched                                                                | 0.608 ± 0.0087 ms   |
| Convolved/numeric/logpdf broadcast                                                              | 1.42 ± 0.0088 ms    |
| Convolved/numeric/logpdf scalar                                                                 | 14.1 ± 0.05 μs      |
| Convolved/numeric/mean                                                                          | 5.99 ± 0.041 ns     |
| Convolved/numeric/pdf batched                                                                   | 0.608 ± 0.0086 ms   |
| Convolved/numeric/pdf scalar                                                                    | 14.1 ± 0.05 μs      |
| Convolved/numeric/rand                                                                          | 2.76 ± 0.43 μs      |
| Difference/analytic/cdf broadcast                                                               | 3.55 ± 0.43 μs      |
| Difference/analytic/cdf scalar                                                                  | 12.4 ± 0.019 ns     |
| Difference/analytic/construction                                                                | 3.5 ± 0.001 ns      |
| Difference/analytic/logpdf broadcast                                                            | 1.53 ± 0.37 μs      |
| Difference/analytic/logpdf scalar                                                               | 17.3 ± 0.31 ns      |
| Difference/analytic/mean                                                                        | 3.48 ± 0 ns         |
| Difference/analytic/rand                                                                        | 1.26 ± 0.066 μs     |
| Difference/numeric/cdf broadcast                                                                | 1.15 ± 0.0041 ms    |
| Difference/numeric/cdf scalar                                                                   | 14 ± 0.03 μs        |
| Difference/numeric/construction                                                                 | 3.5 ± 0.001 ns      |
| Difference/numeric/logpdf broadcast                                                             | 1.45 ± 0.012 ms     |
| Difference/numeric/logpdf scalar                                                                | 14.4 ± 0.091 μs     |
| Difference/numeric/mean                                                                         | 6.29 ± 0.001 ns     |
| Difference/numeric/rand                                                                         | 2.77 ± 0.42 μs      |
| Product/analytic/cdf broadcast                                                                  | 5.11 ± 0.053 μs     |
| Product/analytic/cdf scalar                                                                     | 29 ± 0.13 ns        |
| Product/analytic/construction                                                                   | 3.5 ± 0.001 ns      |
| Product/analytic/logpdf broadcast                                                               | 2.17 ± 0.4 μs       |
| Product/analytic/logpdf scalar                                                                  | 24.1 ± 0.17 ns      |
| Product/analytic/mean                                                                           | 10.2 ± 0.021 ns     |
| Product/analytic/rand                                                                           | 1.7 ± 0.39 μs       |
| Product/numeric/cdf broadcast                                                                   | 2.47 ± 0.01 ms      |
| Product/numeric/cdf scalar                                                                      | 25.9 ± 0.089 μs     |
| Product/numeric/construction                                                                    | 3.84 ± 0.001 ns     |
| Product/numeric/logpdf broadcast                                                                | 1.53 ± 0.0093 ms    |
| Product/numeric/logpdf scalar                                                                   | 15.2 ± 0.089 μs     |
| Product/numeric/mean                                                                            | 6.15 ± 0.04 ns      |
| Product/numeric/rand                                                                            | 2.77 ± 0.43 μs      |
| Quantile/Convolved analytic/grid                                                                | 0.587 ± 0.11 ms     |
| Quantile/Convolved analytic/median                                                              | 22.3 ± 1 μs         |
| Quantile/Convolved numeric/median                                                               | 0.416 ± 0.0095 ms   |
| Quantile/Difference numeric/median                                                              | 0.238 ± 0.0075 ms   |
| Quantile/Product numeric/median                                                                 | 0.575 ± 0.0098 ms   |
| Timeseries/Convolved delay                                                                      | 0.949 ± 0.0023 ms   |
| Timeseries/Gamma delay                                                                          | 1.87 ± 0.037 μs     |
| Timeseries/Poisson delay                                                                        | 1.35 ± 0.03 μs      |
| time_to_load                                                                                    | 0.903 ± 0.0098 s    |

|                                                                                                 | 45114d9dbc1796...         |
|:------------------------------------------------------------------------------------------------|:-------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward                 | 0.07 k allocs: 14.8 kB    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse                 | 1.46 k allocs: 0.168 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff                    | 30  allocs: 5.66 kB       |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward               | 0.142 k allocs: 30.5 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse               | 1.5 k allocs: 0.797 MB    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape)             | 0.0341 M allocs: 1.4 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward                 | 0.118 k allocs: 29 kB     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse                 | 1.47 k allocs: 0.168 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff                    | 0.071 k allocs: 8.16 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward               | 0.244 k allocs: 0.0573 MB |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse               | 1.48 k allocs: 0.796 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape)             | 0.0385 M allocs: 1.54 MB  |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                                 | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                                 | 14  allocs: 1.86 kB       |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                                    | 7  allocs: 0.266 kB       |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                               | 0.058 k allocs: 2.91 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                               | 0.953 k allocs: 1.14 MB   |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                             | 0.0529 M allocs: 2.06 MB  |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                             | 0.032 k allocs: 1.3 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                             | 2  allocs: 0.0938 kB      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                                | 7  allocs: 0.484 kB       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward                           | 0.07 k allocs: 3.33 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse                           | 0.078 k allocs: 3.71 kB   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)                         | 0.041 k allocs: 1.7 kB    |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                                 | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                                 | 14  allocs: 1.86 kB       |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                                    | 7  allocs: 0.266 kB       |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                               | 0.058 k allocs: 2.91 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                               | 0.953 k allocs: 1.14 MB   |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                             | 0.0529 M allocs: 2.06 MB  |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                                  | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                                  | 24  allocs: 1.03 kB       |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                                     | 7  allocs: 0.266 kB       |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                                | 0.058 k allocs: 2.91 kB   |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                                | 0.289 k allocs: 0.0329 MB |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                              | 0.238 k allocs: 9.92 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward                          | 0.036 k allocs: 1.11 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse                          | 14  allocs: 1.7 kB        |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                             | 7  allocs: 0.266 kB       |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward                        | 0.058 k allocs: 2.91 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse                        | 0.857 k allocs: 1.11 MB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)                      | 0.0529 M allocs: 2.06 MB  |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                            | 0.032 k allocs: 1.3 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                            | 2  allocs: 0.0938 kB      |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                               | 7  allocs: 0.484 kB       |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward                          | 0.07 k allocs: 3.33 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse                          | 0.078 k allocs: 3.71 kB   |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)                        | 0.041 k allocs: 1.7 kB    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward                          | 0.036 k allocs: 1.11 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse                          | 14  allocs: 1.89 kB       |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                             | 7  allocs: 0.266 kB       |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward                        | 0.058 k allocs: 2.91 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse                        | 0.857 k allocs: 1.11 MB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)                      | 0.0529 M allocs: 2.06 MB  |
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
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                             | 0.036 k allocs: 1.11 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                             | 14  allocs: 1.86 kB       |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                                | 7  allocs: 0.266 kB       |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward                           | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse                           | 0.971 k allocs: 1.25 MB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)                         | 0.0577 M allocs: 2.22 MB  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                             | 0.036 k allocs: 1.11 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                             | 14  allocs: 1.97 kB       |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                                | 7  allocs: 0.266 kB       |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward                           | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse                           | 0.971 k allocs: 1.25 MB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)                         | 0.0577 M allocs: 2.22 MB  |
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
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme forward     | 0.052 k allocs: 2.39 kB   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Enzyme reverse     | 10  allocs: 0.531 kB      |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ForwardDiff        | 0.048 k allocs: 3.12 kB   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake forward   | 0.11 k allocs: 5.53 kB    |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/Mooncake reverse   | 0.815 k allocs: 1.34 MB   |
| AD gradients/Timeseries convolve discretised Convolved Gamma+LogNormal delay/ReverseDiff (tape) | 0.133 M allocs: 5.45 MB   |
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
| Convolved/numeric/cdf batched                                                                   | 13  allocs: 8.43 kB       |
| Convolved/numeric/cdf scalar                                                                    | 0  allocs: 0 B            |
| Convolved/numeric/construction                                                                  | 0  allocs: 0 B            |
| Convolved/numeric/logpdf batched                                                                | 14  allocs: 8.52 kB       |
| Convolved/numeric/logpdf broadcast                                                              | 2  allocs: 0.906 kB       |
| Convolved/numeric/logpdf scalar                                                                 | 0  allocs: 0 B            |
| Convolved/numeric/mean                                                                          | 0  allocs: 0 B            |
| Convolved/numeric/pdf batched                                                                   | 12  allocs: 7.61 kB       |
| Convolved/numeric/pdf scalar                                                                    | 0  allocs: 0 B            |
| Convolved/numeric/rand                                                                          | 2  allocs: 0.906 kB       |
| Difference/analytic/cdf broadcast                                                               | 2  allocs: 0.906 kB       |
| Difference/analytic/cdf scalar                                                                  | 0  allocs: 0 B            |
| Difference/analytic/construction                                                                | 0  allocs: 0 B            |
| Difference/analytic/logpdf broadcast                                                            | 2  allocs: 0.906 kB       |
| Difference/analytic/logpdf scalar                                                               | 0  allocs: 0 B            |
| Difference/analytic/mean                                                                        | 0  allocs: 0 B            |
| Difference/analytic/rand                                                                        | 2  allocs: 0.906 kB       |
| Difference/numeric/cdf broadcast                                                                | 2  allocs: 0.906 kB       |
| Difference/numeric/cdf scalar                                                                   | 0  allocs: 0 B            |
| Difference/numeric/construction                                                                 | 0  allocs: 0 B            |
| Difference/numeric/logpdf broadcast                                                             | 2  allocs: 0.906 kB       |
| Difference/numeric/logpdf scalar                                                                | 0  allocs: 0 B            |
| Difference/numeric/mean                                                                         | 0  allocs: 0 B            |
| Difference/numeric/rand                                                                         | 2  allocs: 0.906 kB       |
| Product/analytic/cdf broadcast                                                                  | 2  allocs: 0.906 kB       |
| Product/analytic/cdf scalar                                                                     | 0  allocs: 0 B            |
| Product/analytic/construction                                                                   | 0  allocs: 0 B            |
| Product/analytic/logpdf broadcast                                                               | 2  allocs: 0.906 kB       |
| Product/analytic/logpdf scalar                                                                  | 0  allocs: 0 B            |
| Product/analytic/mean                                                                           | 0  allocs: 0 B            |
| Product/analytic/rand                                                                           | 2  allocs: 0.906 kB       |
| Product/numeric/cdf broadcast                                                                   | 2  allocs: 0.906 kB       |
| Product/numeric/cdf scalar                                                                      | 0  allocs: 0 B            |
| Product/numeric/construction                                                                    | 0  allocs: 0 B            |
| Product/numeric/logpdf broadcast                                                                | 2  allocs: 0.906 kB       |
| Product/numeric/logpdf scalar                                                                   | 0  allocs: 0 B            |
| Product/numeric/mean                                                                            | 0  allocs: 0 B            |
| Product/numeric/rand                                                                            | 2  allocs: 0.906 kB       |
| Quantile/Convolved analytic/grid                                                                | 5.71 k allocs: 0.324 MB   |
| Quantile/Convolved analytic/median                                                              | 0.265 k allocs: 15.6 kB   |
| Quantile/Convolved numeric/median                                                               | 0.282 k allocs: 16.4 kB   |
| Quantile/Difference numeric/median                                                              | 0.242 k allocs: 14.8 kB   |
| Quantile/Product numeric/median                                                                 | 0.297 k allocs: 17.1 kB   |
| Timeseries/Convolved delay                                                                      | 4  allocs: 0.594 kB       |
| Timeseries/Gamma delay                                                                          | 4  allocs: 0.594 kB       |
| Timeseries/Poisson delay                                                                        | 4  allocs: 0.594 kB       |
| time_to_load                                                                                    | 0.149 k allocs: 11.2 kB   |

