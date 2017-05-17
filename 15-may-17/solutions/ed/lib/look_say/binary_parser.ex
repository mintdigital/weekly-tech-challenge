defmodule LookSay.BinaryParser do
  @doc """
  Parses given input, returning next member of look and say sequence.

  ## Examples

      iex> LookSay.BinaryParser.parse("1")
      "11"

  """
  def parse(input), do: do_parse("", input) |> String.reverse()

  defp do_parse(acc, ""), do: acc
  defp do_parse(<<char::8, count::8, prev::binary>>, <<char::8, next::binary>>) do
    do_parse(<<char, count + 1>> <> prev, next)
  end
  defp do_parse(acc, <<char::8, next::binary>>) do
    do_parse(<<char, ?1>> <> acc, next)
  end
end
