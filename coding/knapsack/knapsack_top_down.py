def knapsack(wt, val, w, n):
    t = [[None for i in range(W + 1)] for j in range(n+1)]
    # Initialize t array fow when either wt = 0 or n = 0
    for i in range(n+1):
        for j in range(w+1):
            if i == 0 or j ==0:
                t[i][j] = 0
    for i in range(1,n+1):
        for j in range(1,w+1):
            if wt[i-1]<=j:
                t[i][j] = max(val[i-1] + t[i-1][j-wt[i-1]], t[i-1][j])
            else:
                t[i][j] = t[i-1][j]
    return t[n][w]

if __name__ == "__main__":
    val = [60, 100, 120]
    wt = [10, 20, 30]
    W = 50
    n = len(val)
    print(knapsack(wt,val,W,n))
