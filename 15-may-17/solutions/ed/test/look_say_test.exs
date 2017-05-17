defmodule LookSayTest do
  use ExUnit.Case
  doctest LookSay

  test "charlist_parse/1" do
    assert '11' = LookSay.charlist_parse('1')
    assert '21' = LookSay.charlist_parse('11')
    assert '1211' = LookSay.charlist_parse('21')
    assert '111221' = LookSay.charlist_parse('1211')
    assert '312211' = LookSay.charlist_parse('111221')
  end

  @tag skip: "is this possible with a look and say sequence?"
  test "parse when more than 9 reps of given number" do
    assert '101' = LookSay.charlist_parse('1111111111')
  end

  test "binary_parse/1" do
    assert "11" = LookSay.binary_parse("1")
    assert "21" = LookSay.binary_parse("11")
    assert "1211" = LookSay.binary_parse("21")
    assert "111221" = LookSay.binary_parse("1211")
    assert "312211" = LookSay.binary_parse("111221")

    assert LookSay.binary_solve() |> String.to_charlist() == LookSay.charlist_solve()
  end

  test "stupid_parse/1" do
    assert '11' = LookSay.stupid_parse('1')
    assert '21' = LookSay.stupid_parse('11')
    assert '1211' = LookSay.stupid_parse('21')
    assert '111221' = LookSay.stupid_parse('1211')
    assert '312211' = LookSay.stupid_parse('111221')

    assert LookSay.stupid_solve() == LookSay.charlist_solve()
  end
end
