require "set"

input = "abc"
OUTPUT = []

def main(input)
  solve(input[1..-1], input[0])
end

def solve(input, output)
  if input.length == 0
    OUTPUT << output
    return
  end

  output_1 = output.clone
  output_2 = output.clone
  output_1 << "_#{input[0]}"
  output_2 << "#{input[0]}"

  solve(input[1..-1], output_1)
  solve(input[1..-1], output_2)
  return
end

p main(input)
p OUTPUT

# >> nil
# >> ["a_b_c", "a_bc", "ab_c", "abc"]
