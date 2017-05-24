defmodule NaughtyOrNice.Charlist.SinglePass do
  @vowels 'aeiou'
  @invalid ['ab', 'cd', 'pq', 'xy']

  def test(input), do: do_test(0, false, input)

  def test_match(input), do: do_match_test(0, false, input)

  # Original
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

  # Test
  defp do_match_test(_, _, [?a, ?b|_]), do: false
  defp do_match_test(_, _, [?c, ?d|_]), do: false
  defp do_match_test(_, _, [?p, ?q|_]), do: false
  defp do_match_test(_, _, [?x, ?y|_]), do: false
  defp do_match_test(vowel_count, _, [?a, ?a|tail]) do
    do_match_test(vowel_count+2, true, tail)
  end
  defp do_match_test(vowel_count, _, [?e, ?e|tail]) do
    do_match_test(vowel_count+2, true, tail)
  end
  defp do_match_test(vowel_count, _, [?i, ?i|tail]) do
    do_match_test(vowel_count+2, true, tail)
  end
  defp do_match_test(vowel_count, _, [?o, ?o|tail]) do
    do_match_test(vowel_count+2, true, tail)
  end
  defp do_match_test(vowel_count, _, [?u, ?u|tail]) do
    do_match_test(vowel_count+2, true, tail)
  end
  defp do_match_test(vowel_count, _, [char, char|tail]) do
    do_match_test(vowel_count, true, tail)
  end
  defp do_match_test(vowel_count, repeat?, [?a|tail]) do
    do_match_test(vowel_count+1, repeat?, tail)
  end
  defp do_match_test(vowel_count, repeat?, [?e|tail]) do
    do_match_test(vowel_count+1, repeat?, tail)
  end
  defp do_match_test(vowel_count, repeat?, [?i|tail]) do
    do_match_test(vowel_count+1, repeat?, tail)
  end
  defp do_match_test(vowel_count, repeat?, [?o|tail]) do
    do_match_test(vowel_count+1, repeat?, tail)
  end
  defp do_match_test(vowel_count, repeat?, [?u|tail]) do
    do_match_test(vowel_count+1, repeat?, tail)
  end
  defp do_match_test(vowel_count, repeat?, [_|tail]) do
    do_match_test(vowel_count, repeat?, tail)
  end
  defp do_match_test(0, _, []), do: false
  defp do_match_test(1, _, []), do: false
  defp do_match_test(2, _, []), do: false
  defp do_match_test(_, true, []), do: true
  defp do_match_test(_, _, []), do: false
end
