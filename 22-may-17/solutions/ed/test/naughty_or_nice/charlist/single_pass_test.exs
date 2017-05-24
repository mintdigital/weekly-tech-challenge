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
end
