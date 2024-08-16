// Strings in Go:
// In Go, a string is a sequence of bytes. Each byte represents a character, and strings are immutable, meaning their values cannot be changed after creation. The Go programming language uses UTF-8 encoding for strings, where each character can be represented by one to four bytes.

// Find all pairs of size x of given string
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
