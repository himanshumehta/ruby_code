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
