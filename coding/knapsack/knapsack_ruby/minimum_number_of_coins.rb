require "awesome_print"
# |---w+1 == Sum
# |
# n+1 == Size of array
#
# Infinity,Infinity,Infinity,Infinity,Infinity
# 0
# 0
# 0

def coin_change(coins, amount)
  weights = coins
  n = coins.length
  w = amount
  t = dp(weights, w, n)
  return -1 if t[n][w] == Float::INFINITY
  return 0 if amount == 0

  t[n][w]
end

def dp(weights, w, n)
  rows = n + 1
  cols = w + 1
  t = Array.new(rows, -1) { Array.new(cols, -1) }

  (n + 1).times do |i|
    (w + 1).times do |j|
      if i == 1 && t[i][j] == -1
        t[i][j] = if (j % weights[0]).zero?
            j / weights[0]
          else
            Float::INFINITY - 1
          end
      end

      t[i][j] = 0 if j.zero? # Fill zero in 1st columns
      t[i][j] = Float::INFINITY - 1 if i.zero? # Fill infinity in 1st row
    end
  end

  (2..n).each do |i|
    (1..w).each do |j|
      t[i][j] = if weights[i - 1] <= j
          [1 + t[i][j - weights[i - 1]], t[i - 1][j]].min
        else
          t[i - 1][j]
        end
    end
  end
  t
end

coins = [1, 2]
amount = 3
pp coin_change(coins, amount)

# #  [[Infinity, Infinity, Infinity], [0, -1, -1], [0, -1, -1]]

# >> 2
