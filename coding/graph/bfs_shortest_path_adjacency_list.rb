=begin

+----+
v    |
A--->B--->F
|         ^
V         |
C--->D----+
     |
     v
     E
   
=end

graph = {
  "A" => ["B", "C"],
  "B" => ["A", "F"],
  "C" => ["D"],
  "D" => ["E", "F"],
  "E" => [],
  "F" => [],
}

def bfs(graph, start, goal)
  q = Queue.new
  q.enq start
  shortest_path_helper = { start => nil }

  while !q.empty?
    curr = q.deq
    if graph.key? curr
      return shortest_path(shortest_path_helper, goal) if curr == goal

      graph[curr].each do |neighbor|
        if !shortest_path_helper.key? neighbor
          shortest_path_helper[neighbor] = curr
          q.enq neighbor
        end
      end
    end
  end
end

def shortest_path(shortest_path_helper, goal)
  path = []
  while !goal.nil?
    path << goal
    goal = shortest_path_helper[goal]
  end

  path.reverse
end

p bfs(graph, "A", "F") # => ["A", "B", "F"]
p bfs(graph, "A", "E") # => ["A", "C", "D", "E"]
p bfs(graph, "B", "E") # => ["B", "A", "C", "D", "E"]

# >> ["A", "B", "F"]
# >> ["A", "C", "D", "E"]
# >> ["B", "A", "C", "D", "E"]
