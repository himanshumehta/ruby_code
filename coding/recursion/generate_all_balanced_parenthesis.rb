require "set"

OUTPUT = Set.new
OPEN = "("
CLOSE = ")"

def main(input)
  solve(input, input, input, "")
end

def solve(input, open, close, output)
  if open == 0 && close == 0
    OUTPUT << output
    return
  end

  if open != 0
    output_1 = output.clone
    output_1 << OPEN
    solve(input - 1, open - 1, close, output_1)
  end

  if close > open
    output_2 = output.clone
    output_2 << CLOSE
    solve(input, open, close - 1, output_2)
  end

  return
end

p main(3)
p OUTPUT

# >> nil
# >> #<Set: {"((()))", "(()())", "(())()", "()(())", "()()()"}>
