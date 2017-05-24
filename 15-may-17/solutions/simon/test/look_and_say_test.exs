defmodule LookAndSayTest do
  use ExUnit.Case
  doctest LookAndSay

  test "generate_look_and_say_sequence/1 with '1'" do
    sequence = "1" |> LookAndSay.generate_look_and_say_sequence
    assert sequence == "11"
  end

  test "generate_look_and_say_sequence/1 with '11'" do
    sequence = "11" |> LookAndSay.generate_look_and_say_sequence
    assert sequence == "21"
  end

  test "generate_look_and_say_sequence/1 with '21'" do
    sequence = "21" |> LookAndSay.generate_look_and_say_sequence
    assert sequence == "1211"
  end

  test "generate_look_and_say_sequence/1 with '1211'" do
    sequence = "1211" |> LookAndSay.generate_look_and_say_sequence
    assert sequence == "111221"
  end

  test "generate_look_and_say_sequence/1 with '111221'" do
    sequence = "111221" |> LookAndSay.generate_look_and_say_sequence
    assert sequence == "312211"
  end
end
