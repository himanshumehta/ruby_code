// Time complexity of the provided wordBreak method is O(n^3)

// Inserting Words into Trie: The loop that inserts words from wordDict into the Trie has a time complexity of O(m * k), where m is the total number of characters in the words in wordDict and k is the average length of the words. This is because, for each character in each word, you perform constant-time operations (insertion into the Trie).

// Dynamic Programming Loop: The main part of the time complexity comes from the dynamic programming loop:

// The outer loop (for idx := range s) has a time complexity of O(n), where n is the length of the input string.
// The inner loop (for i := 0; i <= idx) can iterate up to idx times, leading to a worst-case time complexity of O(n^2) when idx is at its maximum value (n).
// Trie Search: In the innermost part of the dynamic programming loop, the trie.Search(s[i:idx+1]) operation has a time complexity of O(k), where k is the length of the substring s[i:idx+1].

// Combining all these factors, the overall time complexity is O(n^3).

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
	s := "leetcode"
	fmt.Println(wordBreak(s, wordDict))
}

func wordBreak(s string, wordDict []string) bool {
	trie := Constructor()
	for _, ele := range wordDict {
		trie.Insert(ele)
	}
	dp := make([]bool, len(s)+1)
	dp[0] = true
	for idx := range s {
		for i := 0; i <= idx; i++ {
			if dp[i] == true && trie.Search(s[i:idx+1]) {
				dp[idx+1] = true
			}
		}
	}
	return dp[len(dp)-1]
}

type Trie struct {
	child map[rune]*Trie
	isEnd bool
}

func Constructor() Trie {
	return Trie{
		child: make(map[rune]*Trie),
	}
}

func (t *Trie) Insert(word string) {
	node := t
	for _, char := range word {
		if node.child[char] == nil {
			newTrie := Constructor()
			node.child[char] = &newTrie
		}
		node = node.child[char]
	}

	node.isEnd = true
}

func (t *Trie) Search(word string) bool {
	node := t
	for _, char := range word {
		if node.child[char] == nil {
			return false
		}
		node = node.child[char]
	}
	return node.isEnd == true
}

func (t *Trie) StartsWith(prefix string) bool {
	node := t
	for _, char := range prefix {
		if node.child[char] == nil {
			return false
		}
		node = node.child[char]
	}
	return true
}
