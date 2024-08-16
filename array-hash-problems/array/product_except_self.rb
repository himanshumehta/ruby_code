# O(n^2) time
def product_except_self(nums)
  n = nums.size
  result = Array.new(n, 1)

  n.times do |i|
    (0...n).each do |j|
      result[j] *= nums[i] unless i == j
    end
  end

  result
end

# O(n) time
def product_except_self(nums)
  n = nums.size
  result = Array.new(n, 1)

  prefix = 1
  n.times do |i|
    result[i] *= prefix
    prefix *= nums[i]
  end

  suffix = 1
  (n - 1).downto(0) do |i|
    result[i] *= suffix
    suffix *= nums[i]
  end

  result
end

nums = [-1, 1, 0, -3, 3]
# [0,0,9,0,0]

p product_except_self(nums)
