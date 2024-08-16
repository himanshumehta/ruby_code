
=begin
This problem is example of fixed window size
Right way to solve any sliding window

Set two pointers
i = j = 0
window size k = j - i + 1

Run loop while j < size

if j - i + 1 < k
    window size is smaller
    do work
    j++    
else j - i + 1 == k
    window size is matching
    do work
    i++
    j++    
=end

def max_sum_sub_array(arr, k)
    sub_array_sums = []
	# arr.each_with_index do |val, idx|
    upto = arr.length - k + 1
    (0...upto).each_with_index do |val, idx|
        i = idx
        j = k + i - 1
        if sub_array_sums.length > 0
            sum = sub_array_sums[-1] + arr[j] - arr[i-1]
        else
            sum = sum_starting_sub_array(arr, i, j)
        end
        sub_array_sums << sum
    end     
    p "sub_array_sums": sub_array_sums
    sub_array_sums.max
end

def sum_starting_sub_array(arr, i, j)
    sum = 0 
    (i..j).each do |i|
        sum += arr[i]
    end
    p "sum": sum
    sum
end

# Window size k = j - i + 1
w_array = [2,5,1,8,2,9,1]
k = 3
p max_sum_sub_array(w_array, k)

# This is not best way
# We can use k = j - i + 1 condition to write better code. Refer to other solutions in same

# >> {:sum=>8}
# >> {:sub_array_sums=>[8, 14, 11, 19, 12]}
# >> 19

