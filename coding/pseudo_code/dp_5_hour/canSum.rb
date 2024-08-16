# require 'benchmark'
# Benchmark.bm do |x|
#   x.report("factorial(10000)") { puts poor_fib(10) }
# end

#########################################
def canSum(targetSum, numbers)
  return true if targetSum == 0
  return false if targetSum < 0

  numbers.each do |num|
    remainder = targetSum - num
    if canSum(remainder, numbers) == true
      return true
    end
  end

  return false
end
# m = target sum
# n = length of array
# Time Complexity: O(n^m)
# Space Complexity: O(m)

# canSum - Memo
def canSum(num, numbers, memo = {})
  return true if num == 0
  return false if num < 0
  return memo[num] if memo.has_key?(num)

  for number in numbers # Adding Time complexity equal to O(length of numbers)
    if canSum(num - number, numbers, memo) == true # Adding Time complexity equal to O(num)
      memo[num] = true
      return true
    end
  end

  memo[num] = false
  return false
end
# m = target sum
# n = length of array
# Time Complexity: O(n*m)
# Space Complexity: O(m)

# canSum - Tabulation
def canSum(targetSum, numbers)
  table = Array.new(targetSum + 1, false)
  table[0] = true

  (0..targetSum).each do |i|
    if table[i] == true
      numbers.each do |num|
        table[i + num] = true
      end
    end
  end

  return table[targetSum]
end
# m = target sum
# n = length of array
# Time Complexity: O(m*n)
# Space Complexity: O(m)

p canSum(7, [2, 3]) # true
p canSum(7, [5, 3, 4, 7]) # true
p canSum(7, [2, 4]) # false
p canSumTabulation(7, [2, 3]) # true
p canSumTabulation(7, [5, 3, 4, 7]) # true
p canSumTabulation(7, [2, 4]) # false

# >> true
# >> true
# >> false
# >> true
# >> true
# >> false
