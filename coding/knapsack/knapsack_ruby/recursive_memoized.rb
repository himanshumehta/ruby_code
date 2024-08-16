def knapsack(wt, w, val, n, t)
  # wt is weight array
  # val is value array
  # w is weight
  # n is length

  return 0 if n == 0
  return 0 if w == 0
  return t[n][w] if t[n][w] != -1

  if wt[n - 1] <= w
    t[n][w] = [knapsack(wt, w - wt[n - 1], val, n - 1, t) + val[n - 1], knapsack(wt, w, val, n - 1, t)].max
  else
    t[n][w] = knapsack(wt, w, val, n - 1, t)
  end
  p t
  return t[n][w]
end

val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length
t = (n + 1).times.collect { [-1] * (w + 1) }
p knapsack(wt, w, val, n, t)
