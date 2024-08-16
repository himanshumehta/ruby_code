class TreeNode
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class Solution:
    def isCousins(self, root: TreeNode, x:int, y:int) -> bool:
        if root is None:
            return False
        xinfo = []
        yinfo = []
        depth = 0
        parent = None
        self.dfs(root, x,y,0,None,xinfo, yinfo)
        return xinfo[0][0] == yinfo[0][0] and xinfo[0][1] != yinfo[0][1]

    def dfs(self, root, x, y, depth, parent, xinfo, yinfo):
        if root is None:
            return False
        if root.val == x:
            xinfo.append((depth, parent))
        if root.val == y:
            yinfo.append((depth, parent))
        self.dfs(root.left, x, y, depth + 1, root, xinfo, yinfo)  
        self.dfs(root.right, x, y, depth + 1, root, xinfo, yinfo)
