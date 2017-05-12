## Look and say

This week we are playing a game called [look-and-say](https://en.wikipedia.org/wiki/Look-and-say_sequence).

How it works:

To generate a member of the sequence from the previous member, read off the digits of the previous member, counting the number of digits in groups of the same digit. For example:

- 1 is read off as "one 1" or 11.
- 11 is read off as "two 1s" or 21.
- 21 is read off as "one 2, then one 1" or 1211.
- 1211 is read off as "one 1, one 2, then two 1s" or 111221.
- 111221 is read off as "three 1s, two 2s, then one 1" or 312211.

It is your job to produce the "look and say" sequence (in digits) for the input given.

To give you an example:

- 1 becomes 11 (1 copy of digit 1).
- 11 becomes 21 (2 copies of digit 1).
- 21 becomes 1211 (one 2 followed by one 1).
- 1211 becomes 111221 (one 1, one 2, and two 1s).
- 111221 becomes 312211 (three 1s, two 2s, and one 1).

The puzzle input is `111312211382399229999992222441191239988800899922231114444111888223332222999988222288822211177281`.
