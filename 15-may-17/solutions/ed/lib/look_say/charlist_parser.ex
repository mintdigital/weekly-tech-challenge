defmodule LookSay.CharlistParser do
  @doc """
  Parses given input, returning next member of look and say sequence.

  ## Examples

      iex> LookSay.CharlistParser.parse('1')
      '11'

  """
  def parse(input), do: do_parse('', input) |> Enum.reverse()

  defp do_parse(acc, ''), do: acc
  defp do_parse([char|[count|prev]], [char|next]) do
    do_parse([char|[count + 1|prev]], next)
  end
  defp do_parse(acc, [char|next]), do: do_parse([char|[?1|acc]], next)
end
