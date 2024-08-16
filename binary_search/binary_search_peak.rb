

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
