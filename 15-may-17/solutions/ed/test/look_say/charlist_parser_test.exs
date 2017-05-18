defmodule LookSay.CharlistParserTest do
  use ExUnit.Case, async: true
  alias LookSay.CharlistParser

  test "parse/1" do
    assert '11' = CharlistParser.parse('1')
    assert '21' = CharlistParser.parse('11')
    assert '1211' = CharlistParser.parse('21')
    assert '111221' = CharlistParser.parse('1211')
    assert '312211' = CharlistParser.parse('111221')
  end
end
