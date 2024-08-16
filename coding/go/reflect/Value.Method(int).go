package main

import (
	"fmt"
	"reflect"
)

type Calculator struct {
}

func (c Calculator) Add(a, b int) int {
	return a + b
}

func (c Calculator) Subtract(a, b int) int {
	return a - b
}

func main() {
	calculator := Calculator{}

	// Get the type of the struct
	calculatorType := reflect.TypeOf(calculator)

	// Get the number of methods in the struct
	numMethods := calculatorType.NumMethod()

	// Print information about each method
	for i := 0; i < numMethods; i++ {
		method := calculatorType.Method(i)
    // The returned Method has information about the method, such as its name, type, and other properties. 

		fmt.Printf("Method %d: Name=%s, Type=%v\n", i+1, method.Name, method.Type)
	}
}
