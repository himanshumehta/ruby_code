package main

import "fmt"

func main() {
	//trie := Constructor()
	//trie.Insert("leet")
	//trie.Insert("code")
	//println(trie.Search("leet"))    // true
	//println(trie.Search("code"))    // false
	//println(trie.StartsWith("lee")) // true
	//println(trie.Search("app"))     // true

	wordDict := []string{"leet", "code"}
	s := "leetcodee"
	fmt.Println(wordBreak(s, wordDict))
}

func wordBreak(s string, wordDict []string) bool {
	queue := []int{0}
	seen := make(map[int]bool)
	for len(queue) > 0 {
		start := queue[0]
		if start == len(s) {
			return true
		}
		queue = queue[1:]

		for end := start + 1; end <= len(s); end++ {
			ok := valueExists(wordDict, s[start:end])
			if seen[end] {
				continue
			}
			if ok {
				queue = append(queue, end)
				seen[end] = true
			}
		}
	}
	return false
}

func valueExists(arr []string, target string) bool {
	for _, value := range arr {
		if value == target {
			return true
		}
	}
	return false
}
