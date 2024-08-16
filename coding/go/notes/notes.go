// Go string literals are UTF-8 encoded text.

// Strings and Runes:
// Go strings are defined as sequences of bytes. However, Go uses UTF-8 encoding, which can represent Unicode characters using variable-length sequences of bytes (1 to 4 bytes per character).
// The rune type allows you to work with individual characters within a string, regardless of their byte representation. You can convert a string to a slice of runes or access specific characters by their index as runes.

// Strings in Go:
// In Go, a string is a sequence of bytes. Each byte represents a character, and strings are immutable, meaning their values cannot be changed after creation. The Go programming language uses UTF-8 encoding for strings, where each character can be represented by one to four bytes.

// Find all pairs of size x = 2 of given string
for i := 0; i < len(s)-1; i++ {
  for length := 2; length+i < len(s); length += 2 {
    subString := s[i : i+length]
    fmt.Println(subString)
  }
}

// All possible combination of string
for i := 0; i < n; i++ {
  for j := i + 1; j <= n; j++ {
    fmt.Println(s[i:j])
  }
}
