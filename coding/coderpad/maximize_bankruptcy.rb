def get_biggest_loss(prices)
  # Initial situation. We get the first price as the max and the min.
  # We consider we do a buy+sell with this price. The loss is 0.
  max_price = prices[0] # => 3,     5,     1,     3,     42,    1000,  30,    360206605
  min_price_after = prices[0]                 # => 3,     5,     1,     3,     42,    1000,  30,    360206605
  biggest_loss = min_price_after - max_price  # => 0,     0,     0,     0,     0,     0,     0,     0
  must_update_loss = false                    # => false, false, false, false, false, false, false, false

  prices.each do |price| # => [3, 2, 4, 2, 1, 5], [5, 3, 4, 2, 3, 1], [1, 2, 4, 4, 5], [3, 4, 7, 9, 10], [42, 42, 42, 42, 42], [1000], [30, 20, 100, 70, 150, 140], [360206605, 753529295, 289276846, 389601008, 956209493, 759816072, 21292839, 95253218, 761349009, 529261257, 360206605, 753529295, 289276846, 389601008, 956209493, 759816072, 21292839, 95253218, 761349009, 529261257, 360206605, 753529295, 289276846, 389601008, 956209493, 759816072, 21292839, 95253218, 761349009, 529261257, 36...
    if max_price < price # => false, false, true, false, false, true, false, false, false, false, false, false, false, true, true, false, true, false, true, true, true, true, false, false, false, false, false, false, false, false, true, false, true, false, false, true, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false...
      # We must update max_price.
      max_price = price # => 4, 5, 2, 4, 5, 4, 7, 9, 10, 100, 150, 753529295, 956209493
      # As a consequence, we reset min_price_after to the current price.
      min_price_after = price  # => 4,    5,    2,    4,    5,    4,    7,    9,    10,   100,  150,  753529295, 956209493
      must_update_loss = true  # => true, true, true, true, true, true, true, true, true, true, true, true,      true
    end

    if min_price_after > price # => false, true, false, true, true, false, false, true, false, true, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true, false, true, false, false, true, false, false, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, fal...
      # We must update min_price_after.
      min_price_after = price # => 2,    2,    1,    3,    2,    1,    20,   70,   140,  289276846, 759816072, 21292839
      must_update_loss = true # => true, true, true, true, true, true, true, true, true, true,      true,      true
    end

    # => false, true, true, true, true, true, false, true, false, true, false, true, false, true, true, false, true, false, true, true, true, true, false, false, false, false, false, false, false, true, true, true, true, true, false, true, true, false, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, ...
    next unless must_update_loss

    # Something has changed in our price values.
    # We must recalculate the loss, and replace the previous one
    # if necessary.
    current_loss = min_price_after - max_price # => -1,    0,     -2,    -3,    0,     -2,    -3,    -4,    0,     0,     0,     0,     0,     0,     0,     -10,   0,     -30,   0,     -10,   0,     -464252449, 0,          -196393421, -934916654
    biggest_loss = [current_loss, biggest_loss].min  # => -1,    -1,    -2,    -3,    -3,    -2,    -3,    -4,    0,     0,     0,     0,     0,     0,     0,     -10,   -10,   -30,   -30,   -30,   0,     -464252449, -464252449, -464252449, -934916654
    must_update_loss = false                         # => false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,      false,      false,      false
  end

  biggest_loss # => -3, -4, 0, 0, 0, 0, -30, -934916654
end

# Test cases
puts "Nominal case: #{get_biggest_loss([3, 2, 4, 2, 1, 5]) == -3}"                                                                                                             # => nil
puts "Maximum Loss between the first and last values: #{get_biggest_loss([5, 3, 4, 2, 3, 1]) == -4}"                                                                           # => nil
puts "Profit with a flat part: #{get_biggest_loss([1, 2, 4, 4, 5]).zero?}"                                                                                                      # => nil
puts "Constant Profit: #{get_biggest_loss([3, 4, 7, 9, 10]).zero?}"                                                                                                             # => nil
puts "All flat: #{get_biggest_loss([42, 42, 42, 42, 42]).zero?}"                                                                                                                # => nil
puts "One element: #{get_biggest_loss([1000]).zero?}"                                                                                                                           # => nil
puts "Varied: #{get_biggest_loss([30, 20, 100, 70, 150, 140]) == -30}" # => nil
puts "Large dataset: #{get_biggest_loss([360_206_605, 753_529_295, 289_276_846, 389_601_008, 956_209_493, 759_816_072, 21_292_839, 95_253_218, 761_349_009, 529_261_257] * 10_000) == -934_916_654}" # => nil

# >> Nominal case: true
# >> Maximum Loss between the first and last values: true
# >> Profit with a flat part: true
# >> Constant Profit: true
# >> All flat: true
# >> One element: true
# >> Varied: true
# >> Large dataset: true
