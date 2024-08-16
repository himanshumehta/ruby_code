package main

import (
	"fmt"
	"strings"
)

func main() {
	n := allConstruct("purple", []string{"purp", "p", "ur", "le", "purpl"})
	fmt.Println(n)
}

func allConstruct(n string, m []string) [][]string {
	dp := make([][][]string, len(n)+1)
	dp[0] = [][]string{{}}

	for i := 0; i <= len(n); i++ {
		for _, prefix := range m {
			if i+len(prefix) <= len(n) && isPrefix(n[i:], prefix) {
				for _, ele := range dp[i] {
					newWay := append(ele, prefix)
					dp[i+len(prefix)] = append(dp[i+len(prefix)], newWay)
				}
			}
		}
	}

	return dp[len(n)]
}

func isPrefix(word, prefix string) bool {
	return len(prefix) <= len(word) && strings.HasPrefix(word, prefix)
}
