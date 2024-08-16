
# =begin
# This problem is example of variable window size
# Right way to solve any sliding window

# Set two pointers
# i = j = 0
# sum = 0
# while j < size
#     calculate sum = sum + sum[j]
#     if sum == condition met    
#         store result, which is window size j - i + 1 
#         update sum - subtract value of i
#         i++
#         j++
#     else
#         j++
#     end
# =end

def largest_sub_array_size_k(arr, k)
    i = j = 0
    sum = 0
    window_sizes = []
    while j < arr.length do
        sum = sum + arr[j] if sum < k
        if sum == k
             window_sizes << (j - i + 1) 
             sum = sum - arr[i]
             i += 1
             j += 1
        elsif sum > k 
            sum = sum - arr[i]
            i += 1
        elsif sum < k
            j += 1     
        end
    end
    window_sizes.max
end

w_array = [4,1,1,1,2,3,5]
k = 5
p largest_sub_array_size_k(w_array, k)

