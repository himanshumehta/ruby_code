# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  h = {}
  nums.each_with_index do |a, i|
    n = target - a
    return [h[n], i] if h[n]
    h[a] = i
  end
end
