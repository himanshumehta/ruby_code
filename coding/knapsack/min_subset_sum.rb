 def min_subset_sum(numbers)
  total = numbers.sum
  t = subset_sum(numbers, total, numbers.length)
  vector = []
  (t[-1].length / 2).times do |i|
    vector << i if t[-1][i]
  end
  mn = Float::INFINITY
  vector.each do |ele|
    mn = [mn, total - 2 * ele].min
  end
  mn
end

def subset_sum(numbers, total, n)
  t = Array.new(n + 1) { Array.new(total + 1) }
  (n + 1).times do |i|
    (total + 1).times do |j|
      if i.zero?
        t[i][j] = false
      elsif j.zero?
        t[i][j] = true
      elsif numbers[i - 1] <= j
        t[i][j] = t[i - 1][j - numbers[i - 1]] || t[i - 1][j]
      else
        t[i][j] = t[i - 1][j]
      end
    end
  end
  t
end

numbers = [3, 1, 4, 2, 2, 1]
puts min_subset_sum(numbers)
