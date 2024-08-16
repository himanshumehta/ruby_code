def find_missing_page(page_numbers)
  pages_qty = page_numbers.length + 1 # => 10, 1, 10, 5000

  # Apply the formula to calculate the sum of all pages
  sum_page_complete = ((pages_qty**2) + pages_qty) / 2 # => 55, 1, 55, 12502500

  # Sum all the remaining page numbers
  sum_page_partial = page_numbers.sum # => 47, 0, 45, 12498258

  # Return the difference between the complete sum and the partial sum
  (sum_page_complete - sum_page_partial).to_i # => 8, 1, 10, 4242
end

# Test cases
# Nominal case, little thesis
missing_page = find_missing_page([4, 6, 1, 3, 7, 9, 10, 2, 5])  # => 8
puts "Missing page: #{missing_page}, Expected: 8"               # => nil

# The thesis has only one page
missing_page = find_missing_page([])               # => 1
puts "Missing page: #{missing_page}, Expected: 1"  # => nil

# The missing page is the last one
missing_page = find_missing_page([3, 4, 6, 7, 9, 1, 2, 5, 8])  # => 10
puts "Missing page: #{missing_page}, Expected: 10"             # => nil

# Real case, with 5000 pages
expected_missing_page = 4242                                              # => 4242
page_numbers = (1..5000).to_a                                             # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, ...
page_numbers.delete(expected_missing_page)                                # => 4242
missing_page = find_missing_page(page_numbers)                            # => 4242
puts "Missing page: #{missing_page}, Expected: #{expected_missing_page}"  # => nil

# >> Missing page: 8, Expected: 8
# >> Missing page: 1, Expected: 1
# >> Missing page: 10, Expected: 10
# >> Missing page: 4242, Expected: 4242
