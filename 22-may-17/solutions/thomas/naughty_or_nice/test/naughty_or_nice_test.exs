defmodule NaughtyOrNiceTest do
  use ExUnit.Case
  doctest NaughtyOrNice

  test "nice?" do
    assert NaughtyOrNice.nice?("ugknbfddgicrmopn")
    assert NaughtyOrNice.nice?("aaa")
    refute NaughtyOrNice.nice?("jchzalrnumimnmhp")
    refute NaughtyOrNice.nice?("haegwjzuvuyypxyu")
    refute NaughtyOrNice.nice?("dvszwmarrgswjxmb")
  end
end
