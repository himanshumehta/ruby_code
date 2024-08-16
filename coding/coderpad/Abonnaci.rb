module Direction
  UP = :up        # => :up
  DOWN = :down    # => :down
  LEFT = :left    # => :left
  RIGHT = :right  # => :right
end

class The2048Bonacci
  def initialize(game_area)
    @game_area = game_area         # => [[2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0], [5, 0, 0, 0]], [[0, 0, 1, 2], [1, 0, 1, 0], [0, 8, 5, 0], [0, 5, 8, 0]], [[0, 1, 2, 3], [0, 3, 2, 1], [0, 0, 0, 0], [0, 5, 3, 5]], [[1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0]]
    @width = @game_area[0].length  # => 4,                                                         4,                                                        4,                                                        4
    @height = @game_area.length    # => 4,                                                         4,                                                        4,                                                        4
    @fibonacci = [1, 1]            # => [1, 1],                                                    [1, 1],                                                   [1, 1],                                                   [1, 1]
  end

  def _init_fibonacci
    max_val = @game_area.flatten.max                                                 # => 13,  8,   5,   8,   1
    @fibonacci << (@fibonacci[-1] + @fibonacci[-2]) while @fibonacci[-1] <= max_val  # => nil, nil, nil, nil, nil
  end

  def get_tile(x, y)
    @game_area[y][x] # => 2, 0, 0, 5, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 1, 0, 0, 8, 5, 0, 0, 5, 8, 0, 0, 1, 2, 3, 0, 3, 2, 1, 0, 0, 0, 0, 0, 5, 3, 5, 0, 0, 1, 5, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 5, 8, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  end

  def set_tile(x, y, value)
    @game_area[y][x] = value # => 0, 0, 2, 5, 0, 0, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 2, 0, 0, 0, 13, 0, 0, 0, 13, 0, 0, 1, 5, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 5, 8, 0, 0, 1, 5, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  end

  def process_push(pushing_direction)
    _init_fibonacci                                                                      # => nil,   nil,    nil,    nil,    nil
    case pushing_direction                                                               # => :down, :right, :right, :right, :up
    when Direction::DOWN, Direction::UP
      (0...@width).each do |x|                                                           # => 0...4, 0...4
        line_coords = # => [[0, 0], [0, 1], [0, 2], [0, 3]],                     [[1, 0], [1, 1], [1, 2], [1, 3]],                     [[2, 0], [2, 1], [2, 2], [2, 3]],                      [[3, 0], [3, 1], [3, 2], [3, 3]],                     [[0, 0], [0, 1], [0, 2], [0, 3]],                     [[1, 0], [1, 1], [1, 2], [1, 3]],                     [[2, 0], [2, 1], [2, 2], [2, 3]],                     [[3, 0], [3, 1], [3, 2],...
          (0...@height).map do |y|
            [x, y]
          end
        # => nil,                                                  nil,                                                  nil,                                                   nil,                                                  [[0, 3], [0, 2], [0, 1], [0, 0]],                     [[1, 3], [1, 2], [1, 1], [1, 0]],                     [[2, 3], [2, 2], [2, 1], [2, 0]],                     [[3, 3], [3, 2], [3, 1],...
        line_coords.reverse! if pushing_direction == Direction::UP
        fibo_vals = # => [2, 0, 0, 5],                                         [0, 0, 0, 0],                                         [0, 13, 0, 0],                                         [0, 0, 0, 0],                                         [1, 1, 1, 1],                                         [0, 0, 0, 0],                                         [0, 0, 0, 0],                                         [0, 0, 0, 0]
          line_coords.map do |coord|
            get_tile(*coord)
          end
        fused_fibo_vals = _do_fibonacci_fusing(fibo_vals) # => [0, 0, 2, 5],                                         [0, 0, 0, 0],                                         [0, 0, 0, 13],                                         [0, 0, 0, 0],                                         [0, 0, 2, 2],                                         [0, 0, 0, 0],                                         [0, 0, 0, 0],                                         [0, 0, 0, 0]
        # => [[[0, 0], 0], [[0, 1], 0], [[0, 2], 2], [[0, 3], 5]], [[[1, 0], 0], [[1, 1], 0], [[1, 2], 0], [[1, 3], 0]], [[[2, 0], 0], [[2, 1], 0], [[2, 2], 0], [[2, 3], 13]], [[[3, 0], 0], [[3, 1], 0], [[3, 2], 0], [[3, 3], 0]], [[[0, 3], 0], [[0, 2], 0], [[0, 1], 2], [[0, 0], 2]], [[[1, 3], 0], [[1, 2], 0], [[1, 1], 0], [[1, 0], 0]], [[[2, 3], 0], [[2, 2], 0], [[2, 1], 0], [[2, 0], 0]], [[[3, 3], 0], [[3, 2], 0...
        line_coords.zip(fused_fibo_vals).each do |(x, y), value|
          set_tile(x, y, value)
        end
      end
    when Direction::LEFT, Direction::RIGHT
      (0...@height).each do |y| # => 0...4, 0...4, 0...4
        line_coords = # => [[0, 0], [1, 0], [2, 0], [3, 0]],                     [[0, 1], [1, 1], [2, 1], [3, 1]],                     [[0, 2], [1, 2], [2, 2], [3, 2]],                      [[0, 3], [1, 3], [2, 3], [3, 3]],                      [[0, 0], [1, 0], [2, 0], [3, 0]],                     [[0, 1], [1, 1], [2, 1], [3, 1]],                     [[0, 2], [1, 2], [2, 2], [3, 2]],                     [[0, 3], [1, 3], [2, 3]...
          (0...@width).map do |x|
            [x, y]
          end
        # => nil,                                                  nil,                                                  nil,                                                   nil,                                                   nil,                                                  nil,                                                  nil,                                                  nil,                   ...
        line_coords.reverse! if pushing_direction == Direction::LEFT
        fibo_vals = # => [0, 0, 1, 2],                                         [1, 0, 1, 0],                                         [0, 8, 5, 0],                                          [0, 5, 8, 0],                                          [0, 1, 2, 3],                                         [0, 3, 2, 1],                                         [0, 0, 0, 0],                                         [0, 5, 3, 5],          ...
          line_coords.map do |coord|
            get_tile(*coord)
          end
        fused_fibo_vals = _do_fibonacci_fusing(fibo_vals) # => [0, 0, 0, 3],                                         [0, 0, 0, 2],                                         [0, 0, 0, 13],                                         [0, 0, 0, 13],                                         [0, 0, 1, 5],                                         [0, 0, 3, 3],                                         [0, 0, 0, 0],                                         [0, 0, 5, 8],          ...
        # => [[[0, 0], 0], [[1, 0], 0], [[2, 0], 0], [[3, 0], 3]], [[[0, 1], 0], [[1, 1], 0], [[2, 1], 0], [[3, 1], 2]], [[[0, 2], 0], [[1, 2], 0], [[2, 2], 0], [[3, 2], 13]], [[[0, 3], 0], [[1, 3], 0], [[2, 3], 0], [[3, 3], 13]], [[[0, 0], 0], [[1, 0], 0], [[2, 0], 1], [[3, 0], 5]], [[[0, 1], 0], [[1, 1], 0], [[2, 1], 3], [[3, 1], 3]], [[[0, 2], 0], [[1, 2], 0], [[2, 2], 0], [[3, 2], 0]], [[[0, 3], 0], [[1, 3], ...
        line_coords.zip(fused_fibo_vals).each do |(x, y), value|
          set_tile(x, y, value)
        end
      end
    end
  end

  def _do_fibonacci_fusing(fibo_vals)
    nb_total_vals = fibo_vals.length       # => 4,      4,  4,    4,  4,      4,      4,      4,      4,         4,         4,  4,         4,      4,      4,  4,      4,            4,  4,  4
    fibo_vals = fibo_vals.reject(&:zero?)  # => [2, 5], [], [13], [], [1, 2], [1, 1], [8, 5], [5, 8], [1, 2, 3], [3, 2, 1], [], [5, 3, 5], [1, 5], [3, 3], [], [5, 8], [1, 1, 1, 1], [], [], []
    processed_fibo_vals = []               # => [],     [], [],   [], [],     [],     [],     [],     [],        [],        [], [],        [],     [],     [], [],     [],           [], [], []

    unless fibo_vals.empty?                         # => false, true, false, true, false, false, false, false, false, false, true, false, false, false, true, false, false, true, true, true
      prev_val = fibo_vals.pop                      # => 5, 13, 2, 1, 5, 8, 3, 1, 5, 5, 3, 8, 1
      until fibo_vals.empty?                        # => false, true, true, false, true, false, true, false, true, false, true, false, false, true, false, false, true, false, false, true, false, true, false, true, false, true, false, false, false, true
        cur_val = fibo_vals.pop                     # => 2,     1,    1,    8,    5,    2,    1,     2,    3,     3,    5,     1,     3,     5,    1,    1,     1
        if @fibonacci.include?(prev_val + cur_val)  # => false, true, true, true, true, true, false, true, false, true, false, false, false, true, true, false, true
          prev_val += cur_val                       # => 3, 2, 13, 13, 5, 3, 8, 13, 2, 2
        else
          processed_fibo_vals.unshift(prev_val)     # => [5], [5], [3], [8], [5], [3], [2]
          prev_val = cur_val                        # => 2,   1,   3,   5,   1,   3,   1
        end
      end
      processed_fibo_vals.unshift(prev_val)         # => [2, 5], [13], [3], [2], [13], [13], [1, 5], [3, 3], [5, 8], [1, 5], [3, 3], [13], [2, 2]
    end

    ([0] * (nb_total_vals - processed_fibo_vals.length)) + processed_fibo_vals # => [0, 0, 2, 5], [0, 0, 0, 0], [0, 0, 0, 13], [0, 0, 0, 0], [0, 0, 0, 3], [0, 0, 0, 2], [0, 0, 0, 13], [0, 0, 0, 13], [0, 0, 1, 5], [0, 0, 3, 3], [0, 0, 0, 0], [0, 0, 5, 8], [0, 0, 1, 5], [0, 0, 3, 3], [0, 0, 0, 0], [0, 0, 0, 13], [0, 0, 2, 2], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]
  end

  def get_description
    # => " 0  0  0  0\n 0  0  0  0\n 2  0  0  0\n 5  0 13  0", " 0  0  0  3\n 0  0  0  2\n 0  0  0 13\n 0  0  0 13", " 0  0  1  5\n 0  0  3  3\n 0  0  0  0\n 0  0  5  8", " 0  0  1  5\n 0  0  3  3\n 0  0  0  0\n 0  0  0 13", " 2  0  0  0\n 2  0  0  0\n 0  0  0  0\n 0  0  0  0"
    @game_area.map do |line|
      line.map do |fib_val|
        format("%2d", fib_val)
      end.join(" ")
    end.join("\n")
  end
end

# Tests
def main
  # Rule 1
  game_area = [
    [2, 0, 0, 0],                                                                                   # => [2, 0, 0, 0]
    [0, 0, 13, 0],                                                                                  # => [0, 0, 13, 0]
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [5, 0, 0, 0]                                                                                    # => [5, 0, 0, 0]
  ]                                                                                                 # => [[2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0], [5, 0, 0, 0]]
  the_2048_bonacci = The2048Bonacci.new(game_area)                                                  # => #<The2048Bonacci:0x000000012a1e7848 @game_area=[[2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0], [5, 0, 0, 0]], @width=4, @height=4, @fibonacci=[1, 1]>
  the_2048_bonacci.process_push(Direction::DOWN)                                                    # => 0...4
  puts the_2048_bonacci.get_description                                                             # => nil
  game_area_test = [
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [2, 0, 0, 0],                                                                                   # => [2, 0, 0, 0]
    [5, 0, 13, 0]                                                                                   # => [5, 0, 13, 0]
  ]                                                                                                 # => [[0, 0, 0, 0], [0, 0, 0, 0], [2, 0, 0, 0], [5, 0, 13, 0]]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test  # => nil

  puts "----" # => nil

  # Rule 2
  game_area = [
    [0, 0, 1, 2],                                                                                   # => [0, 0, 1, 2]
    [1, 0, 1, 0],                                                                                   # => [1, 0, 1, 0]
    [0, 8, 5, 0],                                                                                   # => [0, 8, 5, 0]
    [0, 5, 8, 0]                                                                                    # => [0, 5, 8, 0]
  ]                                                                                                 # => [[0, 0, 1, 2], [1, 0, 1, 0], [0, 8, 5, 0], [0, 5, 8, 0]]
  the_2048_bonacci = The2048Bonacci.new(game_area)                                                  # => #<The2048Bonacci:0x000000011a00faf8 @game_area=[[0, 0, 1, 2], [1, 0, 1, 0], [0, 8, 5, 0], [0, 5, 8, 0]], @width=4, @height=4, @fibonacci=[1, 1]>
  the_2048_bonacci.process_push(Direction::RIGHT)                                                   # => 0...4
  puts the_2048_bonacci.get_description                                                             # => nil
  game_area_test = [
    [0, 0, 0, 3],                                                                                   # => [0, 0, 0, 3]
    [0, 0, 0, 2],                                                                                   # => [0, 0, 0, 2]
    [0, 0, 0, 13],                                                                                  # => [0, 0, 0, 13]
    [0, 0, 0, 13]                                                                                   # => [0, 0, 0, 13]
  ]                                                                                                 # => [[0, 0, 0, 3], [0, 0, 0, 2], [0, 0, 0, 13], [0, 0, 0, 13]]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test  # => nil

  puts "----" # => nil

  # Rule 3
  game_area = [
    [0, 1, 2, 3],                                                                                   # => [0, 1, 2, 3]
    [0, 3, 2, 1],                                                                                   # => [0, 3, 2, 1]
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [0, 5, 3, 5]                                                                                    # => [0, 5, 3, 5]
  ]                                                                                                 # => [[0, 1, 2, 3], [0, 3, 2, 1], [0, 0, 0, 0], [0, 5, 3, 5]]
  the_2048_bonacci = The2048Bonacci.new(game_area)                                                  # => #<The2048Bonacci:0x000000012a206888 @game_area=[[0, 1, 2, 3], [0, 3, 2, 1], [0, 0, 0, 0], [0, 5, 3, 5]], @width=4, @height=4, @fibonacci=[1, 1]>
  the_2048_bonacci.process_push(Direction::RIGHT)                                                   # => 0...4
  puts the_2048_bonacci.get_description                                                             # => nil
  game_area_test = [
    [0, 0, 1, 5],                                                                                   # => [0, 0, 1, 5]
    [0, 0, 3, 3],                                                                                   # => [0, 0, 3, 3]
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [0, 0, 5, 8]                                                                                    # => [0, 0, 5, 8]
  ]                                                                                                 # => [[0, 0, 1, 5], [0, 0, 3, 3], [0, 0, 0, 0], [0, 0, 5, 8]]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test  # => nil

  puts "----"                                                                                       # => nil
  the_2048_bonacci.process_push(Direction::RIGHT)                                                   # => 0...4
  puts the_2048_bonacci.get_description                                                             # => nil
  game_area_test = [
    [0, 0, 1, 5],                                                                                   # => [0, 0, 1, 5]
    [0, 0, 3, 3],                                                                                   # => [0, 0, 3, 3]
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [0, 0, 0, 13]                                                                                   # => [0, 0, 0, 13]
  ]                                                                                                 # => [[0, 0, 1, 5], [0, 0, 3, 3], [0, 0, 0, 0], [0, 0, 0, 13]]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test  # => nil

  puts "----" # => nil

  # Rule 4
  game_area = [
    [1, 0, 0, 0],                                                                                   # => [1, 0, 0, 0]
    [1, 0, 0, 0],                                                                                   # => [1, 0, 0, 0]
    [1, 0, 0, 0],                                                                                   # => [1, 0, 0, 0]
    [1, 0, 0, 0]                                                                                    # => [1, 0, 0, 0]
  ]                                                                                                 # => [[1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0]]
  the_2048_bonacci = The2048Bonacci.new(game_area)                                                  # => #<The2048Bonacci:0x000000012a1dd8c0 @game_area=[[1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0], [1, 0, 0, 0]], @width=4, @height=4, @fibonacci=[1, 1]>
  the_2048_bonacci.process_push(Direction::UP)                                                      # => 0...4
  puts the_2048_bonacci.get_description                                                             # => nil
  game_area_test = [
    [2, 0, 0, 0],                                                                                   # => [2, 0, 0, 0]
    [2, 0, 0, 0],                                                                                   # => [2, 0, 0, 0]
    [0, 0, 0, 0],                                                                                   # => [0, 0, 0, 0]
    [0, 0, 0, 0]                                                                                    # => [0, 0, 0, 0]
  ]                                                                                                 # => [[2, 0, 0, 0], [2, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test  # => nil

  puts "----" # => nil
end

main if __FILE__ == $PROGRAM_NAME # => nil

# >>  0  0  0  0
# >>  0  0  0  0
# >>  2  0  0  0
# >>  5  0 13  0
# >> ----
# >>  0  0  0  3
# >>  0  0  0  2
# >>  0  0  0 13
# >>  0  0  0 13
# >> ----
# >>  0  0  1  5
# >>  0  0  3  3
# >>  0  0  0  0
# >>  0  0  5  8
# >> ----
# >>  0  0  1  5
# >>  0  0  3  3
# >>  0  0  0  0
# >>  0  0  0 13
# >> ----
# >>  2  0  0  0
# >>  2  0  0  0
# >>  0  0  0  0
# >>  0  0  0  0
# >> ----
