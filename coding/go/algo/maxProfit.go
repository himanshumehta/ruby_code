package main

import (
	"fmt"
)

func main() {
	s := []int{7, 1, 5, 3, 6, 4}
	result := maxProfit(s)
	fmt.Println(result)
}

func maxProfit(prices []int) int {
	maxP := 0
	minP := prices[0]

	for i := 1; i < len(prices); i++ {
		profit := prices[i] - minP
		if prices[i] < minP {
			minP = prices[i]
		}
		if profit > maxP {
			maxP = profit
		}

	}

	return maxP
}

func maxProfit(prices []int) int {

	maxProfit := 0
	minSo := prices[0]
	for i := 1; i < len(prices); i++ {
		Profit := (prices[i] - minSo)
		minSo = min(prices[i], minSo)
		maxProfit = max(maxProfit, Profit)
	}

	return maxProfit

}
