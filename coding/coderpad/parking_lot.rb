class ParkingLot
  attr_reader :motorcycle_spots, :compact_spots, :regular_spots # => [:motorcycle_spots, :compact_spots, :regular_spots]

  def initialize(motorcycle_spots, compact_spots, regular_spots)
    @motorcycle_spots = motorcycle_spots                          # => 10
    @compact_spots = compact_spots                                # => 20
    @regular_spots = regular_spots                                # => 30
    @occupied_motorcycle_spots = 0                                # => 0
    @occupied_compact_spots = 0                                   # => 0
    @occupied_regular_spots = 0                                   # => 0
    @occupied_van_spots = 0                                       # => 0
  end

  def park_vehicle(vehicle)
    case vehicle.type # => :motorcycle, :car, :van
    when :motorcycle
      park_motorcycle(vehicle)      # => 1
    when :car
      park_car(vehicle)             # => 1
    when :van
      park_van(vehicle)             # => 1
    else
      raise "Invalid vehicle type"
    end
  end

  def park_motorcycle(_motorcycle)
    if @occupied_motorcycle_spots < @motorcycle_spots # => true
      @occupied_motorcycle_spots += 1 # => 1
    elsif @occupied_compact_spots < @compact_spots
      @occupied_compact_spots += 1
    elsif @occupied_regular_spots < @regular_spots
      @occupied_regular_spots += 1
    else
      raise "No available spots for motorcycle"
    end
  end

  def park_car(_car)
    if @occupied_compact_spots < @compact_spots # => true
      @occupied_compact_spots += 1 # => 1
    elsif @occupied_regular_spots < @regular_spots
      @occupied_regular_spots += 1
    else
      raise "No available spots for car"
    end
  end

  def park_van(_van)
    raise "No available spots for van" unless @occupied_regular_spots + 3 <= @regular_spots # => true

    @occupied_regular_spots += 3                    # => 3
    @occupied_van_spots += 1                        # => 1
  end

  def spots_remaining
    total_spots - occupied_spots # => 55, 55
  end

  def total_spots
    @motorcycle_spots + @compact_spots + @regular_spots # => 60, 60, 60
  end

  def occupied_spots
    @occupied_motorcycle_spots + @occupied_compact_spots + @occupied_regular_spots # => 5, 5, 5
  end

  def full?
    spots_remaining.zero? # => false
  end

  def empty?
    occupied_spots.zero? # => false
  end

  def motorcycle_spots_full?
    @occupied_motorcycle_spots == @motorcycle_spots # => false
  end

  def van_spots_occupied
    @occupied_van_spots # => 1
  end
end

class Vehicle
  attr_reader :type # => [:type]

  def initialize(type)
    @type = type # => :motorcycle, :car, :van
  end
end

# Example usage
parking_lot = ParkingLot.new(10, 20, 30) # => #<ParkingLot:0x000000013383ff48 @motorcycle_spots=10, @compact_spots=20, @regular_spots=30, @occupied_motorcycle_spots=0, @occupied_compact_spots=0, @occupied_regular_spots=0, @occupied_van_spots=0>

motorcycle = Vehicle.new(:motorcycle)  # => #<Vehicle:0x000000013382ff80 @type=:motorcycle>
car = Vehicle.new(:car)                # => #<Vehicle:0x000000013382f3f0 @type=:car>
van = Vehicle.new(:van)                # => #<Vehicle:0x000000013382eab8 @type=:van>

parking_lot.park_vehicle(motorcycle)  # => 1
parking_lot.park_vehicle(car)         # => 1
parking_lot.park_vehicle(van)         # => 1

puts "Spots remaining: #{parking_lot.spots_remaining}"                   # => nil
puts "Total spots: #{parking_lot.total_spots}"                           # => nil
puts "Is parking lot full? #{parking_lot.full?}"                         # => nil
puts "Is parking lot empty? #{parking_lot.empty?}"                       # => nil
puts "Are motorcycle spots full? #{parking_lot.motorcycle_spots_full?}"  # => nil
puts "Number of van spots occupied: #{parking_lot.van_spots_occupied}"   # => nil

# >> Spots remaining: 55
# >> Total spots: 60
# >> Is parking lot full? false
# >> Is parking lot empty? false
# >> Are motorcycle spots full? false
# >> Number of van spots occupied: 1
