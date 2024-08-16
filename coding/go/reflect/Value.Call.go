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

func main() {
	calculator := Calculator{}

	// Get the type of the struct
	calculatorType := reflect.TypeOf(calculator)

	// Get the value of the struct
	calculatorValue := reflect.ValueOf(calculator)

	// Get the method by name
	methodName := "Add"
	method := calculatorValue.MethodByName(methodName)

	// Prepare arguments for the method
  // The syntax you provided is related to creating a slice of reflect.Value instances, and it's commonly used when preparing arguments for the Call method in the reflect package.
	args := []reflect.Value{reflect.ValueOf(10), reflect.ValueOf(5)}

	// Invoke the method
	result := method.Call(args)

	fmt.Printf("%s result: %v\n", methodName, result[0].Interface())
}


