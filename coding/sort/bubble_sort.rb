def bubble_sort(arr)
  return arr if arr.size < 2
  swap = true
  while swap
    swap = false
    (arr.length - 1).times do |x|
      if arr[x] > arr[x+1]
        arr[x], arr[x+1] = arr[x+1], arr[x]
        swap = true
      end
    end
  end
  arr
end

bubble_sort([3,2,4])
