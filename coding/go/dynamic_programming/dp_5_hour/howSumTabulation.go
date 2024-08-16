package main

import (
	"fmt"
)

func main() {
	n := howSum(7, []int{3, 4, 1, 7})
	for _, ele := range n {
		fmt.Println(ele)
	}
	fmt.Println(n)
}

func howSum(n int, m []int) []int {
	dp := make([][]int, n+1)
	dp[0] = []int{}

	for i := 0; i <= n; i++ {
		if dp[i] != nil {
			for _, ele := range m {
				if i+ele <= n {
					dp[i+ele] = []int{}
					dp[i+ele] = append([]int{ele}, dp[i]...)
				}
			}
		}
	}

	return dp[n]
}
