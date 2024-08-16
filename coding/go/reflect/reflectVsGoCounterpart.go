// Invoke the method
result := method.Call(args)

fmt.Printf("%s result: %v\n", methodName, result[0].Interface())

// What is difference between result[0].Interface() vs result[0]
// result[0].Interface() v/s result[0]:

// When you call result[0].Interface(), you are extracting the actual Go value from the reflect.Value.

// Interface() returns the underlying value as an interface{} type, and then you can assert its type using a type assertion.

// go
// Copy code
// actualValue := result[0].Interface().(ActualType)
// This is useful when you want to work with the concrete type of the value and use it in a type-safe manner.

// result[0]:

// When you access result[0] directly, you are working with the reflect.Value itself.
// reflect.Value is a powerful type that contains information about the value's type and provides methods for various reflective operations.
// If you want to perform further reflection operations or obtain type information, you can work directly with the reflect.Value.

// ********************************************************************************************************************************

package main

import (
	"fmt"
	"reflect"
)

func main() {
	// Example function that returns an int
	myFunc := func() int {
		return 42
	}

	// Call the function using reflection
	result := reflect.ValueOf(myFunc).Call([]reflect.Value{})

	// Using result[0].Interface() to get the actual Go value
	actualValue := result[0].Interface().(int)
	fmt.Printf("Using Interface(): %d\n", actualValue)

	// Using result[0] to work with the reflect.Value
	// You can still extract the actual value using methods of reflect.Value
	convertedValue := result[0].Int()
	fmt.Printf("Using reflect.Value methods: %d\n", convertedValue)
}
