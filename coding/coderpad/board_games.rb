class TilePosError < StandardError; end

Direction = Struct.new(:UP, :UP_RIGHT, :RIGHT, :DOWN_RIGHT, :DOWN, :DOWN_LEFT, :LEFT, :UP_LEFT)
                  .new(0, 1, 2, 3, 4, 5, 6, 7)

ALL_DIRS = Direction.values
CARDINAL_DIRS = ALL_DIRS.select.with_index { |_, i| i.even? }
DIAGONAL_DIRS = ALL_DIRS.select.with_index { |_, i| i.odd? }

class Tile
  attr_accessor :char_data, :adjacencies

  def initialize(char_data = " ")
    @char_data = char_data
    @adjacencies = Array.new(8)
  end

  def get_adjacent(direction)
    adj_tile = @adjacencies[Direction[direction]]
    raise TilePosError if adj_tile.nil?

    adj_tile
  end

  def set_adjacencies(board_owner, x, y)
    direction_offset_coords = [
      [0, 0, -1],  # UP
      [1, 1, -1],  # UP_RIGHT
      [2, 1, 0],   # RIGHT
      [3, 1, 1],   # DOWN_RIGHT
      [4, 0, 1],   # DOWN
      [5, -1, 1],  # DOWN_LEFT
      [6, -1, 0],  # LEFT
      [7, -1, -1]  # UP_LEFT
    ]
    direction_offset_coords.each do |direc, offset_x, offset_y|
      adj_tile = board_owner.get_tile(x + offset_x, y + offset_y)
    rescue TilePosError
    else
      @adjacencies[direc] = adj_tile
    end
  end
end

class Board
  attr_reader :width, :height

  def initialize(width = 1, height = 1, coords_and_sub_boards = nil)
    raise "The width and height must be strictly positive." if width <= 0 || height <= 0

    if coords_and_sub_boards.nil?
      @width = width
      @height = height
      @tiles =
        Array.new(@height) do
          Array.new(@width) do
            Tile.new
          end
        end
    else
      @width, @height = compute_dim(coords_and_sub_boards)
      @tiles = Array.new(@height) { Array.new(@width) }
      coords_and_sub_boards.each { |coords, sub_board| get_tiles_from_sub_board(coords, sub_board) }
      @tiles.each_with_index do |row, y|
        row.each_with_index do |tile, x|
          @tiles[y][x] = Tile.new if tile.nil?
        end
      end
    end

    @height.times do |y|
      @width.times do |x|
        tile = @tiles[y][x]
        tile.set_adjacencies(self, x, y)
      end
    end
  end

  def compute_dim(coords_and_sub_boards)
    x_main = coords_and_sub_boards.map { |coords, sub_board| coords[0] + sub_board.width }.max
    y_main = coords_and_sub_boards.map { |coords, sub_board| coords[1] + sub_board.height }.max
    [x_main, y_main]
  end

  def get_tiles_from_sub_board(coords, sub_board)
    offset_x, offset_y = coords
    sub_board.height.times do |sub_y|
      main_y = sub_y + offset_y
      sub_board.width.times do |sub_x|
        main_x = sub_x + offset_x
        @tiles[main_y][main_x] = sub_board.instance_variable_get(:@tiles)[sub_y][sub_x]
      end
    end
  end

  def get_tile(x, y)
    raise TilePosError if x.negative? || x >= @width || y.negative? || y >= @height

    @tiles[y][x]
  end

  def render
    str_rendered_board = @tiles.map { |row| row.map(&:char_data).join }
    str_rendered_board.join("\n")
  end

  def [](x, y)
    get_tile(x, y)
  end

  def extend(direction, length = 1)
    direction = Direction[direction]

    case direction
    when Direction::UP, Direction::DOWN
      length.times do
        new_line = Array.new(@width) { Tile.new }
        direction == Direction::UP ? @tiles.unshift(new_line) : @tiles.push(new_line)
      end
      @height += length
      y_start = direction == Direction::UP ? 0 : @height - length - 1
      y_end = direction == Direction::UP ? length + 1 : @height
      (y_start...y_end).each do |y|
        @width.times do |x|
          @tiles[y][x].set_adjacencies(self, x, y)
        end
      end

    when Direction::LEFT, Direction::RIGHT
      @height.times do |y|
        tiles_to_add = Array.new(length) { Tile.new }
        direction == Direction::LEFT ? @tiles[y].unshift(*tiles_to_add) : @tiles[y].concat(tiles_to_add)
      end
      @width += length
      x_start = direction == Direction::LEFT ? 0 : @width - length - 1
      x_end = direction == Direction::LEFT ? length + 1 : @width
      @height.times do |y|
        (x_start...x_end).each do |x|
          @tiles[y][x].set_adjacencies(self, x, y)
        end
      end

    else
      cardinal_dirs_from_diag_dir = {
        Direction::UP_RIGHT => [Direction::UP, Direction::RIGHT],
        Direction::DOWN_RIGHT => [Direction::DOWN, Direction::RIGHT],
        Direction::DOWN_LEFT => [Direction::DOWN, Direction::LEFT],
        Direction::UP_LEFT => [Direction::UP, Direction::LEFT]
      }
      dir_vertic, dir_horiz = cardinal_dirs_from_diag_dir[direction]
      extend(dir_vertic, length)
      extend(dir_horiz, length)
    end
  end
end

def set_board_from_string(str_lines, dest_board)
  str_lines.each_with_index do |line, y|
    line.each_char.with_index do |char_data, x|
      dest_board[x, y].char_data = char_data
    end
  end
end

corridor_vertic = Board.new(3, 4)
set_board_from_string(["║.║", "║.║", "║.║", "║.║"], corridor_vertic)

str_lines_horiz = ["════", "....", "════"]
corridor_horiz_1 = Board.new(4, 3)
set_board_from_string(str_lines_horiz, corridor_horiz_1)
corridor_horiz_2 = Board.new(4, 3)
set_board_from_string(str_lines_horiz, corridor_horiz_2)

little_room_up = Board.new(5, 5)
set_board_from_string(["╔╩─╩╗", "║...║", "║...║", "║...║", "╚═══╝"], little_room_up)

little_room_right = Board.new(5, 5)
set_board_from_string(["╔═══╗", "║...╠", "║...│", "║...╠", "╚═══╝"], little_room_right)

big_room = Board.new(7, 7)
set_board_from_string([
                        "╔═╩─╩═╗",
                        "║.o.o.║",
                        "╣.....╠",
                        "│.....│",
                        "╣.....╠",
                        "║.o.o.║",
                        "╚═╦─╦═╝"
                      ], big_room)

space_hulk_main_board = Board.new(coords_and_sub_boards: [
                                    [[0, 1], little_room_right],
                                    [[5, 2], corridor_horiz_1],
                                    [[9, 2], corridor_horiz_2],
                                    [[13, 0], big_room],
                                    [[15, 7], corridor_vertic],
                                    [[14, 11], little_room_up]
                                  ])

render_reference = [
  "             ╔═╩─╩═╗",
  "╔═══╗        ║.o.o.║",
  "║...╠════════╣.....╠",
  "║...│........│.....│",
  "║...╠════════╣.....╠",
  "╚═══╝        ║.o.o.║",
  "             ╚═╦─╦═╝",
  "               ║.║  ",
  "               ║.║  ",
  "               ║.║  ",
  "               ║.║  ",
  "              ╔╩─╩╗ ",
  "              ║...║ ",
  "              ║...║ ",
  "              ║...║ ",
  "              ╚═══╝ "
].join("\n")

render_test = space_hulk_main_board.render
puts render_test
raise "Renders do not match" unless render_test == render_reference
