
func longestValidParentheses(s string) int {
	runeSlice := []rune(s)
	stack := make([]int, 0)
	stack = append(stack, -1)
	maxSoFar := 0

	for index, char := range runeSlice {
		switch char {
		case '(':
			stack = append(stack, index)
		case ')':
			// Pop the top item
			stack = stack[:len(stack)-1]
			if len(stack) == 0 {
				stack = append(stack, index)
			} else {
				peek := stack[len(stack)-1]
				length := index - peek
				if length > maxSoFar {
					maxSoFar = length
				}
			}
		}
	}

	return maxSoFar
}
