defmodule NaughtyOrNice.CharlistParser do
  @vowels 'aeiou'
  @invalid ['ab', 'cd', 'pq', 'xy']

  def at_least_3_vowels?(input), do: do_count_vowels(0, input)

  defp do_count_vowels(3, _), do: true
  defp do_count_vowels(n, [char|tail]) when char in @vowels do
    do_count_vowels(n+1, tail)
  end
  defp do_count_vowels(n, [_|tail]), do: do_count_vowels(n, tail)
  defp do_count_vowels(_, []), do: false

  def two_in_a_row?([char|[char|_]]), do: true
  def two_in_a_row?([_|tail]), do: two_in_a_row?(tail)
  def two_in_a_row?([]), do: false

  def no_invalid_substring?([char, next|_]) when [char,next] in @invalid, do: false
  def no_invalid_substring?([_|tail]), do: no_invalid_substring?(tail)
  def no_invalid_substring?([]), do: true
end
