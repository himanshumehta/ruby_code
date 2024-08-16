set = [3, 27, 34, 4, 12, 5, 2]
sum = 30
n = 6

t = [[None for i in range(sum+1)] for j in range(n +1)]
for i in range(n+1):
    for j in range(sum+1):
        if j == 0:
            t[i][j] = True
        if (i == 0) and (j != 0):
            t[i][j] = False

for i in range(1, n + 1):
    for j in range(1, sum+1):
        if set[i-1] <= j:
            t[i][j] = t[i-1][j - set[i-1]] or t[i-1][j]
        else:
            t[i][j] = t[i-1][j]

print(t[n][sum])
