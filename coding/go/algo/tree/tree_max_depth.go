func maxDepth(root *Node) int {
	if root == nil {
		return 0
	}

	queue := []*Node{root}
	depth := 0

	for len(queue) > 0 {
		levelSize := len(queue)
		for i := 0; i < levelSize; i++ {
			node := queue[0]
			queue = queue[1:]
			if node.Left != nil {
				queue = append(queue, node.Left)
			}
			if node.Right != nil {
				queue = append(queue, node.Right)
			}
		}
		depth++
	}

	return depth
}

func main() {
	// Create your binary tree here and call the maxDepth function
}
Make sure to create a binary tree and call the maxDepth function with the root node to calculate the maximum depth.





