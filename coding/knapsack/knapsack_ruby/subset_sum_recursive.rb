set = [3, 27, 34, 4, 12, 5, 2]
sum = 30
n = set.length

# print(isSubSetSum(set, n, sum))

def isSubSetSum(set, sum, n)
  return true if sum == 0
  return false if n == 0 && sum != 0

  if sum < set[n - 1]
    return isSubSetSum(set, sum, n - 1)
  end

  isSubSetSum(set, sum - set[n - 1], n - 1) || isSubSetSum(set, sum, n - 1)
end

p isSubSetSum(set, sum, n)

# >> false
