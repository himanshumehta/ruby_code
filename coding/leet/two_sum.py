class Solution:
    def twoSum(self, nums, target):
        compliment = {}
        result = []
        for index, value in enumerate(nums):
            if compliment.get(value) is None:
                compliment[target-value] = index
            else:
                return [compliment[value], index]
        return result
