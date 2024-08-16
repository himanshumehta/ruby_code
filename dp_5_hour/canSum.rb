

# def canSum(num, numbers)
#   return true if num == 0
#   return false if num < 0

#   for number in numbers
#     if canSum(num - number, numbers) == true
#       return true
#     end
#   end

#   return false
# end

# p canSum(9, [2,4,8])
# p canSum(16, [2,4,8])

# m = target sum
# n = length of array
# Time O(n) - O(n^m)
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

def canSum_bottom_up(num, numbers)
	arr = Array.new(num+1)
	arr[0] = TRUE

	(0..(num+1)).each do |num|
		if arr[num] == TRUE
			numbers.each do |plus_num|
				arr[num+plus_num] = TRUE 
			end
		end
	end

	arr[num] || FALSE
end

# m = target sum
# n = length of array
# Time Complexity: O(m*n)
# Space Complexity: O(m)


p canSum_bottom_up(9, [2,4,8])
p canSum_bottom_up(16, [2,4,8])