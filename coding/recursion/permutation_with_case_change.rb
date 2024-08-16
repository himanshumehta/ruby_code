require "set"

input = "ab"
OUTPUT = []

def main(input)
  solve(input, "")
end

def solve(input, output)
  if input.length == 0
    OUTPUT << output
    return
  end

  output_1 = output.clone
  output_2 = output.clone
  output_1 << "#{input[0].swapcase}"
  output_2 << "#{input[0]}"

  solve(input[1..-1], output_1)
  solve(input[1..-1], output_2)
  return
end

p main(input)
p OUTPUT

# >> nil
# >> ["AB", "Ab", "aB", "ab"]
