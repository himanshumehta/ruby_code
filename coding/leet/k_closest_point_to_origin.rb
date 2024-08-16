def k_closest(points, k)
    res = {}
    points.each do |point|
      res[point] = Euclideandistance.new(
            [point[0],point[1]],
            [0,0]
        ).distance
    end
    res
    sorted = Hash[res.sort_by{|k, v| v}].keys
    return sorted.first(k)
end

class Euclideandistance
  include Math
  attr_reader :∫from, :to
  def initialize(from, to)
    @from = from
    @to = to
  end
  def distance
    # First; group the x's and y's, then sum the squared difference in x's and y's
    Math.sqrt(@from.zip(@to).reduce(0) { |sum, p| sum + (p[0] - p[1]) ** 2 })
  end
end

