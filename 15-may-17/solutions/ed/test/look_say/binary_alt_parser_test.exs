defmodule LookSay.BinaryAltParserTest do
  use ExUnit.Case, async: true
  alias LookSay.BinaryAltParser

  test "parse/1" do
    assert "11" = BinaryAltParser.parse("1")
    assert "21" = BinaryAltParser.parse("11")
    assert "1211" = BinaryAltParser.parse("21")
    assert "111221" = BinaryAltParser.parse("1211")
    assert "312211" = BinaryAltParser.parse("111221")
  end
end
