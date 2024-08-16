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
  