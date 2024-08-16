func twoSum(nums []int, target int) []int {
	h := make(map[int]int)
	for i, a := range nums {
		n := target - a
		if val, ok := h[n]; ok {
			return []int{val, i}
		}
		h[a] = i
	}

	return nil
}
