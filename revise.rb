# Loop over Matrix
rows = n + 1
cols = w + 1
t = Array.new(rows, -1) { Array.new(cols, -1) }

(n + 1).times do |i|
  (w + 1).times do |j|
  end
end

# Circular rotation ke funday
n = 10   # => 10
idx = 0  # => 0

(idx + 1) % n      # => 1
(idx - 1 + n) % n  # => 9

# How to build incremental array?
size = 5                         # => 5
@id = Array.new(size) { |i| i }  # => [0, 1, 2, 3, 4]

# How Modulo operator works?
# Modulo operator Whenever the second number is larger than the first, the second number will divide the first 0 times, so the first number will be the remainder. p 7 % 8

7 % 8   # => 7
# The modulus operator can also work with negative operands. x % y always returns results with the sign of y. 
-6 % 4  # => 2
6 % -4  # => -2

# Notice how unshift works
a = [1, 23, 4]  # => [1, 23, 4]
p a.shift       # => 1
p a.unshift     # => [23, 4]

# Start of ./low_level_design/lld.rb
require "readline"                         # => true
while buf = Readline.readline("> ", true)  # => nil
  p buf
end                                        # => nil

# for-loop method
for n in 0..2  # => 0..2
  puts n       # => nil, nil, nil
end            # => 0..2
# 1
# 2

nums = [[1, 12, 3], [4, 5, 6]]
p nums.transpose
p nums.transpose.map(&:sort)
# >> [[1, 4], [12, 5], [3, 6]]
# >> [[1, 4], [5, 12], [3, 6]]

# In general, the top-down approach (memoization) is preferred when the problem involves overlapping subproblems and the recursion stack depth is not a concern. The bottom-up approach (tabulation) is preferred when the problem can be solved by iteratively building the solution from the base cases, without the need for recursion.



# Common issue encountered when initializing a two-dimensional array in Ruby using Array.new with default values. Specifically, the problem arises because the inner Array.new(m+1, 0) creates a single array object that each outer array element points to. 
n = 3  # => 3
m = 3  # => 3
# puts gridTraveller_memo(n,m)


arr = Array.new(n+1, Array.new(m+1, 0))  # => [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
arr[1][1] = 2                            # => 2
p arr                                    # => [[0, 2, 0, 0], [0, 2, 0, 0], [0, 2, 0, 0], [0, 2, 0, 0]]

# Correct way to initialise
arr_2 = Array.new(n+1) { Array.new(m+1, 0) }  # => [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
arr_2[1][1] = 2                               # => 2
p arr_2                                       # => [[0, 0, 0, 0], [0, 2, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]

# >> [[0, 2, 0, 0], [0, 2, 0, 0], [0, 2, 0, 0], [0, 2, 0, 0]]
# >> [[0, 0, 0, 0], [0, 2, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]