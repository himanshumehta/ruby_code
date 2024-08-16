CUT_TYPE_X = 0  # => 0
CUT_TYPE_Y = 1  # => 1

class LootItem
  attr_reader :name, :value, :width, :height # => [:name, :value, :width, :height]

  def initialize(name, value, width, height)
    @name = name                              # => "Potion of Potionentiality", "Jeweled Dog Draught Excluder", "Spartan Shield", "Palindromic Sword o'Drows", "Unobsidian Armor", "Wardrobe of Infinite Lions"
    @value = value                            # => 30,                          150,                            300,              120,                         540,                1337
    @width = width                            # => 1,                           3,                              2,                1,                           2,                  20
    @height = height                          # => 1,                           1,                              2,                3,                           3,                  10
  end
end

class Treasure
  def initialize(loot_items)
    @loot_items = loot_items # => [#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, #<LootItem:0x00000001050259f8 @name="Jeweled Dog Draught Excluder", @value=150, @width=3, @height=1>, #<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>, #<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>, #<LootItem:0x0000000105024120 @name="Unobsidian Armor", @value=540, @width...
  end

  def get_best_loot(width, height)
    sized_loot_items = # => [#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>], [],  [#<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>], [],  [],  [#<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>], [#<LootItem:0x0000000105024120 @name="Unobsidian Armor", @value=540, @width=2, @height=...
      @loot_items.select do |item|
        item.width == width && item.height == height
      end
    sized_loot_items.max_by(&:value) # => #<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>,   nil, #<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>,   nil, nil, #<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>,   #<LootItem:0x0000000105024120 @name="Unobsidian Armor", @value=540, @width=2, @height=3...
  end
end

class RPGInventory
  attr_reader :width, :height, :loot_items, :total_value # => [:width, :height, :loot_items, :total_value]

  def initialize(width, height)
    @width = width                                                     # => 1,         1,                  1,                           1,                                    2,                2,                                2,                                                2,                                                                3,                       3,                                              3,                                                                     3,         ...
    @height = height                                                   # => 1,         2,                  3,                           4,                                    1,                2,                                3,                                                4,                                                                1,                       2,                                              3,                                                                     4,         ...
    @occupied_squares = # => [[false]], [[false], [false]], [[false], [false], [false]], [[false], [false], [false], [false]], [[false, false]], [[false, false], [false, false]], [[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false]], [[false, false, false]], [[false, false, false], [false, false, false]], [[false, false, false], [false, false, false], [false, false, false]], [[false, fa...
      Array.new(height) do
        Array.new(width, false)
      end
    @loot_items = []                                                   # => [],        [],                 [],                          [],                                   [],               [],                               [],                                               [],                                                               [],                      [],                                             [],                                                                    [],        ...
    @total_value = 0                                                   # => 0,         0,                  0,                           0,                                    0,                0,                                0,                                                0,                                                                0,                       0,                                              0,                                                                     0,         ...
  end

  def add_loot_item(loot_item, x, y)
    (x...x + loot_item.width).each do |x_cursor| # => 0...1, 0...1, 0...1, 0...1, 0...1, 0...1, 0...1, 1...2, 0...2, 0...2, 0...1, 1...2, 0...2, 0...3, 0...1, 0...1, 1...3, 0...1, 1...3, 0...3, 0...1, 1...3, 0...1, 1...4, 0...2, 2...4, 0...2, 2...4, 0...1, 1...4, 0...2, 2...4, 0...1, 1...2, 2...5, 0...1, 0...1, 1...3, 3...5, 0...1, 1...3, 3...5, 0...1, 0...1, 1...2, 2...5, 1...3, 3...5
      (y...y + loot_item.height).each do |y_cursor| # => 0...1, 0...1, 1...2, 0...3, 0...1, 1...4, 0...1, 0...1, 0...2, 0...2, 0...3, 0...3, 0...1, 0...1, 1...4, 1...4, 0...1, 0...1, 0...1, 0...1, 1...2, 0...2, 0...2, 0...3, 0...3, 0...3, 0...1, 0...1, 0...1, 1...4, 1...4, 1...4, 0...1, 0...1, 0...1, 0...1, 0...2, 0...2, 0...2, 0...2, 0...3, 0...3, 0...3, 0...3, 0...1, 0...1, 0...1, 0...1, 1...4, 1...4, 1...4, 1...4, 0...1, 0...1, 0...1, 0...
        # => nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  ni...
        raise "Trying to add a loot item in an occupied square" if @occupied_squares[y_cursor][x_cursor]

        @occupied_squares[y_cursor][x_cursor] = true # => true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, tr...
      end
    end
    @loot_items << [loot_item, x, y]                                                                      # => [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0], [#<LootItem:0x0000000105026380 @name="Potion of Potionentiality...
    @total_value += loot_item.value                                                                       # => 30,                                                                                                         30,                                                                                                         60,                                                                                                                                                                       ...
  end

  def add_rpg_inventory(rpg_inventory, rpg_x, rpg_y)
    rpg_inventory.loot_items.each do |loot_item, l_ob_x, l_ob_y| # => [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], [[#<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>, 0...
      add_loot_item(loot_item, rpg_x + l_ob_x, rpg_y + l_ob_y) # => 30, 60, 30, 150, 30, 60, 30, 60, 600, 30, 60, 360, 120, 660, 150, 270, 810, 30, 180, 300, 600, 540, 1080, 30, 180, 720, 1260, 30, 60, 210, 30, 60, 360, 660, 120, 660, 1200, 30, 150, 180, 330, 870, 1410
    end
  end

  def get_str_description
    lines = # => [" - Potion of Potionentiality at (0, 0)", " - Palindromic Sword o'Drows at (0, 1)", " - Potion of Potionentiality at (1, 0)", " - Jeweled Dog Draught Excluder at (2, 0)", " - Unobsidian Armor at (1, 1)", " - Unobsidian Armor at (3, 1)"]
      @loot_items.map do |loot_item, l_ob_x, l_ob_y|
        " - #{loot_item.name} at (#{l_ob_x}, #{l_ob_y})"
      end
    lines << "Total value: #{@total_value}"                                                                   # => [" - Potion of Potionentiality at (0, 0)", " - Palindromic Sword o'Drows at (0, 1)", " - Potion of Potionentiality at (1, 0)", " - Jeweled Dog Draught Excluder at (2, 0)", " - Unobsidian Armor at (1, 1)", " - Unobsidian Armor at (3, 1)", "Total value: 1410"]
    lines.join("\n")                                                                                          # => " - Potion of Potionentiality at (0, 0)\n - Palindromic Sword o'Drows at (0, 1)\n - Potion of Potionentiality at (1, 0)\n - Jeweled Dog Draught Excluder at (2, 0)\n - Unobsidian Armor at (1, 1)\n - Unobsidian Armor at (3, 1)\nTotal value: 1410"
  end
end

def iter_on_rect_cuttings(width, height)
  (1..width / 2).each do |x| # => 1..0, 1..0, 1..0, 1..0, 1..1, 1..1, 1..1, 1..1, 1..1, 1..1, 1..1, 1..1, 1..2, 1..2, 1..2, 1..2, 1..2, 1..2, 1..2, 1..2
    yield [x, height], [width - x, height], CUT_TYPE_X # => [[60, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @tota...
  end
  (1..height / 2).each do |y| # => 1..0,                                                                                                                                                                                                                                                                                                                                                                                                                                               ...
    yield [width, y], [width, height - y], CUT_TYPE_Y # => [[60, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @tota...
  end
end

def get_next_rpg_inventory(width, height, best_rpg_inventories, treasure)
  candidates = [] # => [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []
  iter_on_rect_cuttings(width, height) do |dimension_1, dimension_2, cut_type|
    rpg_inv_1 = best_rpg_inventories[dimension_1] # => #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>,                                                                                                                                                                           ...
    rpg_inv_2 = best_rpg_inventories[dimension_2]                                                    # => #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>,                                                                                                                                                                           ...
    candidates << [rpg_inv_1.total_value + rpg_inv_2.total_value, [rpg_inv_1, rpg_inv_2, cut_type]]  # => [[60, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @...
  end

  loot_item_big = treasure.get_best_loot(width, height)     # => #<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, nil, #<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>, nil, nil, #<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>, #<LootItem:0x0000000105024120 @name="Unobsidian Armor", @value=540, @width=2, @height=3>, nil, #<LootItem:0x00000001050259f8 @name="...
  if loot_item_big                                          # => #<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, nil, #<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>, nil, nil, #<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>, #<LootItem:0x0000000105024120 @name="Unobsidian Armor", @value=540, @width=2, @height=3>, nil, #<LootItem:0x00000001050259f8 @name="...
    rpg_inv_big = RPGInventory.new(width, height) # => #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[false]], @loot_items=[], @total_value=0>,                                                                                                                   #<RPGInventory:0x00000001050575c0 @width=1, @height=3, @occupied_squares=[[false], [false], [false]], @loot_items=[], @total_value=0>,                                                                   ...
    rpg_inv_big.add_loot_item(loot_item_big, 0, 0)          # => 30,                                                                                                                                                                                                                                    120,                                                                                                                                                                                                     ...
    candidates << [rpg_inv_big.total_value, [rpg_inv_big]]  # => [[30, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>]]], [[90, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>,...
  end

  # => false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
  return RPGInventory.new(width, height) if candidates.empty?

  best_candidate = candidates.max_by(&:first)                                                   # => [30, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>]], [60, [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality",...
  best_next_rpg_inv_info = best_candidate[1]                                                    # => [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>],       [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @val...
  if best_next_rpg_inv_info.size == 1                                                           # => true,                                                                                                                                                                                                                                false,                                                                                                                                                                 ...
    best_next_rpg_inv_info[0]                                                                   # => #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x00000001050575c0 @width=1, @height=3, @occupied_squares=[[true], [true], [true]], @loot_items=[[#<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows...
  else
    rpg_inv_1, rpg_inv_2, cut_type = best_next_rpg_inv_info                                     # => [#<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @...
    best_next_rpg_inv = RPGInventory.new(width, height)                                         # => #<RPGInventory:0x0000000105047cd8 @width=1, @height=2, @occupied_squares=[[false], [false]], @loot_items=[], @total_value=0>,                                                                                                                                                                                                                                                                               ...
    best_next_rpg_inv.add_rpg_inventory(rpg_inv_1, 0, 0)                                        # => [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]],                                                                                                                                                                                                                                                                                                 ...
    offset_x, offset_y = cut_type == CUT_TYPE_X ? [rpg_inv_1.width, 0] : [0, rpg_inv_1.height]  # => [0, 1],                                                                                                                                                                                                                                                                                                                                                                                                     ...
    best_next_rpg_inv.add_rpg_inventory(rpg_inv_2, offset_x, offset_y)                          # => [[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]],                                                                                                                                                                                                                                                                                                 ...
    best_next_rpg_inv                                                                           # => #<RPGInventory:0x0000000105047cd8 @width=1, @height=2, @occupied_squares=[[true], [true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0], [#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 1]], @total_value=60>,                                                              ...
  end
end

def get_best_rpg_inventory(width, height, treasure)
  best_rpg_inventories = {} # => {}
  (1..width).each do |cur_w| # => 1..5
    (1..height).each do |cur_h| # => 1..4, 1..4, 1..4, 1..4, 1..4
      best_next_rpg_inventory = get_next_rpg_inventory(cur_w, cur_h, best_rpg_inventories, treasure)  # => #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x0000000105047cd8 @width=1, @height=2, @occupied_squares=[[true], [true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality",...
      best_rpg_inventories[[cur_w, cur_h]] = best_next_rpg_inventory                                  # => #<RPGInventory:0x000000010502c410 @width=1, @height=1, @occupied_squares=[[true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0]], @total_value=30>, #<RPGInventory:0x0000000105047cd8 @width=1, @height=2, @occupied_squares=[[true], [true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality",...
    end
  end
  best_rpg_inventories[[width, height]] # => #<RPGInventory:0x00000001050648b0 @width=5, @height=4, @occupied_squares=[[true, true, true, true, true], [true, true, true, true, true], [true, true, true, true, true], [true, true, true, true, true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0], [#<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @v...
end

def main
  treasure = Treasure.new([ # => Treasure
                            LootItem.new("Potion of Potionentiality", 30, 1, 1), # => #<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>
                            LootItem.new("Jeweled Dog Draught Excluder", 150, 3, 1),   # => #<LootItem:0x00000001050259f8 @name="Jeweled Dog Draught Excluder", @value=150, @width=3, @height=1>
                            LootItem.new("Spartan Shield", 300, 2, 2),                 # => #<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>
                            LootItem.new("Palindromic Sword o'Drows", 120, 1, 3),      # => #<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>
                            LootItem.new("Unobsidian Armor", 540, 2, 3),               # => #<LootItem:0x0000000105024120 @name="Unobsidian Armor", @value=540, @width=2, @height=3>
                            LootItem.new("Wardrobe of Infinite Lions", 1337, 20, 10)   # => #<LootItem:0x000000010502f8b8 @name="Wardrobe of Infinite Lions", @value=1337, @width=20, @height=10>
                          ]) # => #<Treasure:0x000000010502f048 @loot_items=[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, #<LootItem:0x00000001050259f8 @name="Jeweled Dog Draught Excluder", @value=150, @width=3, @height=1>, #<LootItem:0x00000001050251b0 @name="Spartan Shield", @value=300, @width=2, @height=2>, #<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>,...
  best_rpg_inventory = get_best_rpg_inventory(5, 4, treasure)  # => #<RPGInventory:0x00000001050648b0 @width=5, @height=4, @occupied_squares=[[true, true, true, true, true], [true, true, true, true, true], [true, true, true, true, true], [true, true, true, true, true]], @loot_items=[[#<LootItem:0x0000000105026380 @name="Potion of Potionentiality", @value=30, @width=1, @height=1>, 0, 0], [#<LootItem:0x0000000105024968 @name="Palindromic Sword o'Drows", @value=120, @width=1, @height=3>, 0, 1], ...
  puts best_rpg_inventory.get_str_description                  # => nil
end

main # => nil

# >>  - Potion of Potionentiality at (0, 0)
# >>  - Palindromic Sword o'Drows at (0, 1)
# >>  - Potion of Potionentiality at (1, 0)
# >>  - Jeweled Dog Draught Excluder at (2, 0)
# >>  - Unobsidian Armor at (1, 1)
# >>  - Unobsidian Armor at (3, 1)
# >> Total value: 1410
