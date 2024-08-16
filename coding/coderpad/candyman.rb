class CandyStick
  attr_reader :size, :color # => [:size, :color]

  def initialize(size, color)
    @size = size                                                                   # => 1,     2,     3,     4,     5,     6,     7,     8,     9,     10,    11,    12,    13,    14,    15,    16,    17,    18,    19,    20,    21,    22,    23,    24,    1,       2,       3,       4,       5,       6,       7,       8
    @color = color                                                                 # => "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "red", "green", "green", "green", "green", "green", "green", "green", "green"
    # => nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     nil,     nil,     nil,     nil,     nil,     nil,     nil
    raise "The color must be red or green." unless %w[red green].include?(@color)
  end
end

class CandyMan
  def initialize
    @candy_sticks = []     # => []
    @sum_sizes = 0         # => 0
    @nb_red_candies = 0    # => 0
    @nb_green_candies = 0  # => 0
  end

  def add_candy(candy_stick)
    @candy_sticks << candy_stick    # => [#<CandyStick:0x000000013d8e2798 @size=1, @color="red">], [#<CandyStick:0x000000013d8e2798 @size=1, @color="red">, #<CandyStick:0x000000013d8e1848 @size=2, @color="red">], [#<CandyStick:0x000000013d8e2798 @size=1, @color="red">, #<CandyStick:0x000000013d8e1848 @size=2, @color="red">, #<CandyStick:0x000000013d8e0b00 @size=3, @color="red">], [#<CandyStick:0x000000013d8e2798 @size=1, @color="red">, #<CandyStick:0x000000013d8e1848 @size=2, @color="red">, #...
    @sum_sizes += candy_stick.size  # => 1,                                                        3,                                                                                                                6,                                                                                                                                                                        10,                                                                                                               ...
    if candy_stick.color == "red"   # => true,                                                     true,                                                                                                             true,                                                                                                                                                                     true,                                                                                                             ...
      @nb_red_candies += 1          # => 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
    else
      @nb_green_candies += 1        # => 1, 2, 3, 4, 5, 6, 7, 8
    end
  end

  def get_a_random_candy
    check_candy_sticks_in_bag                  # => nil
    chosen_candy_stick = @candy_sticks.sample  # => #<CandyStick:0x000000013d8f09d8 @size=11, @color="red">
    @candy_sticks.delete(chosen_candy_stick)   # => #<CandyStick:0x000000013d8f09d8 @size=11, @color="red">
    @sum_sizes -= chosen_candy_stick.size      # => 325
    if chosen_candy_stick.color == "red"       # => true
      @nb_red_candies -= 1 # => 23
    else
      @nb_green_candies -= 1
    end
    chosen_candy_stick # => #<CandyStick:0x000000013d8f09d8 @size=11, @color="red">
  end

  def get_average_size
    check_candy_sticks_in_bag                               # => nil,  nil,  nil
    nb_total_candies = @nb_red_candies + @nb_green_candies  # => 32,   32,   31
    @sum_sizes.to_f / nb_total_candies                      # => 10.5, 10.5, 10.483870967741936
  end

  def get_red_candy_chance
    check_candy_sticks_in_bag                               # => nil,  nil,  nil
    nb_total_candies = @nb_red_candies + @nb_green_candies  # => 32,   32,   31
    @nb_red_candies.to_f / nb_total_candies                 # => 0.75, 0.75, 0.7419354838709677
  end

  private # => CandyMan

  def check_candy_sticks_in_bag
    raise "There are no candy sticks in the bag." if @candy_sticks.empty? # => nil, nil, nil, nil, nil, nil, nil
  end
end

# Test cases
candy_man = CandyMan.new                                                   # => #<CandyMan:0x000000013d8e3198 @candy_sticks=[], @sum_sizes=0, @nb_red_candies=0, @nb_green_candies=0>
(1..24).each { |size| candy_man.add_candy(CandyStick.new(size, "red")) }   # => 1..24
(1..8).each { |size| candy_man.add_candy(CandyStick.new(size, "green")) }  # => 1..8

puts "Average size: #{candy_man.get_average_size}"          # => nil
puts "Red candy chance: #{candy_man.get_red_candy_chance}"  # => nil

raise "Expected average size 10.5, but got #{candy_man.get_average_size}" unless candy_man.get_average_size == 10.5
unless candy_man.get_red_candy_chance == 0.75
  raise "Expected red candy chance 0.75, but got #{candy_man.get_red_candy_chance}"
end

chosen_candy = candy_man.get_a_random_candy # => #<CandyStick:0x000000013d8f09d8 @size=11, @color="red">

expected_average_size = (336.0 - chosen_candy.size) / 31                                                                                                  # => 10.483870967741936
puts "Expected average size after removing a candy: #{expected_average_size}"                                                                             # => nil
unless candy_man.get_average_size == expected_average_size
  raise "Expected average size #{expected_average_size}, but got #{candy_man.get_average_size}"
end

expected_red_candy_chance = if chosen_candy.color == "red" # => true
                              23.0 / 31 # => 0.7419354838709677
                            else
                              24.0 / 31
                            end
puts "Expected red candy chance after removing a candy: #{expected_red_candy_chance}" # => nil
unless candy_man.get_red_candy_chance == expected_red_candy_chance
  raise "Expected red candy chance #{expected_red_candy_chance}, but got #{candy_man.get_red_candy_chance}"
end

# >> Average size: 10.5
# >> Red candy chance: 0.75
# >> Expected average size after removing a candy: 10.483870967741936
# >> Expected red candy chance after removing a candy: 0.7419354838709677
