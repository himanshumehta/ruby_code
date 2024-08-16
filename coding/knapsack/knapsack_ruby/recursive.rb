# def knapsack(wt, val, w, n)
#   if n == 0 || w == 0
#     return 0
#   end

#   if wt[n - 1] <= w
#     return [(val[n - 1] + knapsack(wt, val, w - wt[n - 1], n - 1)), knapsack(wt, val, w, n - 1)].max
#   else
#     return knapsack(wt, val, w, n - 1)
#   end
# end

def knapsack(wt, val, w, n)
  return 0 if w == 0 || n == 0

  if wt[n - 1] <= w
    return [knapsack(wt[0..n - 2], val[0..n - 2], w - wt[n - 1], n - 1) + val[n - 1],
            knapsack(wt[0..n - 2], val[0..n - 2], w, n - 1)].max
  else
    knapsack(wt[0..n - 2], val[0..n - 2], w, n - 1)
  end
end

val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length

p knapsack(wt, val, w, n)

# >> 220
