# Problem Statement
# Given an array of integers nums and an integer target, return the indices of the two numbers such that they add up to target.

# You may assume that each input would have exactly one solution, and you may not use the same element twice. You can return the answer in any order.

def two_sum(nums, target)
  map = {}
  nums.each_with_index do |num, idx|
    return map[target - num], idx if map[target - num]

    map[num] = idx
  end
  nil
end

# Example usage
nums = [2, 7, 11, 15]
target = 9
result = two_sum(nums, target)
puts "Indices of the two numbers that add up to #{target} are: #{result}"
