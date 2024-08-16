=begin
AdjacencyListnode - id, next - id hold data
Vertices - data, next, last - same as id but for vertices
=end
class Node
  attr_accessor :data, :next_node

  def initialize(data, next_node = nil)
    self.data = data
    self.next_node = next_node
  end
end

class Queue
  attr_accessor :head, :tail, :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def enqueue(data)
    return unless data
    node = Node.new data

    unless self.head
      self.head = node
    else
      self.tail.next_node = node
    end

    self.tail = node
    self.length += 1
  end

  def dequeue
    return nil unless self.length > 0
    self.head = self.head.next_node
    self.tail = nil if self.length == 1
    self.length -= 1
  end

  def peek
    self.head
  end

  def size
    self.length
  end

  def clear
    while peek
      dequeue
    end
  end

  def each
    return unless block_given?

    current = self.head
    while current
      yield current
      current = current.next_node
    end
  end

  def print
    if self.length == 0
      puts "empty"
    else
      self.each do |curr_node|
        puts curr_node.data
      end
    end
  end
end

q = Queue.new
q.enqueue "foo"
q.enqueue "bar"
pp q.size
pp q.peek
q.dequeue
pp q.size

class AdjacencyListnode
  attr_accessor :id, :next

  def initialize(id)
    self.id = id
    self.next = nil
  end
end

class Vertices
  attr_accessor :data, :next, :last

  def initialize(data)
    self.data = data
    self.next = nil
    self.last = nil
  end
end

class Graph
  attr_accessor :size, :node

  def initialize(size)
    self.size = size
    self.node = Array.new(size) { nil }
    self.setData
  end

  def setData
    if self.size <= 0
      print ("\nEmpty graph")
    else
      index = 0
      while index < self.size
        self.node[index] = Vertices.new(index)
        index += 1
      end
    end
  end

  def connect(start, last)
    edge = AdjacencyListnode.new(last)
    if self.node[start].next == nil
      self.node[start].next = edge
    else
      self.node[start].last.next = edge
    end

    self.node[start].last = edge
  end

  def addEdge(start, last)
    if start >= 0 && start < self.size && last >= 0 && last < self.size
      self.connect(start, last)
      #   if start == last
      #     return
      #   end

      #   self.connect(last, start)
    else
      print("\nSomething went wrong")
    end
  end

  def printGraph
    if self.size > 0
      index = 0
      while index < self.size
        print("\nAdjacency list of vertex ", index, " :")
        temp = self.node[index].next
        while temp != nil
          print(" ", self.node[temp.id].data)
          temp = temp.next
        end

        index += 1
      end
    end
  end

  def bfs(point)
    return if point < 0 || self.size <= 0 || point > self.size

    q = Queue.new
    visited = Array.new(self.size) { false }
    q.enqueue point

    while q.size > 0
      current = q.peek.data
      visited[current] = true
      print(" ", current)
      q.dequeue
      temp = self.node[current].next
      while temp != nil
        q.enqueue temp.id if visited[temp.id] == false
        temp = temp.next
      end
    end
  end
end

g = Graph.new(6)
#  Connect node with an edge
g.addEdge(0, 1)
g.addEdge(0, 5)
g.addEdge(1, 1)
g.addEdge(2, 1)
g.addEdge(3, 0)
g.addEdge(3, 3)
g.addEdge(4, 2)
g.addEdge(4, 3)
g.addEdge(5, 1)
#  print graph element
g.printGraph()
puts
g.bfs(4)

# >> 2
# >> #<Node:0x00007f9b378e8210
# >>  @data="foo",
# >>  @next_node=#<Node:0x00007f9b378e8170 @data="bar", @next_node=nil>>
# >> 1
# >>
# >> Adjacency list of vertex 0 : 1 5
# >> Adjacency list of vertex 1 : 1
# >> Adjacency list of vertex 2 : 1
# >> Adjacency list of vertex 3 : 0 3
# >> Adjacency list of vertex 4 : 2 3
# >> Adjacency list of vertex 5 : 1
# >>  4 2 3 1 0 5
