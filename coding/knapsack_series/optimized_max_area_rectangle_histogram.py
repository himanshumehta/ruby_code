def largestRectangleArea(heights):
    pstack, hstack = [], []
    max_area = 0
    heights.append(0)

    for i in range(len(heights)):
        last_width = len(heights) + 1
        while pstack and hstack[-1] > heights[i]:
            last_width = pstack[-1]
            carea = (i - pstack[-1])*hstack[-1]
            max_area = max(carea, max_area)
            pstack.pop()
            hstack.pop()

        if not pstack or hstack[-1] < heights[i]:
            pstack.append(min(last_width, i))
            hstack.append(heights[i])

    return max_area

print(largestRectangleArea([2,3,1,3,4,1,2]))
