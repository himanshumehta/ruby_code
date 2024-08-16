# Find first or last occurence of element if duplicates are present in an sorted array

def binary_search_occurences(arr, el)
    return -1 if arr.empty?            # => false

    first = find_first_occurences(arr, el)  # => 5
    last = find_last_occurences(arr, el)    # => 8

    return first, last  # => 8
end                     # => :binary_search_occurences

def find_first_occurences(arr, el)
    start_ = 0                      # => 0
    end_ = arr.length - 1           # => 8
    result = -1                     # => -1

    while start_ <= end_                   # => true, true, true, false
        mid_ = start_ + (end_ - start_)/2  # => 4,     6,    5
        if arr[mid_] == el                 # => false, true, true
            result = mid_                  # => 6, 5
            end_ = mid_ - 1                # => 5, 4
        elsif arr[mid_] > el               # => false
            end_ = mid_ - 1
        else 
            start_ = mid_ + 1              # => 5
        end                                # => 5, 5, 4
    end                                    # => nil

    return result  # => 5
end                # => :find_first_occurences

def find_last_occurences(arr, el)
    start_ = 0                     # => 0
    end_ = arr.length - 1          # => 8
    result = -1                    # => -1

    while start_ <= end_                   # => true, true, true, true, false
        mid_ = start_ + (end_ - start_)/2  # => 4,     6,    7,    8
        if arr[mid_] == el                 # => false, true, true, true
            result = mid_                  # => 6, 7, 8
            start_ = mid_ + 1              # => 7, 8, 9
        elsif arr[mid_] > el               # => false
            end_ = mid_ - 1
        else 
            start_ = mid_ + 1              # => 5
        end                                # => 5, 7, 8, 9
    end                                    # => nil

    return result  # => 8
end                # => :find_last_occurences

p binary_search_occurences([76, 88, 93, 94, 97, 100, 100, 100, 100], 100)  # => [5, 8]

# >> [5, 8]


def binary_search_rotated(arr)
    start_ = 0
    end_ = arr.length - 1
    n = arr.length

    while start_ <= end_
        mid_ = start_ + (end_ - start_)/2
        next_ = (mid_ + 1) % n
        prev_ = (mid_ - 1 + n) % n

        if arr[mid_] < arr[prev_] && arr[mid_] < arr[next_]
            return mid_
        end

        if arr[mid_] > arr[end_]
            start_ = mid_ + 1
        else
            end_ = prev_
        end
    end
end

p binary_search_rotated([97, 100, 100, 101, 102, 103, 104, 105, 76, 88, 93, 94])
p binary_search_rotated([97, 100, 100, 101, 65, 68, 76, 88, 93, 94])
p binary_search_rotated([2,1])



def binary_search_ceil(arr, el)
    s = 0                        # => 0
    e = arr.length - 1           # => 5
    result = -1                  # => -1

    while s < e            # => true, true, false
        m = s + (e - s)/2  # => 2,     4
        if arr[m] == el    # => false, false
            return m
        elsif arr[m] > el  # => false, true
            result = m     # => 4
            e = m - 1      # => 3
        else arr[m] > el   # => false
            
            s = m + 1  # => 3
        end
    end                # => nil

    return result  # => 4
end                # => :binary_search_ceil

p binary_search_ceil([76, 88, 93, 94, 97, 100], 95)  # => 4

# >> 4



