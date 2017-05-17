defmodule LookSay do
  @moduledoc """
  Documentation for LookSay.
  """

  def charlist_solve do
    charlist_parse('111312211382399229999992222441191239988800899922231114444111888223332222999988222288822211177281')
  end

  def binary_solve do
    binary_parse("111312211382399229999992222441191239988800899922231114444111888223332222999988222288822211177281")
  end

  def stupid_solve do
    stupid_parse('111312211382399229999992222441191239988800899922231114444111888223332222999988222288822211177281')
  end

  @doc """
  Parses given input, returning next member of look and say sequence.

  ## Examples

      iex> LookSay.charlist_parse('1')
      '11'

  """
  @spec charlist_parse(input :: charlist()) :: charlist()
  def charlist_parse(input), do: do_charlist_parse('', input) |> Enum.reverse()

  @doc """
  Parses given input, returning next member of look and say sequence.

  ## Examples

      iex> LookSay.binary_parse("1")
      "11"

  """
  @spec binary_parse(input :: String.t()) :: String.t()
  def binary_parse(input), do: do_binary_parse("", input) |> String.reverse()

  def stupid_parse(input) do
    input
    |> Enum.chunk_by(&(&1))
    |> Enum.flat_map(fn([h|_]=subsequence) ->
         [h|subsequence |> Enum.count() |> Integer.to_charlist()] |> Enum.reverse()
       end)
  end

  defp do_charlist_parse(acc, ''), do: acc
  defp do_charlist_parse([char|[count|prev]], [char|next]) do
    do_charlist_parse([char|[count + 1|prev]], next)
  end
  defp do_charlist_parse(acc, [char|next]), do: do_charlist_parse([char|[?1|acc]], next)

  defp do_binary_parse(acc, ""), do: acc
  defp do_binary_parse(<<char::8, count::8, prev::binary>>, <<char::8, next::binary>>) do
    do_binary_parse(<<char, count + 1>> <> prev, next)
  end
  defp do_binary_parse(acc, <<char::8, next::binary>>) do
    do_binary_parse(<<char, ?1>> <> acc, next)
  end
end
