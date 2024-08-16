class Node
 attr_reader :val
 attr_accessor :left, :right
 def initialize(val)
  @val = val
  @left =nil
  @right =nil
 end
end

def max_path_sum(root)
    @result = -(1 << 64)
    dfs(root)
    @result
end

def dfs(node)
    return 0 if !node
    l, r = dfs(node.left), dfs(node.right)
    temp = [[l,r].max + node.val, node.val].max
    ans = [temp, l + r + node.val].max
    @result = [@result, ans].max
    return temp
end

p max_path_sum(root)
