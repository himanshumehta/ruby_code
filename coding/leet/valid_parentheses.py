class Solution:
    def ValidParentheses(self, s):
        stack = Stack()
        opening = '([{'
        closing = ')]}'

        if len(s) == 0:
            return True
        if len(s) < 2:
            return False
        for char in s:
            if char in closing and not stack.is_empty():
                popped = stack.pop()
                try:
                    opening_index = opening.index(popped)
                except:
                    opening_index = -1
                try:
                    closing_index = closing.index(char)
                except:
                    closing_index = -1
                if opening_index != closing_index:
                    return False
            else:
                stack.push(char)
        if stack.is_empty():
            return True
        return False

class Stack:
    def __init__(self):
        self.stack = []
    def peek(self):
        return self.stack[-1]
    def push(self, value):
        self.stack.append(value)
    def pop(self):
        return self.stack.pop()
    def is_empty(self):
        return len(self.stack) == 0
    def size(self):
        return len(self.stack)

s = '()'
obj = Solution()
print( obj.ValidParentheses(s))
