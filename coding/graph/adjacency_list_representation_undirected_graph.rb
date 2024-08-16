=begin
AdjacencyListnode - id, next - id hold data
Vertices - data, next, last - same as id but for vertices


=end

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
      if start == last
        return
      end

      self.connect(last, start)
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
end

g = Graph.new(5)
#  Connect node with an edge
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(0, 4)
g.addEdge(1, 2)
g.addEdge(1, 4)
g.addEdge(2, 3)
g.addEdge(3, 4)
g.printGraph()

# >> 
# >> Adjacency list of vertex 0 : 1 2 4
# >> Adjacency list of vertex 1 : 0 2 4
# >> Adjacency list of vertex 2 : 0 1 3
# >> Adjacency list of vertex 3 : 2 4
# >> Adjacency list of vertex 4 : 0 1 3
