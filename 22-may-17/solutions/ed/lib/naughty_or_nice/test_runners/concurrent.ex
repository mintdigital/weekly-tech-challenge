defmodule NaughtyOrNice.TestRunners.Concurrent do
  def test(funs, input) do
    owner = self()
    funs
    |> Stream.map(fn f ->
         send(owner, {:test, f.(input)})
         receive do
           {:test, result} -> result
         end
       end)
    |> Enum.all?(&(&1))
  end
end
