<!-- # Recursion
# 3 things
# Base condition - Think of smallest valid input or think of invalid input
# Choice diagram
# For base condition - Think of smallest valid input
# Nested array with default - initialization and iterate
-->

### Tree - 6 problems 
1. General syntax
2. How can dp be applied on Tree
3. Diameter of binary tree
4. Maximum path sum from any node to any
5. Maximum path sum from leaf to leaf
6. Diameter of N-ary tree

Whenever we need to traverse the tree O(N) and at every node we need to do some operation which take O(N), we can suspect dp

Tree recursive method structure
{
    Base condition
    Hypothesis ---> Bring Right ka answer or left ka answer - we can store in 2 variables
    Induction ---> Use right and left to find answer
}

#### 3. Diameter of binary tree
- Return number of nodes along the longest path between 2 leafs

<!-- Base condition -->
result = Initialize with minimum 

if root == null
    return 0

<!-- Hypothesis  -->
left = solve(left, result)
right = solve(right, result)

<!-- Induction -->
At each node =>
temp_answer = 1 + Max(left, right)
if_it_is_answer_itself = 1 + left + right

We will set max of either of above to find final answer

result = Max(temp_answer, if_it_is_answer_itself)

#### Maximum path sum from any node to any node (There is no leaf node restriction)
<!-- Solve method -->
<!-- Base condition -->
solve(node root, result)

if root == nullptr
    return 0

<!-- Hypothesis  -->
left = solve(root -> left, result)
right = solve(root -> right, result)

<!-- Induction -->
temp = max(
    max(l,r) + root,
    root
)
answer = max(temp, l + r + root)
result = max (result, answer)

return temp

<!-- Main method -->
main()
    result = INT_MIN
    solve
    return result

#### Maximum path sum from leaf to leaf

<!-- Base condition -->
result = Initialize with minimum 

if root == null
    return 0

<!-- Hypothesis  -->
left = solve(left, result)
right = solve(right, result)

<!-- Induction -->
temp = max(l,r) + root

<!-- Below 2 lines are optional, code will work otherwise -->
if root.left = nullptr && root.right = nullptr # Meaning if it is leaf
    temp = max(temp, root.value)

answer = max(temp, l + r + root)
result = max (result, answer)

return temp

<!-- Main method -->
main()
    result = INT_MIN
    solve
    return result

