def group_anagrams(strs)
  result = Hash.new { |h, k| h[k] = [] }  # => {}
  strs.each do |str|                      # => ["eat", "tea", "tan", "ate", "nat", "bat"]
    key = count_chars(str)                # => [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    result[key] << str                    # => ["eat"],                                                                        ["eat", "tea"],                                                                 ["tan"],                                                                        ["eat", "tea", "ate"],                                                          ["tan", "nat"],                                                                 ["bat"]
  end
  result.values                           # => [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
end

def count_chars(str)
  counts = Array.new(26, 0) # => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
  # => "eat",                                                                          "tea",                                                                          "tan",                                                                          "ate",                                                                          "nat",                                                                          "bat"
  str.each_char do |c|
    counts[c.ord - 'a'.ord] += 1
  end
  counts # => [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0], [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
end

p group_anagrams(%w[eat tea tan ate nat bat]) # => [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

# >> [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

# Group anagrams optimised
# def group_anagrams(strs)
#   res = Hash.new([])        # => {}
#   strs.each do |str|        # => ["eat", "tea", "tan", "ate", "nat", "bat"]
#     key = count_chars(str)  # => {"e"=>1, "a"=>1, "t"=>1}, {"t"=>1, "e"=>1, "a"=>1}, {"t"=>1, "a"=>1, "n"=>1}, {"a"=>1, "t"=>1, "e"=>1},     {"n"=>1, "a"=>1, "t"=>1},            {"b"=>1, "a"=>1, "t"=>1}
#     res[key] << str         # => ["eat"],                  ["eat", "tea"],           ["eat", "tea", "tan"],    ["eat", "tea", "tan", "ate"], ["eat", "tea", "tan", "ate", "nat"], ["eat", "tea", "tan", "ate", "nat", "bat"]
#   end                       # => ["eat", "tea", "tan", "ate", "nat", "bat"]
#   res.values                # => []
# end                         # => :group_anagrams

# def count_chars(str)
#   str.each_char.with_object(Hash.new(0)) do |c, counts|  # => #<Enumerator: "eat":each_char>, #<Enumerator: "tea":each_char>, #<Enumerator: "tan":each_char>, #<Enumerator: "ate":each_char>, #<Enumerator: "nat":each_char>, #<Enumerator: "bat":each_char>
#     counts[c] += 1                                       # => 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
#   end                                                    # => {"e"=>1, "a"=>1, "t"=>1}, {"t"=>1, "e"=>1, "a"=>1}, {"t"=>1, "a"=>1, "n"=>1}, {"a"=>1, "t"=>1, "e"=>1}, {"n"=>1, "a"=>1, "t"=>1}, {"b"=>1, "a"=>1, "t"=>1}
# end                                                      # => :count_chars

# p group_anagrams(%w[eat tea tan ate nat bat])  # => []
