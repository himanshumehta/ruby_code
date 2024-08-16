

class Node
 attr_reader :value
 attr_accessor :left, :right
 def initialize(value)
  @value = value
  @left =nil
  @right =nil
 end
end

RESULT = []
def count_path_sum(root=nil,sum=0)
	path_sum = 0
	path = []
	dfs(root, sum, path, path_sum)
end

def dfs(root, sum, path, path_sum)
	if root.nil?
	  return 0
	end

	path_sum += root.value

	if root.left.nil? && root.right.nil? && sum == path_sum
		temp = path + [root.value]
		RESULT << temp
	end
	path << root.value
	dfs(root.left, sum, path, path_sum)
	dfs(root.right, sum, path, path_sum)
	path_sum -= root.value
	path.pop
end

root = Node.new(5)
root.left = Node.new(4)
root.right = Node.new(8)
root.left.left = Node.new(11)
root.left.left.right = Node.new(2)
root.left.left.left = Node.new(7)
root.right.right = Node.new(4)
root.right.right.left = Node.new(5)
root.right.right.right = Node.new(1)
root.right.left = Node.new(13)
count_path_sum(root=root,sum=22)

p RESULT

