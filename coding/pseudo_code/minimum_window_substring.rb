
=begin

# array = ["t", "i", "m", "e", "t", "o", "p", "r", "a", "c", "t", "i", "c", "e"]
# required = ["t", "o", "c"]

i = j = 0

Maintain a map with count of required chars
required_map = {
     "t" => 1, 
     "o" => 1, 
     "c" => 1
}

Also maintain count of chars required - Whenever count of char required is zero, decrease count by 1
char_count = 3 
min_window_substring = []


while j < size    
    if condition char found having key in required map
        Decrease count of char in map by 1
        Check if char required count is zero and if it is - decrease char_count by 1
        If count is zero - Trigger while i < j
        j++
    end
end

while i < j 
    if Previous pointer char found having key in required map 
        Increase char count by 1
        Update char_count if it was zero 
    end

    if Current pointer char found having key in required map
        Decrease count of char in map by 1
        Check if char required count is zero and if it is - decrease char_count by 1
    end

    i++
end    

return 


=end

# def minimum_window_substring(array, required)
#     while j < size do   
#         if condition char found having key in required map
#             Decrease count of char in map by 1
#             Check if char required count is zero and if it is - decrease char_count by 1
#             If count is zero - Trigger while i < j
#             j++
#         end
#     end

#     while i < j do
#         if Previous pointer char found having key in required map 
#             Increase char count by 1
#             Update char_count if it was zero 
#         end

#         if Current pointer char found having key in required map
#             Decrease count of char in map by 1
#             Check if char required count is zero and if it is - decrease char_count by 1
#         end

#         i++
#     end 
# end


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

def minimum_window_substring(s, t)
  return "" if s.empty? || t.empty?

  char_map = t.each_char.with_object(Hash.new(0)) { |c, h| h[c] += 1 }
  required = char_map.length

  left = 0
  right = 0
  formed = 0

  window_counts = Hash.new(0)

  # (window length, left, right)
  ans = Float::INFINITY, nil, nil

  while right < s.length
    character = s[right]
    window_counts[character] += 1

    if char_map.include?(character) && window_counts[character] == char_map[character]
      formed += 1
    end

    while left <= right && formed == required
      character = s[left]

      # Save the smallest window until now.
      if right - left + 1 < ans[0]
        ans = right - left + 1, left, right
      end

      window_counts[character] -= 1
      if char_map.include?(character) && window_counts[character] < char_map[character]
        formed -= 1
      end

      left += 1
    end

    right += 1
  end

  return "" if ans[0] == Float::INFINITY

  s[ans[1]..ans[2]]
end

s = "timetopractice"
t = "toc"
puts minimum_window_substring(s, t)

# ["t", "i", "m", "e", "t", "o", "p", "r", "a", "c", "t", "i", "c", "e"]
# ["t", "o", "c"]

# >> {"t"=>1, "o"=>1, "c"=>1}
# >> {"t"=>1, "o"=>1, "c"=>1}
