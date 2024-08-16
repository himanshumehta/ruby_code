weights = [2, 3, 6]
n = weights.length
w = 6

rows, cols = n + 1, w + 1  # your values
t = Array.new(rows, -1) { Array.new(cols, -1) }

(n + 1).times do |i|
  (w + 1).times do |j|
    if i == 0
      t[i][j] = 0
    end
    if j == 0
      t[i][j] = 1
    end
  end
end

(1..n).each do |i|
  (1..w).each do |j|
    if weights[i - 1] <= j
      t[i][j] = t[i][j - weights[i - 1]] + t[i - 1][j]
    else
      t[i][j] = t[i - 1][j]
    end
  end
end

p t[n][w]

# >> 3
