package main

import "fmt"

func main() {
	numbers := []int{1, 2, 3, 4, 5}
	exists := valueExists(numbers, 3) // true
	fmt.Println(exists)

	strings := []string{"apple", "banana", "cherry"}
	exists = valueExists(strings, "banana") // true
	fmt.Println(exists)
}

func valueExists[T comparable](arr []T, target T) bool {
	for _, elem := range arr {
		if elem == target {
			return true
		}
	}
	return false
}

// Comparable - what are other constraints/alternatives?
Constraints in Go Generics:

Comparable (comparable): Requires types to support comparison using == and != operators.
Ordered (ordered): Requires types to support comparison using <, >, <=, and >= operators.
Integer (integer): Requires types to represent integers with appropriate arithmetic operations.
Custom Constraints: You can create constraints based on interfaces to enforce specific behaviors or methods.
