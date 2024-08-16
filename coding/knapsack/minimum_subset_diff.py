import sys
def min_subset_sum(t,total,n):
    vector = []
    for i in range(len(t[n-1])//2):
        if t[n-1][i] == True:
            vector.append(i)
    mn = sys.maxsize
    for ele in vector:
        mn = min(mn, total - 2*ele)
    return mn
def subset_sum(numbers, total, n):
    t = [[None for j in range(total + 1)] for i in range(n+1)]
    # Initialize t array fow when either number of elements to pick = 0 or sum = 0
    for i in range(n+1):
        for j in range(total+1):
            if i == 0:  # if number of elements to make the sum is 0:
                t[i][j] = False
            if j == 0: # if total to find is 0 then:
                t[i][j] = True
    for i in range(1, n+1):
        for j in range(1, total+1):
            if numbers[i-1] <= total:
                t[i][j] = t[i-1][j-numbers[i-1]] or t[i-1][j]
            else:
                t[i][j] = t[i-1][j]
    return t


if __name__ == "__main__":
    numbers = [ 3, 1, 4, 2, 2, 1 ] 
    total = sum(numbers) #range
    n = len(numbers)
    t = subset_sum(numbers, total, n)
    print(min_subset_sum(t,total,n))
