<!-- Recursive base condition is initialization for DP top down -->

LCS - 15 problems on lcs pattern
1. LCS
2. Print LCS
3. Shortest common super sequence
4. Print SCS
5. Min num of insertion or deletion a->b
6. Longest repeating subsequence
7. Length of largest subsequence of a which is a sub string of b
8. Subsequence pattern matching
9. Count how many times a appear as sub string in b
10. Longest palindromic subsequence
11. Longest palindromic sub string 
12. Count of palindromic subsequence
13. Min number of deletion in a string to make it a palindrom
14. Min number of insertion in a string to make it a palindrom

Substring - Continuous string
Subsequence - Can be disconnected

1. LCS(subsequence)
Problem statement
x = [a b c d g h]
y = [a b e d f h a]
common = a b d h
We only need to calculate length of the subsequence

Solution: Recursive
Recursive in general - 3 parts
- Base condition
- Choice diagram
- Input small with each call

```ruby
def lcs(xstr, ystr)
  return "" if xstr.empty? || ystr.empty?

  x = xstr[0..0]
  xs = xstr[1..-1]
  y = ystr[0..0]
  ys = ystr[1..-1]
  if x == y
    x + lcs(xs, ys)
  else
    [lcs(xstr, ys), lcs(xs, ystr)].max_by(&:size)
  end
end

p lcs("thisisatest", "testing123testing")
```

DP solution
```ruby
def longest_common_subsequence(text1, text2)
  dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }

  1.upto(text1.size).each do |i|
    1.upto(text2.size).each do |j|
      dp[i][j] = if text1[i - 1] == text2[j - 1]
          dp[i - 1][j - 1] + 1
        else
          [dp[i - 1][j], dp[i][j - 1]].max
        end
    end
  end

  dp[text1.size][text2.size]
end
```

Print LCS
```ruby
def longest_common_subsequence(text1, text2)
  dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }

  1.upto(text1.size).each do |i|
    1.upto(text2.size).each do |j|
      dp[i][j] = if text1[i - 1] == text2[j - 1]
                   dp[i - 1][j - 1] + 1
                 else
                   [dp[i - 1][j], dp[i][j - 1]].max
                 end
    end
  end

  lcs = ""

  i = text1.size - 1
  j = text2.size - 1
  while i >= 0 && j >= 0
    if text1[i] == text2[j]
      lcs << text1[i]
      i -= 1
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      i -= 1
    elsif dp[i - 1][j] < dp[i][j - 1]
      j -= 1
    else
      i -= 1
      j -= 1
    end
  end

  pp ["lcs", lcs.reverse]
  dp[text1.size][text2.size]
end

p longest_common_subsequence("aebece", "acbcdce")
```

2. LCS (Substring)
```ruby
def lcs(xstr, ystr)
  return "" if xstr.empty? || ystr.empty?

  x = xstr[0..0]
  xs = xstr[1..-1]
  y = ystr[0..0]
  ys = ystr[1..-1]
  if x == y
    x + lcs(xs, ys)
  else
    0
  end
end

p lcs("thisisatest", "testing123testing")
```

DP solution
```ruby
def longest_common_substring(text1, text2)
  dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }

  1.upto(text1.size).each do |i|
    1.upto(text2.size).each do |j|
      dp[i][j] = if text1[i - 1] == text2[j - 1]
                   dp[i - 1][j - 1] + 1
                 else
                   #  [dp[i - 1][j], dp[i][j - 1]].max
                   0
                 end
    end
  end

  lcs = ""

  i = text1.size - 1
  j = text2.size - 1
  while i >= 0 && j >= 0
    if text1[i] == text2[j]
      lcs << text1[i]
      i -= 1
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      i -= 1
    elsif dp[i - 1][j] < dp[i][j - 1]
      j -= 1
    else
      i -= 1
      j -= 1
    end
  end

  pp ["lcs", lcs.reverse]
  lcs.length
end

p longest_common_substring("abathist", "hisathis")

# >> ["lcs", "athis"]
# >> 5
```

#### 3. Shortest common super sequence - Based on LCS 
Problem statement
a = "geek"
b = "eke"

Find such a sequence where both a and b are present and we find to find shortest common subsequence
Examples of super sequences - "geekeve", "geeke"
So for above case "geeke" is the shortest common super subsequence

P.S - Sequence of char should be maintained in super sequence.
Order should be maintained but continuous is not required.

Solution: This question has 2 parts, this one is only about finding length of SCS
Find LCS of both string and also combine both sequences
Sutract lcs from combination of both sequences
"geekeke" - lcs("geek", "eve")
"geekeke" - "ek" ==> "geeke"
Answer Length = 5 

TODO: Write code

#### 4. Print SCS
```ruby
def shortest_common_supersequence(str1, str2)
  dp = Array.new(str1.size + 1) { Array.new(str2.size + 1, 0) }

  # for loop has advantage that it will set variables i and j
  for i in 1..str1.size # rubocop:disable Style/for
    for j in 1..str2.size # rubocop:disable Style/for
      dp[i][j] = if str1[i - 1] == str2[j - 1]
                   dp[i - 1][j - 1] + 1
                 else
                   [dp[i - 1][j], dp[i][j - 1]].max
                 end
    end
  end

  lcs = []
  while i.positive? && j.positive?
    if str1[i - 1] == str2[j - 1]
      lcs << str1[i - 1]
      i -= 1
      j -= 1
    elsif dp[i - 1][j] < dp[i][j - 1]
      lcs << str2[j - 1]
      j -= 1
    elsif dp[i - 1][j] > dp[i][j - 1]
      lcs << str1[i - 1]
      i -= 1
    end
  end

  while i.positive?
    lcs << str1[i - 1]
    i -= 1
  end

  while j.positive?
    lcs << str2[j - 1]
    j -= 1
  end

  pp ["lcs", lcs.reverse.join]
end

p shortest_common_supersequence("abac", "cab")

# >> ["lcs", "cabac"]
# >> ["lcs", "cabac"]
```

#### 5. Min num of insertion or deletion a -> b - Based on lcs
Problem statement
a = "heap"
b = "pea"

Operations allowed +/-

In above case
Deletions - 2 - delete h and p from heap
Insertions - 1 - insert p into heap after h and p are removed from heap

Formula for no of insertion or deletion
Insertions - a.length - lcs
Deletions - b.length - lcs

#### 10. Longest palindromic subsequence - Based on lcs
Problem Statement:
input = agbcba
output = integer value, subsequence which is palindromic subsequence

How to apply lcs
a = input = "agbcba"
b = input.reverse = "abcbga"

Answer Lcs(a, a.reverse)

#### 13. Min number of deletion in a string to make it a palindrom - Based on lcs
Problem Statement:
input = agbcba

No of deletion to make above a palindromic subsequence

Solutions - a.length - lcs(a, a.reverse)

#### 6. Longest repeating subsequence - length only - Based on lcs
Problem Statement:
input = agbcbab
Find a subsequence which is repeating, in same order but can be disconnected
In above example, output = ab

Solution - Only add one condition if i != j
```ruby
def longest_repeating_subsequence(text1, text2)
  dp = Array.new(text1.size + 1) { Array.new(text2.size + 1, 0) }

  1.upto(text1.size).each do |i|
    1.upto(text2.size).each do |j|
      dp[i][j] = if text1[i - 1] == text2[j - 1] && i != j
                   dp[i - 1][j - 1] + 1
                 else
                   [dp[i - 1][j], dp[i][j - 1]].max
                 end
    end
  end
 
  dp[text1.size][text2.size]
end

a = "AABEBCDD"
pp longest_repeating_subsequence(a, a)

# >> 3
```

#### 8. Subsequence pattern matching
Problem Statement:
a = "AXY"
b = "ADXCPY"

We need to find if sequence a is subsequence of sequence b

Solution: Find LCS length and if length of lcs is same as sequence a - output is true as LCS is same as sequence a

#### 14. Min number of insertions in a string to make it a palindrom
Problem Statement:
input = agbcba

Minimum num of insertions to make above a palindromic subsequence

Solutions - a.length - lcs(a, a.reverse)




