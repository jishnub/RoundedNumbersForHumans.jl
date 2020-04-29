# RoundedNumbersForHumans

[![Build Status](https://travis-ci.com/jishnub/RoundedNumbersForHumans.jl.svg?branch=master)](https://travis-ci.com/jishnub/RoundedNumbersForHumans.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/jishnub/RoundedNumbersForHumans.jl?svg=true)](https://ci.appveyor.com/project/jishnub/RoundedNumbersForHumans-jl)
[![Codecov](https://codecov.io/gh/jishnub/RoundedNumbersForHumans.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jishnub/RoundedNumbersForHumans.jl)

# Introduction

Easy way to convert numbers to a human-readable string, with suffixes of thousands, millions etc as appropriate.

Examples:

```julia
julia> RoundedNumber(10_000)
10k

julia> RoundedNumber(1_000_000)
1M

julia> RoundedNumber(10^7)
10M

# Population of the world
julia> RoundedNumber(7_781_027_178)
7.78B
```