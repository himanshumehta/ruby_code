# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  
  dummy = result = ListNode.new(carry = 0)
  while l1 && l2
    tmp = l1.val + l2.val + carry
    carry, value = tmp > 9 ? 1: 0, tmp > 9 ? tmp - 10 : tmp
    result.next = ListNode.new(value)
    result = result.next
    l1, l2 = l1.next, l2.next
  end
  result.next = carry == 0 ? l1 || l2 : add_two_numbers(l1 || l2, ListNode.new(1))
  dummy.next
end

puts 1 + 1

# >> 2

