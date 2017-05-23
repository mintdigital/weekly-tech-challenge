defmodule NaughtyOrNiceTest do
  use ExUnit.Case
  doctest NaughtyOrNice

  alias NaughtyOrNice.CharlistParser

  test "test_serial/1" do
    assert NaughtyOrNice.test_serial(CharlistParser, 'ugknbfddgicrmopn')
    assert NaughtyOrNice.test_serial(CharlistParser, 'aaa')
    refute NaughtyOrNice.test_serial(CharlistParser, 'jchzalrnumimnmhp')
    refute NaughtyOrNice.test_serial(CharlistParser, 'haegwjzuvuyypxyu')
    refute NaughtyOrNice.test_serial(CharlistParser, 'dvszwmarrgswjxmb')
  end

  test "test_concurrent/1" do
    assert NaughtyOrNice.test_concurrent(CharlistParser, 'ugknbfddgicrmopn')
    assert NaughtyOrNice.test_concurrent(CharlistParser, 'aaa')
    refute NaughtyOrNice.test_concurrent(CharlistParser, 'jchzalrnumimnmhp')
    refute NaughtyOrNice.test_concurrent(CharlistParser, 'haegwjzuvuyypxyu')
    refute NaughtyOrNice.test_concurrent(CharlistParser, 'dvszwmarrgswjxmb')
  end

  @skip "benchmark"
  test "benchmark" do
    Benchee.run(%{
      "serial" =>
        fn -> NaughtyOrNice.test_serial(CharlistParser, 'dvszwmarrgswjxmb') end,
      "concurrent" =>
        fn -> NaughtyOrNice.test_concurrent(CharlistParser, 'dvszwmarrgswjxmb') end
    }, time: 10)
  end
end
