defmodule LookSay.InferiorParserTest do
  use ExUnit.Case
  alias LookSay.InferiorParser

  test "parse/1" do
    assert '11' = InferiorParser.parse('1')
    assert '21' = InferiorParser.parse('11')
    assert '1211' = InferiorParser.parse('21')
    assert '111221' = InferiorParser.parse('1211')
    assert '312211' = InferiorParser.parse('111221')
  end
end
