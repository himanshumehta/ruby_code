def kth_grammar(n, k)
  if n == 1 && k == 1
    return 0
  end

  mid = (2 ** (n - 1)) / 2

  if k <= mid
    return kth_grammar(n - 1, k)
  elsif k > mid
    res = (kth_grammar(n - 1, k - mid) == 0) ? 1 : 0
    return res
  end
end

p kth_grammar(4, 3)

# >> 1
