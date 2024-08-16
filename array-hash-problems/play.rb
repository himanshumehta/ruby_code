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
  n.downto(0) do |j|
    result[j] *= suffix
    suffix *= nums[j]
  end

  result
end

nums = [-1, 1, 0, -3, 3]
# [0,0,9,0,0]

p product_except_self(nums)
