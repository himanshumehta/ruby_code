# Problem statement - https://app.coderpad.io/NEYPQ62D
class PlateIndexer
  def initialize(plates)
    @stackstart = {}                                           # => {}
    plates.each_with_index do |plate, idx|                     # => ["flower-decorated plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "transparent plate"]
      @stackstart[plate] = idx unless @stackstart.key?(plate) # => 0, 1, nil, 3, nil, 5
    end
    @stacksize = plates.length # => 6
  end

  def get_insertion_details(plate1, plate2 = nil)
    if plate2.nil? # => true, false, false, false
      @stacksize += 1                                            # => 7
      insertion_index = @stackstart[plate1]                      # => 3
      @stackstart.each do |plate_type, index|                    # => {"flower-decorated plate"=>0, "light green plate"=>1, "big blue plate"=>3, "transparent plate"=>5}
        @stackstart[plate_type] += 1 if index > insertion_index # => nil, nil, nil, 6
      end
      return insertion_index, false # => false
    end

    @stacksize += 2                                                 # => 9,                11,                  13
    should_invert = @stackstart[plate1] > @stackstart[plate2]       # => false,            false,               true
    highest_group = # => "big blue plate", "light green plate", "transparent plate"
      [plate1, plate2].max_by do |x|
        @stackstart[x]
      end
    insertion_index = @stackstart[highest_group]               # => 3,                                                                                                  1,                                                                                                  10
    @stackstart.each do |plate_type, index|                    # => {"flower-decorated plate"=>0, "light green plate"=>1, "big blue plate"=>3, "transparent plate"=>6}, {"flower-decorated plate"=>0, "light green plate"=>1, "big blue plate"=>3, "transparent plate"=>8}, {"flower-decorated plate"=>0, "light green plate"=>2, "big blue plate"=>5, "transparent plate"=>10}
      @stackstart[plate_type] += 2 if index > insertion_index
    end

    @stackstart[highest_group] += 1 if plate1 != plate2 # => nil, 2, 11

    [insertion_index, should_invert] # => false, false, true
  end

  def reconstruct_plate_pile
    curr_idx = 0                                           # => 0
    curr_plate = nil                                       # => nil
    result = []                                            # => []
    @stackstart.each do |plate, idx|                       # => {"flower-decorated plate"=>0, "light green plate"=>2, "big blue plate"=>5, "transparent plate"=>11}
      result.concat([curr_plate] * (idx - curr_idx))       # => [],                       ["flower-decorated plate", "flower-decorated plate"], ["flower-decorated plate", "flower-decorated plate", "light green plate", "light green plate", "light green plate"], ["flower-decorated plate", "flower-decorated plate", "light green plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate"]
      curr_plate = plate                                   # => "flower-decorated plate", "light green plate",                                  "big blue plate",                                                                                                    "transparent plate"
      curr_idx = idx                                       # => 0,                        2,                                                    5,                                                                                                                   11
    end
    result.concat([curr_plate] * (@stacksize - curr_idx))  # => ["flower-decorated plate", "flower-decorated plate", "light green plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "transparent plate", "transparent plate"]
    result                                                 # => ["flower-decorated plate", "flower-decorated plate", "light green plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "transparent plate", "transparent plate"]
  end
end

def main
  plates = [
    "flower-decorated plate", # => "flower-decorated plate"
    "light green plate",                                  # => "light green plate"
    "light green plate",                                  # => "light green plate"
    "big blue plate",                                     # => "big blue plate"
    "big blue plate",                                     # => "big blue plate"
    "transparent plate"                                   # => "transparent plate"
  ] # => ["flower-decorated plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "transparent plate"]
  plate_indexer = PlateIndexer.new(plates)                # => #<PlateIndexer:0x000000014f9ad440 @stackstart={"flower-decorated plate"=>0, "light green plate"=>1, "big blue plate"=>3, "transparent plate"=>5}, @stacksize=6>
  puts plate_indexer.instance_variable_get(:@stackstart)  # => nil

  insertion_details = plate_indexer.get_insertion_details("big blue plate")                               # => [3, false]
  assert_equal([3, false], insertion_details)                                                             # => nil
  insertion_details = plate_indexer.get_insertion_details("big blue plate", "big blue plate")             # => [3, false]
  assert_equal([3, false], insertion_details)                                                             # => nil
  insertion_details = plate_indexer.get_insertion_details("flower-decorated plate", "light green plate")  # => [1, false]
  assert_equal([1, false], insertion_details)                                                             # => nil
  insertion_details = plate_indexer.get_insertion_details("transparent plate", "big blue plate")          # => [10, true]
  assert_equal([10, true], insertion_details)                                                             # => nil

  puts plate_indexer.instance_variable_get(:@stackstart)       # => nil
  reconstructed_plates = plate_indexer.reconstruct_plate_pile  # => ["flower-decorated plate", "flower-decorated plate", "light green plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "transparent plate", "transparent plate"]
  reconstructed_plates.each do |plate|                         # => ["flower-decorated plate", "flower-decorated plate", "light green plate", "light green plate", "light green plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "big blue plate", "transparent plate", "transparent plate"]
    puts plate # => nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  assert_equal([
                 "flower-decorated plate", # => "flower-decorated plate"
                 "flower-decorated plate",                                  # => "flower-decorated plate"
                 "light green plate",                                       # => "light green plate"
                 "light green plate",                                       # => "light green plate"
                 "light green plate",                                       # => "light green plate"
                 "big blue plate",                                          # => "big blue plate"
                 "big blue plate",                                          # => "big blue plate"
                 "big blue plate",                                          # => "big blue plate"
                 "big blue plate",                                          # => "big blue plate"
                 "big blue plate",                                          # => "big blue plate"
                 "big blue plate",                                          # => "big blue plate"
                 "transparent plate",                                       # => "transparent plate"
                 "transparent plate"                                        # => "transparent plate"
               ], reconstructed_plates) # => nil
end

def assert_equal(expected, actual)
  # => nil, nil, nil, nil, nil
  raise "Assertion failed: Expected #{expected}, but got #{actual}" unless expected == actual
end

main if __FILE__ == $PROGRAM_NAME # => nil

# >> {"flower-decorated plate"=>0, "light green plate"=>1, "big blue plate"=>3, "transparent plate"=>5}
# >> {"flower-decorated plate"=>0, "light green plate"=>2, "big blue plate"=>5, "transparent plate"=>11}
# >> flower-decorated plate
# >> flower-decorated plate
# >> light green plate
# >> light green plate
# >> light green plate
# >> big blue plate
# >> big blue plate
# >> big blue plate
# >> big blue plate
# >> big blue plate
# >> big blue plate
# >> transparent plate
# >> transparent plate
