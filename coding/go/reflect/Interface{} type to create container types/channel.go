package main

import "fmt"

func main() {
	// Create a channel of empty interfaces
	mixedChannel := make(chan interface{})

	// Launch a goroutine to send values of different types to the channel
	go func() {
		mixedChannel <- 42
		mixedChannel <- "Hello, World"
		mixedChannel <- 3.14
		mixedChannel <- true
		close(mixedChannel)
	}()

	// Receive and print values from the channel
	for value := range mixedChannel {
		fmt.Printf("Type: %T, Value: %v\n", value, value)
	}
}
