defmodule LookSayTest do
  use ExUnit.Case
  doctest LookSay
  alias LookSay.{CharlistParser, BinaryParser, InferiorParser}

  test "parse/2" do
    assert LookSay.parse(LookSay.charlist_input(), CharlistParser) ==
           LookSay.parse(LookSay.binary_input(), BinaryParser) |> String.to_charlist()
    assert LookSay.parse(LookSay.charlist_input(), CharlistParser) ==
           LookSay.parse(LookSay.charlist_input(), InferiorParser)
  end

  @tag skip: "is this possible with a look and say sequence?"
  test "parse when more than 9 reps of given number" do
    assert '101' = LookSay.parse('1111111111', CharlistParser)
    assert '101' = LookSay.parse('1111111111', InferiorParser)
    assert '101' = LookSay.parse("1111111111", BinaryParser)
  end
end
