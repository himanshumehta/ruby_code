def lcs(xstr, ystr)
  return "" if xstr.empty? || ystr.empty?

  x = xstr[0..0]
  xs = xstr[1..-1]
  y = ystr[0..0]
  ys = ystr[1..-1]
  if x == y
    x + lcs(xs, ys)
  else
    [lcs(xstr, ys), lcs(xs, ystr)].max_by(&:size)
  end
end

p lcs("thisisatest", "testing123testing")

# >> "tsitest"

