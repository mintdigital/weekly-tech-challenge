defmodule LookSay.BinaryParserTest do
  use ExUnit.Case
  alias LookSay.BinaryParser

  test "parse/1" do
    assert "11" = BinaryParser.parse("1")
    assert "21" = BinaryParser.parse("11")
    assert "1211" = BinaryParser.parse("21")
    assert "111221" = BinaryParser.parse("1211")
    assert "312211" = BinaryParser.parse("111221")
  end
end
