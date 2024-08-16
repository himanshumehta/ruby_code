class Solution(object):
    def numDecodings(self, s):
        memo = [-1 for i in range(len(s))]
        return self.helperr(len(s) - 1, s, memo)

    def helperr(self, curr, code, memo):
        if curr == 0 and code[curr] == '0':
            memo[curr] = 0
        elif curr == 0:
            memo[curr] =  1

        if curr == -1:
            return 1

        if memo[curr] != -1:
            return memo[curr]

        if code[curr] == '0' and (code[curr - 1] == '1' or code[curr - 1] == '2'):
            print("A")
            memo[curr] =  self.helperr(curr - 2, code, memo)
            return memo[curr]
        elif code[curr] == '0' and (code[curr - 1] != '1' or code[curr - 1] != '2'):
            print("B")
            memo[curr] =  0
            return memo[curr]
        if code[curr - 1] == '1' or (code[curr - 1] == '2' and int(code[curr]) < 7):
            print("C")
            memo[curr] =  self.helperr(curr - 1, code, memo) + self.helperr(curr - 2, code, memo)
            return memo[curr]
        else:
            print("D")
            memo[curr] =  self.helperr(curr - 1, code, memo)
            return memo[curr]


print(Solution().numDecodings("10"))
