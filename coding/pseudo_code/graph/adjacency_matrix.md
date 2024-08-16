1. Adjacency matrix dfs
2. Adjacency matrix bfs

#### **1. Adjacency matrix dfs**
```ruby
class Graph
  def initialize(v, e)
    @v = v
    @e = e
    @adj = Array.new(v, 0) { Array.new(v, 0) }
  end

  def addEdge(start, e)
    # Considering a bidirectional edge
    @adj[start][e] = 1
    @adj[e][start] = 1
  end

  def dfs(start, visited)
    print(start, " ")
    visited[start] = true

    for i in 0..@v
      if @adj[start][i] == 1 && visited[i] == false
        dfs(i, visited)
      end
    end
  end
end

v, e = 5, 4

# Create the graph
g = Graph.new(v, e)
g.addEdge(0, 1)
g.addEdge(0, 2)
g.addEdge(0, 3)
g.addEdge(0, 4)

# Visited vector to so that a vertex
# is not visited more than once
# Initializing the vector to false as no
# vertex is visited at the beginning
visited = Array.new(v, false)
g.dfs(0, visited)

# >> 0 1 2 3 4 
```

#### **2. Adjacency matrix bfs**
```ruby
class Graph
  def initialize(v, e)
    @v = v
    @e = e
    @adj = Array.new(v, 0) { Array.new(v, 0) }
  end

  def addEdge(start, e)
    # Considering a bidirectional edge
    @adj[start][e] = 1
    @adj[e][start] = 1
  end

  def bfs(start)
    visited = Array.new(@v, false)
    q = [start]

    while q.length > 0
      curr = q.shift

      print(curr, " ") if visited[curr] == false
      visited[curr] = true
      for i in 0..@v
        if @adj[curr][i] == 1 && visited[i] == false
          print(i, " ")
          q.append i
          visited[i] = true
        end
      end
    end
  end
end

v, e = 8, 4

# Create the graph
g = Graph.new(v, e)
g.addEdge(1, 2)
g.addEdge(1, 5)
g.addEdge(1, 3)
g.addEdge(2, 6)
g.addEdge(2, 4)
g.addEdge(5, 4)
g.addEdge(3, 4)
g.addEdge(3, 7)

g.bfs(1)

# pp 11

# >> 1 2 3 5 4 6 7
```

