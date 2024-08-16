
class Node
 attr_reader :value
 attr_accessor :left, :right
 def initialize(value)
  @value = value
  @left =nil
  @right =nil
 end
end

array = [2,4,5]

root = Node.new(2)
root.left = Node.new(4)
root.right = Node.new(5)

def diameter_of_binary_tree(root)
    @result = 1
    dfs(root)
    @result - 1 # result has number of nodes in longest path, -1 of the gives us edges
end

def dfs(node)
    return 0 if !node
    l, r = dfs(node.left), dfs(node.right)
    @result = [@result, l + r + 1].max

    [l, r].max + 1
end


p diameter_of_binary_tree(root)
