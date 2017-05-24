defmodule NaughtyOrNice.Charlist.SinglePassTest do
  use ExUnit.Case, async: true
  alias NaughtyOrNice.Charlist.SinglePass

  test "test single pass" do
    assert SinglePass.test('ugknbfddgicrmopn')
    assert SinglePass.test('aaa')
    refute SinglePass.test('jchzalrnumimnmhp')
    refute SinglePass.test('haegwjzuvuyypxyu')
    refute SinglePass.test('dvszwmarrgswjxmb')
  end

  test "test single pass alt" do
    assert SinglePass.test_match('ugknbfddgicrmopn')
    assert SinglePass.test_match('aaa')
    refute SinglePass.test_match('jchzalrnumimnmhp')
    refute SinglePass.test_match('haegwjzuvuyypxyu')
    refute SinglePass.test_match('dvszwmarrgswjxmb')
  end

  test "benchmark" do
    Benchee.run(%{
      "guards" => fn -> SinglePass.test('dvszwmarrgswjxmb') end,
      "match" => fn -> SinglePass.test_match('dvszwmarrgswjxmb') end
    }, time: 10)
  end
end
