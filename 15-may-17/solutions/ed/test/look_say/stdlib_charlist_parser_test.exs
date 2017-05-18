defmodule LookSay.StdlibCharlistParserTest do
  use ExUnit.Case, async: true

  alias LookSay.StdlibCharlistParser

  test "parse/1" do
    assert '11' = StdlibCharlistParser.parse('1')
    assert '21' = StdlibCharlistParser.parse('11')
    assert '1211' = StdlibCharlistParser.parse('21')
    assert '111221' = StdlibCharlistParser.parse('1211')
    assert '312211' = StdlibCharlistParser.parse('111221')
  end
end
