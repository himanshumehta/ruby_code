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
