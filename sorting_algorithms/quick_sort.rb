def quick_sort(arr)
  return arr if arr.length <= 1  # => false, false, false, true, true, false, false, false, false, true, true, true, true, true, true

  pivot = arr[arr.length / 2]  # Choose pivot as the middle element
  left = []   # => [], [], [], [], [], [], []
  right = []  # => [], [], [], [], [], [], []
  equal = []  # => [], [], [], [], [], [], []

  arr.each do |x|    # => [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5], [3, 1, 4, 1, 5, 2, 6, 5, 3, 5], [1, 1], [3, 4, 5, 6, 5, 3, 5], [3, 4, 5, 5, 3, 5], [3, 4, 3], [3, 3]
    if x < pivot     # => true, true, true, true, true, false, true, true, true, true, true, false, true, false, true, false, false, false, false, false, false, false, false, true, true, true, false, true, true, true, true, true, false, false, true, false, true, false, true, false, false
      left << x      # => [3], [3, 1], [3, 1, 4], [3, 1, 4, 1], [3, 1, 4, 1, 5], [3, 1, 4, 1, 5, 2], [3, 1, 4, 1, 5, 2, 6], [3, 1, 4, 1, 5, 2, 6, 5], [3, 1, 4, 1, 5, 2, 6, 5, 3], [3, 1, 4, 1, 5, 2, 6, 5, 3, 5], [1], [1, 1], [3], [3, 4], [3, 4, 5], [3, 4, 5, 5], [3, 4, 5, 5, 3], [3, 4, 5, 5, 3, 5], [3], [3, 4], [3, 4, 3], [3], [3, 3]
    elsif x > pivot  # => false, true, true, true, false, true, true, true, true, false, false, false, false, false, false, false, false, false
      right << x     # => [3], [3, 4], [3, 4, 5], [3, 4, 5, 6], [3, 4, 5, 6, 5], [3, 4, 5, 6, 5, 3], [3, 4, 5, 6, 5, 3, 5]
    else
      equal << x     # => [9], [2], [1], [1, 1], [6], [5], [5, 5], [5, 5, 5], [4], [3], [3, 3]
    end              # => [3], [3, 1], [3, 1, 4], [3, 1, 4, 1], [3, 1, 4, 1, 5], [9], [3, 1, 4, 1, 5, 2], [3, 1, 4, 1, 5, 2, 6], [3, 1, 4, 1, 5, 2, 6, 5], [3, 1, 4, 1, 5, 2, 6, 5, 3], [3, 1, 4, 1, 5, 2, 6, 5, 3, 5], [3], [1], [3, 4], [1, 1], [3, 4, 5], [2], [3, 4, 5, 6], [3, 4, 5, 6, 5], [3, 4, 5, 6, 5, 3], [3, 4, 5, 6, 5, 3, 5], [1], [1, 1], [3], [3, 4], [3, 4, 5], [6], [3, 4, 5, 5], [3, 4, 5, 5, 3], [3, 4, 5, 5, 3, 5], [3], [3, 4], [5], [5, 5], [3, 4, 3], [5, 5, 5], [3], [4], [3, 3], [3], [...
  end                # => [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5], [3, 1, 4, 1, 5, 2, 6, 5, 3, 5], [1, 1], [3, 4, 5, 6, 5, 3, 5], [3, 4, 5, 5, 3, 5], [3, 4, 3], [3, 3]

  quick_sort(left) + equal + quick_sort(right)  # => [1, 1], [3, 3], [3, 3, 4], [3, 3, 4, 5, 5, 5], [3, 3, 4, 5, 5, 5, 6], [1, 1, 2, 3, 3, 4, 5, 5, 5, 6], [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
end                                             # => :quick_sort

# Example usage:
arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]  # => [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_arr = quick_sort(arr)             # => [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
puts sorted_arr.inspect                  # => nil

# >> [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
# >> [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]