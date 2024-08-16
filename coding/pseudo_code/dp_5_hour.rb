# Key points
# Space complexity of tree problem statement is equal to height of the tree
# Brute force time complexity - 0(Branching factor ^ Height of tree * Any other operation) 
# We have O(n^m) brute force time complexity, which also means no of leaf are O(n^m)

#########################################
# What is fib 0 to 10?
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
# See fib.rb
def poor_fib(n); end
# Time complexity - O(n) = O(2^n)
# Space complexity - O(n) = O(n)
#########################################
# Add memoization to improve time complexity
def fib_memo(n, memo = {}); end
# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
# Bottom up approach
def fib_bottom_up(n)
  return 1 if n <= 2
  fibs = [0, 1, 1]
  (3..n).each do |i|
    fibs[i] = fibs[i-1] + fibs[i-2]
  end
  fibs[n]
end
# Time complexity - O(n) = O(n)
# Space complexity - O(n) = O(n)
#########################################
# See grid_traveller.rb for details
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
# canSum - Brute force

def canSum(num, numbers)
  return true if num == 0
  return false if num < 0

  for number in numbers
    if canSum(num - number, numbers) == true
      return true
    end
  end

  return false
end

# Time complexity - O(n) = O(num power length of numbers)
# Space complexity - O(n) = O(num)

# canSum - Memo
def canSum(num, numbers, memo = {})
  return true if num == 0
  return false if num < 0
  return memo[num] if memo.has_key?(num)

  for number in numbers # Adding Time complexity equal to O(length of numbers)
    if canSum(num - number, numbers, memo) == true # Adding Time complexity equal to O(num)
      memo[num] = true
      return true
    end
  end

  memo[num] = false
  return false
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5]]]

for input in inputs
  result = canSum(input[0], input[1])
  puts result
end

# Time complexity - O(length of numbers*num) 
# Space complexity - O(n) = O(num)

#########################################

# howSum - Brute force

def howSum(num, numbers)
  return [] if num == 0
  return nil if num < 0

  numbers.each do |number|
    result = howSum(num - number, numbers)
    if result != nil
      return result + [number]
    end
  end

  return nil
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5]]]

for input in inputs
  result = howSum(input[0], input[1])
  p result
end

# Time complexity - O(n) = O(num power length of numbers)
# Space complexity - O(n) = O(num)

# howSum - Memo

def howSum(num, numbers, memo = {})
  return memo[num] if memo.has_key?(num)
  return [] if num == 0
  return nil if num < 0

  numbers.each do |number|
    remainder = num - number
    result = howSum(remainder, numbers, memo)
    if result != nil
      memo[num] = result + [number]
      return memo[num]
    end
  end

  memo[num] = nil
  return nil
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [300, [2, 3, 5]]]

for input in inputs
  result = howSum(input[0], input[1])
  p result
end
# Time complexity - O(length of numbers*num) 
# Space complexity - O(n) = O(num^2) - Due to memo object, num of keys in memo is num and each value can be at max of length num so num * num

#########################################
# howSum - Tabulation
def howSum(num, numbers)
  table = Array.new(numbers.length + 1, nil)
  table[0] = []

  (0..num).each do |i|
    if table[i]
      numbers.each do |number|
        table[i+number] = table[i] + [number]
      end
    end
  end

  return table[num]
end

# Time complexity - O(n*m)
# Space complexity - O(m*m)

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5]]]

for input in inputs
  result = howSum(input[0], input[1])
  p result
end
#########################################
# Brute force
def bestSum(num, numbers)
  return [] if num == 0
  return nil if num < 0

  shortestCombination = nil

  numbers.each do |number|
    remainder = num - number
    combination = bestSum(remainder, numbers)
    if combination != nil
      currentCombination = combination + [number]
      if shortestCombination.nil? || currentCombination.length < shortestCombination.length
        shortestCombination = currentCombination
      end
    end
  end

  return shortestCombination
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5, 8]]]

for input in inputs
  result = bestSum(input[0], input[1])
  p result
end

# m = target sum
# n = length of array
# Time complexity - O(n^m)
# Space complexity - O(n^2) but why not clear at 02:06:51

def bestSum(num, numbers, memo = {})
  return [] if num == 0
  return nil if num < 0
  return memo[num] if memo.has_key? num

  shortest_combination = nil

  numbers.each do |number|
    remainder = num - number
    combination = bestSum(remainder, numbers)
    if combination != nil && (shortest_combination.nil? || combination.length < shortest_combination.length)
      shortest_combination = combination
    end
  end

  if shortest_combination != nil
    memo[num] = shortest_combination + [num]
    return memo[num]
  end

  return nil
end

inputs = [[5, [2, 3]], [7, [5, 3, 4, 7]], [7, [2, 4]], [8, [2, 3, 5, 8]]]

for input in inputs
  result = bestSum(input[0], input[1])
  p result
end

# m = target sum
# n = length of array
# Time complexity - O(n * m) - Why? Height of tree m, child at each level * m so O(n * m) 
# Space complexity - O(m^2) 

#########################################
# bestSum tabulation
def bestSum(num, numbers)
  table = Array.new(numbers.length + 1, nil)
  table[0] = []

  (0..num).each do |i|
    if table[i]
      numbers.each do |number|
        current_value = table[i + number]
        new_value = [*table[i], number]
        if current_value.nil? || new_value.length < current_value.length
          current_value = new_value
          table[i+number] = new_value
        end
      end
    end
  end

  return table[num]
end

# m = target sum
# n = numbers.length
# Time complexity: O(m * n)
# Space complexity: O(m^2)

inputs = [[5, [2, 3, 1, 5]], [7, [5, 3, 4, 1]], [7, [2, 4]], [8, [2, 3, 5, 8]]]

for input in inputs
  result = bestSum(input[0], input[1])
  p result
end
#########################################
# Brute force
def canConstruct(target_word, words)
  return true if target_word.length == 0

  for word in words
    if target_word.start_with?(word)
      remainder = target_word.slice(word.length..-1)
      return true if canConstruct(remainder, words)
    end
  end

  return false
end

# m = Target word length
# n = Word bank length
# Time complexity - O(n ^ m * m) - Why? Multiply m, for prefix match operation
# Space complexity - O(m^2) - Why? One m for tree height and one for remainder variable we have per stack in height

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  # ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = canConstruct(input[0], input[1])
  p result
end

#########################################
# Memo 
def canConstruct(target_word, words, memo = {})
  return true if target_word.length == 0
  return false if words.empty?
  return memo[target_word] if memo.has_key? target_word

  for word in words
    if target_word.start_with?(word)
      remainder = target_word[word.length..-1]
      memo[target_word] = canConstruct(remainder, words, memo)
      return true if memo[target_word]
    end
  end

  memo[target_word] = false
  # false.tap { |result| memo[target_word] = result }
  return false
end

# m = Target word length
# n = Word bank length
# Time complexity - O(n * m) - Why? depth of the recursion is limited to the length of the target_word, the total number of recursive calls made is bounded by m.
# Space complexity - O(m^2) - Why? One m for tree height and one for remainder variable we have per stack in height

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = canConstruct(input[0], input[1])
  p result
end

#########################################
# canConstruct tabulation
def canConstruct(target_word, words)
  target_length = target_word.length
  table = [true] + Array.new(target_length, false)

  (0..target_length).each do |i|
    next unless table[i]

    words.each do |word|
      if target_word[i..-1].start_with?(word)
        table[i + word.length] = true
      end
    end
  end

  table[target_length]
end

# m = Target word length
# n = Word bank length
# Time complexity - O(n * m ) - Why? Multiply m, for prefix match operation
# Space complexity - O(m^2) - Why? One m for tree height and one for remainder variable we have per stack in height

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = canConstruct(input[0], input[1])
  p result
end
#########################################
# Brute force - Skipped
# Memo
def countConstruct(target_word, words, memo = nil)
  memo ||= {}
  return memo[target_word] if memo[target_word]
  return 1 if target_word == "" # I made this mistake
  return 0 if words.empty?

  count = 0

  words.each do |word|
    if target_word.start_with?(word)
      remainder = target_word[word.length..-1]
      count += countConstruct(remainder, words, memo)
    end
  end

  memo[target_word] = count
  count
end

# m = Target word length
# n = Word bank length

# Brute force
# Time complexity - O(n ^ m ^ 2)
# Space complexity - O(m ^ 2)

# Memoized
# Time complexity - O(n * m ^ 2)
# Space complexity - O(m ^ 2)

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd", "ef"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = countConstruct(input[0], input[1])
  p result
end

# Tabulation
def countConstruct(target_word, words, table = nil)
  target_length ||= target_word.length
  table ||= Array.new(target_length + 1, 0)
  table[0] = 1


  (0..target_length).each do |i|
    next if table[i].zero?

    words.each do |word|
      if target_word[i..-1].start_with?(word)
        table[i + word.length] += table[i]
      end
    end
  end

  table[target_length]
end

# m = Target word length
# n = Word bank length
# Time complexity - O(m * n)
# Space complexity - O(m)

inputs = [
  # ["abcdef", ["ab", "abc", "cde", "de","f", "def"]],
  ["abcdef", ["ab", "abc", "cd", "def", "abcd", "ef"]],                 # true
  # ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  # ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = countConstruct(input[0], input[1])
  p result
end

# >> 3
#########################################
# Core Logic for next problem allConstruct
# word = "word"
# a = [[]]
# b = []
# aa = a.map do |item|; [word] + item; end
# bb = b.map do |item|; [word] + item; end

# pp word
# p aa
# p bb

# >> "word"
# >> [["word"]]
# >> []

def allConstruct(target_word, words)
  return [[]] if target_word == ""

  result = []

  words.each do |word|
    if target_word.start_with?(word)
      suffix = target_word[word.length..-1]
      suffixWays = allConstruct(suffix, words)
      suffixWays.map! do |way|
        [word] + way
      end
      result.push(*suffixWays)
    end
  end

  result
end

# m = Target word length
# n = Word bank length

# Brute force
# Time complexity - O(n ^ m)
# Space complexity - O(m)

# Memoized - IN THIS CASE IT IS SAME AS BRUTE FORCE
# Time complexity - O(n * m)
# Space complexity - O(m)

inputs = [
  ["abcdef", ["ab", "abc", "cd", "def", "abcd", "ef"]],                 # true
  ["purple", ["purp", "p", "ur", "le", "purpl"]],
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  # ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = allConstruct(input[0], input[1])
  p result
end

# Tabulation
def allConstruct(target_word, words, table = nil)
  target_length ||= target_word.length
  table ||= Array.new(target_length + 1, nil)
  table[0] = [[]]
  # result = []

  (0..target_length).each do |i|
    next unless table[i]

    words.each_with_index do |word, index|
      next unless target_word[i..-1].start_with?(word)

      new_ways = table[i].map { |way| [word] + way }
      table[i + word.length] ||= []
      table[i + word.length].concat(new_ways)
    end
  end

  table[target_length]
end

# m = Target word length
# n = Word bank length
# Time complexity - O(m * n)
# Space complexity - O(m * m)

inputs = [
  ["abcdef", ["ab", "abc", "cde", "de","f", "def"]],
  ["abcdef", ["ab", "abc", "cd", "def", "abcd"]],                 # true
  ["skateboard", ["bo", "rd", "ate", "t", "ska", "sk", "boar"]],   # false
  ["enterapotentpot", ["a", "p", "ent", "enter", "ot", "o", "t"]], # true
  # ["eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ["e", "ee", "eee", "eeee", "eeeee"]], # false
]

for input in inputs
  result = allConstruct(input[0], input[1])
  p result
end






