defmodule LookSay do
  @moduledoc """
  Documentation for LookSay.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LookSay.hello
      :world

  """
  def parse(input), do: do_parse('', input) |> Enum.reverse()

  defp do_parse(acc, ''), do: acc
  defp do_parse([char|[count|prev]], [char|next]) do
    do_parse([char|[count + 1|prev]], next)
  end
  defp do_parse(acc, [char|next]), do: do_parse([char|[?1|acc]], next)
end
