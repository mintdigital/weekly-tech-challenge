defmodule NaughtyOrNiceTest do
  use ExUnit.Case
  doctest NaughtyOrNice

  alias NaughtyOrNice.{Charlist.Serial, Charlist.Concurrent, Charlist.SinglePass}

  test "test serial" do
    assert NaughtyOrNice.test(Serial, 'ugknbfddgicrmopn')
    assert NaughtyOrNice.test(Serial, 'aaa')
    refute NaughtyOrNice.test(Serial, 'jchzalrnumimnmhp')
    refute NaughtyOrNice.test(Serial, 'haegwjzuvuyypxyu')
    refute NaughtyOrNice.test(Serial, 'dvszwmarrgswjxmb')
  end

  test "test concurrent" do
    assert NaughtyOrNice.test(Concurrent, 'ugknbfddgicrmopn')
    assert NaughtyOrNice.test(Concurrent, 'aaa')
    refute NaughtyOrNice.test(Concurrent, 'jchzalrnumimnmhp')
    refute NaughtyOrNice.test(Concurrent, 'haegwjzuvuyypxyu')
    refute NaughtyOrNice.test(Concurrent, 'dvszwmarrgswjxmb')
  end


  @tag skip: "benchmark"
  test "benchmark test single" do
    Benchee.run(%{
      "serial" =>
        fn -> NaughtyOrNice.test(Serial, 'dvszwmarrgswjxmb') end,
      "concurrent" =>
        fn -> NaughtyOrNice.test(Concurrent, 'dvszwmarrgswjxmb') end,
      "onepass" =>
        fn -> NaughtyOrNice.test(SinglePass, 'dvszwmarrgswjxmb') end
    }, time: 10)
  end

  @tag skip: "benchmark"
  test "benchmark test many" do
    input = "priv/input.txt"

    Benchee.run(%{
      "serial" =>
        fn -> NaughtyOrNice.count_serial(SinglePass, input) end,
      "concurrent" =>
        fn -> NaughtyOrNice.count_concurrent(SinglePass, input) end
    }, time: 10)
  end
end
