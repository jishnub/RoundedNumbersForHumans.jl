using RoundedNumbersForHumans
using Test
import RoundedNumbersForHumans: Scientific, Common

@testset "string" begin
    function test_common(n, str_common)
        @test string(RoundedNumber(n)) == str_common
        @test string(RoundedNumber(n, Common())) == str_common
    end
    function test_common_sci(n, str_common, str_sci = str_common)
        test_common(n, str_common)
        @test string(RoundedNumber(n, Scientific())) == str_sci
    end

    test_common_sci(300, "300")
    test_common_sci(3_000, "3k")
    test_common_sci(3_000_000, "3M")
    test_common_sci(3_000_000_000, "3B", "3G")
    if Int === Int64
        test_common_sci(3_000_000_000_000, "3T")
        test_common_sci(3_000_000_000_000_000, "3Qd", "3P")
        test_common_sci(3_000_000_000_000_000_000, "3Qn", "3E")
    end

    @testset "sigdigits" begin
    	@testset "default" begin
            test_common(3_100, "3.1k")
            test_common(3_150, "3.15k")
            test_common(3_153, "3.15k")
            test_common(31_532, "31.5k")
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
        test_common_sci(300.3, "300")
        test_common_sci(300.6, "301")
        test_common_sci(3_000.6, "3k")
        @test string(RoundedNumber(3_000.6),sigdigits=4) == "3.001k"

        @testset "negative exponent" begin
            test_common_sci(10^-1, "100m")
            test_common_sci(10^-12, "1p")
            test_common_sci(10^-24, "1.0e-6a", "1y")
        end
    end

    @testset "zero" begin
        test_common_sci(0, "0")
    end

    @testset "negative" begin
        test_common_sci(-30, "-30")
        test_common_sci(-3000, "-3k")
        test_common_sci(-30_000, "-30k")
    end

end

@testset "convert" begin
    for n in [100, 100_000, 100_000_000]
        r = RoundedNumber(n)
        @test Int(r) === n
        @test BigInt(r) == big(n)
        @test float(r) === float(n)
    end
end
