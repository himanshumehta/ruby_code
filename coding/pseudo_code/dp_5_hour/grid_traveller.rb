#########################################
def gridTraveller(n,m, memo)
  return memo[n][m] if  memo[n][m] != 0
  return 1 if m == 1 && n == 1
  return 0 if m == 0 || n == 0

  memo[n][m] = gridTraveller(n-1,m, memo) + gridTraveller(n,m-1, memo)
end

memo = []
n = 30
m = 50
memo = Array.new(n+1) {Array.new(m+1, 0)}
p memo
puts gridTraveller(n,m, memo)
#########################################
def gridTraveller(n,m)
  result = Array.new(n+1) {Array.new(m+1, 1)}
  result[0][0] = 0

  (1..n-1).each do |i|
    (1..m-1).each do |j|
      result[i][j] = result[i-1][j] + result[i][j-1]
    end
  end

  result[n-1][m-1]
end

n = 50
m = 30
puts gridTraveller(n,m)
# 2105556772509601296600

# Time complexity: O(n*m)
# Space complexity: O(n*m)

#########################################
# Alternate solution
def gridTraveller_2(n,m)
  result = Array.new(n+1) {Array.new(m+1, 0)}
  result[1][1] = 1

  (0..n).each do |i|
    (0..m).each do |j|
      current = result[i][j]
      if j+1 <= m
        result[i][j+1] += current
      end
      if i+1 <= n
        result[i+1][j] += current
      end
    end
  end

  result[n][m]
end

n = 50
m = 30
puts gridTraveller_2(n,m)
# >> 2105556772509601296600

# Time complexity: O(n*m)
# Space complexity: O(n*m)
#########################################
