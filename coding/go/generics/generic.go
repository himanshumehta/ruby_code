// The [T any] part in the method signature is a type parameter declaration, indicating that the function PrintAnyType is generic over a type T. The any keyword in this context is a type constraint, meaning that T can be any type. 

package main

import "fmt"

// Filter is a generic function that filters elements of a slice based on a predicate.
func Filter[T any](slice []T, predicate func(T) bool) []T {
    var result []T
    for _, item := range slice {
        if predicate(item) {
            result = append(result, item)
        }
    }
    return result
}

func main() {
    // Example 1: Filter even numbers
    numbers := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    evenNumbers := Filter(numbers, func(n int) bool {
        return n%2 == 0
    })
    fmt.Println("Even numbers:", evenNumbers)

    // Example 2: Filter strings with length greater than 5
    words := []string{"apple", "banana", "grape", "kiwi", "orange"}
    longWords := Filter(words, func(s string) bool {
        return len(s) > 5
    })
    fmt.Println("Words with length greater than 5:", longWords)
}
