func main() {
	sampleString := "racecar"
	maxLength := 0

	for i := 0; i < len(sampleString); i++ {
		for j := i + 1; j <= len(sampleString); j++ {
			s := sampleString[i:j]
			fmt.Println(s)
			res, clen := checkPalindrome(s)
			if res {
				if clen > maxLength {
					maxLength = clen
				}
			}
		}
	}

	fmt.Println(maxLength)
}

func checkPalindrome(s string) (bool, int) {
	for start, end := 0, len(s)-1; start < end; start, end = start+1, end-1 {
		if s[start] != s[end] {
			return false, 0
		}
	}
	return true, len(s)
}
