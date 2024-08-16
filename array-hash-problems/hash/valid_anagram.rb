# Problem Statement: Valid Anagram
# Given two strings s and t, write a function to determine if t is an anagram of s.

# An anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

# Example
# Input: s = "anagram", t = "nagaram"
# Output: true

# Input: s = "rat", t = "car"
# Output: false

def is_anagram(s, t)
  # Return false if lengths differ
  return false if s.length != t.length

  # Initialize hash map to count character frequencies
  count = Hash.new(0)

  # Increment count for characters in s and decrement for characters in t
  s.each_char { |char| count[char] += 1 }
  t.each_char { |char| count[char] -= 1 }

  # Check if all counts are zero
  count.all? { |_, value| value.zero? }
end

# Example usage
puts is_anagram('anagram', 'nagaram') # true
puts is_anagram('rat', 'car')         # false
