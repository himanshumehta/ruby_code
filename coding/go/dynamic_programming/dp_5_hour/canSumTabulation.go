package main

import "fmt"

func main() {
	n := canSum(7, []int{3, 3})
	fmt.Println(n)
}

func canSum(n int, m []int) bool {
	dp := make([]bool, n+1)
	dp[0] = true

	for i := 0; i <= n; i++ {
		if dp[i] {
			for _, ele := range m {
				if i+ele <= n {
					dp[i+ele] = true
				}
			}
		}
	}

	return dp[n]
}
