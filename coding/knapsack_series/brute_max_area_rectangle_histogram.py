def histogram(height):
    max_area = 0
    for i in range(len(height)):
        min_height = height[i]
        for j in range(i,len(height)):
            if height[j] == 0:
                break
            min_height = min(min_height,height[j])
            max_area = max(max_area, min_height * (j - i + 1))
    return max_area
height = [2,1,3,2,3]
print(histogram(height))
