defmodule CharacterFrequencyTest do
  use ExUnit.Case
  doctest CharacterFrequency

  test "unscrambling" do
    assert CharacterFrequency.unscramble("./test/test-input.txt") == "programmer"
  end
end
