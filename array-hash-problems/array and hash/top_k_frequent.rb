# Not optimised
# def top_k_frequent(nums, k)
#   # Tally the frequencies of each number in the array
#   freq = nums.tally
#   # Sort the frequencies in descending order and take the first k elements
#   freq.sort_by { |_, count| -count }.first(k).map(&:first)
# end

def top_k_frequent(nums, k)
  # Tally the frequencies of each number in the array
  freq = nums.tally

  # Create an array of empty arrays, with a size of nums.size + 1
  buckets = Array.new(nums.size + 1) { [] }

  # Populate the buckets: each bucket[i] contains all numbers with frequency i
  freq.each do |num, count|
    buckets[count] << num # buckets[3] << 1, buckets[2] << 2, buckets[1] << 3
  end

  result = []

  # Iterate from highest frequency to lowest
  (buckets.size - 1).downto(0) do |i|
    result.concat(buckets[i])
    break if result.size >= k
  end

  result
end

nums = [1, 1, 1, 2, 2, 3]
k = 2
p top_k_frequent(nums, k)

# Output should be: [1, 2]
