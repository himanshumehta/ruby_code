# Calculates the nth Fibonacci number using the closed-form formula
def fib_closed_form(n)
  sqrt5 = Math.sqrt(5)
  phi = (1 + sqrt5) / 2
  return ((phi**n - (1 - phi)**n) / sqrt5).round
end

puts fib_closed_form(6) # Output: 8