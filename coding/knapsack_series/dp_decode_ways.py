class Solution(object):
    def numDecodings(self, s):
        dp = [0 for i in range(len(s)+1)]
        dp[0] = 1
        if s[0] == '0':
            return 0
        else:
            dp[1] = 1
        for i in range(2, len(s)+1):
            if s[i-1] == '0':
                if (s[i - 2] == '1' or s[i - 2] == '2'):
                    dp[i] = dp[i-2]
                else:
                    return 0
            else:
                if s[i - 2] == '1' or (s[i - 2] == '2' and int(s[i-1]) < 7):
                    dp[i] =  dp[i-1] + dp[i-2]
                else:
                    dp[i] = dp[i-1]
        return dp[len(s)]
