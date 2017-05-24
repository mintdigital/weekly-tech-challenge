defmodule NaughtyOrNice.Charlist.SinglePass do
  def test(input), do: do_test(0, false, input)

  defp do_test(_, _, [?a, ?b|_]), do: false
  defp do_test(_, _, [?c, ?d|_]), do: false
  defp do_test(_, _, [?p, ?q|_]), do: false
  defp do_test(_, _, [?x, ?y|_]), do: false
  defp do_test(vowels, _, [?a, ?a|tail]), do: do_test(vowels+2, true, tail)
  defp do_test(vowels, _, [?e, ?e|tail]), do: do_test(vowels+2, true, tail)
  defp do_test(vowels, _, [?i, ?i|tail]), do: do_test(vowels+2, true, tail)
  defp do_test(vowels, _, [?o, ?o|tail]), do: do_test(vowels+2, true, tail)
  defp do_test(vowels, _, [?u, ?u|tail]), do: do_test(vowels+2, true, tail)
  defp do_test(vowels, _, [char, char|tail]), do: do_test(vowels, true, tail)
  defp do_test(vowels, repeat?, [?a|tail]), do: do_test(vowels+1, repeat?, tail)
  defp do_test(vowels, repeat?, [?e|tail]), do: do_test(vowels+1, repeat?, tail)
  defp do_test(vowels, repeat?, [?i|tail]), do: do_test(vowels+1, repeat?, tail)
  defp do_test(vowels, repeat?, [?o|tail]), do: do_test(vowels+1, repeat?, tail)
  defp do_test(vowels, repeat?, [?u|tail]), do: do_test(vowels+1, repeat?, tail)
  defp do_test(vowels, repeat?, [_|tail]), do: do_test(vowels, repeat?, tail)
  defp do_test(0, _, []), do: false
  defp do_test(1, _, []), do: false
  defp do_test(2, _, []), do: false
  defp do_test(_, true, []), do: true
  defp do_test(_, _, []), do: false
end
