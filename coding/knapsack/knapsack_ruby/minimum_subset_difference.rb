def minimum_subset_difference_positive_number_only(nums)
  set = nums

  sum = set.inject(0, :+)
  n = set.length

  t = (n + 1).times.collect { [nil] * (sum + 1) }
  rows, columns = n + 1, sum + 1

  rows.times do |row|
    columns.times do |col|
      if col == 0
        t[row][col] = true
      end
      if row == 0 && col != 0
        t[row][col] = false
      end
    end
  end

  (1..n).each do |i|
    (1..sum).each do |j|
      if j < set[i - 1]
        t[i][j] = t[i - 1][j]
      end

      t[i][j] = t[i - 1][j - set[i - 1]] || t[i - 1][j]
    end
  end

  row_length = ((sum + 1) / 2).ceil

  s1 = t[-1][0..row_length].rindex { |item| item == true }
end

set = [1, 2, 5, 11]
p minimum_subset_difference_positive_number_only(set)

# >> 10
# >> 8
