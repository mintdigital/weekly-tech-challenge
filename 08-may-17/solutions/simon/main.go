package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strings"
)

func main() {
	list, _ := file_to_list()
	answer := runner(list)
	fmt.Printf("%s", answer)
}

func file_to_list() ([]string, error) {
	file, err := ioutil.ReadFile("../../input.txt")
	if err != nil {
		log.Fatal("something went wrong, could not open file.")
	}
	bytes_to_string := string(file)
	return strings.Split(bytes_to_string, "\n"), nil
}

func runner(list []string) string {
	acc := make(map[int]map[string]int)
	for _, l := range list {
		for i, v := range strings.Split(l, "") {
			if len(acc[i]) == 0 {
				acc[i] = make(map[string]int)
			}
			acc[i][v] = acc[i][v] + 1
		}
	}
	slice := sort_and_format(acc)
	return strings.Join(slice, "")
}

func sort_and_format(map_of_maps map[int]map[string]int) []string {
	var char_map []string
	for i := 0; i <= len(map_of_maps); i++ {
		var highest_character string
		var last_highest_value int
		for key, value := range map_of_maps[i] {
			if last_highest_value < value {
				highest_character = key
				last_highest_value = value
			}
		}
		char_map = append(char_map, highest_character)
	}
	return char_map
}
