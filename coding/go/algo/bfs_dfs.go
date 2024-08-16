%v - prints the value in a default format.
%T - prints the type of the value.
%t - formats a boolean value.
%b - prints the integer in binary format.
%c - prints the character represented by the corresponding Unicode code point.
%d - prints the integer in decimal (base 10) format.
%o - prints the integer in octal (base 8) format.
%x - prints the integer in hexadecimal (base 16), with lowercase letters for a-f.
%X - prints the integer in hexadecimal (base 16), with upper-case letters for A-F.
%f - prints the floating-point number in decimal point notation.
%e - prints the floating-point number in scientific notation (e.g., -1.234456e+78).
%E - prints the floating-point number in scientific notation (e.g., -1.234456E+78).
%s - prints a string of characters.
%p - prints the pointer representation of a value.
%U - prints the Unicode format.
%% - prints a per cent sign.

// DFS
package main

import (
	"fmt"
)

type Node struct {
	val   int
	left  *Node
	right *Node
}

func newNode(val int) *Node {
	return &Node{
		val:   val,
		left:  nil,
		right: nil,
	}
}

func dfs(node *Node, level int) {
	if node == nil {
		return
	}
	fmt.Printf("%s-> %d\n", indentation(level), node.val)
	dfs(node.left, level+1)
	dfs(node.right, level+1)
}

func indentation(level int) string {
	indentation := ""
	if level == 0 {
		return indentation
	}

	i := 1
	for i <= level {
		indentation += "  " + indentation
		i++
	}

	return indentation
}

func main() {
	root := newNode(3)
	childL := newNode(9)
	childR := newNode(20)
	grandChildRL := newNode(15)
	grandChildRR := newNode(7)
	grandChildLL := newNode(33)
	childR.left = grandChildRL
	childR.right = grandChildRR
	childL.left = grandChildLL
	root.left = childL
	root.right = childR

	dfs(root, 0)
}

func bfs(node *Node, level int) {
	queue := []*Node{node}
	for len(queue) > 0 {
		currentNode := queue[0]
		queue = queue[1:]
		fmt.Println(currentNode.val)
		if currentNode.left != nil {
			queue = append(queue, currentNode.left)
		}
		if currentNode.right != nil {
			queue = append(queue, currentNode.right)
		}
	}
}

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


