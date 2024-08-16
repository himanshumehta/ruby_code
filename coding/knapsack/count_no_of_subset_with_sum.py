def isSubSetSum(set, n, sum):
    if sum == 0:
        return 1
    if (n == 0 and sum != 0):
        return 0
    if set[n-1] > sum:
        return isSubSetSum(set, n-1, sum)
    return isSubSetSum(set, n-1, sum - set[n-1]) + isSubSetSum(set, n-1, sum)

set = [2, 3, 5,6,8,10]
sum = 10
n = 6

print(isSubSetSum(set, n, sum))
