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

// Using reflect
func valueExists(arr interface{}, target interface{}) bool {
	arrValue := reflect.ValueOf(arr)
	targetValue := reflect.ValueOf(target)

	if arrValue.Kind() != reflect.Slice {
		return false
	}

	for i := 0; i < arrValue.Len(); i++ {
		elem := arrValue.Index(i)
		if elem.Interface() == targetValue.Interface() {
			return true
		}
	}

	return false
}

// Using generics
func valueExists[T comparable](arr []T, target T) bool {
	for _, elem := range arr {
		if elem == target {
			return true
		}
	}
	return false
}



