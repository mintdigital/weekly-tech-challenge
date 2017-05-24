defmodule LookSay.RegexParserTest do
  use ExUnit.Case, async: true
  alias LookSay.RegexParser

  test "parse/1" do
    assert "11" = RegexParser.parse("1")
    assert "21" = RegexParser.parse("11")
    assert "1211" = RegexParser.parse("21")
    assert "111221" = RegexParser.parse("1211")
    assert "312211" = RegexParser.parse("111221")
  end
end
