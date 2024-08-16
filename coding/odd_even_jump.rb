require "awesome_print"
require "pp"

def odd_even_jumps(arr)
  arr_with_index = arr.each_with_index.map { |num, idx| [idx, num] }

  odd_sorted_arr = arr_with_index.sort do |(idx1, num1), (idx2, num2)|
    if num1 == num2
      idx1 <=> idx2
    else
      num1 <=> num2
    end
  end

  even_sorted_arr = arr_with_index.sort do |(idx1, num1), (idx2, num2)|
    if num1 == num2
      idx1 <=> idx2
    else
      num2 <=> num1
    end
  end

  odd_next = Array.new(arr.length, nil)
  odd_stack = []

  odd_sorted_arr.each do |(idx, num)|
    while !odd_stack.empty? && idx > odd_stack[-1]
      odd_next[odd_stack.pop] = idx
    end
    odd_stack.push(idx)
  end

  even_next = Array.new(arr.length, nil)
  even_stack = []

  even_sorted_arr.each do |(idx, num)|
    while !even_stack.empty? && idx > even_stack[-1]
      even_next[even_stack.pop] = idx
    end
    even_stack.push(idx)
  end

  odd_good = Array.new(arr.length, nil)
  even_good = Array.new(arr.length, nil)

  odd_good[-1] = 1
  even_good[-1] = 1

  (arr.length - 2).downto(0) do |i|
    even_index = odd_next[i]
    if even_index.nil? || even_good[even_index].nil?
      odd_good[i] = 0
    else
      odd_good[i] = even_good[even_index]
    end

    odd_index = even_next[i]
    if odd_index.nil? || odd_good[odd_index].nil?
      even_good[i] = 0
    else
      even_good[i] = odd_good[odd_index]
    end
  end

  pp even_good
  pp odd_good

  return odd_good.count(1)
end

arr = [2, 3, 1, 1, 4]
pp odd_even_jumps(arr)
