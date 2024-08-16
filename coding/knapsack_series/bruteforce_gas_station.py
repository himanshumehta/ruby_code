class Solution(object):
    def canCompleteCircuit(self, gas, cost):
        for i in range(0, len(gas)):
            tank = 0
            possible = True
            for j in range(i, len(gas)+i):
                station = j % len(gas)
                tank = tank + gas[station] - cost[station]
                if tank < 0:
                    possible = False
                    break
            if possible:
                return i
        return -1
