def dictionary(s,dictionary):
    if  len(s) == 0:
        return False
    return util(s, dictionary)

def util(s, dictionary):
    if not s:
        return True
    for x in dictionary:
        prefix = s[0:len(x)]
        result = False
        if prefix == x:
            result = util(s[len(x):], dictionary)
        if result:
            return True

    return False

dictionaryy = ['as', 'bew']
s = 'asbe'
print(dictionary(s,dictionaryy))



******************** CODEE GOLF
def dictionary(s,dictionary):
    if  len(s) == 0:
        return False
    return util(s, dictionary)

def util(s, dictionary):
    if not s:
        return True
    for x in dictionary:
        if s[0:len(x)] == x and util(s[len(x):], dictionary):
            return True
    return False

dictionaryy = ['as', 'be']
s = 'asbe'
print(dictionary(s,dictionaryy))
