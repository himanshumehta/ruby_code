

def gridTraveller(n,m)
  return 1 if m == 1 && n == 1
  return 0 if m == 0 || n == 0

  return gridTraveller(n-1,m) + gridTraveller(n,m-1)
end

n = 3
m = 3
puts gridTraveller(n,m)

# Bottom up - Version 1
def gridTraveller(n,m)
	arr = Array.new(n+1) {Array.new(m+1, 0)}
	arr[0][1] = 1


	(n).times do |i|
		(m).times do |j|
			arr[i+1][j+1] = arr[i][j+1] + arr[i+1][j]
		end
	end

	arr[n][m]
end


n = 4
m = 4

gridTraveller(n,m)
# Time O(n) - O(n*m)
# Space O(n) - O(n*m)

# Bottom up version 2
def gridTraveller(n,m)
	arr = Array.new(n+1) {Array.new(m+1, 0)}
	arr[1][1] = 1


	(1..n).each do |i|
		(1..m).each do |j|
			arr[i+1][j] += arr[i][j] if i+1 <= n
			arr[i][j+1] += arr[i][j] if j+1 <= m
		end
	end

	arr[n][m]
end


n = 3
m = 3

gridTraveller(n,m)
# Time O(n) - O(n*m)
# Space O(n) - O(n*m)



