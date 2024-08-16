# Revision notes

def top_k_frequent(nums, k)
  # Tally the frequencies of each number in the array
  freq = nums.tally                                         # => {1=>3, 2=>2, 3=>1}
  freq.sort_by { |_, count| -count }                        # => [[1, 3], [2, 2], [3, 1]]
  freq.sort_by { |_, count| count }                         # => [[3, 1], [2, 2], [1, 3]]
  freq.sort_by { |_, count| -count }.first(k)               # => [[1, 3], [2, 2]]
  freq.sort_by { |_, count| -count }.first(k).map(&:first)  # => [1, 2]
end

# Example usage
nums = [1, 1, 1, 2, 2, 3]  # => [1, 1, 1, 2, 2, 3]
k = 2                      # => 2
p top_k_frequent(nums, k)  # => [1, 2]
# >> [1, 2]
