// 1. Definition:

// An empty interface is an interface with zero methods. It specifies no method signatures, making it applicable to values of any type.
// It is denoted by the keyword interface{}.

// 2. Use Cases:

// Container for Values of Any Type:
var data interface{}
data = 42
fmt.Println(data) // 42
data = "Hello, World!"
fmt.Println(data) // Hello, World!

// Functions with Generic Parameters:
func printValue(value interface{}) {
    fmt.Println(value)
}
printValue(42)
printValue("Hello, World!")

// Dynamic Data Handling:
func processData(data interface{}) {
// Perform actions based on the dynamic type of 'data'
    // ...
}

// JSON Unmarshaling:
var result interface{}
json.Unmarshal([]byte(jsonData), &result)


// 3. Type Assertions:
// To work with the values stored in an empty interface, you often need to perform type assertions to convert them back to their concrete types.
value, ok := data.(int)
if ok {
    fmt.Println("It's an integer:", value)
} else {
    fmt.Println("Not an integer.")
}

// 4. Empty Interface and Reflection:
// The empty interface is often used in conjunction with the reflect package for more advanced reflection operations.
func inspect(value interface{}) {
    // Use reflection to inspect the type and value of 'value'
    // ...
}

// 5. Drawbacks:
// While powerful, the use of empty interfaces can lead to less type safety and more runtime errors.
// It is crucial to use type assertions carefully and ensure proper error handling.
// Example:
package main

import "fmt"

func printValue(value interface{}) {
	fmt.Println(value)
}

func main() {
	var data interface{}

	data = 42
	printValue(data)

	data = "Hello, World!"
	printValue(data)

	// Type assertion
	if value, ok := data.(string); ok {
		fmt.Println("It's a string:", value)
	} else {
		fmt.Println("Not a string.")
	}
}
