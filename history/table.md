|                                                                                     | v0.3.1              | v0.3.0              | v0.2.0              | 5709ceb8b7aaa6...   |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:-------------------:|:-------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0625 ± 0.0037 ms  | 0.0631 ± 0.0036 ms  | 0.0631 ± 0.0035 ms  | 0.0624 ± 0.0034 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.462 ± 0.047 ms    | 0.465 ± 0.047 ms    | 0.477 ± 0.043 ms    | 0.467 ± 0.044 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0541 ± 0.00038 ms | 0.0529 ± 0.00038 ms | 0.0529 ± 0.00046 ms | 0.0539 ± 0.00042 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.254 ± 0.0067 ms   | 0.253 ± 0.0066 ms   | 0.254 ± 0.0087 ms   | 0.253 ± 0.0067 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.579 ± 0.024 ms    | 0.586 ± 0.026 ms    | 0.598 ± 0.036 ms    | 0.587 ± 0.026 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.23 ± 0.3 ms       | 2.23 ± 0.27 ms      | 2.23 ± 0.28 ms      | 2.22 ± 0.27 ms      |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0861 ± 0.0066 ms  | 0.0862 ± 0.0075 ms  | 0.0867 ± 0.0067 ms  | 0.087 ± 0.0074 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.46 ± 0.047 ms     | 0.466 ± 0.046 ms    | 0.492 ± 0.04 ms     | 0.465 ± 0.047 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0662 ± 0.00086 ms | 0.0657 ± 0.00065 ms | 0.0657 ± 0.0009 ms  | 0.0662 ± 0.00082 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.523 ± 0.013 ms    | 0.522 ± 0.014 ms    | 0.526 ± 0.015 ms    | 0.523 ± 0.014 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.573 ± 0.023 ms    | 0.586 ± 0.026 ms    | 0.597 ± 0.035 ms    | 0.586 ± 0.025 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.53 ± 0.33 ms      | 2.54 ± 0.32 ms      | 2.57 ± 0.35 ms      | 2.55 ± 0.31 ms      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0728 ± 0.0004 ms  | 0.074 ± 0.00049 ms  | 0.0725 ± 0.00055 ms | 0.0738 ± 0.00048 ms |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.122 ± 0.0061 ms   | 0.122 ± 0.0066 ms   | 0.126 ± 0.0078 ms   | 0.123 ± 0.0057 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0698 ± 0.00014 ms | 0.0684 ± 0.00018 ms | 0.0683 ± 0.00017 ms | 0.0698 ± 0.00012 ms |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.293 ± 0.0091 ms   | 0.292 ± 0.0088 ms   | 0.292 ± 0.0092 ms   | 0.292 ± 0.0089 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.546 ± 0.02 ms     | 0.558 ± 0.029 ms    | 0.573 ± 0.038 ms    | 0.552 ± 0.024 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.47 ± 0.3 ms       | 2.51 ± 0.3 ms       | 2.47 ± 0.31 ms      | 2.5 ± 0.3 ms        |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.27 ± 0.28 μs      | 7.19 ± 0.22 μs      | 7.17 ± 0.31 μs      | 7.22 ± 0.3 μs       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0468 ± 0.0055 μs  | 0.0462 ± 0.0061 μs  | 0.0498 ± 0.0089 μs  | 0.0465 ± 0.016 μs   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.556 ± 0.047 μs    | 0.533 ± 0.042 μs    | 0.548 ± 0.044 μs    | 0.527 ± 0.041 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.01 ± 0.72 μs      | 5.05 ± 0.68 μs      | 5.06 ± 0.7 μs       | 5.07 ± 0.58 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.56 ± 0.27 μs      | 4.53 ± 0.25 μs      | 4.7 ± 0.33 μs       | 4.58 ± 0.25 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.51 ± 0.072 μs     | 2.51 ± 0.079 μs     | 2.52 ± 0.079 μs     | 2.51 ± 0.067 μs     |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0932 ± 0.00065 ms | 0.0941 ± 0.00063 ms | 0.0936 ± 0.00068 ms | 0.0937 ± 0.00068 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.145 ± 0.0071 ms   | 0.145 ± 0.0078 ms   | 0.148 ± 0.0077 ms   | 0.146 ± 0.0067 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0858 ± 0.0002 ms  | 0.0844 ± 0.00019 ms | 0.0846 ± 0.00028 ms | 0.0856 ± 0.00024 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.377 ± 0.0096 ms   | 0.377 ± 0.0091 ms   | 0.377 ± 0.0095 ms   | 0.377 ± 0.0094 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.592 ± 0.019 ms    | 0.6 ± 0.027 ms      | 0.616 ± 0.038 ms    | 0.6 ± 0.027 ms      |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.36 ± 0.29 ms      | 2.4 ± 0.29 ms       | 2.35 ± 0.29 ms      | 2.37 ± 0.29 ms      |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.08 ± 0.063 μs     | 8.08 ± 0.08 μs      | 8.07 ± 0.088 μs     | 8.06 ± 0.073 μs     |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.38 ± 0.095 μs     | 3.35 ± 0.051 μs     | 3.36 ± 0.06 μs      | 3.35 ± 0.048 μs     |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.605 ± 0.085 μs    | 0.614 ± 0.079 μs    | 0.611 ± 0.085 μs    | 0.614 ± 0.081 μs    |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.72 ± 0.44 μs      | 5.65 ± 0.26 μs      | 5.74 ± 0.34 μs      | 5.67 ± 0.23 μs      |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.7 ± 3 μs         | 27.1 ± 2.9 μs       | 28.1 ± 3.6 μs       | 27 ± 2.8 μs         |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17 ± 0.37 μs        | 17.3 ± 0.43 μs      | 17.1 ± 0.53 μs      | 17 ± 0.39 μs        |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.00095 ms  | 0.12 ± 0.00099 ms   | 0.121 ± 0.0015 ms   | 0.119 ± 0.001 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.209 ± 0.011 ms    | 0.207 ± 0.011 ms    | 0.207 ± 0.011 ms    | 0.207 ± 0.01 ms     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.117 ± 0.00033 ms  | 0.118 ± 0.00039 ms  | 0.118 ± 0.00052 ms  | 0.117 ± 0.00046 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.503 ± 0.01 ms     | 0.504 ± 0.011 ms    | 0.504 ± 0.011 ms    | 0.504 ± 0.011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.83 ± 0.019 ms     | 0.831 ± 0.019 ms    | 0.862 ± 0.046 ms    | 0.835 ± 0.025 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.24 ± 0.52 ms      | 4.3 ± 0.51 ms       | 4.24 ± 0.55 ms      | 4.26 ± 0.49 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.24 ± 0.29 μs      | 7.12 ± 0.12 μs      | 7.18 ± 0.27 μs      | 7.11 ± 0.091 μs     |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0477 ± 0.0063 μs  | 0.0469 ± 0.0088 μs  | 0.0474 ± 0.012 μs   | 0.0473 ± 0.016 μs   |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.54 ± 0.046 μs     | 0.53 ± 0.039 μs     | 0.537 ± 0.043 μs    | 0.529 ± 0.04 μs     |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.08 ± 0.75 μs      | 4.98 ± 0.71 μs      | 5.12 ± 0.71 μs      | 4.88 ± 0.7 μs       |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.69 ± 0.27 μs      | 4.44 ± 0.22 μs      | 4.68 ± 0.28 μs      | 4.48 ± 0.17 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.52 ± 0.075 μs     | 2.53 ± 0.12 μs      | 2.54 ± 0.078 μs     | 2.58 ± 0.16 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.144 ± 0.0012 ms   | 0.145 ± 0.0012 ms   | 0.145 ± 0.0015 ms   | 0.145 ± 0.0013 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.234 ± 0.012 ms    | 0.266 ± 0.012 ms    | 0.239 ± 0.011 ms    | 0.239 ± 0.012 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.139 ± 0.00054 ms  | 0.14 ± 0.00076 ms   | 0.14 ± 0.00067 ms   | 0.139 ± 0.00054 ms  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.623 ± 0.0095 ms   | 0.625 ± 0.0092 ms   | 0.624 ± 0.0094 ms   | 0.624 ± 0.0091 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.895 ± 0.015 ms    | 0.905 ± 0.02 ms     | 0.941 ± 0.041 ms    | 0.914 ± 0.023 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.15 ± 0.52 ms      | 4.19 ± 0.52 ms      | 4.15 ± 0.53 ms      | 4.18 ± 0.5 ms       |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.07 ± 0.084 μs     | 8 ± 0.08 μs         | 8 ± 0.093 μs        | 8 ± 0.092 μs        |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.2 ± 0.045 μs      | 3.18 ± 0.089 μs     | 3.18 ± 0.062 μs     | 3.18 ± 0.1 μs       |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.589 ± 0.083 μs    | 0.579 ± 0.078 μs    | 0.577 ± 0.079 μs    | 0.585 ± 0.08 μs     |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.38 ± 0.31 μs      | 5.38 ± 0.29 μs      | 5.42 ± 0.41 μs      | 5.44 ± 0.35 μs      |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 27 ± 2.9 μs         | 27.6 ± 3.3 μs       | 27.3 ± 3 μs         | 27.5 ± 3.2 μs       |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.1 ± 0.5 μs       | 18.2 ± 0.53 μs      | 18.4 ± 0.53 μs      | 18.4 ± 0.53 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.3 ± 0.29 μs       | 7.15 ± 0.12 μs      | 7.21 ± 0.3 μs       | 7.15 ± 0.085 μs     |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0687 ± 0.0059 μs  | 0.0696 ± 0.01 μs    | 0.0705 ± 0.012 μs   | 0.0691 ± 0.016 μs   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.6 ± 0.042 μs      | 0.631 ± 0.041 μs    | 0.61 ± 0.045 μs     | 0.598 ± 0.041 μs    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.27 ± 0.54 μs      | 5.29 ± 0.71 μs      | 5.34 ± 0.56 μs      | 5.21 ± 0.69 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.54 ± 0.65 μs      | 6.25 ± 0.85 μs      | 6.64 ± 0.75 μs      | 6.27 ± 0.71 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.2 ± 0.26 μs      | 10.3 ± 0.34 μs      | 10.1 ± 0.31 μs      | 10.2 ± 0.39 μs      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.00095 ms  | 0.123 ± 0.001 ms    | 0.124 ± 0.0013 ms   | 0.123 ± 0.001 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.21 ± 0.011 ms     | 0.212 ± 0.011 ms    | 0.212 ± 0.011 ms    | 0.213 ± 0.011 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.119 ± 0.00036 ms  | 0.119 ± 0.00045 ms  | 0.119 ± 0.00044 ms  | 0.119 ± 0.00041 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.53 ± 0.011 ms     | 0.529 ± 0.0096 ms   | 0.531 ± 0.01 ms     | 0.53 ± 0.011 ms     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.868 ± 0.017 ms    | 0.872 ± 0.019 ms    | 0.913 ± 0.038 ms    | 0.88 ± 0.024 ms     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.72 ± 0.56 ms      | 4.75 ± 0.51 ms      | 4.78 ± 0.57 ms      | 4.77 ± 0.55 ms      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.152 ± 0.0013 ms   | 0.15 ± 0.0014 ms    | 0.15 ± 0.0014 ms    | 0.151 ± 0.0014 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.242 ± 0.011 ms    | 0.248 ± 0.012 ms    | 0.251 ± 0.011 ms    | 0.249 ± 0.012 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00044 ms  | 0.143 ± 0.00059 ms  | 0.143 ± 0.00066 ms  | 0.143 ± 0.00056 ms  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.648 ± 0.0087 ms   | 0.65 ± 0.0087 ms    | 0.65 ± 0.0092 ms    | 0.652 ± 0.0086 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.946 ± 0.015 ms    | 0.96 ± 0.021 ms     | 0.977 ± 0.036 ms    | 0.953 ± 0.02 ms     |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.61 ± 0.55 ms      | 4.65 ± 0.54 ms      | 4.64 ± 0.56 ms      | 4.63 ± 0.55 ms      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.06 ± 0.064 μs     | 8.04 ± 0.08 μs      | 8.07 ± 0.094 μs     | 8.02 ± 0.07 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.31 ± 0.098 μs     | 3.27 ± 0.068 μs     | 3.3 ± 0.1 μs        | 3.25 ± 0.05 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.567 ± 0.08 μs     | 0.58 ± 0.08 μs      | 0.575 ± 0.082 μs    | 0.583 ± 0.081 μs    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.71 ± 0.47 μs      | 5.58 ± 0.29 μs      | 5.72 ± 0.43 μs      | 5.64 ± 0.26 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.5 ± 1.4 μs       | 16.9 ± 1 μs         | 17.9 ± 1.6 μs       | 17 ± 0.71 μs        |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 22 ± 0.52 μs        | 21.9 ± 0.55 μs      | 21.8 ± 0.58 μs      | 22.1 ± 0.57 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.29 ± 0.078 μs     | 7.28 ± 0.1 μs       | 7.3 ± 0.13 μs       | 7.34 ± 0.11 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 6.92 ± 0.066 μs     | 7.13 ± 0.088 μs     | 7.56 ± 0.083 μs     | 7.26 ± 0.072 μs     |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.936 ± 0.076 μs    | 0.956 ± 0.11 μs     | 0.94 ± 0.09 μs      | 0.933 ± 0.097 μs    |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.04 ± 0.9 μs       | 6 ± 0.92 μs         | 6.11 ± 0.99 μs      | 5.97 ± 0.88 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.3 ± 0.88 μs      | 17.3 ± 0.91 μs      | 18.3 ± 1.3 μs       | 17.9 ± 1.1 μs       |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 28.5 ± 0.59 μs      | 28.9 ± 0.6 μs       | 29.1 ± 0.76 μs      | 28.8 ± 0.62 μs      |
| Baseline/Gamma/cdf                                                                  | 3.55 ± 0.045 μs     | 3.61 ± 0.37 μs      | 5.86 ± 0.36 μs      | 3.58 ± 0.36 μs      |
| Baseline/Gamma/logpdf                                                               | 2.86 ± 0.33 μs      | 3.04 ± 0.32 μs      | 3 ± 0.34 μs         | 2.89 ± 0.34 μs      |
| Baseline/Normal/cdf                                                                 | 1.47 ± 0.3 μs       | 1.47 ± 0.3 μs       | 1.47 ± 0.3 μs       | 1.47 ± 0.3 μs       |
| Baseline/Normal/logpdf                                                              | 1.05 ± 0.027 μs     | 1.05 ± 0.026 μs     | 1.05 ± 0.029 μs     | 1.04 ± 0.025 μs     |
| Convolved/analytic/cdf batched                                                      | 2.65 ± 0.34 μs      | 2.66 ± 0.33 μs      | 2.67 ± 0.34 μs      | 2.64 ± 0.38 μs      |
| Convolved/analytic/cdf scalar                                                       | 28.3 ± 0.089 ns     | 28.3 ± 0.12 ns      | 28.1 ± 0.08 ns      | 28.1 ± 0.21 ns      |
| Convolved/analytic/construction                                                     | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 4.33 ± 0.01 ns      | 3.1 ± 0.01 ns       |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.026 μs     | 1.08 ± 0.025 μs     | 1.08 ± 0.028 μs     | 1.07 ± 0.025 μs     |
| Convolved/analytic/logpdf broadcast                                                 | 2.55 ± 0.33 μs      | 2.56 ± 0.34 μs      | 2.55 ± 0.34 μs      | 2.53 ± 0.33 μs      |
| Convolved/analytic/logpdf scalar                                                    | 28.2 ± 0.061 ns     | 28 ± 0.22 ns        | 27.9 ± 0.081 ns     | 27.8 ± 0.15 ns      |
| Convolved/analytic/mean                                                             | 2.79 ± 0.01 ns      | 2.79 ± 0.01 ns      | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       |
| Convolved/analytic/pdf batched                                                      | 1.12 ± 0.037 μs     | 1.12 ± 0.026 μs     | 1.12 ± 0.032 μs     | 1.11 ± 0.03 μs      |
| Convolved/analytic/pdf scalar                                                       | 30 ± 0.15 ns        | 29.8 ± 0.08 ns      | 30 ± 0.16 ns        | 29.9 ± 0.16 ns      |
| Convolved/analytic/rand                                                             | 1.12 ± 0.032 μs     | 1.12 ± 0.027 μs     | 1.13 ± 0.035 μs     | 1.12 ± 0.028 μs     |
| Convolved/numeric/cdf batched                                                       | 0.835 ± 0.0022 ms   | 0.833 ± 0.002 ms    | 0.832 ± 0.0053 ms   | 0.835 ± 0.0024 ms   |
| Convolved/numeric/cdf scalar                                                        | 15.7 ± 0.069 μs     | 15.7 ± 0.061 μs     | 15.7 ± 0.069 μs     | 15.7 ± 0.07 μs      |
| Convolved/numeric/construction                                                      | 3.41 ± 0.001 ns     | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.11 ± 0.01 ns      |
| Convolved/numeric/logpdf batched                                                    | 0.735 ± 0.0047 ms   | 0.745 ± 0.0034 ms   | 0.736 ± 0.0054 ms   | 0.735 ± 0.0054 ms   |
| Convolved/numeric/logpdf broadcast                                                  | 1.35 ± 0.0089 ms    | 1.35 ± 0.0094 ms    | 1.35 ± 0.0092 ms    | 1.35 ± 0.0085 ms    |
| Convolved/numeric/logpdf scalar                                                     | 12.6 ± 0.04 μs      | 12.6 ± 0.049 μs     | 12.5 ± 0.04 μs      | 12.6 ± 0.031 μs     |
| Convolved/numeric/mean                                                              | 7.21 ± 0.04 ns      | 6.58 ± 0.04 ns      | 6.58 ± 0.039 ns     | 6.61 ± 0.04 ns      |
| Convolved/numeric/pdf batched                                                       | 0.733 ± 0.0031 ms   | 0.744 ± 0.0042 ms   | 0.732 ± 0.0058 ms   | 0.734 ± 0.0057 ms   |
| Convolved/numeric/pdf scalar                                                        | 12.6 ± 0.04 μs      | 12.5 ± 0.041 μs     | 12.5 ± 0.031 μs     | 12.6 ± 0.039 μs     |
| Convolved/numeric/rand                                                              | 2.8 ± 0.35 μs       | 2.79 ± 0.35 μs      | 2.87 ± 0.36 μs      | 2.79 ± 0.35 μs      |
| Difference/analytic/cdf broadcast                                                   | 3.37 ± 0.34 μs      | 3.38 ± 0.34 μs      | 3.35 ± 0.022 μs     | 3.37 ± 0.34 μs      |
| Difference/analytic/cdf scalar                                                      | 10.8 ± 0.011 ns     | 10.8 ± 0.08 ns      | 10.8 ± 0.021 ns     | 10.8 ± 0.011 ns     |
| Difference/analytic/construction                                                    | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      | 3.72 ± 0.001 ns     |
| Difference/analytic/logpdf broadcast                                                | 1.53 ± 0.31 μs      | 1.52 ± 0.33 μs      | 1.51 ± 0.32 μs      | 1.51 ± 0.31 μs      |
| Difference/analytic/logpdf scalar                                                   | 17 ± 0.16 ns        | 17.1 ± 0.08 ns      | 17 ± 0.08 ns        | 17 ± 0.17 ns        |
| Difference/analytic/mean                                                            | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       |
| Difference/analytic/rand                                                            | 1.12 ± 0.032 μs     | 1.12 ± 0.039 μs     | 1.14 ± 0.037 μs     | 1.12 ± 0.035 μs     |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.017 ms     | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 1.36 ± 0.018 ms     |
| Difference/numeric/cdf scalar                                                       | 19.5 ± 0.081 μs     | 19.4 ± 0.09 μs      | 19.4 ± 0.11 μs      | 19.5 ± 0.09 μs      |
| Difference/numeric/construction                                                     | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      |
| Difference/numeric/logpdf broadcast                                                 | 1.65 ± 0.016 ms     | 1.66 ± 0.016 ms     | 1.65 ± 0.017 ms     | 1.65 ± 0.015 ms     |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.08 μs      | 16.8 ± 0.07 μs      | 16.8 ± 0.081 μs     | 16.8 ± 0.089 μs     |
| Difference/numeric/mean                                                             | 7.04 ± 0.051 ns     | 6.59 ± 0.051 ns     | 6.59 ± 0.031 ns     | 6.53 ± 0.03 ns      |
| Difference/numeric/rand                                                             | 2.8 ± 0.36 μs       | 2.79 ± 0.35 μs      | 2.87 ± 0.36 μs      | 2.8 ± 0.34 μs       |
| Product/analytic/cdf broadcast                                                      | 4.91 ± 0.2 μs       | 4.91 ± 0.19 μs      | 4.9 ± 0.19 μs       | 4.91 ± 0.19 μs      |
| Product/analytic/cdf scalar                                                         | 29.7 ± 0.061 ns     | 29.7 ± 0.12 ns      | 29.5 ± 0.18 ns      | 29.8 ± 0.55 ns      |
| Product/analytic/construction                                                       | 3.72 ± 0 ns         | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 4.02 ± 0.011 ns     |
| Product/analytic/logpdf broadcast                                                   | 2.24 ± 0.33 μs      | 2.21 ± 0.33 μs      | 2.21 ± 0.34 μs      | 2.22 ± 0.29 μs      |
| Product/analytic/logpdf scalar                                                      | 24.1 ± 0.15 ns      | 23.9 ± 0.09 ns      | 23.8 ± 0.17 ns      | 24 ± 0.091 ns       |
| Product/analytic/mean                                                               | 12.5 ± 0.079 ns     | 10.9 ± 0.031 ns     | 10.8 ± 0.031 ns     | 10.9 ± 0.039 ns     |
| Product/analytic/rand                                                               | 1.77 ± 0.31 μs      | 1.77 ± 0.3 μs       | 2.17 ± 0.29 μs      | 1.78 ± 0.3 μs       |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.015 ms     | 1.99 ± 0.015 ms     | 1.98 ± 0.015 ms     | 1.98 ± 0.015 ms     |
| Product/numeric/cdf scalar                                                          | 23.2 ± 0.11 μs      | 23.2 ± 0.1 μs       | 23.2 ± 0.13 μs      | 23.2 ± 0.091 μs     |
| Product/numeric/construction                                                        | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.11 ± 0.01 ns      | 3.11 ± 0.01 ns      |
| Product/numeric/logpdf broadcast                                                    | 1.77 ± 0.015 ms     | 1.77 ± 0.015 ms     | 1.77 ± 0.017 ms     | 1.77 ± 0.014 ms     |
| Product/numeric/logpdf scalar                                                       | 17.6 ± 0.08 μs      | 17.6 ± 0.08 μs      | 17.6 ± 0.09 μs      | 17.6 ± 0.07 μs      |
| Product/numeric/mean                                                                | 7.34 ± 0.041 ns     | 6.77 ± 0.24 ns      | 6.71 ± 0.039 ns     | 6.71 ± 0.039 ns     |
| Product/numeric/rand                                                                | 2.8 ± 0.35 μs       | 2.79 ± 0.35 μs      | 2.86 ± 0.35 μs      | 2.8 ± 0.33 μs       |
| Quantile/Convolved analytic/grid                                                    | 0.729 ± 0.11 ms     | 0.75 ± 0.12 ms      | 0.735 ± 0.12 ms     | 0.737 ± 0.11 ms     |
| Quantile/Convolved analytic/median                                                  | 28 ± 0.82 μs        | 28.9 ± 1 μs         | 28.5 ± 1.2 μs       | 28.4 ± 0.94 μs      |
| Quantile/Convolved numeric/median                                                   | 0.303 ± 0.012 ms    | 0.299 ± 0.012 ms    | 0.299 ± 0.012 ms    | 0.299 ± 0.012 ms    |
| Quantile/Difference numeric/median                                                  | 0.347 ± 0.01 ms     | 0.35 ± 0.01 ms      | 0.347 ± 0.011 ms    | 0.35 ± 0.011 ms     |
| Quantile/Product numeric/median                                                     | 0.505 ± 0.011 ms    | 0.507 ± 0.012 ms    | 0.507 ± 0.011 ms    | 0.506 ± 0.012 ms    |
| Timeseries/Convolved delay                                                          | 0.357 ± 0.0097 μs   | 0.354 ± 0.0099 μs   | 0.36 ± 0.0084 μs    | 0.354 ± 0.0089 μs   |
| Timeseries/Gamma delay                                                              | 0.357 ± 0.011 μs    | 0.353 ± 0.011 μs    | 0.36 ± 0.0095 μs    | 0.353 ± 0.012 μs    |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.02 μs      | 1.27 ± 0.023 μs     | 1.27 ± 0.019 μs     | 1.27 ± 0.026 μs     |
| time_to_load                                                                        | 0.863 ± 0.019 s     | 0.876 ± 0.0068 s    | 0.882 ± 0.0034 s    | 0.874 ± 0.0047 s    |

|                                                                                     | v0.3.1                    | v0.3.0                    | v0.2.0                    | 5709ceb8b7aaa6...         |
|:------------------------------------------------------------------------------------|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.088 k allocs: 11.6 kB   | 0.088 k allocs: 11.6 kB   | 0.088 k allocs: 11.6 kB   | 0.088 k allocs: 11.6 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 1.35 k allocs: 0.168 MB   | 1.35 k allocs: 0.168 MB   | 1.35 k allocs: 0.168 MB   | 1.35 k allocs: 0.168 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.04 k allocs: 4.7 kB     | 0.04 k allocs: 4.7 kB     | 0.04 k allocs: 4.7 kB     | 0.04 k allocs: 4.7 kB     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.264 k allocs: 27.2 kB   | 0.264 k allocs: 27.2 kB   | 0.264 k allocs: 27.2 kB   | 0.264 k allocs: 27.2 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 2.08 k allocs: 0.666 MB   | 2.08 k allocs: 0.666 MB   | 2.08 k allocs: 0.666 MB   | 2.08 k allocs: 0.666 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 28.5 k allocs: 1.2 MB     | 28.5 k allocs: 1.2 MB     | 28.5 k allocs: 1.2 MB     | 28.5 k allocs: 1.2 MB     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.151 k allocs: 22.6 kB   | 0.151 k allocs: 22.6 kB   | 0.151 k allocs: 22.6 kB   | 0.151 k allocs: 22.6 kB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 1.36 k allocs: 0.169 MB   | 1.36 k allocs: 0.169 MB   | 1.36 k allocs: 0.169 MB   | 1.36 k allocs: 0.169 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.081 k allocs: 7.2 kB    | 0.081 k allocs: 7.2 kB    | 0.081 k allocs: 7.2 kB    | 0.081 k allocs: 7.2 kB    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.519 k allocs: 0.0521 MB | 0.519 k allocs: 0.0521 MB | 0.519 k allocs: 0.0521 MB | 0.519 k allocs: 0.0521 MB |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 2.07 k allocs: 0.665 MB   | 2.07 k allocs: 0.665 MB   | 2.07 k allocs: 0.665 MB   | 2.07 k allocs: 0.665 MB   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 0.0327 M allocs: 1.23 MB  | 0.0327 M allocs: 1.23 MB  | 0.0327 M allocs: 1.23 MB  | 0.0327 M allocs: 1.23 MB  |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 2.35 k allocs: 0.639 MB   | 2.35 k allocs: 0.639 MB   | 2.35 k allocs: 0.639 MB   | 2.35 k allocs: 0.639 MB   |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 31.1 k allocs: 1.29 MB    | 31.1 k allocs: 1.29 MB    | 31.1 k allocs: 1.29 MB    | 31.1 k allocs: 1.29 MB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   | 0.078 k allocs: 3.41 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   | 0.147 k allocs: 18.8 kB   |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       | 21  allocs: 1.03 kB       |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    | 0.142 k allocs: 7.5 kB    |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 2.37 k allocs: 0.633 MB   | 2.37 k allocs: 0.633 MB   | 2.37 k allocs: 0.633 MB   | 2.37 k allocs: 0.633 MB   |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 30.2 k allocs: 1.26 MB    | 30.2 k allocs: 1.26 MB    | 30.2 k allocs: 1.26 MB    | 30.2 k allocs: 1.26 MB    |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 24  allocs: 1.03 kB       | 24  allocs: 1.03 kB       | 24  allocs: 1.03 kB       | 24  allocs: 1.03 kB       |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 0.289 k allocs: 0.0329 MB | 0.289 k allocs: 0.0329 MB | 0.289 k allocs: 0.0329 MB | 0.289 k allocs: 0.0329 MB |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 0.238 k allocs: 9.92 kB   | 0.238 k allocs: 9.92 kB   | 0.238 k allocs: 9.92 kB   | 0.238 k allocs: 9.92 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   | 0.078 k allocs: 3.71 kB   |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    | 0.041 k allocs: 1.7 kB    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    | 2.46 k allocs: 1.03 MB    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  | 0.0532 M allocs: 2.07 MB  |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 0.289 k allocs: 0.0331 MB | 0.289 k allocs: 0.0331 MB | 0.289 k allocs: 0.0331 MB | 0.289 k allocs: 0.0331 MB |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 0.268 k allocs: 10.9 kB   | 0.268 k allocs: 10.9 kB   | 0.268 k allocs: 10.9 kB   | 0.268 k allocs: 10.9 kB   |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    | 0.032 k allocs: 1.3 kB    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      | 2  allocs: 0.0938 kB      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       | 7  allocs: 0.484 kB       |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    | 0.07 k allocs: 3.33 kB    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 0.093 k allocs: 5.09 kB   | 0.093 k allocs: 5.09 kB   | 0.093 k allocs: 5.09 kB   | 0.093 k allocs: 5.09 kB   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 0.127 k allocs: 5.25 kB   | 0.127 k allocs: 5.25 kB   | 0.127 k allocs: 5.25 kB   | 0.127 k allocs: 5.25 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   | 0.159 k allocs: 23.1 kB   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   | 0.096 k allocs: 8.14 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   | 0.159 k allocs: 23.2 kB   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       | 27  allocs: 2.61 kB       |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     | 0.178 k allocs: 17 kB     |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    | 2.57 k allocs: 1.15 MB    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   | 0.058 M allocs: 2.44 MB   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   | 0.036 k allocs: 1.11 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       | 24  allocs: 1.02 kB       |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       | 7  allocs: 0.266 kB       |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   | 0.058 k allocs: 2.91 kB   |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 0.27 k allocs: 12.5 kB    | 0.27 k allocs: 12.5 kB    | 0.27 k allocs: 12.5 kB    | 0.27 k allocs: 12.5 kB    |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 0.298 k allocs: 12 kB     | 0.298 k allocs: 12 kB     | 0.298 k allocs: 12 kB     | 0.298 k allocs: 12 kB     |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 0.033 k allocs: 1.2 kB    | 0.033 k allocs: 1.2 kB    | 0.033 k allocs: 1.2 kB    | 0.033 k allocs: 1.2 kB    |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 10  allocs: 0.5 kB        | 10  allocs: 0.5 kB        | 10  allocs: 0.5 kB        | 10  allocs: 0.5 kB        |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 11  allocs: 0.547 kB      | 11  allocs: 0.547 kB      | 11  allocs: 0.547 kB      | 11  allocs: 0.547 kB      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 0.068 k allocs: 3.58 kB   | 0.068 k allocs: 3.58 kB   | 0.068 k allocs: 3.58 kB   | 0.068 k allocs: 3.58 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 0.198 k allocs: 16.1 kB   | 0.198 k allocs: 16.1 kB   | 0.198 k allocs: 16.1 kB   | 0.198 k allocs: 16.1 kB   |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 0.462 k allocs: 18.2 kB   | 0.462 k allocs: 18.2 kB   | 0.462 k allocs: 18.2 kB   | 0.462 k allocs: 18.2 kB   |
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
| time_to_load                                                                        | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   |

