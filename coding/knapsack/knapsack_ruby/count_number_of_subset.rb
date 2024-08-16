set = [2, 3, 5, 6, 8, 10]
sum = 10
n = 6

# print(isSubSetSum(set, n, sum))

def isSubSetSum(set, sum, n)
  return 1 if sum == 0
  return 0 if n == 0 && sum != 0

  if sum < set[n - 1]
    return isSubSetSum(set, sum, n - 1)
  end

  isSubSetSum(set, sum - set[n - 1], n - 1) + isSubSetSum(set, sum, n - 1)
end

p isSubSetSum(set, sum, n)

# >> 3
