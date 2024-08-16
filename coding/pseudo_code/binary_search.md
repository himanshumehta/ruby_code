### Binary search - 
1. Binary search
2. Binary search on reverse sorted array
3. Order agnostic search
4. Count number of an element in an sorted array
5. Number of times a sorted array is rotated
6. Find an element in rotated sorted array 
7. Searching in a nearly sorted array
8. Finding floor or ceiling 
9. Find position of an element in infinite sorted array
10. Find index of 1st 1 in infinite binary sorted array
11. Find minimum difference element in sorted array
12. Peak element

#### 1. Binary search
mid = (start_ + end_) / 2

We can rewrite mid as 
**mid = (start_ + end_) / 2 = start_ + (end_ - start_)/2**
**Avoids Integer Overflow: If start and end are both large integers and their sum exceeds the maximum value that can be represented by the data type, overflow occurs. By calculating end - start first, we're dealing with a smaller number, reducing the risk of overflow.**

```ruby
def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0

  while start_ <= end_
    mid = start_ + (end_ - start_)/2
    if arr[mid] == el
      return mid
    elsif arr[mid] > el
      end_ = mid - 1
    else
      start_ = mid + 1
    end
  end

  return -1
end
p binary_search([76, 88, 93, 94, 97, 100], 100)
# >> 5
```

#### 2. Binary search on reverse sorted array
```ruby
def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0

  while start_ <= end_
    mid = start_ + (end_ - start_)/2
    if arr[mid] == el
      return mid
    elsif arr[mid] < el
      end_ = mid - 1
    else
      start_ = mid + 1
    end
  end

  return nil
end
p binary_search([*1..10].reverse, 10)
# >> 0
```

#### 3. Order agnostic search
Check any 2 index and find if it ascending or descending array and apply either one of above

#### 4. Find first or last occurence of element if duplicates are present in an sorted array
```ruby
def binary_search(arr, el, searchFirst)
  end_ = arr.length - 1
  start_ = 0
  result = -1

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
    if arr[mid] == el
      result = mid
      # go on searching towards the left (lower indices)
      if searchFirst
        end_ = mid - 1
      # go on searching towards the right (higher indices)
      else
        start_ = mid + 1
      end
    elsif arr[mid] > el
      end_ = mid - 1
    else
      start_ = mid + 1
    end
  end

  return result
end
p binary_search([76, 88, 93, 94, 97, 100, 100, 100], 100, false)
# >> 7
```

#### 5. Number of times a sorted array is rotated
Hint: Element of minimum number in array is number of times a sorted array is rotated

```ruby
def binary_search(arr)
  n = arr.length
  end_ = n - 1
  start_ = 0
  result = -1

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
    next_ = (mid + 1) % n
    prev_ = (mid - 1 + n) % n
    p ["here", arr[start_], arr[prev_], arr[mid], arr[next_], arr[end_], start_, end_]
    if arr[mid] < arr[prev_] && arr[mid] <= arr[next_]
      return mid
      # We need to check in unsorted array
    elsif arr[start_] > arr[mid] # Means first half is unsorted
      end_ = mid - 1
    elsif arr[end_] < arr[mid] # Means second half is unsorted
      start_ = mid + 1
    end
  end

  return result
end

p binary_search([97, 100, 100, 101, 102, 103, 104, 105, 76, 88, 93, 94])
# >> ["here", 97, 102, 103, 104, 94, 0, 11]
# >> ["here", 104, 105, 76, 88, 94, 6, 11]
# >> 8
```

</br>

**Most importtant piece in above code**
```ruby
n = arr.length
start_ = 0
end_ = n - 1
  
next_ = (mid + 1) % n
prev_ = (mid - 1 + n) % n

arr[start_] > arr[mid] # Means first half is unsorted
arr[end_] < arr[mid] # Means second half is unsorted
```

#### 6. Find an element in rotated sorted array 
Logic: We find minimum element, break array into 2 parts and run normal binary search in both arrays

#### 7. Searching in a nearly sorted array
What is nearly sorted array?
Element which should be present at i'th index, can be present at either i'th - 1,i'th or i'th + 1 index
```ruby
def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
    if arr[mid] == el
      return mid
    elsif arr[mid + 1] != nil && arr[mid + 1] == el
      return mid + 1
    elsif arr[mid - 1] != nil && arr[mid - 1] == el
      return mid - 1
    elsif arr[mid] < el
      start_ = mid + 2
    else
      end_ = mid - 2
    end
  end

  return -1
end

p binary_search([5, 10, 30, 20, 40, 50, 70, 60, 80, 90, 100, 95], 95)

# >> 11
```

Most important point in above solution, checking for out of bound before comparision
```ruby
arr[mid + 1] != nil 
arr[mid - 1] != nil

# Another way to check same thing is by comapring below 2
arr[mid] > arr[start_]
arr[mid] < arr[end_] 
```

#### 8. Finding floor or ceiling 
##### Floor
```ruby
def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0
  result = nil

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
    if arr[mid] == el
      return mid
    elsif arr[mid] < el
      result = mid
      start_ = mid + 1
    else
      end_ = mid - 1
    end
  end

  return result
end

p binary_search([76, 88, 93, 94, 97, 100], 101)

# >> 5
```

#### Ceil
```ruby
def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0
  result = nil

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
    if arr[mid] == el
      return mid
    elsif arr[mid] > el
      result = mid
      end_ = mid - 1
    else
      start_ = mid + 1
    end
  end

  return result
end

p binary_search([76, 88, 93, 94, 97, 100], 1)

# >> 0
```

#### 9. Find position of an element in infinite sorted array
Logic:

start = 0
end = 1

while key > arr[end]
    start = end
    end = end * 2
end

Once while loop is done, apply binary search
```ruby

def find_range_and_search(arr, key)
  start = 0
  end_ = 1

  # Expand the range exponentially until the key is less than the end value
  while key > arr[end_]
    start = end_
    end_ *= 2
  end

  # Now apply binary search within the identified range
  binary_search(arr, start, end_, key)
end

def binary_search(arr, start, end_, key)
  while start <= end_
    mid = start + (end_ - start) / 2
    if arr[mid] == key
      return mid
    elsif arr[mid] < key
      start = mid + 1
    else
      end_ = mid - 1
    end
  end
  -1 # If the element is not found
end

# Assuming an "infinite" sorted array (for demonstration, a large enough array will suffice)
# and assuming the function knows when to stop.
# The array should have a mechanism to handle out-of-bound indexes if it's truly infinite.
# For this example, we'll use a finite array but the concept applies for an infinite one as well.

infinite_array = [3, 5, 7, 9, 10, 90, 100, 130, 140, 160, 170]
key = 10

position = find_range_and_search(infinite_array, key)
puts "The position of the element is: #{position}"
```

#### 10. Find index of 1st 1 in infinite binary sorted array
For infinite - Refer to 9. Find position of an element in infinite sorted array 
For first occurence - Refer to 4. Count number of an element in an sorted array

#### 11. Find minimum difference element in sorted array
Refer to ceil and floor problem and find both and key absolute difference to find answer

#### 12. Peak element
```ruby


def binary_search_peak(arr)
    s = 0
    e = arr.length - 1
    l = arr.length
    result = -1

    return result if arr.empty?

    while s <= e
        m = s + (e - s)/2

        if (arr[m+1] == nil || arr[m] > arr[m+1]) && (m == 0 || arr[m] >= arr[m-1])
            return arr[m]
        elsif arr[m+1] > arr[m]
            s = m + 1
        else
            e = m - 1
        end
       
    end

    return arr[s]
end

p binary_search_peak([76,88,93,94,95,100,99,7,6,5,4,3,2,1])
p binary_search_peak([1,2,3,4,5,6,7,3,1])
p binary_search_peak([1,1,1])
p binary_search_peak([2,1])
p binary_search_peak([1,2])
p binary_search_peak([2])
p binary_search_peak([3,2,1])
p binary_search_peak([1,2,3])
```

#### 13. Bitonic array
Logic: Same as find peak element

#### 14. Search in Bitonic array
Logic:  Find peak element and break arr into 2 array
1. Sorted arr
2. Reverse sorted

Apply binary search on both array 


