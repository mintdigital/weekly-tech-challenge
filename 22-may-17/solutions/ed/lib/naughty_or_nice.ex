defmodule NaughtyOrNice do
  @moduledoc """
  Documentation for NaughtyOrNice.
  """

  def test_serial(parser, input) do
    parser.at_least_3_vowels?(input) &&
    parser.two_in_a_row?(input) &&
    parser.no_invalid_substring?(input)
  end

  def test_concurrent(parser, input) do
    owner = self()
    spawn(fn -> test_and_await(owner, &parser.at_least_3_vowels?/1, input) end)
    spawn(fn -> test_and_await(owner, &parser.two_in_a_row?/1, input) end)
    spawn(fn -> test_and_await(owner, &parser.no_invalid_substring?/1, input) end)

    1..3
    |> Enum.map(fn _ -> wait() end)
    |> handle_results()
  end

  defp test_and_await(owner, fun, input), do: send(owner, {:test, fun.(input)})

  defp wait do
    receive do
      {:test, result} -> result
    end
  end

  defp handle_results([true, true, true]), do: true
  defp handle_results(_), do: false
end
