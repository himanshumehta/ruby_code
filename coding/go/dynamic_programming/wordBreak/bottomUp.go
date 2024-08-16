package main

import "fmt"

func main() {
	wordDict := []string{"leet", "code"}
	s := "leetcode"
	fmt.Println(wordBreak(s, wordDict))
}

func wordBreak(s string, wordDict []string) bool {
	dp := make([]bool, len(s)+1)
	dp[0] = true

	for idx := 0; idx < len(s); idx++ {
		for i := 0; i <= idx; i++ {
			if dp[i] == true {
				ok := valueExists(wordDict, s[i:idx+1])
				if ok {
					dp[idx+1] = true
				}
			}
		}
	}

	return dp[len(dp)-1]
}

func valueExists[T comparable](arr []T, s T) bool {
	for _, ele := range arr {
		if ele == s {
			return true
		}
	}
	return false
}
