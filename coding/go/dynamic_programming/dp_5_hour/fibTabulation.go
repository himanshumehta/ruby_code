package main

import "fmt"

func main() {
	n := fib(6)
	fmt.Println(n)
}

func fib(n int) int {
	dp := make([]int, n+1)
	dp[0] = 0
	dp[1] = 1

	for i := 0; i < n; i++ {
		//	0, 1...6
		dp[i+1] += dp[i]
		if i+2 <= n {
			dp[i+2] += dp[i]
		}
	}

	return dp[n]
}

// Optimised code suggested by ChatGPT
func fib(n int) int64 {
	dp := make([]int64, n+2)
	dp[0] = 0
	dp[1] = 1

	for i := 0; i <= n; i++ {
		dp[i+1] += dp[i]
		dp[i+2] += dp[i]
	}

	return dp[n]
}

