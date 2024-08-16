package main

import (
	"fmt"
	"strings"
)

func main() {
	wordDict := []string{"a", "p", "ent", "enter", "ot", "o", "t"}
	samples := []string{
		"enterapotentpot",
	}

	for _, s := range samples {
		ways := allConstruct(s, wordDict)
		fmt.Printf("Input: %s\n", s)
		fmt.Println("Possible constructions:")
		for _, way := range ways {
			fmt.Println(" -", way) // Print each way as a space-separated string
		}
	}
}

func allConstruct(s string, wordDict []string) [][]string {
	_, ways := helper(s, wordDict)
	return ways
}

func helper(s string, wordDict []string) (bool, [][]string) {
	if len(s) == 0 {
		// This is important and what I missed last time
		return true, [][]string{{}}
	}

	totalWays := make([][]string, 0)

	for _, ele := range wordDict {
		if isPrefix(s, ele) {
			ok, suffixWays := helper(s[len(ele):], wordDict)
			if ok {
				for _, wordArr := range suffixWays {
					newWay := append([]string{ele}, wordArr...)
					totalWays = append(totalWays, newWay)

				}

			}

		}
	}
	// This len check is edge case I missed last time
	return len(totalWays) > 0, totalWays
}

func isPrefix(word, prefix string) bool {
	return len(prefix) <= len(word) && strings.HasPrefix(word, prefix)
}


// Better way
package main

import (
	"fmt"
	"strings"
)

func main() {
	wordDict := []string{"a", "p", "ent", "enter", "ot", "o", "t"}
	samples := []string{
		"enterapotentpot",
	}

	for _, s := range samples {
		ways := allConstruct(s, wordDict)
		fmt.Printf("Input: %s\n", s)
		fmt.Println("Possible constructions:")
		for _, way := range ways {
			fmt.Println(" -", way) // Print each way as a space-separated string
		}
	}
}

func allConstruct(s string, wordDict []string) [][]string {
	ways, _ := helper(s, wordDict)
	return ways
}

func helper(s string, wordDict []string) ([][]string, bool) {
	if len(s) == 0 {
		return [][]string{{}}, true
	}

	totalWays := [][]string{}

	for _, word := range wordDict {
		if isPrefix(s, word) {
			suffixWays, suffixPossible := helper(s[len(word):], wordDict)
			if suffixPossible {
				for _, suffix := range suffixWays {
					newWay := append([]string{word}, suffix...)
					totalWays = append(totalWays, newWay)
				}
			}
		}
	}

	return totalWays, len(totalWays) > 0
}

func isPrefix(word, prefix string) bool {
	return len(prefix) <= len(word) && strings.HasPrefix(word, prefix)
}


// Here's why the len(totalWays) > 0 check is crucial in helper method return statement, along with an example:

// 1. Accurately Determining Constructibility:

// The helper function's primary goal is to determine whether the target string s can be constructed using words from wordDict.
// Returning true only when len(totalWays) > 0 ensures that true is returned only if at least one valid construction is found.
// Returning true unconditionally could lead to false positives in cases where no valid construction exists.
// 2. Example:

// Consider the input s = "hello" and wordDict = ["he", "llo", "abc"].

// The recursive calls will explore different combinations, but none will successfully construct "hello" using the available words.
// Without the len(totalWays) > 0 check, the function would incorrectly return true even though no valid construction exists.
// By checking len(totalWays), it accurately returns false in this case.
// 3. Importance for Algorithm Correctness:

// This check plays a vital role in the algorithm's overall correctness.
// It prevents misleading results and ensures that the algorithm only reports successful constructions when they are genuinely possible.
// It's a small but essential detail that significantly impacts the reliability of the code.
// 4. Impact on Further Recursive Calls:

// The true or false value returned from helper guides subsequent recursive calls.
// Incorrectly returning true when no construction is possible could lead to unnecessary exploration of invalid paths, potentially affecting the algorithm's efficiency.
// 5. Preventing Unnecessary Recursion:

// When a branch of recursion fails to find any valid constructions, returning false signals to parent calls that they don't need to pursue that path further, saving time and resources.
// In conclusion, the len(totalWays) > 0 check is a critical guard against false positives and plays a key role in maintaining the accuracy and efficiency of the algorithm.
