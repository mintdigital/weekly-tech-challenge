package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	list, err := file_to_list()
	if err != nil {
		fmt.Printf("something went wrong, could not open file.")
	}
	fmt.Printf("%s", find_word(list))
}

func file_to_list() ([]string, error) {
	file, err := ioutil.ReadFile("../../input.txt")
	if err != nil {
		return make([]string, 0), err
	}
	bytes_to_string := string(file)
	return strings.Split(bytes_to_string, "\n"), nil
}

func find_word(lines []string) string {
	acc := make(map[int]map[string]int)
	for _, word := range lines {
		// could probably use pointers here to get around re-assignment
		acc = split_and_count(word, acc)
	}
	slice := sort_and_format(acc)
	return strings.Join(slice, "")
}

func split_and_count(str string, acc map[int]map[string]int) map[int]map[string]int {
	for i, v := range strings.Split(str, "") {
		if len(acc[i]) == 0 {
			acc[i] = make(map[string]int)
		}
		acc[i][v] = acc[i][v] + 1
	}
	return acc
}

func sort_and_format(map_of_maps map[int]map[string]int) []string {
	var char_map []string
	for i := 0; i <= len(map_of_maps); i++ {
		char_map = append(char_map, highest_char_in_map(map_of_maps, i))
	}
	return char_map
}

func highest_char_in_map(map_of_maps map[int]map[string]int, i int) string {
	var highest_character string
	var last_highest_value int

	for key, value := range map_of_maps[i] {
		if last_highest_value < value {
			highest_character = key
			last_highest_value = value
		}
	}
	return highest_character
}
