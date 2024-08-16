coins = [1, 2, 3]
sum = 5
n = coins.length

def coins_ways(coins, sum, n)
  return 1 if sum == 0
  return 0 if n == 0 && sum != 0

  if coins[n - 1] <= sum
    coins_ways(coins, sum - coins[n - 1], n) + coins_ways(coins, sum, n - 1)
  else
    coins_ways(coins, sum, n - 1)
  end
end

p coins_ways(coins, sum, n)

# >> 5
