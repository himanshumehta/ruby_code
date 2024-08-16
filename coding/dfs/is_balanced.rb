
def is_balanced(root=nil)
	dfs(root)
	true
rescue
	false
end

def dfs(root)
	return 0 if root.nil?

	left = dfs(root.left)
	right = dfs(root.right)

	if (left - right).abs > 1
		raise false
	end

	1 + [left, right].max
end

root = Node.new(1)
root.left = Node.new(2)
root.right = Node.new(12)
root.right.right = nil
root.right.left = nil
root.left.left = Node.new(3)
root.left.right = Node.new(13)
root.left.left.left = Node.new(4)
root.left.left.right = Node.new(14)

is_balanced(root=root)

