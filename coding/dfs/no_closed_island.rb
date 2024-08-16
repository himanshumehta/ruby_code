# @param {Integer[][]} grid
# @return {Integer}
def closed_island(grid)
  rows = grid.length
  cols = grid[0].length
  if rows == 0
    return 0
  else
    islands = 0
    for i in 1...rows-1
      for j in 1...cols-1
        if grid[i][j] == 0
          islands += 1 if marknearby(grid,i,j,rows,cols)
        end
      end
    end
    return islands
  end
end
def marknearby(land,i,j,rows,cols,closed_land=0)
  if land[i][j] != 0
    return true
  elsif (i == rows-1 || i == 0 || j == cols-1 || j == 0) &&land[i][j] == 0
    return false
  else
    land[i][j] = 2
    left = marknearby(land,i-1,j,rows,cols)
    right = marknearby(land,i+1,j,rows,cols)
    up = marknearby(land,i,j-1,rows,cols)
    down = marknearby(land,i,j+1,rows,cols)
    return left && right && up && down
  end
end
