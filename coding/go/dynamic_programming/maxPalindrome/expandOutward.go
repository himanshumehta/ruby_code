package main

import "fmt"

func main() {
	s := "abcdade"
	result := longestPalindrome(s)
	fmt.Println(result)
}

func longestPalindrome(s string) string {
	n := len(s)
	maxSubstring := ""

	for i := 0; i < n; i++ {
		//	Check odd palindromes
		left, right := i, i
		for left >= 0 && right < n && s[left] == s[right] {
			left--
			right++
		}
		oddSubstring := s[left+1 : right]

		//	Check even palindromes
		left, right = i, i+1
		for left >= 0 && right < n && s[left] == s[right] {
			left--
			right++
		}

		evenSubstring := s[left+1 : right]

		if len(oddSubstring) > len(maxSubstring) {
			maxSubstring = oddSubstring
		}

		if len(evenSubstring) > len(maxSubstring) {
			maxSubstring = evenSubstring
		}
	}
	return maxSubstring
}
