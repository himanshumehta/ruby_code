class Euclideandistance
  include Math                                                                 # => Euclideandistance
  attr_reader :from, :to                                                       # => nil

  def initialize(from, to)
    @from = from                                                               # => [3, 5]
    @to = to                                                                   # => [9, 15]
  end                                                                          # => :initialize

  def distance
    # First; group the x's and y's, then sum the squared difference in x's and y's
    Math.sqrt(@from.zip(@to).reduce(0) { |sum, p| sum + (p[0] - p[1])**2 }) # => 11.661903789690601
  end                                                                          # => :distance
end                                                                            # => :distance

Euclideandistance.new([3, 5], [9, 15]).distance  # => 11.661903789690601
