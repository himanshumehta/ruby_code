def min_window_substring(strArr)
    input, pattern = strArr
    pattern_chars = pattern.each_char.with_object(Hash.new(0)) { |char, hash| hash[char] += 1}
    required = pattern_chars.keys.length
    current_selection_pattern_chars_count = 0
    current_selection_chars_count = Hash.new(0)
    left = 0
    tally = 0
    result = Float::INFINITY, nil, nil

    input.each_char.with_index do |char, right|
        current_selection_chars_count[char] += 1
        if pattern_chars[char] != nil && current_selection_chars_count[char] == pattern_chars[char]
            tally += 1
        end

        while right >= left && tally == required
            char = input[left]

            if result[0] > right - left + 1
                result = right - left + 1, left, right
            end

            current_selection_chars_count[char] -= 1
            if pattern_chars.key?(char) && current_selection_chars_count[char] < pattern_chars[char]
                tally -= 1
            end
            
            left += 1
        end
    end

    return "" if result[0] == Float::INFINITY
    return input[result[1]..result[2]]
end

puts min_window_substring(["aabcxddbcacd", "aad"])
