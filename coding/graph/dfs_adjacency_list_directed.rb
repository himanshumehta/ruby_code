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

  def printDFS(point)
    if self.size <= 0 || point < 0 || point >= self.size
      print("\nNothing for DFS")
      return
    end

    visit = Array.new(self.size) { false }
    self.dfs(visit, point)
  end

  def dfs(visit, point)
    return if visit[point] == true
    visit[point] = true
    print(" ", point)

    temp = self.node[point].next
    while temp != nil
      dfs(visit, temp.id)
      temp = temp.next
    end
  end
end

g = Graph.new(6)
g.addEdge(0, 1)
g.addEdge(0, 5)
g.addEdge(1, 1)
g.addEdge(2, 1)
g.addEdge(3, 0)
g.addEdge(3, 3)
g.addEdge(4, 2)
g.addEdge(4, 3)
g.addEdge(5, 1)
g.printGraph
puts

g.printDFS(4)

# >>
# >> Adjacency list of vertex 0 : 1 5
# >> Adjacency list of vertex 1 : 1
# >> Adjacency list of vertex 2 : 1
# >> Adjacency list of vertex 3 : 0 3
# >> Adjacency list of vertex 4 : 2 3
# >> Adjacency list of vertex 5 : 1
# >>  4 2 1 3 0 5
