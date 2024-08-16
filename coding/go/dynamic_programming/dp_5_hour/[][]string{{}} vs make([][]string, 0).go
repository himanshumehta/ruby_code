package main

import "fmt"

func main() {
	totalWays := [][]string{{}}

	totalWays = append(totalWays, []string{"one", "two"})

	for _, ways := range totalWays {
		fmt.Println(ways) // This won't be executed because totalWays is empty
	}
  // Output - 
  // []
  // [one two]

	totalWays2 := make([][]string, 0)

	totalWays2 = append(totalWays2, []string{"one", "two"})

	for _, ways := range totalWays2 {
		fmt.Println(ways) // This won't be executed because totalWays is empty
	}
  // Output - 
  // [one two]
}

// Initialization:

// totalWays: It's initialized with a slice containing a single empty slice: [][]string{{}}. This creates a slice with a capacity of 1 and a length of 1, already containing an empty slice within it.
// totalWays2: It's initialized using make([][]string, 0), which creates a slice with a capacity of 0 and a length of 0. It's initially empty, with no slices inside.

// 2. Appending:

// totalWays: When appending []string{"one", "two"}, a new slice is added to the existing slice, resulting in: [[]string{}, []string{"one", "two"}].
// totalWays2: When appending []string{"one", "two"}, the slice's capacity is increased to accommodate the new element, resulting in: [[]string{"one", "two"}].
