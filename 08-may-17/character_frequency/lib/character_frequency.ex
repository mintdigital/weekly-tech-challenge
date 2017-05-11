defmodule CharacterFrequency do
  @moduledoc """
  Documentation for CharacterFrequency.
  """

  @doc """
  Decodes given input, by returning the most comman character in each position.
  """
  @spec decode(input :: charlist()) :: charlist()
  def decode(input) do
    input
    |> into_lines()
    |> drop_empty_lines()
    |> transpose()
    |> Enum.map(&count/1)
    |> Enum.map(&get_most_common/1)
    |> Enum.reverse()
  end

  defp into_lines(charlist) do
    Enum.reduce(charlist, [], fn
      ?\n, lines -> [[]|lines]
      char, [] -> [[char]]
      char, [line|rest] -> [[char|line]|rest]
    end)
  end

  defp drop_empty_lines(lines), do: Enum.filter(lines, &(&1 != []))

  defp transpose(lines), do: Enum.zip(lines) |> Enum.map(&Tuple.to_list/1)

  defp count(chars) do
    Enum.reduce(chars, %{}, fn(char, map) ->
      Map.update(map, char, 0, &(&1 + 1))
    end)
  end

  defp get_most_common(map) do
    {most_common, _count} = Enum.max_by(map, fn({_char, count}) -> count end)
    most_common
  end
end
