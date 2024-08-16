require "set"

input = "aab"
OUTPUT = Set.new

def main(input)
  solve(input, "")
end

def solve(input, output)
  if input.length == 0
    OUTPUT << output
    return
  end
  # p ["BEFORE input, output, output_1, output_2", input, output, nil, nil]
  output_1 = output.clone
  output_2 = output.clone
  remove = input.slice!(0)
  output_2 << remove
  # p ["AFTER input, output, output_1, output_2", input, output, output_1, output_2]
  solve(input.dup, output_1.dup)
  solve(input.dup, output_2.dup)
  return
end

p main(input)
p OUTPUT

# >> nil
# >> #<Set: {"", "b", "a", "ab", "aa", "aab"}>
