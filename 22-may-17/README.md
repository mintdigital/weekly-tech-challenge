## Naughty Or Nice

This week we need to figure out which strings in the text file are naughty or nice.

### Rules

A nice string is one with all of the following properties:

- It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
- It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
- It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
For example:

### Examples

`ugknbfddgicrmopn` is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.

`aaa` is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.

`jchzalrnumimnmhp` is naughty because it has no double letter.

`haegwjzuvuyypxyu` is naughty because it contains the string xy.

`dvszwmarrgswjxmb` is naughty because it contains only one vowel.

### Challenge

It is your job to work out, how many strings are naughty?

### Acknowledgement

This weeks challenge was copied from [@ericwastl](https://twitter.com/ericwastl)'s Advent of Code - [2015 day 5](http://adventofcode.com/2015/day/5)
