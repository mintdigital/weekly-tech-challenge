defmodule NaughtyOrNice.Charlist.Serial do
  alias NaughtyOrNice.Charlist
  alias NaughtyOrNice.TestRunners.Serial, as: Runner

  def test(input) do
    tests = [&Charlist.at_least_3_vowels?/1,
             &Charlist.two_in_a_row?/1,
             &Charlist.no_invalid_substring?/1]


    Runner.test(tests, input)
  end
end
