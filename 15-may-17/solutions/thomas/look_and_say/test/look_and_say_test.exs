defmodule LookAndSayTest do
  use ExUnit.Case
  doctest LookAndSay

  test "the truth" do
    assert LookAndSay.play(1) == 11
    assert LookAndSay.play(11) == 21
    assert LookAndSay.play(21) == 1211
    assert LookAndSay.play(1211) == 111221
    assert LookAndSay.play(111221) == 312211
  end
end
