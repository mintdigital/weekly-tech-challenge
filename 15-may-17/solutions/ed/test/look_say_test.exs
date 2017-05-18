defmodule LookSayTest do
  use ExUnit.Case
  doctest LookSay
  alias LookSay.{CharlistParser, BinaryParser, InferiorParser, RegexParser,
    StdlibCharlistParser}

  @charlist_input '111312211382399229999992222441191239988800899922231114444111888223332222999988222288822211177281'
  @binary_input List.to_string(@charlist_input)

  test "parse/2" do
    assert LookSay.parse(@charlist_input, CharlistParser) ==
           LookSay.parse(@binary_input, BinaryParser) |> String.to_charlist()
    assert LookSay.parse(@charlist_input, CharlistParser) ==
           LookSay.parse(@charlist_input, InferiorParser)
    assert LookSay.parse(@charlist_input, CharlistParser) ==
           LookSay.parse(@binary_input, RegexParser) |> String.to_charlist()
    assert LookSay.parse(@charlist_input, CharlistParser) ==
           LookSay.parse(@charlist_input, StdlibCharlistParser)
  end

  @tag skip: """
  benchmarking of various implementations, no need to run as part
  of normal suite
  """
  @tag timeout: 120_000
  test "benchmark" do
    Benchee.run(%{
      "charlist" => fn -> CharlistParser.parse(@charlist_input) end,
      "binary" => fn -> BinaryParser.parse(@binary_input) end,
      "inferior" => fn -> InferiorParser.parse(@charlist_input) end,
      "regex" => fn -> RegexParser.parse(@binary_input) end,
      "stdlib_charlist" => fn -> StdlibCharlistParser.parse(@charlist_input) end
    }, time: 10)
  end

  @tag skip: "is this possible with a look and say sequence?"
  test "parse when more than 9 reps of given number" do
    assert '101' = LookSay.parse('1111111111', CharlistParser)
    assert '101' = LookSay.parse('1111111111', InferiorParser)
    assert '101' = LookSay.parse("1111111111", BinaryParser)
  end
end
