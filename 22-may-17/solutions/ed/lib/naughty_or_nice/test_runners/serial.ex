defmodule NaughtyOrNice.TestRunners.Serial do
  def test(funs, input), do: Enum.all?(funs, fn f -> f.(input) end)
end
