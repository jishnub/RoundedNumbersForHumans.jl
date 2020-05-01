using RoundedNumbersForHumans
using Test
import RoundedNumbersForHumans: Scientific, Common

@testset "string" begin
    @test string(RoundedNumber(300)) == "300"
    @test string(RoundedNumber(300),Common()) == "300"
    @test string(RoundedNumber(300),Scientific()) == "300"
    @test string(RoundedNumber(3_000)) == "3k"
    @test string(RoundedNumber(3_000),Common()) == "3k"
    @test string(RoundedNumber(3_000),Scientific()) == "3k"
    @test string(RoundedNumber(3_000_000)) == "3M"
    @test string(RoundedNumber(3_000_000),Common()) == "3M"
    @test string(RoundedNumber(3_000_000),Scientific()) == "3M"
    @test string(RoundedNumber(3_000_000_000)) == "3B"
    @test string(RoundedNumber(3_000_000_000),Common()) == "3B"
    @test string(RoundedNumber(3_000_000_000),Scientific()) == "3G"
    @test string(RoundedNumber(3_000_000_000_000)) == "3T"
    @test string(RoundedNumber(3_000_000_000_000),Common()) == "3T"
    @test string(RoundedNumber(3_000_000_000_000),Scientific()) == "3T"
    @test string(RoundedNumber(3_000_000_000_000_000)) == "3Qd"
    @test string(RoundedNumber(3_000_000_000_000_000),Common()) == "3Qd"
    @test string(RoundedNumber(3_000_000_000_000_000),Scientific()) == "3P"
    @test string(RoundedNumber(3_000_000_000_000_000_000)) == "3Qn"
    @test string(RoundedNumber(3_000_000_000_000_000_000),Common()) == "3Qn"
    @test string(RoundedNumber(3_000_000_000_000_000_000),Scientific()) == "3E"

    @testset "sigdigits" begin
    	@testset "default" begin
    	    @test string(RoundedNumber(3_100)) == "3.1k"
		    @test string(RoundedNumber(3_150)) == "3.15k"
		    @test string(RoundedNumber(3_153)) == "3.15k"
		    @test string(RoundedNumber(31_532)) == "31.5k"
    	end
    	@testset "specified" begin
		    @test string(RoundedNumber(31_532),sigdigits=1) == "30k"
		    @test string(RoundedNumber(31_532),sigdigits=2) == "32k"
		    @test string(RoundedNumber(31_532),sigdigits=3) == "31.5k"
		    @test string(RoundedNumber(31_532),sigdigits=4) == "31.53k"
		    @test string(RoundedNumber(31_532),sigdigits=5) == "31.532k"
    	end
    end

    @testset "float" begin
        @test string(RoundedNumber(300.3)) == "300"
        @test string(RoundedNumber(300.6)) == "301"
        @test string(RoundedNumber(3_000.6)) == "3k"
        @test string(RoundedNumber(3_000.6),sigdigits=4) == "3.001k"
    end

    @testset "zero" begin
        @test string(RoundedNumber(0)) == "0"
    end

    @testset "negative" begin
        @test string(RoundedNumber(-30)) == "-30"
        @test string(RoundedNumber(-3000)) == "-3k"
        @test string(RoundedNumber(-30_000)) == "-30k"
    end

end
