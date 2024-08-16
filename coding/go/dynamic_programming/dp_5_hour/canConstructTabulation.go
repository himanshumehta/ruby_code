package main

import (
	"fmt"
	"strings"
)

func main() {
	n := canConstruct("dog", []string{"d", "o", "og"})
	fmt.Println(n)
}

func canConstruct(n string, m []string) string {
	dp := make([]string, len(n)+1)
	dp[0] = ""

	for i := 0; i <= len(n); i++ {
		if dp[i] == "" || len(dp[i]) > 0 {
			for _, prefix := range m {
				isPrefix := isPrefix(n[i:], prefix)
				if isPrefix && i+len(prefix) < len(dp) {
					dp[i+len(prefix)] = dp[i] + prefix
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
