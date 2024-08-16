require "set"

# Input: N = 5 and k = 2
# Output: 3

# Input: N = 7 and k = 3
# Output: 4

$global_variable = 0

def solve(n, k)
  if n.length == 1
    p n
    return n
  end

  $global_variable = ($global_variable + k - 1) % n.length
  n.delete_at($global_variable)
  solve(n, k)
end

solve([*1..7], 3)

# >> [4]
