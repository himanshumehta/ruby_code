package main

import (
	"fmt"
	"strconv"
)

func main() {
	s := "226252"
	result := numDecodings(s)
	fmt.Println(result)
}

func numDecodings(s string) int {
	first := 1
	secondNum := 0
	if s[0] != '0' {
		secondNum = 1
	}

	for i := 1; i < len(s); i++ {
		num := 0
		if s[i] != '0' {
			num += secondNum
		}

		// Extracting the substring
		substring := s[i-1 : i+1]

		// Converting the substring to an integer
		substringValue, err := strconv.Atoi(substring)

		// Checking if the integer is between 10 and 26
		if err == nil && substringValue > 9 && substringValue <= 26 {
			num += first
		}

		first = secondNum
		secondNum = num
	}

	return secondNum
}

