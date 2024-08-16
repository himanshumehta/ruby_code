module Direction
  UP = :up
  DOWN = :down
  LEFT = :left
  RIGHT = :right
end

class The2048Bonacci
  def initialize(game_area)
    @game_area = game_area
    @width = @game_area[0].length
    @height = @game_area.length
    @fibonacci = [1, 1]
  end

  def _init_fibonacci
    max_val = @game_area.flatten.max
    @fibonacci << (@fibonacci[-1] + @fibonacci[-2]) while @fibonacci[-1] <= max_val
  end

  def get_tile(x, y)
    @game_area[y][x]
  end

  def set_tile(x, y, value)
    @game_area[y][x] = value
  end

  def _iterate_on_line_coords(pushing_direction)
    case pushing_direction
    when Direction::DOWN, Direction::UP
      coord_ys = (0...@height).to_a
      coord_ys.reverse! if pushing_direction == Direction::UP
      coord_ys.each do |y|
        (0...@width).each do |x|
          yield x, y
        end
      end
    when Direction::LEFT, Direction::RIGHT
      coord_xs = (0...@width).to_a
      coord_xs.reverse! if pushing_direction == Direction::LEFT
      coord_xs.each do |x|
        (0...@height).each do |y|
          yield x, y
        end
      end
    end
  end

  def _do_fibonacci_fusing(fibo_vals)
    nb_total_vals = fibo_vals.length
    fibo_vals = fibo_vals.reject(&:zero?)
    processed_fibo_vals = []

    unless fibo_vals.empty?
      prev_val = fibo_vals.pop
      while !fibo_vals.empty?
        cur_val = fibo_vals.pop
        if @fibonacci.include?(prev_val + cur_val)
          prev_val += cur_val
        else
          processed_fibo_vals.unshift(prev_val)
          prev_val = cur_val
        end
      end
      processed_fibo_vals.unshift(prev_val)
    end

    ([0] * (nb_total_vals - processed_fibo_vals.length)) + processed_fibo_vals
  end

  def process_push(pushing_direction)
    _init_fibonacci
    case pushing_direction
    when Direction::DOWN, Direction::UP
      (0...@width).each do |x|
        line_coords = (0...@height).map { |y| [x, y] }
        line_coords.reverse! if pushing_direction == Direction::UP
        fibo_vals = line_coords.map { |coord| get_tile(*coord) }
        fused_fibo_vals = _do_fibonacci_fusing(fibo_vals)
        line_coords.zip(fused_fibo_vals).each { |(x, y), value| set_tile(x, y, value) }
      end
    when Direction::LEFT, Direction::RIGHT
      (0...@height).each do |y|
        line_coords = (0...@width).map { |x| [x, y] }
        line_coords.reverse! if pushing_direction == Direction::LEFT
        fibo_vals = line_coords.map { |coord| get_tile(*coord) }
        fused_fibo_vals = _do_fibonacci_fusing(fibo_vals)
        line_coords.zip(fused_fibo_vals).each { |(x, y), value| set_tile(x, y, value) }
      end
    end
  end

  def get_description
    @game_area.map { |line| line.map { |fib_val| format("%2d", fib_val) }.join(" ") }.join("\n")
  end
end

# Tests
def main
  # Rule 1
  game_area = [
    [2, 0, 0, 0],
    [0, 0, 13, 0],
    [0, 0, 0, 0],
    [5, 0, 0, 0]
  ]
  the_2048_bonacci = The2048Bonacci.new(game_area)
  the_2048_bonacci.process_push(Direction::DOWN)
  puts the_2048_bonacci.get_description
  game_area_test = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [2, 0, 0, 0],
    [5, 0, 13, 0]
  ]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test
  puts "----"

  # Rule 2
  game_area = [
    [0, 0, 1, 2],
    [1, 0, 1, 0],
    [0, 8, 5, 0],
    [0, 5, 8, 0]
  ]
  the_2048_bonacci = The2048Bonacci.new(game_area)
  the_2048_bonacci.process_push(Direction::RIGHT)
  puts the_2048_bonacci.get_description
  game_area_test = [
    [0, 0, 0, 3],
    [0, 0, 0, 2],
    [0, 0, 0, 13],
    [0, 0, 0, 13]
  ]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test
  puts "----"

  # Rule 3
  game_area = [
    [0, 1, 2, 3],
    [0, 3, 2, 1],
    [0, 0, 0, 0],
    [0, 5, 3, 5]
  ]
  the_2048_bonacci = The2048Bonacci.new(game_area)
  the_2048_bonacci.process_push(Direction::RIGHT)
  puts the_2048_bonacci.get_description
  game_area_test = [
    [0, 0, 1, 5],
    [0, 0, 3, 3],
    [0, 0, 0, 0],
    [0, 0, 5, 8]
  ]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test
  puts "----"
  the_2048_bonacci.process_push(Direction::RIGHT)
  puts the_2048_bonacci.get_description
  game_area_test = [
    [0, 0, 1, 5],
    [0, 0, 3, 3],
    [0, 0, 0, 0],
    [0, 0, 0, 13]
  ]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test
  puts "----"

  # Rule 4
  game_area = [
    [1, 0, 0, 0],
    [1, 0, 0, 0],
    [1, 0, 0, 0],
    [1, 0, 0, 0]
  ]
  the_2048_bonacci = The2048Bonacci.new(game_area)
  the_2048_bonacci.process_push(Direction::UP)
  puts the_2048_bonacci.get_description
  game_area_test = [
    [2, 0, 0, 0],
    [2, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0]
  ]
  raise "Test failed" unless the_2048_bonacci.instance_variable_get(:@game_area) == game_area_test
  puts "----"
end

main if __FILE__ == $PROGRAM_NAME
