def knapsack(wt, w, n):
    if wt == 0 or n == 0:
        return 0
    if wt[n-1] <= w:
        return max(wt[n-1] + knapsack(wt,w-wt[n-1], n-1), knapsack(wt,w, n-1))
    else:
        return knapsack(wt,w, n-1)


wt = [10, 20, 30]
W = 50
n = len(wt)
print(knapsack(wt,W,n))
