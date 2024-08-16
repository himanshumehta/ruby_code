package main

import "fmt"

func main() {
	// Create a map with string keys and empty interface values
	mixedMap := make(map[string]interface{})

	// Add values of different types to the map
	mixedMap["int"] = 42
	mixedMap["string"] = "Hello, World"
	mixedMap["float"] = 3.14
	mixedMap["bool"] = true

	// Retrieve and print values from the map
	for key, value := range mixedMap {
		fmt.Printf("Key: %s, Type: %T, Value: %v\n", key, value, value)
	}
}
