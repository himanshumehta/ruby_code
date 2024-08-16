def flip_coin
  # This is the only place where we use randomness.
  # We are not supposed to use it to directly generate random numbers,
  # since we only have a coin we can flip.
  rand(2) # => 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, ...
end

def get_random_value_by_flipping_coins(max_val = 20)
  nb_coin_flips = 0 # => 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, ...
  nb_coin_flips += 1 while max_val > (2**nb_coin_flips) - 1 # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil...

  big_random_value = 0                                   # => 0, 0, 0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, 0,  0,  0, 0, 0, 0,  0,  0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, 0, 0,  0, 0, 0, 0,  0,  0, 0, 0, ...
  nb_coin_flips.times do                                 # => 5, 5, 5, 5,  5,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  5, 5, 5, 5,  5,  5, 5, 5, 5, 5,  5, 5, 5, 5, 5,  5, 5, 5, 5, 5, 5, 5, 5, 5, 5,  5, 5, 5, 5,  5,  5, 5, 5, 5, 5,  5, 5, 5, 5, 5, 5, 5, 5, 5,  5,  5, 5, 5, 5, 5,  5, 5, 5, 5,  5,  5, 5, 5, 5,  5,  5, 5, 5, 5,  5,  5, 5, 5, 5,  5,  5, 5, 5, 5, 5,  5, 5, 5, 5,  5,  5, 5, 5, 5, 5,  7, 7, 7, 7,  7,  7, 7, 7, 7,  7,  7, 7, 7, 7, 7,  7, 7, 7, 7,  7,  7, 7, 7, 7, 7,  7, 7, 7, 7,  7,  7, 7, 7, ...
    big_random_value = (big_random_value * 2) + flip_coin # => 1, 3, 6, 12, 25, 0, 1, 2, 4, 9, 1, 2, 4, 9, 19, 1, 2, 5, 10, 20, 0, 1, 3, 6, 13, 0, 1, 2, 5, 10, 0, 0, 1, 2, 5, 1, 2, 4, 8, 17, 1, 2, 5, 11, 23, 1, 2, 4, 8, 16, 0, 0, 0, 1, 3, 1, 2, 5, 10, 20, 0, 1, 3, 6, 13, 1, 3, 6, 12, 24, 1, 3, 6, 12, 24, 1, 3, 7, 14, 28, 1, 3, 6, 12, 24, 0, 1, 3, 6, 12, 1, 3, 6, 12, 25, 0, 1, 3, 6, 13, 1, 3, 6, 13, 26, 1, 2, 5, 11, 23, 0, 1, 3, 6, 12, 1, 3, 6, 13, 26, 0, 1, 2, 5, 10, 1, 2, 5, 10, 21, 1, 2, 4, ...
  end

  (big_random_value * max_val / ((2**nb_coin_flips) - 1)).to_i # => 16, 5, 12, 12, 8, 6, 3, 10, 14, 10, 1, 12, 8, 15, 15, 18, 15, 7, 16, 8, 16, 14, 7, 16, 6, 13, 12, 6, 5, 19, 12, 4, 10, 13, 17, 14, 0, 11, 16, 10, 13, 2, 0, 12, 18, 4, 16, 14, 18, 7, 11, 3, 2, 17, 18, 1, 10, 13, 6, 2, 10, 4, 19, 18, 5, 5, 7, 12, 19, 10, 11, 11, 14, 3, 10, 10, 9, 3, 4, 2, 17, 1, 1, 2, 1, 7, 10, 12, 2, 7, 6, 17, 6, 13, 10, 14, 19, 1, 16, 9, 29, 24, 88, 40, 10, 53, 56, 57, 88, 39, 87, 16, 30, 85, 41, 45, 87, 52, 3...
end

# Test cases
def test_get_random_value_by_flipping_coins
  max_val = 20 # => 20
  values = # => [16, 5, 12, 12, 8, 6, 3, 10, 14, 10, 1, 12, 8, 15, 15, 18, 15, 7, 16, 8, 16, 14, 7, 16, 6, 13, 12, 6, 5, 19, 12, 4, 10, 13, 17, 14, 0, 11, 16, 10, 13, 2, 0, 12, 18, 4, 16, 14, 18, 7, 11, 3, 2, 17, 18, 1, 10, 13, 6, 2, 10, 4, 19, 18, 5, 5, 7, 12, 19, 10, 11, 11, 14, 3, 10, 10, 9, 3, 4, 2, 17, 1, 1, 2, 1, 7, 10, 12, 2, 7, 6, 17, 6, 13, 10, 14, 19, 1, 16, 9]
    Array.new(100) do
      get_random_value_by_flipping_coins(max_val)
    end
  puts "Generated values: #{values}"   # => nil
  puts "Minimum value: #{values.min}"  # => nil
  puts "Maximum value: #{values.max}"  # => nil

  raise "Generated value exceeds maximum" if values.max > max_val # => nil
  raise "Generated value is negative" if values.min.negative? # => nil
end

def test_get_random_value_by_flipping_coins_bonus1
  max_val = 100 # => 100
  values = # => [29, 24, 88, 40, 10, 53, 56, 57, 88, 39, 87, 16, 30, 85, 41, 45, 87, 52, 34, 89, 65, 0, 77, 3, 33, 71, 72, 2, 50, 70, 72, 20, 85, 55, 26, 79, 7, 20, 49, 1, 48, 45, 36, 25, 94, 22, 3, 11, 2, 16, 66, 86, 54, 6, 56, 35, 20, 79, 40, 31, 53, 48, 65, 68, 11, 32, 18, 77, 0, 70, 6, 18, 15, 77, 6, 55, 98, 85, 71, 68, 38, 6, 82, 89, 23, 72, 22, 4, 29, 71, 5, 45, 32, 85, 97, 88, 96, 41, 0, 51]
    Array.new(100) do
      get_random_value_by_flipping_coins(max_val)
    end
  puts "Generated values (Bonus 1): #{values}"   # => nil
  puts "Minimum value (Bonus 1): #{values.min}"  # => nil
  puts "Maximum value (Bonus 1): #{values.max}"  # => nil

  raise "Generated value exceeds maximum (Bonus 1)" if values.max > max_val # => nil
  raise "Generated value is negative (Bonus 1)" if values.min.negative? # => nil
end

def test_get_random_value_by_flipping_coins_bonus2
  precision = 3 # => 3
  multiplier = 10**precision # => 1000
  values = # => [0.086, 0.839, 0.478, 0.665, 0.078, 0.293, 0.057, 0.63, 0.893, 0.873, 0.928, 0.572, 0.707, 0.618, 0.338, 0.938, 0.016, 0.535, 0.653, 0.519, 0.606, 0.379, 0.668, 0.306, 0.141, 0.853, 0.558, 0.841, 0.219, 0.576, 0.79, 0.384, 0.926, 0.692, 0.142, 0.571, 0.574, 0.135, 0.114, 0.919, 0.655, 0.499, 0.228, 0.344, 0.922, 0.33, 0.152, 0.359, 0.17, 0.349, 0.853, 0.872, 0.756, 0.249, 0.725, 0.243, 0.604, ...
    Array.new(100) do
      get_random_value_by_flipping_coins(multiplier).to_f / multiplier
    end
  puts "Generated values (Bonus 2): #{values}"   # => nil
  puts "Minimum value (Bonus 2): #{values.min}"  # => nil
  puts "Maximum value (Bonus 2): #{values.max}"  # => nil

  raise "Generated value exceeds 1 (Bonus 2)" if values.max > 1 # => nil
  raise "Generated value is negative (Bonus 2)" if values.min.negative? # => nil
end

test_get_random_value_by_flipping_coins         # => nil
test_get_random_value_by_flipping_coins_bonus1  # => nil
test_get_random_value_by_flipping_coins_bonus2  # => nil

# >> Generated values: [16, 5, 12, 12, 8, 6, 3, 10, 14, 10, 1, 12, 8, 15, 15, 18, 15, 7, 16, 8, 16, 14, 7, 16, 6, 13, 12, 6, 5, 19, 12, 4, 10, 13, 17, 14, 0, 11, 16, 10, 13, 2, 0, 12, 18, 4, 16, 14, 18, 7, 11, 3, 2, 17, 18, 1, 10, 13, 6, 2, 10, 4, 19, 18, 5, 5, 7, 12, 19, 10, 11, 11, 14, 3, 10, 10, 9, 3, 4, 2, 17, 1, 1, 2, 1, 7, 10, 12, 2, 7, 6, 17, 6, 13, 10, 14, 19, 1, 16, 9]
# >> Minimum value: 0
# >> Maximum value: 19
# >> Generated values (Bonus 1): [29, 24, 88, 40, 10, 53, 56, 57, 88, 39, 87, 16, 30, 85, 41, 45, 87, 52, 34, 89, 65, 0, 77, 3, 33, 71, 72, 2, 50, 70, 72, 20, 85, 55, 26, 79, 7, 20, 49, 1, 48, 45, 36, 25, 94, 22, 3, 11, 2, 16, 66, 86, 54, 6, 56, 35, 20, 79, 40, 31, 53, 48, 65, 68, 11, 32, 18, 77, 0, 70, 6, 18, 15, 77, 6, 55, 98, 85, 71, 68, 38, 6, 82, 89, 23, 72, 22, 4, 29, 71, 5, 45, 32, 85, 97, 88, 96, 41, 0, 51]
# >> Minimum value (Bonus 1): 0
# >> Maximum value (Bonus 1): 98
# >> Generated values (Bonus 2): [0.086, 0.839, 0.478, 0.665, 0.078, 0.293, 0.057, 0.63, 0.893, 0.873, 0.928, 0.572, 0.707, 0.618, 0.338, 0.938, 0.016, 0.535, 0.653, 0.519, 0.606, 0.379, 0.668, 0.306, 0.141, 0.853, 0.558, 0.841, 0.219, 0.576, 0.79, 0.384, 0.926, 0.692, 0.142, 0.571, 0.574, 0.135, 0.114, 0.919, 0.655, 0.499, 0.228, 0.344, 0.922, 0.33, 0.152, 0.359, 0.17, 0.349, 0.853, 0.872, 0.756, 0.249, 0.725, 0.243, 0.604, 0.306, 0.011, 0.591, 0.528, 0.878, 0.568, 0.78, 0.771, 0.004, 0.531,...
# >> Minimum value (Bonus 2): 0.004
# >> Maximum value (Bonus 2): 0.988
