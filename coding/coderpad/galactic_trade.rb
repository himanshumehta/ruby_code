require 'set'
require 'cmath'

PLANET_FOOD = 0
PLANET_METAL = 1

class Planet
  attr_reader :p_type, :name, :coordinates, :distances, :trade_routed_planets

  def initialize(p_type, name, coordinates)
    @p_type = p_type
    @name = name
    @coordinates = coordinates
    @distances = {}
    @trade_routed_planets = []
  end

  def calculate_distances(universe)
    s_x, s_y, s_z = @coordinates
    universe.planets.each do |other_planet|
      if other_planet.p_type != @p_type
        o_x, o_y, o_z = other_planet.coordinates
        square_dist = (o_x - s_x)**2 + (o_y - s_y)**2 + (o_z - s_z)**2
        dist = CMath.sqrt(square_dist)
        @distances[other_planet] = dist
      end
    end
  end

  def linked?
    !@trade_routed_planets.empty?
  end
end

class Universe
  attr_reader :planets, :planets_food

  def initialize(planets)
    @planets = planets
    @planets.each { |planet| planet.calculate_distances(self) }
    @planets_food = @planets.select { |planet| planet.p_type == PLANET_FOOD }
  end

  def establish_trade_route(planet_1, planet_2)
    if planet_1.p_type == planet_2.p_type
      raise "Trade route between two planets of same type is useless."
    end

    if planet_2.trade_routed_planets.include?(planet_1) ||
       planet_1.trade_routed_planets.include?(planet_2)
      raise "There is already a trade route between these two planets."
    end

    planet_1.trade_routed_planets << planet_2
    planet_2.trade_routed_planets << planet_1
  end

  def remove_trade_route(planet_1, planet_2)
    unless planet_2.trade_routed_planets.include?(planet_1) &&
           planet_1.trade_routed_planets.include?(planet_2)
      raise "Trying to remove a trade route that do not exist."
    end

    planet_1.trade_routed_planets.delete(planet_2)
    planet_2.trade_routed_planets.delete(planet_1)
  end

  def solve_greedy_from_nothing
    all_distances_food_metal = []
    @planets_food.each do |planet_food|
      planet_food.distances.each do |planet_metal, dist|
        all_distances_food_metal << [planet_food, planet_metal, dist]
      end
    end
    all_distances_food_metal.sort_by! { |_, _, dist| dist }

    all_distances_food_metal.each do |planet_food, planet_metal, _|
      unless planet_food.linked? && planet_metal.linked?
        establish_trade_route(planet_food, planet_metal)
      end
    end
  end

  def do_local_heuristic(p_food_1, p_metal_1, p_food_2, p_metal_2)
    return false if p_food_1 == p_food_2 || p_metal_1 == p_metal_2

    changed_something = false
    if p_metal_2.trade_routed_planets.include?(p_food_1)
      remove_trade_route(p_food_1, p_metal_2)
      changed_something = true
    end
    if p_metal_1.trade_routed_planets.include?(p_food_2)
      remove_trade_route(p_food_2, p_metal_1)
      changed_something = true
    end

    current_dist = p_food_1.distances[p_metal_1] + p_food_2.distances[p_metal_2]
    possible_dist = p_food_1.distances[p_metal_2] + p_food_2.distances[p_metal_1]

    if possible_dist < current_dist
      remove_trade_route(p_food_1, p_metal_1)
      remove_trade_route(p_food_2, p_metal_2)
      establish_trade_route(p_food_1, p_metal_2)
      establish_trade_route(p_food_2, p_metal_1)
      changed_something = true
    end

    changed_something
  end

  def do_one_global_heuristic
    @planets_food.each_with_index do |p_food_1, index|
      @planets_food[index + 1..-1].each do |p_food_2|
        p_food_1.trade_routed_planets.each do |p_metal_1|
          p_food_2.trade_routed_planets.each do |p_metal_2|
            return true if do_local_heuristic(p_food_1, p_metal_1, p_food_2, p_metal_2)
          end
        end
      end
    end
    false
  end

  def do_global_random_heuristic(nb_consecutive_tries_max = 10, nb_modif_max = 100)
    nb_consecutive_tries = 0
    nb_modif = 0
    while nb_consecutive_tries < nb_consecutive_tries_max && nb_modif < nb_modif_max
      p_food_1, p_food_2 = @planets_food.sample(2)
      p_metal_1 = p_food_1.trade_routed_planets.sample
      p_metal_2 = p_food_2.trade_routed_planets.sample

      if do_local_heuristic(p_food_1, p_metal_1, p_food_2, p_metal_2)
        nb_consecutive_tries = 0
        nb_modif += 1
      else
        nb_consecutive_tries += 1
      end
    end
    nb_modif
  end

  def do_global_systematic_heuristic(nb_modif_max = 100)
    nb_modif_max.times do
      break unless do_one_global_heuristic
    end
  end

  def check_solution
    @planets.each do |planet|
      raise "The planet #{planet.name} is not linked." unless planet.linked?
    end
  end

  def print_solution
    sum_dist = 0
    @planets_food.each do |planet_food|
      planet_food.trade_routed_planets.each do |planet_metal|
        dist = planet_food.distances[planet_metal]
        puts " - #{planet_food.name}-#{planet_metal.name} : #{dist}"
        sum_dist += dist
      end
    end
    puts "Total distance: #{sum_dist}"
  end
end

def generate_random_planets(p_type, planet_qty)
  planet_prefix = p_type == PLANET_FOOD ? 'F' : 'M'
  Array.new(planet_qty) do |index|
    Planet.new(
      p_type,
      "#{planet_prefix}#{index.to_s.rjust(3, '0')}",
      [rand(5001), rand(5001), rand(5001)]
    )
  end
end

def main
  nominal_planets = [
    Planet.new(PLANET_FOOD, 'F001', [50, 50, 50]),
    Planet.new(PLANET_FOOD, 'F002', [50, 150, 50]),
    Planet.new(PLANET_METAL, 'M003', [50, 50, 90]),
    Planet.new(PLANET_FOOD, 'F101', [1000, 0, 0]),
    Planet.new(PLANET_FOOD, 'F102', [1000, 10, 0]),
    Planet.new(PLANET_METAL, 'M103', [1000, 0, 70]),
    Planet.new(PLANET_METAL, 'M104', [1000, 10, 70]),
    Planet.new(PLANET_FOOD, 'F201', [0, 0, 2000]),
    Planet.new(PLANET_FOOD, 'F202', [30, -100, 2000]),
    Planet.new(PLANET_METAL, 'M203', [30, 0, 2000]),
    Planet.new(PLANET_METAL, 'M204', [0, 100, 2000])
  ]
  random_planets_food = generate_random_planets(PLANET_FOOD, 50)
  random_planets_metal = generate_random_planets(PLANET_METAL, 50)
  planets = random_planets_food + random_planets_metal

  universe = Universe.new(planets)
  universe.solve_greedy_from_nothing
  universe.check_solution
  universe.print_solution
  puts "-" * 10
  puts "Doing random heuristic."
  nb_modif_made = universe.do_global_random_heuristic
  puts "-" * 10
  puts "Doing systematic heuristic."
  universe.do_global_systematic_heuristic(100 - nb_modif_made) if nb_modif_made < 100
  puts "-" * 10
  universe.check_solution
  universe.print_solution
end

main if __FILE__ == $
