defmodule LookSay.BinaryAltParser do
  def parse(input) do
    do_parse("", {nil, ?0}, input)
  end

  def do_parse(acc, {char, count}, "") do
    acc <> <<count, char>>
  end
  def do_parse(acc, {nil, ?0}, <<char::8, next::binary>>) do
    do_parse(acc, {char, ?1}, next)
  end
  def do_parse(acc, {char, count}, <<char::8, next::binary>>) do
    do_parse(acc, {char, count + 1}, next)
  end
  def do_parse(acc, {last, count}, <<char::8, next::binary>>) do
    do_parse(acc <> <<count, last>>, {char, ?1}, next)
  end
end
