class Excel
  attr_accessor :r, :c, :data, :formulas

  def initialize(r, c)
    @r, @c = decodeCord(r, c)
    rows = @r + 1
    cols = @c + 1
    @data = Array.new(rows, 0) { Array.new(cols, 0) }
    @formulas = {}
  end

  def decodeCord(r, c)
    return r.to_i - 1, c.ord - "A".ord + 1
  end

  def set(r, c, v)
    r, c = decodeCord(r, c)
    @data[r][c] = v
    if @formulas[r] && @formulas[r][c]
      @formulas[r][c] = nil
    end
  end

  def get(r, c)
    r, c = decodeCord(r, c)
    if @formulas[r] && @formulas[r][c]
      return computeFormula(r, c)
    end
    return @data[r][c]
  end

  def computeFormula(r, c)
    ans = 0
    @formulas[r][c].each do |str|
      startI, startJ, endI, endJ = parseRange(str)
      for i in startI..(endI)
        for j in startJ..(endJ)
          if @formulas[i] && @formulas[i][j]
            ans += computeFormula(i, j)
          else
            ans += @data[i][j]
          end
        end
      end
    end
    return ans
  end

  def parseRange(str)
    start_str = str
    end_str = str
    if str.include? ":"
      start_str = str.split(":")[0]
      end_str = str.split(":")[1]
    end
    startI, startJ = decodeCord(start_str[1..-1], start_str[0])
    endI, endJ = decodeCord(end_str[1..-1], end_str[0])
    return startI, startJ, endI, endJ
  end

  def sum(r, c, strs)
    r, c = decodeCord(r, c)
    if @formulas[r]
      @formulas[r].merge!({ c => strs })
    else
      @formulas[r] = { c => strs }
    end
    return computeFormula(r, c)
  end
end

obj = Excel.new(5, "E")
p obj.set(1, "A", 5)
p obj.data
p obj.set(1, "B", 3)
p obj.set(1, "C", 2)
p obj.sum(1, "C", ["A1", "A1:B1"])
p obj.data
p obj.formulas
p obj.get(1, "C")
p obj.set(1, "B", 5)
p obj.get(1, "C")
p obj.sum(1, "B", ["A1:A5"])
p obj.formulas
p obj.set(5, "A", 10)
p obj.get(1, "B")
p obj.data
p obj.get(1, "C")
p obj.data
p obj.sum(3, "C", ["A1:C1", "A1:A5"])
p obj.data
p obj.formulas
p obj.set(3, "A", 3)
p obj.get(1, "B")
p obj.get(1, "C")
p obj.get(3, "C")
p obj.get(5, "A")
