#########################################
# What is fib 0 to 10?
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
def poor_fib(n)
 if n <= 2
    1
  else
    poor_fib(n-1) + poor_fib(n-2)
  end
end

# Time complexity - O(n) = O(2^n)
# Space complexity - O(n) = O(n)
#########################################
# Add memoization to improve time complexity
def fib_memo(n, memo = {})
  if n <= 2
    1
  elsif memo[n]
    memo[n]
  else
    memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
  end
end

# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
# Bottom up approach
def fib_bottom_up(n)
  return 1 if n <= 2
  fibs = [0, 1, 1]
  (3..n).each do |i|
    fibs[i] = fibs[i-1] + fibs[i-2]
  end
  fibs[n]
end

# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
