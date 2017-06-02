defmodule NaughtyOrNice.Charlist.Concurrent do
  alias NaughtyOrNice.Charlist
  alias NaughtyOrNice.TestRunners.Concurrent, as: Runner

  def test(input) do
    tests = [&Charlist.at_least_3_vowels?/1,
             &Charlist.two_in_a_row?/1,
             &Charlist.no_invalid_substring?/1]

    Runner.test(tests, input)
  end
end
