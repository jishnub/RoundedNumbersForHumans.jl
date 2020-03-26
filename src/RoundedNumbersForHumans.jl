module RoundedNumbersForHumans

export RoundedNumber

abstract type SuffixType end
struct Scientific <: SuffixType end
struct Common <: SuffixType end

const suffixlistcommon = Dict(1=>"k", # kilo
					2=>"M", # millions
					3=>"B", # billions
					4=>"T", # trillions
					5=>"Qd", # quadrillions
					6=>"Qn") # quintillions

const suffixlistscientific = Dict(1=>"k", # kilo
					2=>"M", # mega
					3=>"G", # giga
					4=>"T", # tera
					5=>"P", # peta
					6=>"E") # exa

suffixlist(::Common) = suffixlistcommon
suffixlist(::Scientific) = suffixlistscientific

struct RoundedNumber{T}
	n :: T
	exp1000 :: Int
end

exponent1000(n::Integer) = floor(Int,log(1000,n))
maxexp1000(::Common) = 6
maxexp1000(::Scientific) = 6

function RoundedNumber(n::Integer,suffixtype::SuffixType=Common())
	exp1000 = exponent1000(n)
	exp1000 = min(exp1000,maxexp1000(suffixtype))
	RoundedNumber(n,exp1000)
end

prefixnumdigits(r::RoundedNumber) = prefixnumdigits(r.n,r.exp1000)
function prefixnumdigits(n::Integer,exp1000::Integer)
	ceil(Int,log10(n)) - 3*exp1000
end

function numberprefix(r::RoundedNumber;kwargs...)
	numberprefix(r.n,r.exp1000,kwargs...)
end
function numberprefix(n::Integer,exp1000::Integer;sigdigits=3)
	round(n/1000^exp1000,sigdigits=sigdigits)
end

function Base.string(r::RoundedNumber,suffixtype::SuffixType=Common();kwargs...)
	if r.exp1000 != 0
		suffix = suffixlist(suffixtype)[r.exp1000]
	else
		suffix = ""
	end
	prefixnum = numberprefix(r.n,r.exp1000;kwargs...)
	# Not type-stable !
	if isinteger(prefixnum)
		prefixnum = Int(prefixnum)
	end
	prefix = string(prefixnum)
	prefix*suffix
end

Base.show(io::IO,r::RoundedNumber) = print(io,string(r))

end # module
