# module Direction
#   UP = :up        # => :up
#   DOWN = :down    # => :down
#   LEFT = :left    # => :left
#   RIGHT = :right  # => :right
# end               # => :right

# class The2048Bonacci
#   def initialize(game_area)
#     @game_area = game_area         # => [[2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0], [5, 0, 0, 0]]
#     @width = @game_area[0].length  # => 4
#     @height = @game_area.length    # => 4
#     @fibonacci = [1, 1]            # => [1, 1]
#   end                              # => :initialize

#   def _init_fibonacci
#     max_val = @game_area.flatten.max
#     @fibonacci << (@fibonacci[-1] + @fibonacci[-2]) while @fibonacci[-1] <= max_val
#   end                                                                                # => :_init_fibonacci

#   def get_tile(x, y)
#     @game_area[y][x]
#   end                 # => :get_tile

#   def set_tile(x, y, value)
#     @game_area[y][x] = value
#   end                         # => :set_tile

#   def _iterate_on_line_coords(pushing_direction)
#     case pushing_direction                        # => :right
#     when Direction::DOWN, Direction::UP
#       (0...@width).each do |x|
#         puts "width: #{x}"
#         # process each column
#       end
#     when Direction::LEFT, Direction::RIGHT
#       (0...@height).each do |y|                   # => 0...4
#         puts "height: #{y}"                       # => nil, nil, nil, nil
#         # process each row
#       end                                         # => 0...4
#     end                                           # => 0...4
#   end                                             # => :_iterate_on_line_coords
# end                                               # => :_iterate_on_line_coords

# game_area = [
#   [2, 0, 0, 0],   # => [2, 0, 0, 0]
#   [0, 0, 13, 0],  # => [0, 0, 13, 0]
#   [0, 0, 0, 0],   # => [0, 0, 0, 0]
#   [5, 0, 0, 0]    # => [5, 0, 0, 0]
# ]                 # => [[2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0], [5, 0, 0, 0]]

# (0...3).each do |width|  # => 0...3
#   p game_area[width]     # => [2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0]
# end                      # => 0...3

# game = The2048Bonacci.new(game_area)            # => #<The2048Bonacci:0x000000011e1d71e8 @game_area=[[2, 0, 0, 0], [0, 0, 13, 0], [0, 0, 0, 0], [5, 0, 0, 0]], @width=4, @height=4, @fibonacci=[1, 1]>
# puts "/n"                                       # => nil
# game._iterate_on_line_coords(Direction::RIGHT)  # => 0...4

# # >> [2, 0, 0, 0]
# # >> [0, 0, 13, 0]
# # >> [0, 0, 0, 0]
# # >> /n
# # >> height: 0
# # >> height: 1
# # >> height: 2
# # >> height: 3

# Define the Fibonacci sequence and example input
fibonacci_sequence = [1, 1, 2, 3, 5, 8, 13, 21]  # => [1, 1, 2, 3, 5, 8, 13, 21]
fibo_vals = [0, 1, 2, 3]                         # => [0, 1, 2, 3]
processed_fibo_vals = []                         # => []

unless fibo_vals.empty?                                 # => false
  prev_val = fibo_vals.pop                              # => 3
  until fibo_vals.empty?                                # => false, false, false, true
    cur_val = fibo_vals.pop                             # => 2,    1,     0
    if fibonacci_sequence.include?(prev_val + cur_val)  # => true, false, true
      prev_val += cur_val                               # => 5, 1
    else
      processed_fibo_vals.unshift(prev_val)             # => [5]
      prev_val = cur_val                                # => 1
    end
  end
  puts prev_val                                         # => nil
  puts processed_fibo_vals                              # => nil
  processed_fibo_vals.unshift(prev_val)                 # => [1, 5]
end

puts "Processed Fibonacci Values: #{processed_fibo_vals.inspect}" # => nil

# >> a: 3
# >> 1
# >> 5
# >> Processed Fibonacci Values: [1, 5]
