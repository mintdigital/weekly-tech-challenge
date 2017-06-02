defmodule NaughtyOrNiceTest do
  use ExUnit.Case
  doctest NaughtyOrNice

  test "nice?" do
    assert NaughtyOrNice.nice?("ugknbfddgicrmopn")
    assert NaughtyOrNice.nice?("aaa")
    refute NaughtyOrNice.nice?("jchzalrnumimnmhp")
    refute NaughtyOrNice.nice?("haegwjzuvuyypxyu")
    refute NaughtyOrNice.nice?("dvszwmarrgswjxmb")
  end

  test "input" do
    stream = File.stream!("./../../../input.txt", [:read])
    count = Enum.reduce(stream, 0, fn(line, acc) ->
      line = strip_newlines(line)
      if NaughtyOrNice.nice?(line), do: acc + 1, else: acc
    end)


    IO.puts(count)
  end

  defp strip_newlines(line) do
    String.replace_trailing(line, "\n", "")
  end
end
