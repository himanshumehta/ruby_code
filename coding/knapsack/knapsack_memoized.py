def knapsack(wt, val, w, n, t):
    if wt == 0 or n == 0:
        return 0
    if t[n][w] != -1:
        return t[w][n]
    if wt[n-1] <= w:
        t[n][w] = max(val[n-1] + knapsack(wt,val,w-wt[n-1], n-1,t), knapsack(wt,val,w, n-1,t))
    else:
        t[n][w] = knapsack(wt,val,w, n-1,t)
    return t[n][w]


if __name__ == "__main__":
    val = [60, 100, 120]
    wt = [10, 20, 30]
    W = 50
    n = len(val)
    t = [[-1 for i in range(W + 1)] for i in range(n+1)]
    print(knapsack(wt,val,W,n,t))
