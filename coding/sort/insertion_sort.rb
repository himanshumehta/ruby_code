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
