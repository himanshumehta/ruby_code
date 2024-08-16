
func numDecoding(s string) int {
	memo := make(map[int]int)
	answer := helper(s, 0, memo)
	return answer
}

func helper(s string, index int, memo map[int]int) int {
	// If index is greater than length of string
	if len(s) == index {
		return 1
	}

	// If the string starts with a zero, it can't be decoded
	if s[index] == '0' {
		return 0
	}

	// Return 1 for success.
	if index == len(s)-1 {
		return 1
	}

	// Check if the result is already memoized
	if val, ok := memo[index]; ok {
		return val
	}

	answer := helper(s, index+1, memo)

	substringValue, _ := strconv.Atoi(s[index : index+2])
	if substringValue > 9 && substringValue <= 26 {
		answer += helper(s, index+2, memo)
	}

	// Memoize the result
	memo[index] = answer
	return answer
}
