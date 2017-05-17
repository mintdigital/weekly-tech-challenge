defmodule LookSay.InferiorParser do
  @doc """
  Parses given input, returning next member of look and say sequence.

  ## Examples

      iex> LookSay.InferiorParser.parse('1')
      '11'

  """
  def parse(input) do
    input
    |> Enum.chunk_by(&(&1))
    |> Enum.flat_map(fn([h|_]=subsequence) ->
         [h|subsequence |> Enum.count() |> Integer.to_charlist()] |> Enum.reverse()
       end)
  end
end
