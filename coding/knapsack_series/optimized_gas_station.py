class Solution(object):
    def canCompleteCircuit(self, gas, cost):
        diff = 0
        for i in range(0, len(gas)):
            diff += gas[i] - cost[i]
        if diff < 0:
            return -1
        else:
            tank = 0
            start = 0
            for i in range(0, len(gas)):
                tank = tank + gas[i] - cost[i]
                if tank < 0:
                    start = i + 1
                    tank = 0
            return start
