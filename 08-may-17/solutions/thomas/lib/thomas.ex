defmodule CharacterFrequency do
  def unscramble(file) do
    stream = File.stream!(file, [:read])
    data = Enum.reduce(stream, %{}, fn(line, acc) ->
      count_chars(line, acc)
    end)

    word = Enum.map(Map.values(data), fn(col) ->
      pick_winner(col)
    end)

    Enum.join(word, "")
  end

  defp count_chars(line, acc) do
    line
    |> String.graphemes
    |> Enum.reject(fn(char) -> char == "\n" end)
    |> Enum.with_index
    |> Enum.reduce(acc, fn({char, col_index}, acc2) ->
      if Map.has_key?(acc2, col_index) do
        update_in(acc2, [col_index, char], &((&1 || 0) + 1))
      else
        Map.put(acc2, col_index, %{char => 1})
      end
    end)
  end

  defp pick_winner(col) do
    winner = Enum.reduce(col, %{:char => nil, :count => 0}, fn({key, val}, acc) ->
      if val > acc.count do
        %{:char => key, :count => val}
      else
        acc
      end
    end)
    winner[:char]
  end
end
