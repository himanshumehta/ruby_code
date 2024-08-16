def find_quadruplet(numbers, target)
  n = numbers.length
  (0...n).each do |a|
    (0...n).each do |b|
      (0...n).each do |c|
        (0...n).each do |d|
          if numbers[a] + numbers[b] + numbers[c] + numbers[d] == target
            return [numbers[a], numbers[b], numbers[c], numbers[d]]
          end
        end
      end
    end
  end
  nil
end

def find_quadruplet(numbers, target)
  n = numbers.length
  numbers_set = numbers.to_set
  (0...n).each do |a|
    (0...n).each do |b|
      (0...n).each do |c|
        d = target - (numbers[a] + numbers[b] + numbers[c])
        return [numbers[a], numbers[b], numbers[c], d] if numbers_set.include?(d)
      end
    end
  end
  nil
end

def find_quadruplet(numbers, target)
  n = numbers.length # => 6
  pair_sums = {} # => {}

  # Precompute pair sums and store them in a hash
  (0...n).each do |a| # => 0...6
    (a...n).each do |b| # => 0...6, 1...6, 2...6, 3...6, 4...6, 5...6
      sum = numbers[a] + numbers[b]               # => 10,       9,        8,        7,        6,        5,        8,                7,                6,                5,                4,        6,                        5,                        4,                3,        4,                        3,                2,        2,                1,        0
      pair_sums[sum] ||= []                       # => [],       [],       [],       [],       [],       [],       [[5, 3]],         [[5, 2]],         [[5, 1]],         [[5, 0]],         [],       [[5, 1], [4, 2]],         [[5, 0], [4, 1]],         [[4, 0]],         [],       [[4, 0], [3, 1]],         [[3, 0]],         [],       [[2, 0]],         [],       []
      pair_sums[sum] << [numbers[a], numbers[b]]  # => [[5, 5]], [[5, 4]], [[5, 3]], [[5, 2]], [[5, 1]], [[5, 0]], [[5, 3], [4, 4]], [[5, 2], [4, 3]], [[5, 1], [4, 2]], [[5, 0], [4, 1]], [[4, 0]], [[5, 1], [4, 2], [3, 3]], [[5, 0], [4, 1], [3, 2]], [[4, 0], [3, 1]], [[3, 0]], [[4, 0], [3, 1], [2, 2]], [[3, 0], [2, 1]], [[2, 0]], [[2, 0], [1, 1]], [[1, 0]], [[0, 0]]
    end
  end

  # Find two pairs whose sums add up to the target
  pair_sums.each do |sum1, pairs1| # => {10=>[[5, 5]], 9=>[[5, 4]], 8=>[[5, 3], [4, 4]], 7=>[[5, 2], [4, 3]], 6=>[[5, 1], [4, 2], [3, 3]], 5=>[[5, 0], [4, 1], [3, 2]], 4=>[[4, 0], [3, 1], [2, 2]], 3=>[[3, 0], [2, 1]], 2=>[[2, 0], [1, 1]], 1=>[[1, 0]], 0=>[[0, 0]]}
    sum2 = target - sum1 # => 1
    next unless pair_sums.key?(sum2) # => true

    pairs1.each do |pair1| # => [[5, 5]]
      pair_sums[sum2].each do |pair2| # => [[1, 0]]
        return pair1 + pair2 if (pair1 & pair2).empty? # => true
      end
    end
  end

  nil
end

numbers = [5, 4, 3, 2, 1, 0]               # => [5, 4, 3, 2, 1, 0]
target = 11                                # => 11
result = find_quadruplet(numbers, target)  # => [5, 5, 1, 0]
puts result.inspect                        # => nil

# >> [5, 5, 1, 0]
