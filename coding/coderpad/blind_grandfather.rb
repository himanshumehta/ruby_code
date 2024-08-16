def get_nb_books_to_reverse(books)
  left = 0                          # => 0
  right = books.length - 1          # => 6

  while left < right                             # => true, true, true, false
    mid = (left + right) / 2                     # => 3,    5,     4
    if books[mid].downcase <= books[0].downcase  # => true, false, false
      left = mid + 1                             # => 4
    else
      right = mid                                # => 5, 4
    end
  end

  books[left].downcase > books[0].downcase ? left : 0 # => 4
end

# Test case
bumped_book_pile = [
  "Harry Potter and the Prisoner of Azkaban",  # => "Harry Potter and the Prisoner of Azkaban"
  "Gone With the Wind",                        # => "Gone With the Wind"
  "Frankenstein or The Modern Prometheus",     # => "Frankenstein or The Modern Prometheus"
  "Band of Brothers",                          # => "Band of Brothers"
  "The Caves of Steel",                        # => "The Caves of Steel"
  "The Grapes of Wrath",                       # => "The Grapes of Wrath"
  "Ubik"                                       # => "Ubik"
]                                              # => ["Harry Potter and the Prisoner of Azkaban", "Gone With the Wind", "Frankenstein or The Modern Prometheus", "Band of Brothers", "The Caves of Steel", "The Grapes of Wrath", "Ubik"]

nb_books_to_reverse = get_nb_books_to_reverse(bumped_book_pile)                     # => 4
puts nb_books_to_reverse                                                            # => nil
raise "Expected 4, but got #{nb_books_to_reverse}" unless nb_books_to_reverse == 4  # => nil

# >> 4
