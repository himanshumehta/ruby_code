def knapsack(wt, val, w, n):
    if wt == 0 or n == 0:
        return 0
    if wt[n-1] <= w:
        return max(val[n-1] + knapsack(wt,val,w-wt[n-1], n-1), knapsack(wt,val,w, n-1))
    else:
        return knapsack(wt,val,w, n-1)


val = [60, 100, 120]
wt = [10, 20, 30]
W = 50
n = len(val)
print(knapsack(wt,val,W,n))