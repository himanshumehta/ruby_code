# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer}
def min_depth(root)
  return 0 unless root
  return 1 if root.right.nil? && root.left.nil?
  left = root.left ? min_depth(root.left) : 1 << 64
  right = root.right ? min_depth(root.right) : 1 << 64

  return [left,right].min + 1
end
