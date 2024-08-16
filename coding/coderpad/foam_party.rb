class RectangularCuboid
  attr_reader :x1, :x2, :y1, :y2, :z1, :z2 # => [:x1, :x2, :y1, :y2, :z1, :z2]

  def initialize(x1, y1, z1, x2, y2, z2)
    @x1, @x2 = [x1, x2].sort              # => [0, 95.6],  [10.1, 20.5],   [70.4, 79.6],   [0, 95.6],  [10.1, 20.5],   [17.4, 26.6],   [0, 70],  [10, 15],   [11.1, 14.4],   [0, 70],  [0, 70],  [0, 70]
    @y1, @y2 = [y1, y2].sort              # => [0, 301.3], [80.1, 120.9],  [210.0, 220.7], [0, 301.3], [80.1, 120.9],  [115.0, 125.7], [0, 400], [20, 26],   [22.2, 25.5],   [0, 400], [0, 400], [0, 400]
    @z1, @z2 = [z1, z2].sort              # => [0, 200.7], [190.4, 200.7], [185.4, 200.7], [0, 200.7], [190.4, 200.7], [179.4, 194.7], [0, 250], [230, 250], [233.3, 249.9], [0, 250], [0, 250], [0, 250]
  end

  def volume
    (@x2 - @x1) * (@y2 - @y1) * (@z2 - @z1) # => 5781018.995999999, 4370.495999999994, 1506.1319999999948, 5781018.995999999, 4370.495999999994, 1506.1319999999992, 7000000, 600, 180.774, 7000000, 7000000, 7000000
  end
end

def overlapping_length(coord1_min, coord1_max, coord2_min, coord2_max)
  overlap_min = [coord1_min, coord2_min].max                            # => 70.4, 210.0, 190.4,              17.4,               115.0,             190.4,             11.1,               22.2,               233.3,              0,  0,   0
  overlap_max = [coord1_max, coord2_max].min                            # => 20.5, 120.9, 200.7,              20.5,               120.9,             194.7,             14.4,               25.5,               249.9,              70, 400, 250
  overlap_min >= overlap_max ? 0 : overlap_max - overlap_min            # => 0,    0,     10.299999999999983, 3.1000000000000014, 5.900000000000006, 4.299999999999983, 3.3000000000000007, 3.3000000000000007, 16.599999999999994, 70, 400, 250
end

def intersecting_volume(cuboid1, cuboid2)
  overlapping_length_x = overlapping_length(cuboid1.x1, cuboid1.x2, cuboid2.x1, cuboid2.x2)  # => 0,                  3.1000000000000014, 3.3000000000000007, 70
  overlapping_length_y = overlapping_length(cuboid1.y1, cuboid1.y2, cuboid2.y1, cuboid2.y2)  # => 0,                  5.900000000000006,  3.3000000000000007, 400
  overlapping_length_z = overlapping_length(cuboid1.z1, cuboid1.z2, cuboid2.z1, cuboid2.z2)  # => 10.299999999999983, 4.299999999999983,  16.599999999999994, 250
  overlapping_length_x * overlapping_length_y * overlapping_length_z                         # => 0.0,                78.6469999999998,   180.774,            7000000
end

def compute_foam_volume(
  garage_size_x, garage_size_y, garage_size_z,
  first_box_x1, first_box_y1, first_box_z1,
  first_box_x2, first_box_y2, first_box_z2,
  second_box_x1, second_box_y1, second_box_z1,
  second_box_x2, second_box_y2, second_box_z2
)
  garage_cuboid = RectangularCuboid.new(0, 0, 0, garage_size_x, garage_size_y, garage_size_z)                                          # => #<RectangularCuboid:0x000000012784a5f8 @x1=0, @x2=95.6, @y1=0, @y2=301.3, @z1=0, @z2=200.7>,            #<RectangularCuboid:0x000000012781bb40 @x1=0, @x2=95.6, @y1=0, @y2=301.3, @z1=0, @z2=200.7>,            #<RectangularCuboid:0x000000011500f918 @x1=0, @x2=70, @y1=0, @y2=400, @z1=0, @z2=250>,                #<RectangularCuboid:0x0000000115017460 @x1=0, @...
  first_box_cuboid = RectangularCuboid.new(first_box_x1, first_box_y1, first_box_z1, first_box_x2, first_box_y2, first_box_z2)         # => #<RectangularCuboid:0x00000001278490b8 @x1=10.1, @x2=20.5, @y1=80.1, @y2=120.9, @z1=190.4, @z2=200.7>,  #<RectangularCuboid:0x0000000127818c10 @x1=10.1, @x2=20.5, @y1=80.1, @y2=120.9, @z1=190.4, @z2=200.7>,  #<RectangularCuboid:0x000000011500efe0 @x1=10, @x2=15, @y1=20, @y2=26, @z1=230, @z2=250>,             #<RectangularCuboid:0x0000000115016b28 @x1=0, @...
  second_box_cuboid = RectangularCuboid.new(second_box_x1, second_box_y1, second_box_z1, second_box_x2, second_box_y2, second_box_z2)  # => #<RectangularCuboid:0x0000000127832868 @x1=70.4, @x2=79.6, @y1=210.0, @y2=220.7, @z1=185.4, @z2=200.7>, #<RectangularCuboid:0x0000000125114b78 @x1=17.4, @x2=26.6, @y1=115.0, @y2=125.7, @z1=179.4, @z2=194.7>, #<RectangularCuboid:0x000000011500e6a8 @x1=11.1, @x2=14.4, @y1=22.2, @y2=25.5, @z1=233.3, @z2=249.9>, #<RectangularCuboid:0x00000001150161f0 @x1=0, @...
  intersecting_volume = intersecting_volume(first_box_cuboid, second_box_cuboid)                                                       # => 0.0,                                                                                                    78.6469999999998,                                                                                       180.774,                                                                                              7000000

  garage_cuboid.volume - first_box_cuboid.volume - second_box_cuboid.volume + intersecting_volume # => 5775142.367999999, 5775221.014999999, 6999400.0, 0
end

# Tests
def main
  # No overlapping
  foam_volume = compute_foam_volume(
    95.6, 301.3, 200.7,                                                # => 200.7
    20.5, 80.1, 190.4,                                                 # => 190.4
    10.1, 120.9, 200.7,                                                # => 200.7
    70.4, 220.7, 185.4,                                                # => 185.4
    79.6, 210.0, 200.7 # => 200.7
  )                                                                    # => 5775142.367999999
  puts foam_volume                                                     # => nil
  raise "Test failed" unless (foam_volume - 5_775_142.368).abs < 0.0001 # => nil

  puts "Test 1 passed" # => nil

  # Overlapping on a corner
  foam_volume = compute_foam_volume(
    95.6, 301.3, 200.7,                                                # => 200.7
    20.5, 80.1, 190.4,                                                 # => 190.4
    10.1, 120.9, 200.7,                                                # => 200.7
    17.4, 125.7, 179.4,                                                # => 179.4
    26.6, 115.0, 194.7 # => 194.7
  )                                                                    # => 5775221.014999999
  puts foam_volume                                                     # => nil
  raise "Test failed" unless (foam_volume - 5_775_221.015).abs < 0.0001 # => nil

  puts "Test 2 passed" # => nil

  # One box inside another
  foam_volume = compute_foam_volume(
    70, 400, 250,                                    # => 250
    10, 20, 230,                                     # => 230
    15, 26, 250,                                     # => 250
    11.1, 22.2, 233.3,                               # => 233.3
    14.4, 25.5, 249.9 # => 249.9
  )                                                  # => 6999400.0
  puts foam_volume                                   # => nil
  raise "Test failed" unless foam_volume == 6_999_400 # => nil

  puts "Test 3 passed" # => nil

  # My garage consists of two giant embedded cardboard boxes!!
  foam_volume = compute_foam_volume(
    70, 400, 250,                              # => 250
    0, 0, 0,                                   # => 0
    70, 400, 250,                              # => 250
    0, 0, 0,                                   # => 0
    70, 400, 250 # => 250
  )                                            # => 0
  puts foam_volume                             # => nil
  raise "Test failed" unless foam_volume.zero? # => nil

  puts "Test 4 passed" # => nil
end

main if __FILE__ == $PROGRAM_NAME # => nil

# >> 5775142.367999999
# >> Test 1 passed
# >> 5775221.014999999
# >> Test 2 passed
# >> 6999400.0
# >> Test 3 passed
# >> 0
# >> Test 4 passed
