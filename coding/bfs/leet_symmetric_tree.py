class TreeNode
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
        
class Solution:
    def isSymmetric(self, root: TreeNode) -> bool:
        if root is None:
            return True
        
        return isMirror(self, root.left, root.right) 
        
    def isMirror(self, left_root, right_root) -> bool:
        if left_root and right_root:
            return left_root == right_root and self.isMirror(left_root.left, right_root.right) and self.isMirror(left_root.right, right_root.leeft)
        return left_root == right_root
