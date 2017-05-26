package main

import (
	"./fileme"
	"./validator"
	"fmt"
)

func main() {
	list, err := fileme.FileToList()
	if err != nil {
		fmt.Printf("something went wrong, could not open file.")
	}
	fmt.Printf("%d\n", how_many_naughty(list))
}

func how_many_naughty(lines []string) int {
	var count int
	for _, str := range lines {
		if str != "" && validator.IsStringNice(str) {
			count = count + 1
		}
	}
	return count
}
