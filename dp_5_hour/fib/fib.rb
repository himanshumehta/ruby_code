



# # 0,1,1,2,3,5...

def poor_fib(n)
  return 0 if n == 0
  return 1 if n < 1
  return poor_fib(n-1) + poor_fib(n-2)
end

p poor_fib(6)
# Time O(n) - 2^n
# Space O(n) - n

def fib_memo(n, memo={})
  return 0 if n == 0
  return 1 if n <= 2

  return memo[n] if memo[n] != nil
  memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
  return memo[n]
end

p fib_memo(12)
# Time O(n) - O(n)
# Space O(n) - O(n)

def bottom_up_fib_series(n)
  return [0] if n == 0
  return [0,1] if n == 1

  
  seq = [0,1]

  for i in 2..n
    seq << (seq[i-1] + seq[i-2])
  end

  return seq
end

p bottom_up_fib_series(6)
# Time O(n) - O(n)
# Space O(n) - O(n)