def knapsack(wt, val, w, n)
  return 0 if n.zero? || w.zero?
  if wt[n - 1] <= w
    [(val[n - 1] + knapsack(wt, val, w - wt[n - 1], n)), knapsack(wt, val, w, n - 1)].max
  else
    knapsack(wt, val, w, n - 1)
  end
end

val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length
p knapsack(wt, val, w, n)

# >> 300
