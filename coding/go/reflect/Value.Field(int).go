package main

import (
	"fmt"
	"reflect"
)

type Person struct {
	Name    string
	Age     int
	Address string
}

func main() {
	person := Person{"John Doe", 30, "123 Main St"}

	// Get the type of the struct
	personType := reflect.TypeOf(person)

	// Get the value of the struct
	personValue := reflect.ValueOf(person)

	// Get the number of fields in the struct
	numFields := personType.NumField()

	// Print information about each field
	for i := 0; i < numFields; i++ {
		field := personType.Field(i)
		fieldValue := personValue.Field(i).Interface()

		fmt.Printf("Field %d: Name=%s, Type=%v, Value=%v\n", i+1, field.Name, field.Type, fieldValue)
	}
}
