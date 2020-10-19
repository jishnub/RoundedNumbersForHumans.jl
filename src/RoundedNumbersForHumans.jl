module RoundedNumbersForHumans

export RoundedNumber

abstract type SuffixType end
struct Scientific <: SuffixType end
struct Common <: SuffixType end

const suffixlistcommon = Dict(
    -1=>"m", # one-thousandth
    -2=>"μ", # one-millionth
    -3=>"n", # one-billionth
    -4=>"p", # one-trillionth
    -5=>"f", # one-quadrillionth
    -6=>"a", # one-quintillionth
    1=>"k", # kilo
    2=>"M", # millions
    3=>"B", # billions
    4=>"T", # trillions
    5=>"Qd", # quadrillions
    6=>"Qn", # quintillions
    )

const suffixlistscientific = Dict(
    -1=>"m", # milli
    -2=>"μ", # micro
    -3=>"n", # nano
    -4=>"p", # pico
    -5=>"f", # femto
    -6=>"a", # atto
    -7=>"z", # zepto
    -8=>"y", # yocto
    1=>"k", # kilo
    2=>"M", # mega
    3=>"G", # giga
    4=>"T", # tera
    5=>"P", # peta
    6=>"E", # exa
    7=>"Z", # zetta
    8=>"Y", # yotta
    )

suffixlist(::Type{Common}) = suffixlistcommon
suffixlist(::Type{Scientific}) = suffixlistscientific
suffixlist(s::SuffixType) = suffixlist(typeof(s))

struct RoundedNumber{S<:SuffixType,T} <: Number
    n :: T
    exp1000 :: Int
end

RoundedNumber{S}(n, exp1000) where {S<:SuffixType} = RoundedNumber{S, typeof(n)}(n, exp1000)

exponent1000(n) = iszero(n) ? 0 : floor(Int, log(1000,abs(n)))
minexp1000(s::SuffixType) = minimum(keys(suffixlist(s)))
maxexp1000(s::SuffixType) = maximum(keys(suffixlist(s)))

function RoundedNumber(n, suffixtype::SuffixType = Common())
    exp1000 = exponent1000(n)
    exp1000 = min(exp1000, maxexp1000(suffixtype))
    exp1000 = max(exp1000, minexp1000(suffixtype))
    RoundedNumber{typeof(suffixtype)}(n, exp1000)
end

prefixnumdigits(r::RoundedNumber) = prefixnumdigits(r.n,r.exp1000)
function prefixnumdigits(n, exp1000)
    ceil(Int,log10(n)) - 3exp1000
end

function numberprefix(r::RoundedNumber; kwargs...)
    numberprefix(r.n, r.exp1000; kwargs...)
end
function numberprefix(n, exp1000; sigdigits=3)
    y = sign(n) * round(10^(log10(abs(n)) - 3exp1000), sigdigits=sigdigits)
    maybeInt(y)
end

maybeInt(y) = isinteger(y) ? Integer(y) : y

function Base.string(r::RoundedNumber{S}; kwargs...) where {S}
    if r.exp1000 != 0
        suffix = suffixlist(S)[r.exp1000]
    else
        suffix = ""
    end
    prefixnum = numberprefix(r.n, r.exp1000; kwargs...)
    prefix = string(prefixnum)
    prefix*suffix
end

(::Type{T})(r::RoundedNumber) where {T<:Number} = T(r.n)

Base.show(io::IO, r::RoundedNumber) = print(io, string(r))

end # module
