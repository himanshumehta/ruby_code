```ruby
# Array with fixed size
p Array.new(2)

# >> [nil, nil]


# for-loop method
for n in 0..1
  puts n
end

0
1
=> 0..1

(10).downto(0) do |i|
  puts i
end

# times method
2.times do |n|
  puts n
end

0
1
=> 2

# range method
(0..1).each do |n|
  puts n
end

0
1
=> 0..1

# upto method
0.upto(1) do |n|
  puts n
end

0
1
=> 0

0.upto(3) do |i|
  p i
end

4.times do |i|
  p i
end

# >> 0
# >> 1
# >> 2
# >> 3
# >> 0
# >> 1
# >> 2
# >> 3

# Loop over Matrix 
  rows = n + 1
  cols = w + 1
  t = Array.new(rows, -1) { Array.new(cols, -1) }

  (n + 1).times do |i|
    (w + 1).times do |j|
      t[i][j] = 0 if j.zero? # Fill zero in 1st columns
      t[i][j] = Float::INFINITY - 1 if i.zero? # Fill infinity in 1st row
      if i == 1 && t[i][j] == -1 # Fill second row
        t[i][j] = if (j % weights[0]).zero?
                    j / weights[0]
                  else
                    Float::INFINITY - 1
                  end
      end
    end
  end
  
# Recursion
# 2 things
# Base condition
# Choice diagram
# For base condition - Think of smallest valid input
# Nested array with default - initialization and iterate

data = 2.times.collect { [0] * 10 }

data.each_with_index do |row, row_idx|
  row.each_with_index do |col, col_idx|
    print [row, row_idx, col, col_idx]
  end
end

# ---> Rows
# |
# |
# Columns

# Take one element at a time from string
x = xstr[0..0]
xs = xstr[1..-1]
y = ystr[0..0]
ys = ystr[1..-1]

# Edge boundary items in grid
# Edge boundary items in grid
n = 3
m = 4

n.times do |i|
  m.times do |j|
    if (i * j == 0 || i == n - 1 || j == m - 1)
      p [i, j]
    end
  end
end

# Knapsack core logic
return 0 if n.zero? || w.zero?

if wt[n - 1] <= w
  [(val[n - 1] + knapsack(wt, val, w - wt[n - 1], n - 1)), knapsack(wt, val, w, n - 1)].max
else
  knapsack(wt, val, w, n - 1)
end

# Knapsack memoized
t = array = (w + 1).times.collect { [-1] * (n + 1) }
# Store result in t[n][w] and read back if exists

# Knapsack top-down
# ---> w
# |
# |
# n

# In ruby set you can add value only once, if you try to add duplicate, it will return nil
require "set"
s1 = Set[]
s2 = Set[]

if s1.add?(5) && s1.add?(3)
  p "11"
end

if s2.add?(5) && s2.add?(5)
  p "22"
end

# >> "11"

names = %w{fred jess john}
ages = [38,76,91]

p names.zip(ages)

p Hash[names.zip(ages)]

# >> [["fred", 38], ["jess", 76], ["john", 91]]
# >> {"fred"=>38, "jess"=>76, "john"=>91}

false || true || false || true || false    # => true
false || false || false || false || false  # => false
false && true && false && true && false    # => false
true && true                               # => true

x = [1, 1, 2, 4]
y = [1, 2, 2, 2]

# intersection
x & y # => [1, 2]

# union
x | y # => [1, 2, 4]

# difference
x - y            # => [4]


nums = [[1, 2, 3], [4, 5, 6]]
p nums.transpose
p nums.transpose.map(&:sort)

# >> [[1, 4], [2, 5], [3, 6]]
# >> [5, 7, 9]

require 'logger'
logger       = Logger.new(STDOUT)
logger.error("Took longer than #{timeout} to #{message.inspect}")
```
```ruby
def to_int_or_nil(string)
  Integer(string || '')
rescue ArgumentError
  nil
end

def str_to_int(num_in_str)
  num_in_int = to_int_or_nil(num_in_str)
  exit_execution unless num_in_int
  num_in_int
end

p str_to_int(2)

# >> 2
```

Restore IP addresses
```ruby
def valid?(s)
  num = s.to_i
  num.to_s == s && num >= 0 && num < 256
end

def dfs(s, parts)
  if parts.size == 3
    @candidates << [parts + [s]].join(".") if valid?(s)
    return
  end

  (0..[2, s.size - 1].min).each { |i|
    word = s[0..i]
    dfs(s[i + 1..-1], parts + [word]) if valid?(word)
  }
end

def restore_ip_addresses(s)
  @candidates = []
  dfs(s, [])
  @candidates
end

s = "02000"
p restore_ip_addresses(s)

# >> ["0.20.0.0"]
```
