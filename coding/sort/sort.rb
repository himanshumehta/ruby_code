def bubble_sort(arr)
  return arr if arr.size < 2
  swap = true
  while swap
    swap = false
    (arr.length - 1).times do |x|
      if arr[x] > arr[x + 1]
        arr[x], arr[x + 1] = arr[x + 1], arr[x]
        swap = true
      end
    end
  end
  arr
end

bubble_sort([3, 2, 4])

def insertion_sort(array)
  (array.length).times do |j|
    while j > 0
      if array[j - 1] > array[j]
        array[j - 1], array[j] = array[j], array[j - 1]
      else
        break
      end
      pp array
      j -= 1
    end
  end
  array
end

array = [5, 4, 3, 4, 3, 0]
p insertion_sort(array)

# >> [4, 5, 3, 4, 3, 0]
# >> [4, 3, 5, 4, 3, 0]
# >> [3, 4, 5, 4, 3, 0]
# >> [3, 4, 4, 5, 3, 0]
# >> [3, 4, 4, 3, 5, 0]
# >> [3, 4, 3, 4, 5, 0]
# >> [3, 3, 4, 4, 5, 0]
# >> [3, 3, 4, 4, 0, 5]
# >> [3, 3, 4, 0, 4, 5]
# >> [3, 3, 0, 4, 4, 5]
# >> [3, 0, 3, 4, 4, 5]
# >> [0, 3, 3, 4, 4, 5]
# >> [0, 3, 3, 4, 4, 5]

def quick_sort(array, first, last)
  if first < last
    j = partition(array, first, last)
    quick_sort(array, first, j - 1)
    quick_sort(array, j + 1, last)
  end
  return array
end

def partition(array, first, last)
  pivot = array[last]
  pIndex = first
  i = first
  while i < last
    if array[i].to_i <= pivot.to_i
      array[i], array[pIndex] = array[pIndex], array[i]
      pIndex += 1
    end
    i += 1
  end
  array[pIndex], array[last] = array[last], array[pIndex]
  return pIndex
end
