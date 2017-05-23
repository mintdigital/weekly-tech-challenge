defmodule NaughtyOrNice do
  @moduledoc """
  Documentation for NaughtyOrNice.
  """

  def test(parser, input) do
    parser.test(input)
  end

  def count_serial(parser, file) do
    file
    |> File.stream!()
    |> Enum.map(&String.to_charlist/1)
    |> Enum.count(&test(parser, &1))
  end

  def count_concurrent(parser, file) do
    owner = self()

    file
    |> File.stream!()
    |> Enum.reduce(0, fn line, count ->
         spawn(fn ->
           chars = String.to_charlist(line)
           send(owner, {:test, test(parser, chars)})
         end)
         receive do
           {:test, true} -> count + 1
           {:test, _} -> count
         end
       end)
  end
end
