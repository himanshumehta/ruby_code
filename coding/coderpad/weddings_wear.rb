require "set" # => true

class Wedding
  attr_reader :name, :persons, :linked_weddings  # => [:name, :persons, :linked_weddings]
  attr_accessor :hat                             # => [:hat, :hat=]

  def initialize(name, persons)
    @name = name                 # => "Wedding of A&S",                                                                                 "Wedding of B&L",                                          "Wedding of C&R"
    @persons = persons.to_set    # => #<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, #<Set: {"Chloe Bradford", "Casey Lowery", "Ray Solomon"}>, #<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>
    @hat = nil                   # => nil,                                                                                              nil,                                                       nil
    @linked_weddings = []        # => [],                                                                                               [],                                                        []
  end

  def establish_links(all_weddings)
    all_weddings.each do |other_wedding| # => [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=nil, @linked_weddings=[]>, #<Wedding:0x000000012a9f5e90 @name="Wedding of B&L", @persons=#<Set: {"Chloe Bradford", "Casey Lowery", "Ray Solomon"}>, @hat=nil, @linked_weddings=[]>, #<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @person...
      # => true, false, false, false, true, false, false, false, true
      next if name == other_wedding.name

      # => nil, [#<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>, @hat=nil, @linked_weddings=[]>], nil, nil, [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=nil, @linked_weddings=[#<Wedding:0x000000012a9f5670 @name="Wedding of ...
      @linked_weddings << other_wedding if persons.intersect?(other_wedding.persons)
    end
  end

  def print_linked_weddings
    nb_links = linked_weddings.size
    puts "#{name} has #{nb_links} linked weddings."
    linked_weddings.each { |wedding| puts " - #{wedding.name}" }
  end
end

def choose_hats(wedding_data)
  all_weddings = # => [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=nil, @linked_weddings=[]>, #<Wedding:0x000000012a9f5e90 @name="Wedding of B&L", @persons=#<Set: {"Chloe Bradford", "Casey Lowery", "Ray Solomon"}>, @hat=nil, @linked_weddings=[]>, #<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<...
    wedding_data.map do |name, persons|
      Wedding.new(name, persons)
    end
  # => [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=nil, @linked_weddings=[#<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>, @hat=nil, @linked_weddings=[#<Wedding:0x000000012a9f6bb0 ...>]>]>, #<Wedding:0x000000012a9f5e90 @nam...
  all_weddings.each do |wedding|
    wedding.establish_links(all_weddings)
  end
  global_hat_list = [] # => []

  while all_weddings.any? { |wedding| wedding.hat.nil? } # => true, true, true, false
    wedding = # => [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=nil, @linked_weddings=[#<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>, @hat=nil, @linked_weddings=[#<Wedding:0x000000012a9f6bb0 ...>]>]>, #<Wedding:0x000000012a9f5e90 @name="Wedding...
      all_weddings.select do |w|
        w.hat.nil?
      end.max_by do |w|
        linked_hats = w.linked_weddings.map(&:hat).compact.uniq # => [],     [],     [],     [],     [0],    []
        [linked_hats.size, # => [0, 1], [0, 0], [0, 1], [0, 0], [1, 0], [0, 0]
         w.linked_weddings.count do |lw|
           lw.hat.nil?
         end]
      end

    linked_hats = wedding.linked_weddings.map(&:hat).compact                        # => [],  [0],    []
    new_hat = (0...global_hat_list.size).find { |hat| !linked_hats.include?(hat) }  # => nil, nil,    0
    new_hat = global_hat_list.size if new_hat.nil?                                  # => 0,   1,      nil
    global_hat_list << new_hat if new_hat == global_hat_list.size                   # => [0], [0, 1], nil
    wedding.hat = new_hat                                                           # => 0,   1,      0
  end

  [global_hat_list.size, all_weddings] # => [2, [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=0, @linked_weddings=[#<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>, @hat=1, @linked_weddings=[#<Wedding:0x000000012a9f6bb0 ...>]>]>, #<Wedding:0x000000012a9f5e90 @name="Wedding of B&L", @persons=#<Set: {"Chlo...
end

# Test cases
wedding_data = [
  ["Wedding of A&S", ["Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"]], # => ["Wedding of A&S", ["Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"]]
  ["Wedding of B&L", ["Chloe Bradford", "Casey Lowery", "Ray Solomon"]],                                         # => ["Wedding of B&L", ["Chloe Bradford", "Casey Lowery", "Ray Solomon"]]
  ["Wedding of C&R", ["Alex Cline", "Garrett Rose", "Gerald Shepherd"]]                                          # => ["Wedding of C&R", ["Alex Cline", "Garrett Rose", "Gerald Shepherd"]]
]                                                                                                                # => [["Wedding of A&S", ["Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"]], ["Wedding of B&L", ["Chloe Bradford", "Casey Lowery", "Ray Solomon"]], ["Wedding of C&R", ["Alex Cline", "Garrett Rose", "Gerald Shepherd"]]]
global_hat_qty, all_weddings = choose_hats(wedding_data)                                                         # => [2, [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=0, @linked_weddings=[#<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>, @hat=1, @linked_weddings=[#<Wedding:0x000000012a9f6bb0 ...>]>]>, #<...
puts "Test case 1:"                                                                                              # => nil
puts "Global hat quantity: #{global_hat_qty}"                                                                    # => nil
# => [#<Wedding:0x000000012a9f6bb0 @name="Wedding of A&S", @persons=#<Set: {"Robert Arias", "Calvin Booth", "Marlie Coffey", "Gerald Shepherd", "Jazmyn Schroeder"}>, @hat=0, @linked_weddings=[#<Wedding:0x000000012a9f5670 @name="Wedding of C&R", @persons=#<Set: {"Alex Cline", "Garrett Rose", "Gerald Shepherd"}>, @hat=1, @linked_weddings=[#<Wedding:0x000000012a9f6bb0 ...>]>]>, #<Wedd...
all_weddings.each do |wedding|
  puts "#{wedding.name}: hat number #{wedding.hat}"
end
# => nil
raise "Expected 2 hats, but got #{global_hat_qty}" unless global_hat_qty == 2
# => nil
raise "Expected hat 0 for Wedding of A&S, but got #{all_weddings[0].hat}" unless all_weddings[0].hat.zero?
# => nil
raise "Expected hat 0 for Wedding of B&L, but got #{all_weddings[1].hat}" unless all_weddings[1].hat.zero?
# => nil
raise "Expected hat 1 for Wedding of C&R, but got #{all_weddings[2].hat}" unless all_weddings[2].hat == 1

# Rest of the test cases...

# >> Test case 1:
# >> Global hat quantity: 2
# >> Wedding of A&S: hat number 0
# >> Wedding of B&L: hat number 0
# >> Wedding of C&R: hat number 1
