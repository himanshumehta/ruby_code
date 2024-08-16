package main

import "fmt"

func main() {
	s := ")()())"
	result := longestValidParentheses(s)
	fmt.Println(result)

	fmt.Println("isValid:  ", isValid(")()())"))
}

func isValid(s string) bool {
	var stack []string
	for _, ele := range s {
		switch ele {
		case '(':
			stack = append(stack, string(ele))
		case ')':
			if len(stack) > 0 && (stack[len(stack)-1]) == string('(') {
				stack = stack[:len(stack)-1]
			} else {
				stack = append(stack, string(ele))
			}
		}
	}
	return len(stack) == 0
}

func longestValidParentheses(s string) int {
	maxLength := 0
	allCombinations := generateAllEvenSizeCombinations(s)
	for _, ele := range allCombinations {
		fmt.Println(ele)
		result := isValid(ele)
		if result && maxLength < len(ele) {
			maxLength = len(ele)
		}
	}
	return maxLength
}

func generateAllEvenSizeCombinations(s string) []string {
	var allCombinations []string
	for i := 0; i < len(s); i++ {
		for length := 2; i+length <= len(s); length += 2 {
			j := i + length
			allCombinations = append(allCombinations, s[i:j])
		}
	}
	return allCombinations
}
