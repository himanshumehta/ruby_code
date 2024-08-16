func maxSubArray(nums []int) int {
	maxSoFar := math.Inf(-1)
	maxEndingHere := math.Inf(-1)

	for _, num := range nums {
		maxEndingHere = math.Max(float64(maxEndingHere) + float64(num), float64(num))
		if maxSoFar < maxEndingHere {
			maxSoFar = maxEndingHere
		}
	}

	return int(maxSoFar)
}
