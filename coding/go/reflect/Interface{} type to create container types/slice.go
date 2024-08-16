package main

import "fmt"

func main() {
	// Create a slice of empty interfaces
	var mixedSlice []interface{}

	// Add values of different types to the slice
	mixedSlice = append(mixedSlice, 42, "Hello, World", 3.14, true)

	// Iterate over the slice and print the values
	for _, value := range mixedSlice {
		fmt.Printf("Type: %T, Value: %v\n", value, value)
	}
}
