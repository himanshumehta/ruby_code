// https://www.youtube.com/watch?v=ukyRR0oIAHU

func longestValidParentheses(s string) int {
	n := len(s)
	if n <= 1 {
		return 0
	}

	dp := make([]int, n+1)
	maxLength := 0

	for i := 1; i < n; i++ {
		if s[i] == ')' {
			j := i - dp[i] - 1
			if j >= 0 && s[j] == '(' {
				dp[i+1] = dp[i] + dp[j] + 2
			}
		}
		maxLength = maxX(maxLength, dp[i+1])
	}

	return maxLength
}

func maxX(a, b int) int {
	if a > b {
		return a
	}
	return b
}


// 2nd way
package main

import "fmt"

func main() {
	s := ")()())"
	result := longestValidParentheses(s)
	fmt.Println(result)

}

func longestValidParentheses(s string) int {
	n := len(s)
	dp := make([]int, n+1)
	longestValid := 0

	for i := 0; i < n; i++ {
		if s[i] == ')' {
			j := i - dp[i] - 1
			if j >= 0 && s[j] == '(' {
				dp[i+1] = dp[i] + dp[j] + 2
				if dp[i+1] > longestValid {
					longestValid = dp[i+1]
				}
			}
		}
	}
	return longestValid
}

