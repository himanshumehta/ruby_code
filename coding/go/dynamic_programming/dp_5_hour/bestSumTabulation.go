package main

import (
	"fmt"
)

func main() {
	n := bestSum(7, []int{3, 1, 7})
	for _, ele := range n {
		fmt.Println(ele)
	}
	fmt.Println(n)
}

func bestSum(n int, m []int) []int {
	dp := make([][]int, n+1)
	dp[0] = []int{}

	for i := 0; i <= n; i++ {
		if dp[i] != nil {
			for _, ele := range m {
				if i+ele <= n {
					if dp[i+ele] == nil {
						dp[i+ele] = []int{}
						dp[i+ele] = append([]int{ele}, dp[i]...)
					} else {
						currentLen := len(dp[i+ele])
						newLen := len(append([]int{ele}, dp[i]...))
						if newLen < currentLen {
							dp[i+ele] = append([]int{ele}, dp[i]...)
						}
					}
				}
			}
		}
	}

	return dp[n]
}
