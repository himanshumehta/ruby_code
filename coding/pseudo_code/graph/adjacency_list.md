1. AdjacencyListnode directed graph
2. AdjacencyListnode undirected graph
3. DFS adjacency list

#### **1. AdjacencyListnode directed graph without hashmap**

```ruby
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
g.addEdge(1, 2)
g.addEdge(1, 4)
g.addEdge(2, 0)
g.addEdge(2, 3)
g.addEdge(4, 3)
#  print graph element
g.printGraph()

# >> 
# >> Adjacency list of vertex 0 : 1
# >> Adjacency list of vertex 1 : 2 4
# >> Adjacency list of vertex 2 : 0 3
# >> Adjacency list of vertex 3 :
# >> Adjacency list of vertex 4 : 3
```

#### **2. AdjacencyListnode undirected graph**
Logic: Only one change compared to directed graph, we will add both start and last and last and satrt if they are different

```ruby
def addEdge(start, last)
    if start >= 0 && start < self.size && last >= 0 && last < self.size
      self.connect(start, last)
      if start == last # This is also change
        return
      end

      self.connect(last, start) # This is only change
    else
      print("\nSomething went wrong")
    end
end
```

```ruby
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

```

#### **3. DFS adjacency list**
```ruby
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
```


#### **4. Implement undirected graph with hashmap**
```ruby
class Node
  attr_reader :value

  def initialize(value)
    @value = value
    @adjacent_nodes = []
  end

  def add_edge(adjacent_node)
    @adjacent_nodes << adjacent_node
  end
end

class Graph
  def initialize
    @nodes = {}
  end

  def add_node(node)
    # TODO - Add check if key already exists
    @nodes[node.value] = node
  end

  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end
end
```





