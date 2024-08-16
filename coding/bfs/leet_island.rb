def countislands(land)
  rows = land.length
  cols = land[0].length
  if rows.zero?
    0
  else
    islands = 0
    for i in 0...rows
      for j in 0...cols
        if land[i][j] == 1
          marknearby(land, i, j, rows, cols)
          islands += 1
        end
      end
    end
    islands
  end
end

def marknearby(land, i, j, rows, cols)
  return if i >= rows || i < 0 || j >= cols || j < 0 || land[i][j] != 1

  land[i][j] = 2
  marknearby(land, i - 1, j, rows, cols)
  marknearby(land, i + 1, j, rows, cols)
  marknearby(land, i, j - 1, rows, cols)
  marknearby(land, i, j + 1, rows, cols)
end

land = [[1, 1, 1, 0, 0],
        [1, 1, 0, 0, 1]]

p countislands(land)

# >> 2
