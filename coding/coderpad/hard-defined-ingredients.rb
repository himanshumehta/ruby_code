class Ingredient
  attr_accessor :current_quantity, :max_storage_capacity, :needed_quantity # => [:current_quantity, :current_quantity=, :max_storage_capacity, :max_storage_capacity=, :needed_quantity, :needed_quantity=]

  def initialize(needed_quantity = 1)
    @current_quantity = 0               # => 0, 0, 0, 0
    @max_storage_capacity = 0           # => 0, 0, 0, 0
    @needed_quantity = needed_quantity  # => 2, 1, 1, 3
  end
end

def compute_storage_capacities(ingredients_log, ingredients_recipe = { "bread" => 1, "cheese" => 1, "ham" => 1 })
  ingredient_simulation = # => {"bread"=>#<Ingredient:0x000000014e15f2a8 @current_quantity=0, @max_storage_capacity=0, @needed_quantity=2>, "cheese"=>#<Ingredient:0x000000014e15d890 @current_quantity=0, @max_storage_capacity=0, @needed_quantity=1>, "ham"=>#<Ingredient:0x000000014e15cb98 @current_quantity=0, @max_storage_capacity=0, @needed_quantity=1>, "tomatoes"=>#<Ingredient:0x000000014e157a80 @curren...
    ingredients_recipe.transform_values do |needed_quantity|
      Ingredient.new(needed_quantity)
    end
  ingredients_log.each do |ingredient_name| # => ["bread", "bread", "bread", "ham", "cheese", "ham", "tomatoes", "ham", "bread", "tomatoes", "tomatoes", "cheese"]
    current_ingr = ingredient_simulation[ingredient_name] # => #<Ingredient:0x000000014e15f2a8 @current_quantity=0, @max_storage_capacity=0, @needed_quantity=2>, #<Ingredient:0x000000014e15f2a8 @current_quantity=1, @max_storage_capacity=1, @needed_quantity=2>, #<Ingredient:0x000000014e15f2a8 @current_quantity=2, @max_storage_capacity=2, @needed_quantity=2>, #<Ingredient:0x000000014e15cb98 @current_quantity=0, @max_storage_capacity=0, @needed_quantity=1>, #<Ingredient:0x00000001...
    # => nil,                                                                                               nil,                                                                                               nil,                                                                                               nil,                                                                                               nil,                   ...
    raise "Unknown ingredient: #{ingredient_name}!" unless current_ingr

    current_ingr.current_quantity += 1                                               # => 1,     2,    3,     1,    1,    2,     1,     3,     4,     2,     3,    1
    must_check_cook = current_ingr.current_quantity == current_ingr.needed_quantity  # => false, true, false, true, true, false, false, false, false, false, true, true

    cooking_confirmed = false                                                                                     # => false, false, false, false, false, false, false, false, false, false, false, false
    if must_check_cook                                                                                            # => false, true,  false, true,  true,  false, false, false, false, false, true,  true
      quantities_ok = # => false, false, false, true, false
        ingredient_simulation.values.all? do |ingr|
          ingr.current_quantity >= ingr.needed_quantity
        end
      cooking_confirmed = quantities_ok                                                                           # => false, false, false, true, false
    end

    if cooking_confirmed                                                                                          # => false, false, false, false, false, false, false, false, false, false, true, false
      # => {"bread"=>#<Ingredient:0x000000014e15f2a8 @current_quantity=2, @max_storage_capacity=4, @needed_quantity=2>, "cheese"=>#<Ingredient:0x000000014e15d890 @current_quantity=0, @max_storage_capacity=1, @needed_quantity=1>, "ham"=>#<Ingredient:0x000000014e15cb98 @current_quantity=2, @max_storage_capacity=3, @needed_quantity=1>, "tomatoes"=>#<Ingredient:0x000000014e157a80 @current_q...
      ingredient_simulation.each_value do |ingr|
        ingr.current_quantity -= ingr.needed_quantity
      end
    else
      current_ingr.max_storage_capacity = [current_ingr.max_storage_capacity, current_ingr.current_quantity].max # => 1, 2, 3, 1, 1, 2, 1, 3, 4, 2, 1
    end
  end

  ingredient_simulation.transform_values(&:max_storage_capacity) # => {"bread"=>4, "cheese"=>1, "ham"=>3, "tomatoes"=>2}
end

ingredients_log = %w[bread bread bread ham cheese ham tomatoes ham bread tomatoes tomatoes cheese]                      # => ["bread", "bread", "bread", "ham", "cheese", "ham", "tomatoes", "ham", "bread", "tomatoes", "tomatoes", "cheese"]
capacities = compute_storage_capacities(ingredients_log, { "bread" => 2, "cheese" => 1, "ham" => 1, "tomatoes" => 3 })  # => {"bread"=>4, "cheese"=>1, "ham"=>3, "tomatoes"=>2}
puts capacities.inspect # Expected output: {"bread"=>4, "cheese"=>1, "ham"=>3, "tomatoes"=>2}

# >> {"bread"=>4, "cheese"=>1, "ham"=>3, "tomatoes"=>2}
