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