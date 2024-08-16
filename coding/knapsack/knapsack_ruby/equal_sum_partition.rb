# It is not ruby code, suprise
# Do not worry as code is there in file named subset_sum.rb
def findPartion(arr, n):
    sum = 0
    for i in range(0,n):
        sum += arr[i]
    if sum % 2 != 0:
        return False
    return isSubSetSum(arr, n, sum/2)

def isSubSetSum(set, n, sum):
    if sum == 0:
        return True
    if (n == 0 and sum != 0):
        return False
    if set[n-1] > sum:
        return isSubSetSum(set, n-1, sum)
    return isSubSetSum(set, n-1, sum - set[n-1]) or isSubSetSum(set, n-1, sum)

print(findPartion([3, 4, 5, 12], 4))

