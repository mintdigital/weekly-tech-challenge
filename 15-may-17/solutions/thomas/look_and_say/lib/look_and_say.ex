defmodule LookAndSay do
  @moduledoc """
  Documentation for LookAndSay.
  """

  @doc """
  play

  ## Examples

      iex> LookAndSay.play(1)
      11

  """
  def play(input) do
    input
    |> Integer.digits
    |> Enum.reduce([], &into_list/2)
    |> Enum.map(&generate_seq/1)
    |> Enum.reverse
    |> Enum.join("")
    |> String.to_integer
  end

  defp into_list(char, acc) do
    case acc do
      [] -> [[char]]
      _ -> update_list(char, acc)
    end
  end

  defp update_list(char, acc) do
    [head | _] = acc
    last_char = List.first(head)
    if last_char == char do
      List.update_at(acc, 0, &(&1 ++ [char]))
    else
      List.insert_at(acc, 0, [char])
    end
  end

  defp generate_seq(seq) do
    Enum.join([Enum.count(seq),List.first(seq)], "")
  end
end
