def valid?(s)
  num = s.to_i
  num.to_s == s && num >= 0 && num < 256
end

def dfs(s, parts)
  if parts.size == 3
    @candidates << [parts + [s]].join(".") if valid?(s)
    return
  end

  (0..[2, s.size - 1].min).each { |i|
    word = s[0..i]
    dfs(s[i + 1..-1], parts + [word]) if valid?(word)
  }
end

def restore_ip_addresses(s)
  @candidates = []
  dfs(s, [])
  @candidates
end

s = "02000"
p restore_ip_addresses(s)

# >> ["0.20.0.0"]
