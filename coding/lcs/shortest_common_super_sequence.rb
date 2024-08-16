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
  