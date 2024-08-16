// Regular Go Value:

// In Go, variables have a specific type (e.g., int, string, custom struct, etc.).
// A regular Go value is an instance of a particular type, and its type is known at compile time.
// Reflection Counterpart (reflect.Value):

// The reflect.Value type is part of the reflect package and is used to represent a value of any type at runtime.
// reflect.Value is the reflection counterpart of a regular Go value, and it allows you to perform various operations and inspections at runtime.
// When you use reflect.ValueOf on a regular Go value, you obtain a reflect.Value instance that corresponds to that value.
// Here's a simple example to illustrate the concept:

package main

import (
	"fmt"
	"reflect"
)

func main() {
	// Regular Go value
	regularValue := 42

	// Creating the reflection counterpart using reflect.ValueOf
	reflectionCounterpart := reflect.ValueOf(regularValue)

	// Printing information about the reflection counterpart
	fmt.Printf("Regular Go Value: %d\n", regularValue)
	fmt.Printf("Reflection Counterpart (Type): %v\n", reflectionCounterpart.Type())
	fmt.Printf("Reflection Counterpart (Kind): %v\n", reflectionCounterpart.Kind())
	fmt.Printf("Reflection Counterpart (Value): %v\n", reflectionCounterpart.Interface())
}
