defmodule LookSayTest do
  use ExUnit.Case
  doctest LookSay

  test "parse/1" do
    assert '11' = LookSay.parse('1')
    assert '21' = LookSay.parse('11')
    assert '1211' = LookSay.parse('21')
    assert '111221' = LookSay.parse('1211')
    assert '312211' = LookSay.parse('111221')
  end

  @tag skip: "is this possible with a look and say sequence?"
  test "parse when more than 9 reps of given number" do
    assert '101' = LookSay.parse('1111111111')
  end
end
