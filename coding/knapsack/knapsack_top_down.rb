val = [60, 100, 120]
wt = [10, 20, 30]
w = 50
n = val.length
t = (n + 1).times.collect { [-1] * (w + 1) }

(n + 1).times do |row|
  (w + 1).times do |col|
    if row == 0 || col == 0
      t[row][col] = 0
    end
  end
end

(1..n).each do |i|
  (1..w).each do |j|
    if wt[i - 1] <= j
      t[i][j] = [val[i - 1] + t[i - 1][j - wt[i - 1]], t[i - 1][j]].max
    else
      t[i][j] = t[i - 1][j]
    end
  end
end

p t[n][w]

# >> 220
