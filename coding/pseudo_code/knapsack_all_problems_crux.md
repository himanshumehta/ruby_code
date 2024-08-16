### Knapsack notes

3 types
- 0/1 Knapsack - Subset sum, Count number of subset
- Unbounded knapsack - Rod cutting, Coin change, Max ribbon cut
- Fractional knapsack(Greedy approach and not dynamic programming)

#### Knapsack 0-1 recursive
```ruby
def knapsack(wt,val,w,n)
  if n == 0 || w == 0
    return 0
  end

  if wt[n-1] <= w
    return [(val[n-1] + knapsack(wt,val,w-wt[n-1],n-1)),knapsack(wt,val,w,n-1)].max
  else
    return knapsack(wt,val,w,n-1)
  end
end
```

#### Knapsack memoized version 
```python
# |---w+1 == Sum
# |
# n+1 == Size of array

t = [[-1 for i in range(W + 1)] for i in range(n+1)]

def knapsack(wt, val, w, n, t):
    if wt == 0 or n == 0:
        return 0
    if t[n][w] != -1:
        return t[n][w]
    if wt[n-1] <= w:
        t[n][w] = max(val[n-1] + knapsack(wt,val,w-wt[n-1], n-1,t), knapsack(wt,val,w, n-1,t))
    else:
        t[n][w] = knapsack(wt,val,w, n-1,t)
    return t[n][w]
```

#### Knapsack top down
Replace n by i and w by j in knapsack memoized version 
```ruby

rows, cols = n + 1, w + 1  # your values
t = Array.new(rows, -1) { Array.new(cols, -1) }

(n + 1).times do |i|
  (w + 1).times do |j|
    if i == 0 || j == 0
      t[i][j] = 0
    end
  end
end

(1..n).each do |i|
  (1..w).each do |j|
    if weights[i - 1] <= j
      t[i][j] = [(values[i - 1] + t[i - 1][j - weights[i - 1]]), t[i - 1][j]].max
    else
      t[i][j] = t[i - 1][j]
    end
  end
end

t[n][w]
```

#### Subset sum problem
Problem statement - 
arr[] = [2, 3, 7, 8, 10]
sum = 11
Does any subset exist in array whose sum is equal to given sum, in above case 11
```ruby
Initialize with true and false instead of -1

if arr[i - 1] <= j
  t[i][j] = t[i - 1][j - arr[i - 1]]) || t[i - 1][j]]
else
  t[i][j] = t[i - 1][j]
end

return t[n][sum]
```

#### Equal sum partition problem 
Problem statement - 
arr[] = [2, 3, 7, 8, 10]
Does any two subset which are equal
Only possible if total sum is even and now this problem is reduced to subset sum

Subset_sum(arr, tottal_sum/2)

#### Count of subset sum
Same code as subset sum exists?
Diff - Initialize with 0 and 1
Replace or condition with plus in code

#### Minimum subset sum
Problem statement -
arr[] = [2, 3, 7, 8, 10]
Find 2 subset whose difference is minimum

Solution - Find range of subset difference
Total sum - 0 will be range of subset difference
We only need to find one subset as other will be only difference from total sum
So we only need to find one subset - S1 and other will be Range - S1
Solution - Find subset sum true false matrix
Loop on last row of above matrix and find biggest True till half of that row.

#### Count the number of subset with given difference
2 subset should have different equal to given number
Diff = 1
arr[] = [1, 2, 3, 4]

How many subset with different equal to 1?
Solution 
S1 - S2 = Diff
S1 + S2 = Total sum

2S1 = Diff - Total sum
S1 = (Diff - Total sum) / 2

So above problem is now reduced to count the number of subset with sum given above


#### Target sum
arr[] = [1, 1, 2, 3]
sum = 1

Problem statement
Apply +/- sign in front of each element of the array so that the sum is equal to above sum = 1
E.g. = + 1 - 1 + 2 - 3
Sum = 1

Solution 
This is same as S1 - S2 = Diff(Sum)
As nice trick is all elements of the above S2 will have negative sign and S1 will have positive sign

So this problem is now reduced to Count the number of subset with given difference

#### Unbounded Knapsack memoized version 
```ruby
def knapsack(wt,val,w,n)
  if n == 0 || w == 0
    return 0
  end

  if wt[n-1] <= w
    return [(val[n-1] + knapsack(wt,val,w-wt[n-1],n)),knapsack(wt,val,w,n-1)].max
  else
    return knapsack(wt,val,w,n-1)
  end
end
```

Rod cutting algorithm
```ruby
def cut_rod(wt,val,w,n)
    if n == 0 || w == 0
      return 0
    end

    if wt[n-1] <= w
      return [(val[n-1] + cut_rod(wt,val,w-wt[n-1],n)),cut_rod(wt,val,w,n-1)].max
    else
      return cut_rod(wt,val,w,n-1)
    end
end
```

Coin change problem - 2 types
- Maximum ways
- Minimum number of coins

#### Maximum ways
Coins infinity suppy
coins = [1, 2, 3]
amount = 5
Answer  5 ways
<!-- 2, 3 -->
<!-- 1, 2, 2 -->
<!-- 1, 1, 3 -->
<!-- 1, 1, 1, 1, 1 -->
<!-- 1, 1, 1, 2 -->

Solution: Based on subset sum
Initialize
```ruby
# |---w+1 == Sum
# |
# n+1 == Size of array

Initialize x-axis, sum with 0
Initialize y-axis, sum with 1

t[i][j] = if coins[i-1] <= j
  [t[i][j - coins[i-1]] + t[i][j - 1]
else
  t[i][j - 1]
end
```

#### Minimum number of coins
Minimum number of coins we need to have amount
coins = [1, 2], amount = 2, Answer 1
coins = [1, 2], amount = 3, Answer 2(one coin of 1 and one coin of 2)

Solution- 
sum in x-axis - Initialize with Infinite
number of coins in y-axis - Initialize with 0 from index 1 onwards

##### This is unique problem where we also need to initialize row 2 from j = 1 to w+1
where if j % coins[0] (first element in coins array) == 0 then fill with j % coins[0] else fill with Infinite

```ruby
t[i][j] = if coins[i-1] <= j
  {
    1 + t[i][j - coins[i-1]],
    t[i][j - 1]
  }.min
else
  t[i][j - 1]
end
```


