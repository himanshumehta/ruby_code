val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length

t = (n + 1).times.collect { [-1] * (w + 1) }

def knapsack(wt, val, w, n, t)
  if wt == 0 or n == 0
    return 0
  end

  if t[n][w] != -1
    return t[n][w]
  end

  if wt[n - 1] <= w
    t[n][w] = [val[n - 1] + knapsack(wt, val, w - wt[n - 1], n - 1, t), knapsack(wt, val, w, n - 1, t)].max
  else
    t[n][w] = knapsack(wt, val, w, n - 1, t)
  end
  return t[n][w]
end

p knapsack(wt, val, w, n, t)

# >> 220
