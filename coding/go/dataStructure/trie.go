package main

func main() {
	trie := Constructor()
	trie.Insert("apple")
	println(trie.Search("apple"))   // true
	println(trie.Search("app"))     // false
	println(trie.StartsWith("app")) // true
	trie.Insert("app")
	println(trie.Search("app")) // true
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
