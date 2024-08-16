def count_subsets(set, n, target_sum, memo = {})
  return 1 if target_sum == 0
  return 0 if n == 0 && target_sum != 0

  memo_key = "#{n}-#{target_sum}"
  return memo[memo_key] if memo.key?(memo_key)

  if set[n-1] > target_sum
    memo[memo_key] = count_subsets(set, n-1, target_sum, memo)
  else
    memo[memo_key] = count_subsets(set, n-1, target_sum - set[n-1], memo) + count_subsets(set, n-1, target_sum, memo)
  end

  memo[memo_key]
end

set = [2, 3, 5, 6, 8, 10]
target_sum = 10
n = 6

puts count_subsets(set, n, target_sum)
