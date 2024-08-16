def knapsack_top_down(weights, values, W, n, t)
  return 0 if n == 0 || W == 0

  return t[n][W] if t[n][W] != -1

  if weights[n - 1] <= W
    t[n][W] = [values[n - 1] + knapsack_top_down(weights, values, W - weights[n - 1], n - 1, t), knapsack_top_down(weights, values, W, n - 1, t)].max
  else
    t[n][W] = knapsack_top_down(weights, values, W, n - 1, t)
  end

  t[n][W]
end

weights = [10, 20, 30]
values = [60, 100, 120]
W = 50
n = weights.length

t = Array.new(n + 1) { Array.new(W + 1, -1) }

puts knapsack_top_down(weights, values, W, n, t)

########################################################

def knapsack_bottom_up(weights, values, W, n)
  t = Array.new(n + 1) { Array.new(W + 1, 0) }

  for i in 1..n
    for w in 1..W
      if weights[i - 1] <= w
        t[i][w] = [values[i - 1] + t[i - 1][w - weights[i - 1]], t[i - 1][w]].max
      else
        t[i][w] = t[i - 1][w]
      end
    end
  end

  t[n][W]
end

weights = [10, 20, 30]
values = [60, 100, 120]
W = 50
n = weights.length

puts knapsack_bottom_up(weights, values, W, n)
