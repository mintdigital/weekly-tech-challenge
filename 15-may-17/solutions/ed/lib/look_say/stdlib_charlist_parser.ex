defmodule LookSay.StdlibCharlistParser do
  def parse(input) do
    input
    |> Enum.reduce('', fn
         char, [char|[count|prev]] -> [char|[count + 1|prev]]
         char, acc -> [char|[?1|acc]]
       end)
    |> Enum.reverse()
  end
end
