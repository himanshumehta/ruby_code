def binary_search(arr, el)
  end_ = arr.length - 1
  start_ = 0

  while start_ <= end_
    mid = start_ + (end_ - start_) / 2
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
