# Find an element in rotated sorted array
def binary_search_rotated(arr)
    s = 0
    e = arr.length - 1
    l = arr.length

    while s <= e
        m = s + (e - s)/2
        n = (m + 1) % l
        p = (m - 1 + l) % l
        
        if arr[m] < arr[n] && arr[m] < arr[p]
            return m
        elsif arr[m] > arr[e]
            s = m + 1
        else
            e = m - 1
        end
    end

    return 0
end

def binary_search_reverse_sorted(arr, el)
      s = 0
    e = arr.length - 1

    while s <= e
        m = s + (e - s)/2
        if arr[m] == el
            return m
        elsif arr[m] > el
            s = m + 1
        else
            e = m - 1
        end
    end

    return -1 
end

def binary_Search(arr, el)
    rotated = binary_search_rotated(arr)
   
    if rotated != 0
        first_arr_idx = binary_search_sorted(arr[0..(rotated - 1)], el)
        second_arr_idx = binary_search_sorted(arr[rotated..(arr.length-1)], el)
    else
        binary_search_sorted(arr, el)
    end

    return first_arr_idx if first_arr_idx != -1
    return arr[0..rotated].length + second_arr_idx if second_arr_idx != -1
    return -1
end

def binary_search_sorted(arr, el)
    arr
    s = 0
    e = arr.length - 1

    while s <= e
        m = s + (e - s)/2
        if arr[m] == el
            return m
        elsif arr[m] > el
            e = m - 1
        else
            s = m + 1
        end
    end

    return -1
end


# p binary_search_rotated([97, 100, 100, 101, 102, 105, 76, 88, 93, 94])  # => 6
# p binary_search_rotated([76, 88, 93, 94])                               # => 0
# p binary_search_sorted([76, 88, 93, 94], 94)                            # => 3
# p binary_search_sorted([94], 94)                                        # => 0
# p binary_search_reverse_sorted([94, 84, 74, 64], 94)                    # => 0
p binary_Search([97, 100, 100, 101, 102, 105, 76, 88, 93, 94], 101)

