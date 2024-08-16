package main

import "fmt"

func main() {
	s := "abcdade"
	result := longestPalindrome(s)
	fmt.Println(result)
}

func longestPalindrome(s string) string {
	n := len(s)
	ans := [2]int{0, 0}

	dp := make([][]bool, n)
	for i := range dp {
		dp[i] = make([]bool, n)
	}

	for i := 0; i < n; i++ {
		dp[i][i] = true
	}

	for i := 0; i < n-1; i++ {
		if s[i] == s[i+1] {
			dp[i][i+1] = true
			ans = [2]int{i, i + 1}
		}
	}

	for diff := 1; diff < n; diff++ {
		for i := 0; i < n-diff; i++ {
			j := i + diff
			if s[i] == s[j] && dp[i+1][j-1] == true {
				dp[i][j] = true
				ans = [2]int{i, j}
			}
		}
	}

	i, j := ans[0], ans[1]
	return s[i : j+1]
}
