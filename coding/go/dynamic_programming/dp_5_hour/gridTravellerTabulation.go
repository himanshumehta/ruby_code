package main

import "fmt"

func main() {
	n := gridTraveller(3, 3)
	fmt.Println(n)
}

func gridTraveller(n int, m int) int {
	// n + 1 * m + 1 - 4 * 5
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, m+1)
	}

	dp[1][1] = 1
	fmt.Println(dp)

	//return dp[n][m]
	for i := 1; i <= n; i++ {
		for j := 1; j <= m; j++ {
			if i == 1 && j == 1 {
				dp[i][j] = 1
			} else {
				dp[i][j] = dp[i-1][j] + dp[i][j-1]
			}
		}
	}
	fmt.Println(dp)

	return dp[n][m]
}
