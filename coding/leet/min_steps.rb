def min_steps(n)
	return 0 if n ==1
	return n if n < 5
	return min_steps(n/2) + 2 if n.even?
	return min_odd_steps(n) unless n.even?
end

def min_odd_steps(n)
	if prime?(n)
		return n
	else
		smallest_divisor = smallest_odd_divisor(n)
		return smallest_divisor + min_steps(n/smallest_divisor)
	end
end

def prime?(num)
	return false if num <= 1
  	Math.sqrt(num).to_i.downto(2).each {|i| return false if num % i == 0}
  	true
end

def smallest_odd_divisor(n)
 	sanum = (3..n).step(2).each do |num|
 		num
  		break num if n % num == 0
	end
	return sanum
end

def even?(n)
	n % 2 == o
end

p min_steps(54)

# 1+1

# >> 11
