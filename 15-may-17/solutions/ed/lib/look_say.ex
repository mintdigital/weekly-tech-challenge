defmodule LookSay do
  @moduledoc """
  Documentation for LookSay.
  """

  @doc """
  Parses given input, returning next member of look and say sequence.

  ## Examples

      iex> LookSay.parse('1')
      '11'

  """
  def solve do
    parse('111312211382399229999992222441191239988800899922231114444111888223332222999988222288822211177281')
  end

  def parse(input), do: do_parse('', input) |> Enum.reverse()

  defp do_parse(acc, ''), do: acc
  defp do_parse([char|[count|prev]], [char|next]) do
    do_parse([char|[count + 1|prev]], next)
  end
  defp do_parse(acc, [char|next]), do: do_parse([char|[?1|acc]], next)
end
