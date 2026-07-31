|                                                                                     | v0.3.1              | v0.3.0              | v0.2.0              | 67445dc7cba989...   |
|:------------------------------------------------------------------------------------|:-------------------:|:-------------------:|:-------------------:|:-------------------:|
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme forward     | 0.0623 ± 0.0035 ms  | 0.0628 ± 0.0035 ms  | 0.0626 ± 0.0035 ms  | 0.063 ± 0.0033 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Enzyme reverse     | 0.463 ± 0.045 ms    | 0.462 ± 0.044 ms    | 0.462 ± 0.045 ms    | 0.466 ± 0.044 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ForwardDiff        | 0.0531 ± 0.00043 ms | 0.054 ± 0.00042 ms  | 0.0577 ± 0.00041 ms | 0.0535 ± 0.00039 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake forward   | 0.254 ± 0.0068 ms   | 0.253 ± 0.0069 ms   | 0.254 ± 0.0068 ms   | 0.253 ± 0.0068 ms   |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/Mooncake reverse   | 0.575 ± 0.025 ms    | 0.587 ± 0.025 ms    | 0.591 ± 0.026 ms    | 0.585 ± 0.03 ms     |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt params/ReverseDiff (tape) | 2.17 ± 0.28 ms      | 2.22 ± 0.28 ms      | 2.26 ± 0.29 ms      | 2.21 ± 0.28 ms      |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme forward     | 0.0865 ± 0.0071 ms  | 0.0866 ± 0.0078 ms  | 0.0859 ± 0.0064 ms  | 0.0865 ± 0.0067 ms  |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Enzyme reverse     | 0.464 ± 0.045 ms    | 0.463 ± 0.047 ms    | 0.463 ± 0.045 ms    | 0.468 ± 0.045 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ForwardDiff        | 0.0658 ± 0.00069 ms | 0.0663 ± 0.00072 ms | 0.0654 ± 0.00073 ms | 0.0657 ± 0.00067 ms |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake forward   | 0.524 ± 0.014 ms    | 0.52 ± 0.014 ms     | 0.525 ± 0.014 ms    | 0.524 ± 0.014 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/Mooncake reverse   | 0.58 ± 0.028 ms     | 0.586 ± 0.026 ms    | 0.587 ± 0.027 ms    | 0.582 ± 0.029 ms    |
| AD gradients/Convolved Gamma+LogNormal batched logpdf wrt points/ReverseDiff (tape) | 2.56 ± 0.32 ms      | 2.56 ± 0.32 ms      | 2.56 ± 0.32 ms      | 2.59 ± 0.32 ms      |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme forward                     | 0.0729 ± 0.00048 ms | 0.0729 ± 0.00048 ms | 0.0736 ± 0.00046 ms | 0.0731 ± 0.00046 ms |
| AD gradients/Convolved Gamma+LogNormal numerical/Enzyme reverse                     | 0.124 ± 0.0066 ms   | 0.123 ± 0.0067 ms   | 0.122 ± 0.0071 ms   | 0.123 ± 0.007 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/ForwardDiff                        | 0.0685 ± 0.00015 ms | 0.0697 ± 0.00014 ms | 0.0684 ± 0.00021 ms | 0.0693 ± 0.0002 ms  |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake forward                   | 0.292 ± 0.009 ms    | 0.293 ± 0.0088 ms   | 0.292 ± 0.0089 ms   | 0.294 ± 0.0091 ms   |
| AD gradients/Convolved Gamma+LogNormal numerical/Mooncake reverse                   | 0.554 ± 0.024 ms    | 0.558 ± 0.026 ms    | 0.555 ± 0.029 ms    | 0.556 ± 0.028 ms    |
| AD gradients/Convolved Gamma+LogNormal numerical/ReverseDiff (tape)                 | 2.45 ± 0.31 ms      | 2.51 ± 0.31 ms      | 2.51 ± 0.28 ms      | 2.49 ± 0.31 ms      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme forward                 | 7.15 ± 0.29 μs      | 7.25 ± 0.33 μs      | 7.17 ± 0.27 μs      | 7.17 ± 0.26 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Enzyme reverse                 | 0.0468 ± 0.0056 μs  | 0.047 ± 0.015 μs    | 0.046 ± 0.012 μs    | 0.047 ± 0.0058 μs   |
| AD gradients/Convolved Gamma+Normal mean+var moments/ForwardDiff                    | 0.532 ± 0.04 μs     | 0.529 ± 0.043 μs    | 0.537 ± 0.044 μs    | 0.527 ± 0.039 μs    |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake forward               | 5.09 ± 0.77 μs      | 5.05 ± 0.7 μs       | 5.07 ± 0.67 μs      | 5.16 ± 0.74 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/Mooncake reverse               | 4.55 ± 0.28 μs      | 4.72 ± 0.27 μs      | 4.56 ± 0.28 μs      | 4.53 ± 0.25 μs      |
| AD gradients/Convolved Gamma+Normal mean+var moments/ReverseDiff (tape)             | 2.59 ± 0.07 μs      | 2.54 ± 0.078 μs     | 2.54 ± 0.077 μs     | 2.55 ± 0.1 μs       |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme forward                     | 0.0919 ± 0.00068 ms | 0.0926 ± 0.00067 ms | 0.0936 ± 0.00065 ms | 0.0936 ± 0.00066 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Enzyme reverse                     | 0.147 ± 0.0068 ms   | 0.144 ± 0.0073 ms   | 0.145 ± 0.0068 ms   | 0.145 ± 0.0067 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/ForwardDiff                        | 0.0844 ± 0.0002 ms  | 0.0856 ± 0.0002 ms  | 0.0842 ± 0.00019 ms | 0.0854 ± 0.00027 ms |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake forward                   | 0.378 ± 0.0094 ms   | 0.377 ± 0.0093 ms   | 0.376 ± 0.0094 ms   | 0.377 ± 0.0092 ms   |
| AD gradients/Convolved LogNormal+Gamma numerical/Mooncake reverse                   | 0.605 ± 0.028 ms    | 0.595 ± 0.023 ms    | 0.622 ± 0.03 ms     | 0.595 ± 0.022 ms    |
| AD gradients/Convolved LogNormal+Gamma numerical/ReverseDiff (tape)                 | 2.31 ± 0.29 ms      | 2.37 ± 0.29 ms      | 2.38 ± 0.29 ms      | 2.38 ± 0.29 ms      |
| AD gradients/Convolved Normal+Normal analytical/Enzyme forward                      | 8.07 ± 0.077 μs     | 8.09 ± 0.09 μs      | 8.05 ± 0.075 μs     | 8.01 ± 0.073 μs     |
| AD gradients/Convolved Normal+Normal analytical/Enzyme reverse                      | 3.35 ± 0.071 μs     | 3.36 ± 0.1 μs       | 3.4 ± 0.096 μs      | 3.36 ± 0.084 μs     |
| AD gradients/Convolved Normal+Normal analytical/ForwardDiff                         | 0.605 ± 0.079 μs    | 0.615 ± 0.08 μs     | 0.621 ± 0.082 μs    | 0.604 ± 0.081 μs    |
| AD gradients/Convolved Normal+Normal analytical/Mooncake forward                    | 5.66 ± 0.36 μs      | 5.7 ± 0.45 μs       | 5.7 ± 0.32 μs       | 5.64 ± 0.36 μs      |
| AD gradients/Convolved Normal+Normal analytical/Mooncake reverse                    | 27.3 ± 2.9 μs       | 28 ± 3 μs           | 27.4 ± 3.1 μs       | 27.4 ± 3.1 μs       |
| AD gradients/Convolved Normal+Normal analytical/ReverseDiff (tape)                  | 16.8 ± 0.45 μs      | 17.2 ± 0.46 μs      | 17.5 ± 0.44 μs      | 17.2 ± 0.39 μs      |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme forward              | 0.12 ± 0.0012 ms    | 0.119 ± 0.0011 ms   | 0.12 ± 0.00096 ms   | 0.119 ± 0.0011 ms   |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Enzyme reverse              | 0.206 ± 0.011 ms    | 0.205 ± 0.0099 ms   | 0.206 ± 0.01 ms     | 0.208 ± 0.011 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ForwardDiff                 | 0.118 ± 0.00045 ms  | 0.117 ± 0.0004 ms   | 0.117 ± 0.00049 ms  | 0.117 ± 0.00041 ms  |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake forward            | 0.502 ± 0.0098 ms   | 0.503 ± 0.01 ms     | 0.502 ± 0.0096 ms   | 0.503 ± 0.01 ms     |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/Mooncake reverse            | 0.847 ± 0.033 ms    | 0.843 ± 0.025 ms    | 0.84 ± 0.023 ms     | 0.826 ± 0.021 ms    |
| AD gradients/Difference Gamma-LogNormal numerical wrt X/ReverseDiff (tape)          | 4.16 ± 0.55 ms      | 4.27 ± 0.53 ms      | 4.34 ± 0.52 ms      | 4.22 ± 0.52 ms      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme forward                | 7.09 ± 0.1 μs       | 7.09 ± 0.1 μs       | 7.16 ± 0.23 μs      | 7.14 ± 0.26 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Enzyme reverse                | 0.0469 ± 0.0056 μs  | 0.0468 ± 0.0079 μs  | 0.0465 ± 0.013 μs   | 0.0468 ± 0.0057 μs  |
| AD gradients/Difference Gamma-Normal mean+var moments/ForwardDiff                   | 0.555 ± 0.044 μs    | 0.521 ± 0.039 μs    | 0.52 ± 0.042 μs     | 0.537 ± 0.039 μs    |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake forward              | 5.07 ± 0.77 μs      | 4.94 ± 0.73 μs      | 5.24 ± 0.68 μs      | 5.23 ± 0.77 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/Mooncake reverse              | 4.5 ± 0.25 μs       | 4.66 ± 0.24 μs      | 4.52 ± 0.28 μs      | 4.53 ± 0.26 μs      |
| AD gradients/Difference Gamma-Normal mean+var moments/ReverseDiff (tape)            | 2.61 ± 0.16 μs      | 2.58 ± 0.14 μs      | 2.55 ± 0.077 μs     | 2.56 ± 0.13 μs      |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme forward              | 0.143 ± 0.0014 ms   | 0.145 ± 0.0012 ms   | 0.145 ± 0.0014 ms   | 0.145 ± 0.0012 ms   |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Enzyme reverse              | 0.236 ± 0.012 ms    | 0.238 ± 0.011 ms    | 0.235 ± 0.012 ms    | 0.242 ± 0.012 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ForwardDiff                 | 0.139 ± 0.00052 ms  | 0.14 ± 0.00064 ms   | 0.14 ± 0.00081 ms   | 0.139 ± 0.00087 ms  |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake forward            | 0.623 ± 0.0091 ms   | 0.623 ± 0.0091 ms   | 0.623 ± 0.0096 ms   | 0.625 ± 0.009 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/Mooncake reverse            | 0.91 ± 0.021 ms     | 0.922 ± 0.024 ms    | 0.92 ± 0.026 ms     | 0.908 ± 0.027 ms    |
| AD gradients/Difference LogNormal-Gamma numerical wrt Y/ReverseDiff (tape)          | 4.07 ± 0.54 ms      | 4.17 ± 0.54 ms      | 4.22 ± 0.52 ms      | 4.17 ± 0.53 ms      |
| AD gradients/Difference Normal-Normal analytical/Enzyme forward                     | 7.99 ± 0.078 μs     | 7.99 ± 0.098 μs     | 8.01 ± 0.09 μs      | 8.03 ± 0.095 μs     |
| AD gradients/Difference Normal-Normal analytical/Enzyme reverse                     | 3.19 ± 0.068 μs     | 3.25 ± 0.12 μs      | 3.21 ± 0.058 μs     | 3.14 ± 0.083 μs     |
| AD gradients/Difference Normal-Normal analytical/ForwardDiff                        | 0.568 ± 0.081 μs    | 0.577 ± 0.079 μs    | 0.569 ± 0.078 μs    | 0.567 ± 0.081 μs    |
| AD gradients/Difference Normal-Normal analytical/Mooncake forward                   | 5.48 ± 0.35 μs      | 5.35 ± 0.46 μs      | 5.44 ± 0.31 μs      | 5.43 ± 0.33 μs      |
| AD gradients/Difference Normal-Normal analytical/Mooncake reverse                   | 27 ± 3 μs           | 27.9 ± 3.4 μs       | 27 ± 2.9 μs         | 27.2 ± 3 μs         |
| AD gradients/Difference Normal-Normal analytical/ReverseDiff (tape)                 | 18.1 ± 0.49 μs      | 18.1 ± 0.53 μs      | 18.3 ± 0.47 μs      | 18.1 ± 0.52 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme forward                | 7.15 ± 0.11 μs      | 7.13 ± 0.095 μs     | 7.21 ± 0.25 μs      | 7.13 ± 0.17 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Enzyme reverse                | 0.0694 ± 0.006 μs   | 0.0691 ± 0.011 μs   | 0.0698 ± 0.016 μs   | 0.0692 ± 0.0062 μs  |
| AD gradients/Product Gamma*LogNormal mean+var moments/ForwardDiff                   | 0.6 ± 0.044 μs      | 0.592 ± 0.041 μs    | 0.631 ± 0.045 μs    | 0.6 ± 0.042 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake forward              | 5.29 ± 0.63 μs      | 5.37 ± 0.73 μs      | 5.31 ± 0.52 μs      | 5.32 ± 0.57 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/Mooncake reverse              | 6.46 ± 0.84 μs      | 6.48 ± 0.81 μs      | 6.59 ± 0.67 μs      | 6.41 ± 0.72 μs      |
| AD gradients/Product Gamma*LogNormal mean+var moments/ReverseDiff (tape)            | 10.2 ± 0.32 μs      | 10.3 ± 0.38 μs      | 10.3 ± 0.31 μs      | 10.2 ± 0.33 μs      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme forward                 | 0.124 ± 0.0011 ms   | 0.124 ± 0.00098 ms  | 0.123 ± 0.001 ms    | 0.123 ± 0.001 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Enzyme reverse                 | 0.211 ± 0.011 ms    | 0.21 ± 0.011 ms     | 0.21 ± 0.011 ms     | 0.213 ± 0.011 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ForwardDiff                    | 0.118 ± 0.00053 ms  | 0.119 ± 0.00042 ms  | 0.119 ± 0.00051 ms  | 0.118 ± 0.00036 ms  |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake forward               | 0.532 ± 0.01 ms     | 0.53 ± 0.011 ms     | 0.532 ± 0.0099 ms   | 0.53 ± 0.01 ms      |
| AD gradients/Product Gamma*LogNormal numerical wrt X/Mooncake reverse               | 0.888 ± 0.03 ms     | 0.888 ± 0.025 ms    | 0.883 ± 0.028 ms    | 0.871 ± 0.029 ms    |
| AD gradients/Product Gamma*LogNormal numerical wrt X/ReverseDiff (tape)             | 4.7 ± 0.58 ms       | 4.76 ± 0.56 ms      | 4.79 ± 0.56 ms      | 4.78 ± 0.55 ms      |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme forward                 | 0.15 ± 0.0014 ms    | 0.151 ± 0.0011 ms   | 0.15 ± 0.0013 ms    | 0.15 ± 0.0013 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Enzyme reverse                 | 0.247 ± 0.012 ms    | 0.247 ± 0.011 ms    | 0.245 ± 0.012 ms    | 0.249 ± 0.011 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ForwardDiff                    | 0.143 ± 0.00053 ms  | 0.143 ± 0.00057 ms  | 0.143 ± 0.00055 ms  | 0.142 ± 0.00076 ms  |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake forward               | 0.65 ± 0.009 ms     | 0.65 ± 0.0086 ms    | 0.65 ± 0.0089 ms    | 0.648 ± 0.0087 ms   |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/Mooncake reverse               | 0.962 ± 0.029 ms    | 0.963 ± 0.022 ms    | 0.949 ± 0.021 ms    | 0.956 ± 0.033 ms    |
| AD gradients/Product LogNormal*Gamma numerical wrt Y/ReverseDiff (tape)             | 4.57 ± 0.56 ms      | 4.65 ± 0.57 ms      | 4.68 ± 0.55 ms      | 4.65 ± 0.54 ms      |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme forward                  | 8.01 ± 0.075 μs     | 8.03 ± 0.088 μs     | 8.01 ± 0.083 μs     | 8.05 ± 0.085 μs     |
| AD gradients/Product LogNormal*LogNormal analytical/Enzyme reverse                  | 3.27 ± 0.073 μs     | 3.23 ± 0.053 μs     | 3.27 ± 0.1 μs       | 3.26 ± 0.09 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/ForwardDiff                     | 0.574 ± 0.081 μs    | 0.566 ± 0.081 μs    | 0.575 ± 0.079 μs    | 0.588 ± 0.075 μs    |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake forward                | 5.67 ± 0.37 μs      | 5.61 ± 0.35 μs      | 5.68 ± 0.34 μs      | 5.66 ± 0.34 μs      |
| AD gradients/Product LogNormal*LogNormal analytical/Mooncake reverse                | 17.7 ± 1.2 μs       | 17.4 ± 0.82 μs      | 17.6 ± 1.4 μs       | 17.6 ± 1.5 μs       |
| AD gradients/Product LogNormal*LogNormal analytical/ReverseDiff (tape)              | 21.5 ± 0.55 μs      | 21.5 ± 0.57 μs      | 22 ± 0.62 μs        | 21.7 ± 0.55 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme forward              | 7.29 ± 0.1 μs       | 7.36 ± 0.12 μs      | 7.33 ± 0.088 μs     | 7.3 ± 0.098 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Enzyme reverse              | 7.54 ± 0.072 μs     | 7.18 ± 0.078 μs     | 7.03 ± 0.08 μs      | 7.69 ± 0.07 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/ForwardDiff                 | 0.957 ± 0.12 μs     | 0.934 ± 0.091 μs    | 0.938 ± 0.073 μs    | 0.929 ± 0.049 μs    |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake forward            | 6.13 ± 1 μs         | 6.09 ± 0.95 μs      | 6.09 ± 0.87 μs      | 5.99 ± 0.92 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/Mooncake reverse            | 17.9 ± 1.1 μs       | 18.3 ± 1.1 μs       | 17.4 ± 0.9 μs       | 17.7 ± 0.93 μs      |
| AD gradients/Timeseries convolve discrete Poisson delay/ReverseDiff (tape)          | 28.4 ± 0.56 μs      | 29.1 ± 0.61 μs      | 29 ± 0.59 μs        | 28.4 ± 0.56 μs      |
| Baseline/Gamma/cdf                                                                  | 3.53 ± 0.019 μs     | 3.56 ± 0.36 μs      | 3.57 ± 0.36 μs      | 3.55 ± 0.36 μs      |
| Baseline/Gamma/logpdf                                                               | 2.83 ± 0.015 μs     | 2.88 ± 0.32 μs      | 2.88 ± 0.32 μs      | 2.87 ± 0.33 μs      |
| Baseline/Normal/cdf                                                                 | 1.46 ± 0.31 μs      | 1.47 ± 0.3 μs       | 1.46 ± 0.3 μs       | 1.48 ± 0.3 μs       |
| Baseline/Normal/logpdf                                                              | 1.05 ± 0.026 μs     | 1.04 ± 0.022 μs     | 1.05 ± 0.022 μs     | 1.05 ± 0.02 μs      |
| Convolved/analytic/cdf batched                                                      | 2.63 ± 0.33 μs      | 2.67 ± 0.33 μs      | 2.66 ± 0.32 μs      | 2.68 ± 0.38 μs      |
| Convolved/analytic/cdf scalar                                                       | 28.2 ± 0.19 ns      | 28.2 ± 0.14 ns      | 27.9 ± 0.37 ns      | 29.2 ± 0.13 ns      |
| Convolved/analytic/construction                                                     | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.41 ± 0.001 ns     | 3.1 ± 0.01 ns       |
| Convolved/analytic/logpdf batched                                                   | 1.08 ± 0.024 μs     | 1.07 ± 0.025 μs     | 1.08 ± 0.024 μs     | 1.07 ± 0.029 μs     |
| Convolved/analytic/logpdf broadcast                                                 | 2.56 ± 0.33 μs      | 2.57 ± 0.33 μs      | 2.55 ± 0.34 μs      | 2.54 ± 0.33 μs      |
| Convolved/analytic/logpdf scalar                                                    | 27.8 ± 0.17 ns      | 28.2 ± 0.08 ns      | 27.8 ± 0.09 ns      | 28.7 ± 0.1 ns       |
| Convolved/analytic/mean                                                             | 2.79 ± 0.01 ns      | 2.79 ± 0.01 ns      | 2.79 ± 0.01 ns      | 3.41 ± 0.01 ns      |
| Convolved/analytic/pdf batched                                                      | 1.11 ± 0.03 μs      | 1.11 ± 0.028 μs     | 1.11 ± 0.034 μs     | 1.11 ± 0.029 μs     |
| Convolved/analytic/pdf scalar                                                       | 29.9 ± 0.21 ns      | 29.9 ± 0.11 ns      | 29.9 ± 0.091 ns     | 31.1 ± 0.21 ns      |
| Convolved/analytic/rand                                                             | 1.12 ± 0.031 μs     | 1.12 ± 0.026 μs     | 1.12 ± 0.028 μs     | 1.12 ± 0.031 μs     |
| Convolved/numeric/cdf batched                                                       | 0.83 ± 0.0031 ms    | 0.83 ± 0.0023 ms    | 0.828 ± 0.0022 ms   | 0.83 ± 0.0022 ms    |
| Convolved/numeric/cdf scalar                                                        | 15.6 ± 0.06 μs      | 15.6 ± 0.05 μs      | 15.6 ± 0.052 μs     | 15.6 ± 0.061 μs     |
| Convolved/numeric/construction                                                      | 3.41 ± 0.01 ns      | 3.42 ± 0.011 ns     | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       |
| Convolved/numeric/logpdf batched                                                    | 0.736 ± 0.0056 ms   | 0.734 ± 0.006 ms    | 0.751 ± 0.0029 ms   | 0.745 ± 0.005 ms    |
| Convolved/numeric/logpdf broadcast                                                  | 1.35 ± 0.0089 ms    | 1.35 ± 0.0088 ms    | 1.34 ± 0.0086 ms    | 1.35 ± 0.0089 ms    |
| Convolved/numeric/logpdf scalar                                                     | 12.6 ± 0.03 μs      | 12.6 ± 0.039 μs     | 12.5 ± 0.04 μs      | 13 ± 0.44 μs        |
| Convolved/numeric/mean                                                              | 6.61 ± 0.03 ns      | 6.61 ± 0.04 ns      | 6.58 ± 0.031 ns     | 6.66 ± 0.011 ns     |
| Convolved/numeric/pdf batched                                                       | 0.734 ± 0.006 ms    | 0.735 ± 0.0062 ms   | 0.743 ± 0.0051 ms   | 0.745 ± 0.0056 ms   |
| Convolved/numeric/pdf scalar                                                        | 12.5 ± 0.03 μs      | 12.5 ± 0.031 μs     | 12.5 ± 0.031 μs     | 12.6 ± 0.47 μs      |
| Convolved/numeric/rand                                                              | 2.81 ± 0.35 μs      | 2.79 ± 0.34 μs      | 2.8 ± 0.35 μs       | 2.79 ± 0.35 μs      |
| Difference/analytic/cdf broadcast                                                   | 3.36 ± 0.34 μs      | 3.37 ± 0.34 μs      | 3.35 ± 0.024 μs     | 3.36 ± 0.37 μs      |
| Difference/analytic/cdf scalar                                                      | 10.8 ± 0.021 ns     | 10.8 ± 0.019 ns     | 10.8 ± 0.012 ns     | 10.8 ± 0.011 ns     |
| Difference/analytic/construction                                                    | 3.72 ± 0.001 ns     | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 4.03 ± 0.01 ns      |
| Difference/analytic/logpdf broadcast                                                | 1.51 ± 0.31 μs      | 1.51 ± 0.29 μs      | 1.54 ± 0.31 μs      | 1.51 ± 0.31 μs      |
| Difference/analytic/logpdf scalar                                                   | 17 ± 0.08 ns        | 17 ± 0.07 ns        | 16.8 ± 0.081 ns     | 16.9 ± 0.38 ns      |
| Difference/analytic/mean                                                            | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       | 3.1 ± 0.01 ns       |
| Difference/analytic/rand                                                            | 1.12 ± 0.034 μs     | 1.12 ± 0.028 μs     | 1.12 ± 0.043 μs     | 1.12 ± 0.032 μs     |
| Difference/numeric/cdf broadcast                                                    | 1.35 ± 0.018 ms     | 1.35 ± 0.017 ms     | 1.34 ± 0.017 ms     | 1.37 ± 0.017 ms     |
| Difference/numeric/cdf scalar                                                       | 19.4 ± 0.09 μs      | 19.4 ± 0.09 μs      | 19.4 ± 0.09 μs      | 19.4 ± 0.09 μs      |
| Difference/numeric/construction                                                     | 3.11 ± 0.01 ns      | 4.33 ± 0.01 ns      | 3.11 ± 0.01 ns      | 4.33 ± 0.01 ns      |
| Difference/numeric/logpdf broadcast                                                 | 1.65 ± 0.015 ms     | 1.65 ± 0.015 ms     | 1.65 ± 0.016 ms     | 1.75 ± 0.015 ms     |
| Difference/numeric/logpdf scalar                                                    | 16.8 ± 0.079 μs     | 16.8 ± 0.081 μs     | 16.7 ± 0.08 μs      | 16.7 ± 0.08 μs      |
| Difference/numeric/mean                                                             | 6.55 ± 0.03 ns      | 6.59 ± 0.04 ns      | 6.59 ± 0.042 ns     | 6.59 ± 0.05 ns      |
| Difference/numeric/rand                                                             | 2.81 ± 0.34 μs      | 2.78 ± 0.34 μs      | 2.8 ± 0.35 μs       | 2.79 ± 0.35 μs      |
| Product/analytic/cdf broadcast                                                      | 4.91 ± 0.2 μs       | 4.9 ± 0.19 μs       | 4.9 ± 0.2 μs        | 4.9 ± 0.2 μs        |
| Product/analytic/cdf scalar                                                         | 29.4 ± 0.15 ns      | 29.6 ± 0.18 ns      | 29.7 ± 0.06 ns      | 29.7 ± 0.13 ns      |
| Product/analytic/construction                                                       | 3.11 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.41 ± 0.01 ns      |
| Product/analytic/logpdf broadcast                                                   | 2.27 ± 0.32 μs      | 2.25 ± 0.32 μs      | 2.24 ± 0.33 μs      | 2.22 ± 0.33 μs      |
| Product/analytic/logpdf scalar                                                      | 24 ± 0.2 ns         | 24 ± 0.081 ns       | 24.1 ± 0.091 ns     | 24 ± 0.08 ns        |
| Product/analytic/mean                                                               | 10.8 ± 0.031 ns     | 10.8 ± 0.04 ns      | 10.8 ± 0.04 ns      | 10.9 ± 0.031 ns     |
| Product/analytic/rand                                                               | 1.79 ± 0.31 μs      | 1.77 ± 0.3 μs       | 1.77 ± 0.31 μs      | 1.77 ± 0.31 μs      |
| Product/numeric/cdf broadcast                                                       | 1.99 ± 0.015 ms     | 1.98 ± 0.014 ms     | 1.98 ± 0.015 ms     | 1.98 ± 0.016 ms     |
| Product/numeric/cdf scalar                                                          | 23.7 ± 0.11 μs      | 23.2 ± 0.1 μs       | 23.2 ± 0.1 μs       | 23.6 ± 0.1 μs       |
| Product/numeric/construction                                                        | 4.03 ± 0.01 ns      | 3.41 ± 0.01 ns      | 3.72 ± 0 ns         | 3.41 ± 0.01 ns      |
| Product/numeric/logpdf broadcast                                                    | 1.77 ± 0.015 ms     | 1.77 ± 0.014 ms     | 1.77 ± 0.015 ms     | 1.77 ± 0.016 ms     |
| Product/numeric/logpdf scalar                                                       | 17.6 ± 0.061 μs     | 17.6 ± 0.079 μs     | 17.5 ± 0.071 μs     | 18.6 ± 0.091 μs     |
| Product/numeric/mean                                                                | 6.71 ± 0.031 ns     | 6.76 ± 0.22 ns      | 6.71 ± 0.031 ns     | 6.77 ± 0.23 ns      |
| Product/numeric/rand                                                                | 2.82 ± 0.34 μs      | 2.79 ± 0.34 μs      | 2.81 ± 0.35 μs      | 2.8 ± 0.35 μs       |
| Quantile/Convolved analytic/grid                                                    | 0.609 ± 0.1 ms      | 0.603 ± 0.1 ms      | 0.604 ± 0.11 ms     | 0.595 ± 0.1 ms      |
| Quantile/Convolved analytic/median                                                  | 22.6 ± 0.84 μs      | 22.5 ± 0.8 μs       | 22.4 ± 0.74 μs      | 22.5 ± 0.79 μs      |
| Quantile/Convolved numeric/median                                                   | 0.291 ± 0.011 ms    | 0.292 ± 0.011 ms    | 0.29 ± 0.011 ms     | 0.29 ± 0.011 ms     |
| Quantile/Difference numeric/median                                                  | 0.341 ± 0.011 ms    | 0.34 ± 0.011 ms     | 0.339 ± 0.011 ms    | 0.339 ± 0.011 ms    |
| Quantile/Product numeric/median                                                     | 0.499 ± 0.012 ms    | 0.5 ± 0.012 ms      | 0.498 ± 0.012 ms    | 0.498 ± 0.012 ms    |
| Timeseries/Convolved delay                                                          | 0.358 ± 0.0074 μs   | 0.353 ± 0.0075 μs   | 0.356 ± 0.008 μs    | 0.356 ± 0.0086 μs   |
| Timeseries/Gamma delay                                                              | 0.357 ± 0.01 μs     | 0.353 ± 0.01 μs     | 0.356 ± 0.011 μs    | 0.354 ± 0.011 μs    |
| Timeseries/Poisson delay                                                            | 1.28 ± 0.025 μs     | 1.27 ± 0.023 μs     | 1.27 ± 0.017 μs     | 1.26 ± 0.019 μs     |
| time_to_load                                                                        | 0.862 ± 0.0058 s    | 0.869 ± 0.0095 s    | 0.869 ± 0.0035 s    | 0.869 ± 0.016 s     |

|                                                                                     | v0.3.1                    | v0.3.0                    | v0.2.0                    | 67445dc7cba989...         |
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
| Quantile/Convolved analytic/grid                                                    | 5.71 k allocs: 0.324 MB   | 5.71 k allocs: 0.324 MB   | 5.71 k allocs: 0.324 MB   | 5.71 k allocs: 0.324 MB   |
| Quantile/Convolved analytic/median                                                  | 0.265 k allocs: 15.6 kB   | 0.265 k allocs: 15.6 kB   | 0.265 k allocs: 15.6 kB   | 0.265 k allocs: 15.6 kB   |
| Quantile/Convolved numeric/median                                                   | 0.339 k allocs: 19.6 kB   | 0.339 k allocs: 19.6 kB   | 0.339 k allocs: 19.6 kB   | 0.339 k allocs: 19.6 kB   |
| Quantile/Difference numeric/median                                                  | 0.302 k allocs: 21.8 kB   | 0.302 k allocs: 21.8 kB   | 0.302 k allocs: 21.8 kB   | 0.302 k allocs: 21.8 kB   |
| Quantile/Product numeric/median                                                     | 0.381 k allocs: 27 kB     | 0.381 k allocs: 27 kB     | 0.381 k allocs: 27 kB     | 0.381 k allocs: 27 kB     |
| Timeseries/Convolved delay                                                          | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       |
| Timeseries/Gamma delay                                                              | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       | 2  allocs: 0.297 kB       |
| Timeseries/Poisson delay                                                            | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       | 4  allocs: 0.594 kB       |
| time_to_load                                                                        | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   | 0.149 k allocs: 11.2 kB   |

