package fileme

import (
	"io/ioutil"
	"strings"
)

func FileToList() ([]string, error) {
	file, err := ioutil.ReadFile("../../input.txt")
	if err != nil {
		return make([]string, 0), err
	}
	bytes_to_string := string(file)
	return strings.Split(bytes_to_string, "\n"), nil
}
