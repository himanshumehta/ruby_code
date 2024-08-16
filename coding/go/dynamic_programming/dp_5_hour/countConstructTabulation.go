package main

import (
	"fmt"
	"strings"
)

func main() {
	//n := countConstruct("dog", []string{"d", "o", "g", "og"})
	n := countConstruct("purple", []string{"purp", "p", "ur", "le", "purpl"})
	fmt.Println(n)
}

func countConstruct(n string, m []string) int {
	dp := make([]int, len(n)+1)
	dp[0] = 1

	for i := 0; i <= len(n); i++ {
		if dp[i] > 0 {
			for _, prefix := range m {
				isPrefix := isPrefix(n[i:], prefix)
				if isPrefix && i+len(prefix) < len(dp) {
					dp[i+len(prefix)] = dp[i] + dp[i+len(prefix)]
				}
			}
		}
	}

	fmt.Println(dp)
	return dp[len(n)]
}

func isPrefix(word, prefix string) bool {
	return len(prefix) <= len(word) && strings.HasPrefix(word, prefix)
}
