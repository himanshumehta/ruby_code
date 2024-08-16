package main

import (
	"fmt"
	"strings"
)

func main() {
	wordDict := []string{"a", "p", "ent", "enter", "ot", "o", "t"}
	samples := []string{
		"enterapotentpot",
	}

	for _, s := range samples {
		result := countConstruct(s, wordDict)
		fmt.Printf("Input: %s, Ways: %d\n", s, result)
	}
}

func countConstruct(s string, wordDict []string) int {
	return helper(s, wordDict)
}

func helper(s string, wordDict []string) int {
	if len(s) == 0 {
		return 1
	}

	totalWays := 0

	for _, ele := range wordDict {
		if isPrefix(s, ele) {
			totalWays += helper(s[len(ele):], wordDict)
		}
	}

	return totalWays
}

func isPrefix(word, prefix string) bool {
	if len(prefix) > len(word) {
		return false
	}

	if strings.HasPrefix(word, prefix) {
		return true
	}

	return false
}
