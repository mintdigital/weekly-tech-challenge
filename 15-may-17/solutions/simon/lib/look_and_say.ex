defmodule LookAndSay do
  @moduledoc """
  Documentation for LookAndSay.
  """

  @spec generate_look_and_say_sequence(str :: String.t) :: String.t
  def generate_look_and_say_sequence(str) do
    Regex.scan(~r/(\d)\1+|(\d)/, str)
    |> Enum.map(&regex_to_say_representation/1)
    |> Enum.join
  end

  @spec regex_to_say_representation(list :: list) :: String.t
  defp regex_to_say_representation(list) do
    list
    |> Enum.reject(fn(x) -> x == "" end)
    |> get_string
  end

  @spec get_string(list :: list) :: String.t
  def get_string([match, char]) do
    len = match |> String.length
    "#{len}#{char}"
  end
  def get_string(_), do: ""
end
