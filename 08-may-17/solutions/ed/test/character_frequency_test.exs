defmodule CharacterFrequencyTest do
  use ExUnit.Case
  require EEx
  doctest CharacterFrequency

  EEx.function_from_file(:def, :input, "priv/example.txt")

  test "decode/1" do
    message =
      input()
      |> String.to_charlist()
      |> CharacterFrequency.decode()

    assert [?p|tail] = message
    assert [?r|tail] = tail
    assert [?o|_tail] = tail
  end # decode/0
end
