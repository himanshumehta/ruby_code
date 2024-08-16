def isSubSetSum(set, n, sum):
    if sum == 0:
        return True
    if (n == 0 and sum != 0):
        return False
    if set[n-1] > sum:
        return isSubSetSum(set, n-1, sum)
    return isSubSetSum(set, n-1, sum - set[n-1]) or isSubSetSum(set, n-1, sum)

set = [3, 27, 34, 4, 12, 5, 2]
sum = 30
n = 6

print(isSubSetSum(set, n, sum))
