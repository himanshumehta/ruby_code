def dictionary(s,dictionary):
    dp = [False for _ in range(len(s) + 1)]
    dp[0] = True

    for i in range(1, len(s) + 1):
        for j in range(i-1, -1, -1):
            if dp[j] and s[j:i] in dictionaryy:
                dp[i] = True
                break
    return dp[len(s)]

dictionaryy = ['as', 'be', 'w', 'w']
s = 'asbewas'
print(dictionary(s,dictionaryy))
