package main

import (
	"fmt"
	"strconv"
)

func main() {
	s := "226"
	result := numDecoding(s)
	fmt.Println(result)
}

func numDecoding(s string) int {
	answer := helper(s, 0)
	return answer
}

func helper(s string, index int) int {
	if len(s) == index {
		return 1
	}

	// If the string starts with a zero, it can't be decoded
	if s[index] == '0' {
		return 0
	}

	// Return 1 for success.
	if index == len(s)-1 {
		return 1
	}

	answer := helper(s, index+1)

	substringValue, _ := strconv.Atoi(s[index : index+2])
	if substringValue > 9 && substringValue <= 26 {
		answer += helper(s, index+2)
	}

	return answer
}
