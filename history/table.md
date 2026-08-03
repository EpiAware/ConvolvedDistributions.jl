|                                                                                     | v0.3.1              | v0.3.0              | v0.2.0              | 79e06efe85e74d...   |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:-------------------:|:-------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0626 ± 0.0035 ms  | 0.062 ± 0.0037 ms   | 0.0621 ± 0.0035 ms  | 0.0621 ± 0.0037 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.465 ± 0.047 ms    | 0.465 ± 0.048 ms    | 0.472 ± 0.046 ms    | 0.47 ± 0.047 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0521 ± 0.00038 ms | 0.0529 ± 0.00042 ms | 0.0528 ± 0.0004 ms  | 0.0529 ± 0.00043 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.252 ± 0.007 ms    | 0.253 ± 0.0067 ms   | 0.254 ± 0.0069 ms   | 0.251 ± 0.0074 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.578 ± 0.024 ms    | 0.579 ± 0.023 ms    | 0.58 ± 0.028 ms     | 0.606 ± 0.032 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.23 ± 0.28 ms      | 2.22 ± 0.29 ms      | 2.25 ± 0.28 ms      | 2.24 ± 0.28 ms      |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0861 ± 0.0066 ms  | 0.0871 ± 0.0075 ms  | 0.0863 ± 0.0069 ms  | 0.0868 ± 0.0068 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.464 ± 0.049 ms    | 0.463 ± 0.048 ms    | 0.467 ± 0.048 ms    | 0.468 ± 0.046 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0655 ± 0.00067 ms | 0.0656 ± 0.00064 ms | 0.0654 ± 0.00067 ms | 0.0654 ± 0.00078 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.523 ± 0.014 ms    | 0.527 ± 0.014 ms    | 0.525 ± 0.014 ms    | 0.52 ± 0.014 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.574 ± 0.023 ms    | 0.586 ± 0.023 ms    | 0.576 ± 0.023 ms    | 0.586 ± 0.026 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.54 ± 0.33 ms      | 2.55 ± 0.34 ms      | 2.54 ± 0.33 ms      | 2.57 ± 0.34 ms      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0729 ± 0.0004 ms  | 0.073 ± 0.00049 ms  | 0.0732 ± 0.00049 ms | 0.073 ± 0.00053 ms  |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.121 ± 0.0063 ms   | 0.122 ± 0.007 ms    | 0.122 ± 0.0069 ms   | 0.123 ± 0.0069 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0684 ± 0.00016 ms | 0.0686 ± 0.0002 ms  | 0.0685 ± 0.00018 ms | 0.0679 ± 0.00024 ms |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.29 ± 0.0089 ms    | 0.292 ± 0.009 ms    | 0.292 ± 0.0093 ms   | 0.292 ± 0.0093 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.551 ± 0.024 ms    | 0.553 ± 0.022 ms    | 0.552 ± 0.022 ms    | 0.572 ± 0.036 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.5 ± 0.3 ms        | 2.48 ± 0.31 ms      | 2.5 ± 0.3 ms        | 2.51 ± 0.3 ms       |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.2 ± 0.11 μs       | 7.21 ± 0.11 μs      | 7.28 ± 0.14 μs      | 7.26 ± 0.15 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0471 ± 0.015 μs   | 0.0469 ± 0.0059 μs  | 0.0466 ± 0.0057 μs  | 0.0486 ± 0.015 μs   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.588 ± 0.041 μs    | 0.542 ± 0.041 μs    | 0.537 ± 0.042 μs    | 0.53 ± 0.046 μs     |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.11 ± 0.66 μs      | 5.13 ± 0.74 μs      | 5.06 ± 0.75 μs      | 5.11 ± 0.69 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.54 ± 0.23 μs      | 4.52 ± 0.24 μs      | 4.57 ± 0.29 μs      | 4.58 ± 0.29 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.51 ± 0.082 μs     | 2.57 ± 0.17 μs      | 2.55 ± 0.14 μs      | 2.49 ± 0.088 μs     |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0928 ± 0.00074 ms | 0.0926 ± 0.00076 ms | 0.0933 ± 0.00074 ms | 0.0936 ± 0.00073 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.143 ± 0.007 ms    | 0.143 ± 0.0071 ms   | 0.145 ± 0.0073 ms   | 0.147 ± 0.0079 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0846 ± 0.00022 ms | 0.0842 ± 0.00019 ms | 0.0842 ± 0.00023 ms | 0.0845 ± 0.00022 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.376 ± 0.0093 ms   | 0.377 ± 0.0092 ms   | 0.377 ± 0.0097 ms   | 0.378 ± 0.0099 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.621 ± 0.032 ms    | 0.599 ± 0.022 ms    | 0.609 ± 0.028 ms    | 0.614 ± 0.032 ms    |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.37 ± 0.29 ms      | 2.39 ± 0.3 ms       | 2.39 ± 0.29 ms      | 2.41 ± 0.3 ms       |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.15 ± 0.08 μs      | 8.16 ± 0.063 μs     | 8.2 ± 0.087 μs      | 8.2 ± 0.083 μs      |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.38 ± 0.06 μs      | 3.4 ± 0.094 μs      | 3.38 ± 0.1 μs       | 3.38 ± 0.067 μs     |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.62 ± 0.082 μs     | 0.613 ± 0.083 μs    | 0.607 ± 0.083 μs    | 0.613 ± 0.084 μs    |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.72 ± 0.31 μs      | 5.68 ± 0.46 μs      | 5.79 ± 0.46 μs      | 5.68 ± 0.29 μs      |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.6 ± 3.1 μs       | 27.8 ± 3.2 μs       | 28.3 ± 3.2 μs       | 28.2 ± 3.1 μs       |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 17.1 ± 0.46 μs      | 17.2 ± 0.41 μs      | 17.1 ± 0.47 μs      | 17.4 ± 0.5 μs       |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.119 ± 0.001 ms    | 0.121 ± 0.001 ms    | 0.12 ± 0.00098 ms   | 0.12 ± 0.0011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.206 ± 0.011 ms    | 0.21 ± 0.011 ms     | 0.209 ± 0.011 ms    | 0.207 ± 0.011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.118 ± 0.00036 ms  | 0.118 ± 0.00051 ms  | 0.117 ± 0.00057 ms  | 0.117 ± 0.00049 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.503 ± 0.01 ms     | 0.503 ± 0.01 ms     | 0.501 ± 0.01 ms     | 0.501 ± 0.011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.84 ± 0.027 ms     | 0.833 ± 0.029 ms    | 0.841 ± 0.03 ms     | 0.843 ± 0.03 ms     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.23 ± 0.52 ms      | 4.22 ± 0.55 ms      | 4.31 ± 0.63 ms      | 4.3 ± 0.53 ms       |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.23 ± 0.11 μs      | 7.21 ± 0.12 μs      | 7.26 ± 0.26 μs      | 7.24 ± 0.14 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0472 ± 0.016 μs   | 0.0474 ± 0.0093 μs  | 0.0472 ± 0.0055 μs  | 0.0516 ± 0.016 μs   |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.58 ± 0.039 μs     | 0.561 ± 0.041 μs    | 0.529 ± 0.051 μs    | 0.543 ± 0.046 μs    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.08 ± 0.63 μs      | 5.17 ± 0.75 μs      | 5.11 ± 0.77 μs      | 5.12 ± 0.68 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.61 ± 0.23 μs      | 4.56 ± 0.25 μs      | 4.59 ± 0.32 μs      | 4.61 ± 0.27 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.49 ± 0.096 μs     | 2.56 ± 0.16 μs      | 2.55 ± 0.086 μs     | 2.51 ± 0.1 μs       |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.145 ± 0.0012 ms   | 0.145 ± 0.0012 ms   | 0.146 ± 0.0013 ms   | 0.145 ± 0.0014 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.237 ± 0.011 ms    | 0.234 ± 0.01 ms     | 0.235 ± 0.01 ms     | 0.238 ± 0.012 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.14 ± 0.00056 ms   | 0.14 ± 0.0006 ms    | 0.14 ± 0.00069 ms   | 0.141 ± 0.00083 ms  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.625 ± 0.0094 ms   | 0.624 ± 0.009 ms    | 0.624 ± 0.0092 ms   | 0.623 ± 0.0093 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.912 ± 0.026 ms    | 0.913 ± 0.021 ms    | 0.906 ± 0.024 ms    | 0.912 ± 0.019 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.17 ± 0.52 ms      | 4.15 ± 0.55 ms      | 4.2 ± 0.55 ms       | 4.19 ± 0.52 ms      |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 8.06 ± 0.068 μs     | 8.15 ± 0.09 μs      | 8.13 ± 0.097 μs     | 8.07 ± 0.088 μs     |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.21 ± 0.08 μs      | 3.18 ± 0.061 μs     | 3.24 ± 0.11 μs      | 3.21 ± 0.071 μs     |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.591 ± 0.082 μs    | 0.574 ± 0.081 μs    | 0.599 ± 0.084 μs    | 0.571 ± 0.086 μs    |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.46 ± 0.31 μs      | 5.42 ± 0.33 μs      | 5.54 ± 0.46 μs      | 5.48 ± 0.31 μs      |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 27.3 ± 3.1 μs       | 27.2 ± 3 μs         | 27.5 ± 3.1 μs       | 28 ± 3.2 μs         |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.2 ± 0.56 μs      | 18.6 ± 0.54 μs      | 18.4 ± 0.56 μs      | 18.4 ± 0.6 μs       |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.24 ± 0.11 μs      | 7.29 ± 0.12 μs      | 7.36 ± 0.3 μs       | 7.29 ± 0.14 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0704 ± 0.017 μs   | 0.0714 ± 0.0061 μs  | 0.0697 ± 0.0058 μs  | 0.0704 ± 0.015 μs   |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.657 ± 0.042 μs    | 0.607 ± 0.044 μs    | 0.606 ± 0.047 μs    | 0.612 ± 0.051 μs    |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.4 ± 0.56 μs       | 5.4 ± 0.62 μs       | 5.32 ± 0.62 μs      | 5.35 ± 0.55 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.47 ± 0.95 μs      | 6.43 ± 0.93 μs      | 6.58 ± 0.77 μs      | 6.43 ± 0.83 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.1 ± 0.31 μs      | 10.1 ± 0.32 μs      | 10.2 ± 0.28 μs      | 10.2 ± 0.45 μs      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.123 ± 0.0011 ms   | 0.123 ± 0.001 ms    | 0.123 ± 0.00093 ms  | 0.124 ± 0.0011 ms   |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.211 ± 0.011 ms    | 0.211 ± 0.011 ms    | 0.21 ± 0.011 ms     | 0.211 ± 0.012 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.119 ± 0.00052 ms  | 0.119 ± 0.00039 ms  | 0.119 ± 0.00045 ms  | 0.119 ± 0.00037 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.529 ± 0.0098 ms   | 0.533 ± 0.011 ms    | 0.53 ± 0.01 ms      | 0.53 ± 0.011 ms     |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.868 ± 0.025 ms    | 0.869 ± 0.019 ms    | 0.876 ± 0.022 ms    | 0.877 ± 0.021 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.77 ± 0.57 ms      | 4.73 ± 0.56 ms      | 4.76 ± 0.55 ms      | 4.79 ± 0.58 ms      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.15 ± 0.0013 ms    | 0.15 ± 0.0013 ms    | 0.15 ± 0.0014 ms    | 0.15 ± 0.0013 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.243 ± 0.011 ms    | 0.244 ± 0.011 ms    | 0.244 ± 0.01 ms     | 0.247 ± 0.012 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00058 ms  | 0.143 ± 0.00054 ms  | 0.143 ± 0.0007 ms   | 0.143 ± 0.00049 ms  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.648 ± 0.0086 ms   | 0.648 ± 0.0083 ms   | 0.649 ± 0.0089 ms   | 0.649 ± 0.0092 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.946 ± 0.017 ms    | 0.944 ± 0.016 ms    | 0.954 ± 0.021 ms    | 0.958 ± 0.022 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.62 ± 0.56 ms      | 4.64 ± 0.58 ms      | 4.65 ± 0.55 ms      | 4.73 ± 0.59 ms      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.13 ± 0.087 μs     | 8.14 ± 0.093 μs     | 8.15 ± 0.09 μs      | 8.16 ± 0.11 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.3 ± 0.065 μs      | 3.31 ± 0.064 μs     | 3.29 ± 0.11 μs      | 3.3 ± 0.084 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.572 ± 0.084 μs    | 0.58 ± 0.081 μs     | 0.584 ± 0.084 μs    | 0.585 ± 0.084 μs    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.69 ± 0.31 μs      | 5.78 ± 0.36 μs      | 5.7 ± 0.43 μs       | 5.7 ± 0.35 μs       |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.4 ± 1.1 μs       | 17.3 ± 1.1 μs       | 17.9 ± 1.6 μs       | 17.4 ± 1.2 μs       |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 21.9 ± 0.6 μs       | 22.2 ± 0.59 μs      | 22 ± 0.56 μs        | 22.3 ± 0.66 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.39 ± 0.1 μs       | 7.38 ± 0.088 μs     | 7.45 ± 0.11 μs      | 7.4 ± 0.1 μs        |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 6.92 ± 0.055 μs     | 7.1 ± 0.065 μs      | 7.04 ± 0.062 μs     | 7.05 ± 0.08 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.945 ± 0.04 μs     | 0.946 ± 0.047 μs    | 0.98 ± 0.11 μs      | 0.934 ± 0.049 μs    |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.11 ± 0.97 μs      | 6.05 ± 0.99 μs      | 6.18 ± 0.94 μs      | 6.12 ± 0.92 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.3 ± 0.88 μs      | 17.7 ± 1.1 μs       | 18 ± 0.96 μs        | 17.8 ± 0.88 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 29 ± 0.59 μs        | 29.1 ± 0.59 μs      | 29.1 ± 0.6 μs       | 28.7 ± 0.65 μs      |
| Baseline/Gamma/cdf                                                                  | 3.57 ± 0.36 μs      | 3.55 ± 0.38 μs      | 3.71 ± 0.02 μs      | 3.6 ± 0.38 μs       |
| Baseline/Gamma/logpdf                                                               | 2.89 ± 0.34 μs      | 2.86 ± 0.33 μs      | 2.86 ± 0.34 μs      | 2.93 ± 0.34 μs      |
| Baseline/Normal/cdf                                                                 | 1.54 ± 0.3 μs       | 1.47 ± 0.31 μs      | 1.46 ± 0.31 μs      | 1.51 ± 0.32 μs      |
| Baseline/Normal/logpdf                                                              | 1.05 ± 0.023 μs     | 1.05 ± 0.025 μs     | 1.05 ± 0.025 μs     | 1.06 ± 0.028 μs     |
| Convolved/analytic/cdf batched                                                      | 2.66 ± 0.35 μs      | 2.63 ± 0.34 μs      | 2.64 ± 0.34 μs      | 2.67 ± 0.34 μs      |
| Convolved/analytic/cdf scalar                                                       | 28 ± 0.1 ns         | 28.1 ± 0.22 ns      | 28.1 ± 0.33 ns      | 28.2 ± 0.07 ns      |
| Convolved/analytic/construction                                                     | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.41 ± 0.01 ns      | 4.03 ± 0.01 ns      |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.025 μs     | 1.09 ± 0.023 μs     | 1.08 ± 0.026 μs     | 1.08 ± 0.031 μs     |
| Convolved/analytic/logpdf broadcast                                                 | 2.57 ± 0.34 μs      | 2.54 ± 0.34 μs      | 2.54 ± 0.34 μs      | 2.55 ± 0.35 μs      |
| Convolved/analytic/logpdf scalar                                                    | 28.1 ± 0.13 ns      | 27.8 ± 0.071 ns     | 27.7 ± 0.08 ns      | 28.2 ± 0.25 ns      |
| Convolved/analytic/mean                                                             | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       | 2.79 ± 0.01 ns      | 3.41 ± 0.01 ns      |
| Convolved/analytic/pdf batched                                                      | 1.13 ± 0.029 μs     | 1.12 ± 0.031 μs     | 1.12 ± 0.032 μs     | 1.13 ± 0.036 μs     |
| Convolved/analytic/pdf scalar                                                       | 30.1 ± 0.11 ns      | 29.9 ± 0.22 ns      | 29.8 ± 0.081 ns     | 29.9 ± 0.33 ns      |
| Convolved/analytic/rand                                                             | 1.23 ± 0.067 μs     | 1.14 ± 0.033 μs     | 1.12 ± 0.032 μs     | 1.13 ± 0.034 μs     |
| Convolved/numeric/cdf batched                                                       | 0.832 ± 0.0053 ms   | 0.831 ± 0.0019 ms   | 1.11 ± 0.0025 ms    | 0.836 ± 0.0024 ms   |
| Convolved/numeric/cdf scalar                                                        | 16.8 ± 0.07 μs      | 15.6 ± 0.061 μs     | 15.6 ± 0.06 μs      | 15.6 ± 0.07 μs      |
| Convolved/numeric/construction                                                      | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       |
| Convolved/numeric/logpdf batched                                                    | 0.743 ± 0.0048 ms   | 0.735 ± 0.0064 ms   | 0.733 ± 0.0061 ms   | 0.732 ± 0.0059 ms   |
| Convolved/numeric/logpdf broadcast                                                  | 1.34 ± 0.0094 ms    | 1.35 ± 0.009 ms     | 1.35 ± 0.0091 ms    | 1.35 ± 0.0095 ms    |
| Convolved/numeric/logpdf scalar                                                     | 12.5 ± 0.04 μs      | 12.6 ± 0.041 μs     | 12.5 ± 0.031 μs     | 12.6 ± 0.041 μs     |
| Convolved/numeric/mean                                                              | 6.61 ± 0.041 ns     | 6.58 ± 0.03 ns      | 6.58 ± 0.049 ns     | 6.66 ± 0.01 ns      |
| Convolved/numeric/pdf batched                                                       | 0.741 ± 0.0061 ms   | 0.733 ± 0.0065 ms   | 0.733 ± 0.0064 ms   | 0.731 ± 0.0058 ms   |
| Convolved/numeric/pdf scalar                                                        | 12.4 ± 0.039 μs     | 12.6 ± 0.04 μs      | 12.5 ± 0.031 μs     | 12.5 ± 0.039 μs     |
| Convolved/numeric/rand                                                              | 3.07 ± 0.36 μs      | 2.96 ± 0.37 μs      | 2.82 ± 0.36 μs      | 2.79 ± 0.37 μs      |
| Difference/analytic/cdf broadcast                                                   | 3.36 ± 0.35 μs      | 3.41 ± 0.39 μs      | 3.39 ± 0.38 μs      | 3.37 ± 0.35 μs      |
| Difference/analytic/cdf scalar                                                      | 10.8 ± 0.02 ns      | 10.8 ± 0.02 ns      | 10.8 ± 0.02 ns      | 10.8 ± 0.03 ns      |
| Difference/analytic/construction                                                    | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.42 ± 0.01 ns      | 3.41 ± 0.01 ns      |
| Difference/analytic/logpdf broadcast                                                | 1.51 ± 0.3 μs       | 1.79 ± 0.38 μs      | 1.51 ± 0.32 μs      | 1.52 ± 0.32 μs      |
| Difference/analytic/logpdf scalar                                                   | 16.8 ± 0.23 ns      | 16.9 ± 0.25 ns      | 17 ± 0.1 ns         | 17 ± 0.081 ns       |
| Difference/analytic/mean                                                            | 2.79 ± 0.01 ns      | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       |
| Difference/analytic/rand                                                            | 1.23 ± 0.076 μs     | 1.13 ± 0.035 μs     | 1.12 ± 0.034 μs     | 1.13 ± 0.039 μs     |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     | 1.35 ± 0.018 ms     |
| Difference/numeric/cdf scalar                                                       | 19.4 ± 0.09 μs      | 19.5 ± 0.09 μs      | 19.4 ± 0.081 μs     | 19.5 ± 0.1 μs       |
| Difference/numeric/construction                                                     | 3.41 ± 0.01 ns      | 3.72 ± 0.001 ns     | 3.11 ± 0.01 ns      | 4.33 ± 0.01 ns      |
| Difference/numeric/logpdf broadcast                                                 | 1.65 ± 0.015 ms     | 1.66 ± 0.016 ms     | 1.65 ± 0.016 ms     | 1.65 ± 0.016 ms     |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.08 μs      | 16.8 ± 0.08 μs      | 16.8 ± 0.08 μs      | 16.8 ± 0.071 μs     |
| Difference/numeric/mean                                                             | 6.59 ± 0.049 ns     | 6.65 ± 0.011 ns     | 6.54 ± 0.029 ns     | 6.65 ± 0.02 ns      |
| Difference/numeric/rand                                                             | 3.08 ± 0.36 μs      | 3 ± 0.35 μs         | 2.81 ± 0.36 μs      | 2.79 ± 0.35 μs      |
| Product/analytic/cdf broadcast                                                      | 4.89 ± 0.2 μs       | 4.9 ± 0.2 μs        | 4.89 ± 0.21 μs      | 4.91 ± 0.2 μs       |
| Product/analytic/cdf scalar                                                         | 29.6 ± 0.1 ns       | 29.5 ± 0.1 ns       | 29.7 ± 0.11 ns      | 29.7 ± 0.68 ns      |
| Product/analytic/construction                                                       | 3.41 ± 0.01 ns      | 4.64 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      |
| Product/analytic/logpdf broadcast                                                   | 2.2 ± 0.34 μs       | 2.18 ± 0.33 μs      | 2.22 ± 0.35 μs      | 2.18 ± 0.34 μs      |
| Product/analytic/logpdf scalar                                                      | 23.8 ± 0.11 ns      | 24 ± 0.12 ns        | 24 ± 0.08 ns        | 24 ± 0.09 ns        |
| Product/analytic/mean                                                               | 10.8 ± 0.039 ns     | 10.8 ± 0.031 ns     | 10.8 ± 0.049 ns     | 10.8 ± 0.04 ns      |
| Product/analytic/rand                                                               | 1.91 ± 0.31 μs      | 2.1 ± 0.4 μs        | 1.77 ± 0.32 μs      | 1.78 ± 0.32 μs      |
| Product/numeric/cdf broadcast                                                       | 1.98 ± 0.015 ms     | 1.98 ± 0.016 ms     | 1.98 ± 0.016 ms     | 1.98 ± 0.016 ms     |
| Product/numeric/cdf scalar                                                          | 23.1 ± 0.091 μs     | 23.1 ± 0.1 μs       | 23.2 ± 0.09 μs      | 23.2 ± 0.1 μs       |
| Product/numeric/construction                                                        | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      |
| Product/numeric/logpdf broadcast                                                    | 1.76 ± 0.015 ms     | 1.77 ± 0.015 ms     | 1.78 ± 0.016 ms     | 1.77 ± 0.016 ms     |
| Product/numeric/logpdf scalar                                                       | 17.5 ± 0.07 μs      | 17.6 ± 0.08 μs      | 17.6 ± 0.071 μs     | 17.6 ± 0.091 μs     |
| Product/numeric/mean                                                                | 6.74 ± 0.06 ns      | 6.71 ± 0.04 ns      | 6.73 ± 0.2 ns       | 6.71 ± 0.04 ns      |
| Product/numeric/rand                                                                | 3.09 ± 0.35 μs      | 2.97 ± 0.34 μs      | 2.82 ± 0.36 μs      | 2.8 ± 0.36 μs       |
| Quantile/Convolved analytic/grid                                                    | 0.75 ± 0.11 ms      | 0.753 ± 0.12 ms     | 0.751 ± 0.12 ms     | 0.753 ± 0.12 ms     |
| Quantile/Convolved analytic/median                                                  | 29.3 ± 0.92 μs      | 28.6 ± 0.94 μs      | 29.1 ± 1 μs         | 29.5 ± 1.2 μs       |
| Quantile/Convolved numeric/median                                                   | 0.298 ± 0.011 ms    | 0.298 ± 0.011 ms    | 0.299 ± 0.012 ms    | 0.299 ± 0.012 ms    |
| Quantile/Difference numeric/median                                                  | 0.347 ± 0.011 ms    | 0.348 ± 0.011 ms    | 0.349 ± 0.011 ms    | 0.351 ± 0.012 ms    |
| Quantile/Product numeric/median                                                     | 0.504 ± 0.012 ms    | 0.505 ± 0.012 ms    | 0.506 ± 0.012 ms    | 0.51 ± 0.013 ms     |
| Timeseries/Convolved delay                                                          | 0.359 ± 0.01 μs     | 0.358 ± 0.01 μs     | 0.357 ± 0.0081 μs   | 0.356 ± 0.0096 μs   |
| Timeseries/Gamma delay                                                              | 0.358 ± 0.011 μs    | 0.356 ± 0.01 μs     | 0.356 ± 0.072 μs    | 0.356 ± 0.01 μs     |
| Timeseries/Poisson delay                                                            | 1.27 ± 0.028 μs     | 1.27 ± 0.019 μs     | 1.27 ± 0.02 μs      | 1.27 ± 0.032 μs     |
| time_to_load                                                                        | 0.863 ± 0.0063 s    | 0.873 ± 0.007 s     | 0.851 ± 0.0048 s    | 0.91 ± 0.0051 s     |

|                                                                                     | v0.3.1                    | v0.3.0                    | v0.2.0                    | 79e06efe85e74d...         |
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

