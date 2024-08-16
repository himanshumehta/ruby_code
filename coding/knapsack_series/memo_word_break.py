def dictionary(s,dictionary):
    if  len(s) == 0:
        return False
    memo = {}
    util(s, dictionary, memo)
    return memo[s]

def util(s, dictionary, memo):
    if len(s) == 0:
        return True
    elif s in memo:
        return memo[s]
    for x in dictionary:
        if s[0:len(x)] == x and util(s[len(x):], dictionary, memo):
            memo[s] = True
            return True
    memo[s] = False
    return False

dictionaryy = ['as', 'be', 'w', 'w']
s = 'asbewaswff'
print(dictionary(s,dictionaryy))
