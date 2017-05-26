package validator

import "strings"

func IsStringNice(str string) bool {
	return contains_at_least_three_vowels(str) &&
		at_least_one_letter_appears_twice(str) &&
		does_not_contain_disallowed_strings(str)
}

func contains_at_least_three_vowels(str string) bool {
	var count int
	for _, s := range strings.Split(strings.ToLower(str), "") {
		if s == "a" || s == "e" || s == "i" || s == "o" || s == "u" {
			count = count + 1
		}
	}
	return count >= 3
}

func at_least_one_letter_appears_twice(str string) bool {
	var last_char string
	for _, s := range strings.Split(strings.ToLower(str), "") {
		if s == last_char {
			return true
		}
		last_char = s
	}
	return false
}

func does_not_contain_disallowed_strings(str string) bool {
	disallowed_chars := []string{"ab", "cd", "pq", "xy"}
	for _, dc := range disallowed_chars {
		if strings.Contains(str, dc) {
			return false
		}
	}
	return true
}
