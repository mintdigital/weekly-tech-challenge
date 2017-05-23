defmodule NaughtyOrNice.Charlist.SinglePass do
  @vowels 'aeiou'
  @invalid ['ab', 'cd', 'pq', 'xy']

  def test(input), do: do_test(0, false, input)

  defp do_test(_, _, [first, second|_]) when [first, second] in @invalid, do: false
  defp do_test(vowel_count, _, [char, char|tail]) when char in @vowels do
    do_test(vowel_count + 2, true, tail)
  end
  defp do_test(vowel_count, _, [char, char|tail]) do
    do_test(vowel_count, true, tail)
  end
  defp do_test(vowel_count, repeat?, [char|tail]) when char in @vowels do
    do_test(vowel_count + 1, repeat?, tail)
  end
  defp do_test(vowel_count, repeat?, [_|tail]) do
    do_test(vowel_count, repeat?, tail)
  end
  defp do_test(vowel_count, true, []) when vowel_count >= 3, do: true
  defp do_test(_, _, []), do: false
end
