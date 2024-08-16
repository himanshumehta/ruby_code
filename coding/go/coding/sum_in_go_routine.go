package main

import (
	"fmt"
	"sync"
)

func worker(start, end int, resultChan chan int, wg *sync.WaitGroup) {
	defer wg.Done()
	sum := 0
	for i := start; i <= end; i++ {
		sum += i
	}
	resultChan <- sum
}

func main() {
	N := 100
	numWorkers := 4
	chunkSize := N / numWorkers
	remainder := N % numWorkers
	start := 1
	end := chunkSize

	resultChan := make(chan int, numWorkers)
	var wg sync.WaitGroup

	for i := 0; i < numWorkers; i++ {
		wg.Add(1)
		go worker(start, end, resultChan, &wg)
		start = end + 1
		if i == numWorkers-1 {
			end = end + chunkSize + remainder
		} else {
			end = end + chunkSize
		}
	}

	// Close the channel
	go func() {
		wg.Wait()
		close(resultChan)
	}()

	totalSum := 0
	for sum := range resultChan {
		totalSum += sum
	}

	fmt.Printf("The sum of integers from 1 to %d is %d\n", N, totalSum)
}
