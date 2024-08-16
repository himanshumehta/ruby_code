class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def isymmetric(root = nil)
  if root.nil?
    true
  else
    checksymmetry(root.left, root.right)
  end
end

def checksymmetry(left_node, right_node)
  if left_node && right_node
    left_node.value == right_node.value && checksymmetry(left_node.left,
                                                         right_node.right) && checksymmetry(left_node.right,
                                                                                            right_node.left)
  else
    left_node == right_node
  end
end
root = Node.new(1)
root.left = Node.new(2)
root.right = Node.new(2)
root.left.left = Node.new(3)
root.left.right = Node.new(4)
root.right.left = Node.new(4)
root.right.right = Node.new(3)
p isymmetric(root = root)
