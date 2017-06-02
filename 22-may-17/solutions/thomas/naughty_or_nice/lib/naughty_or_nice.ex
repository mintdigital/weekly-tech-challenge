defmodule NaughtyOrNice do
  @moduledoc """
  Documentation for NaughtyOrNice.
  """

  @doc """
  Hello world.

  ## Examples

      iex> NaughtyOrNice.nice?("aaa")
      true

  """
  def nice?(string) do
    list = String.to_charlist(string)
    three_vowels?(list) && double_letter?(list) && no_banned?(list)
  end

  defp three_vowels?(list), do: Enum.count(list, &is_vowel?/1) >= 3

  defp is_vowel?(?a), do: true
  defp is_vowel?(?e), do: true
  defp is_vowel?(?i), do: true
  defp is_vowel?(?o), do: true
  defp is_vowel?(?u), do: true
  defp is_vowel?(_), do: false

  defp double_letter?([char | rest]), do: double_letter?(rest, char, 1)
  defp double_letter?(_, _, 2), do: true
  defp double_letter?([char | rest], char, count), do: double_letter?(rest, char, count + 1)
  defp double_letter?([char | rest], _, _), do: double_letter?(rest, char, 1)
  defp double_letter?([], _, _), do: false

  defp no_banned?([char | rest]), do: no_banned?(rest, char)
  defp no_banned?([?b | _], ?a), do: false
  defp no_banned?([?d | _], ?c), do: false
  defp no_banned?([?q | _], ?p), do: false
  defp no_banned?([?y | _], ?x), do: false
  defp no_banned?([char | rest], _), do: no_banned?(rest, char)
  defp no_banned?([], _), do: true
end
