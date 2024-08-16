def mch(p, i, j)
  if i == j
    return 0
  end

  _min = (1 << 64)

  (i...j).each do |n|
    count = mch(p,i,n) + mch(p,n+1,j) + (p[i-1] * p [n] * p[j])
    if count < _min
      _min = count
    end
  end

  return _min
end

arr = [1, 2, 3, 4, 3]
n = arr.length
p mch(arr, 1, n-1)
