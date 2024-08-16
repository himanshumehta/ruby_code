def longest_common_subsequence_1(text1, text2)
  memo = Array.new(text1.length) { Array.new(text2.length) }
  return helper(text1, text2, 0, 0, memo)
end

def helper(text1, text2, p1, p2, memo)
  return 0 if (p1 >= text1.length) || (p2 >= text2.length)

  return memo[p1][p2] if memo[p1][p2]

  if text1[p1] == text2[p2]
    memo[p1][p2] = 1 + helper(text1, text2, p1 + 1, p2 + 1, memo)
  else
    memo[p1][p2] = [helper(text1, text2, p1 + 1, p2, memo), helper(text1, text2, p1, p2 + 1, memo)].max
  end
end

def longest_common_subsequence_2(text1, text2)
  @memo = (text1.length + 1).times.collect { [nil] * (text2.length + 1) }
  @text1 = text1
  @text2 = text2
  return helper(@text1.length, @text2.length)
  @memo[@text1.length][@text2.length]
end

def helper(p1, p2)
  return 0 if (p1.zero?) || (p2.zero?)
  return @memo[p1][p2] if @memo[p1][p2]

  if @text1[p1 - 1] == @text2[p2 - 1]
    @memo[p1][p2] = 1 + helper(p1 - 1, p2 - 1)
  else
    @memo[p1][p2] = [helper(p1 - 1, p2), helper(p1, p2 - 1)].max
  end
end

p longest_common_subsequence("thisisatest", "testing123testing")
