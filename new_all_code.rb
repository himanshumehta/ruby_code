# Start of ./low_level_design/play_ruby.rb
for i in 1..13 do
    p i
end

# >> 1
# >> 2
# >> 3
# >> 4
# >> 5
# >> 6
# >> 7
# >> 8
# >> 9
# >> 10
# >> 11
# >> 12
# >> 13

# File in ruby
p File.write("test.txt", "hello")
p File.read("test.txt")
p Dir.pwd
p Dir.glob("*.txt")
p Dir.glob("*.rb")
p File.expand_path("test.txt")
puts File.dirname("/Users/hmehta/playground/low_level_design/test.txt")
puts __FILE__

p File.join("foo", "bar")
# => "foo/bar"
p ["foo", "bar"].join("/")
# => "foo/bar"
p File.join("foo/", "bar")
# => "foo/bar"
p ["foo/", "bar"].join("/")
# => "foo//bar"

p File.join(File.dirname(File.expand_path(__FILE__)))
# "/Users/hmehta/playground"

# >> 5
# >> "hello"
# >> "/Users/hmehta/playground/low_level_design"
# >> ["test.txt"]
# >> ["ruby_files.rb", "mutex.rb", "lld.rb", "cache_service.rb", "in_memory_file_system.rb", "parking_lot.rb", "prefix_trie.rb", "notification_service.rb", "simple_ruby_app_with_db.rb", "queue_script_spec.rb", "unit_spec.rb", "simple_document_service.rb", "top_trending_topic.rb"]
# >> "/Users/hmehta/playground/low_level_design/test.txt"
# >> /Users/hmehta/playground/low_level_design
# >> ruby_files.rb
# >> "foo/bar"
# >> "foo/bar"
# >> "foo/bar"
# >> "foo//bar"

# Ruby syntactic sugar
## Arithmetic and Comparison Operators as Method Calls
# For instance, an addition:
a + b   # is syntactically sugar for
a.+(b)

# This applies to other operators like ==, !=, <, >, <=, >=, <=>, ===, &, |, *, /,
# -, %, **, >>, <<, !==, =~, and !~ as well.

## Logical and Bitwise Not
# Negation:
!a      # is the same as
a.!()

# And bitwise NOT:
~a      # becomes
a.~()

## Unary Plus and Minus
# Unary operations:
+a      # is shorthand for
a.+@()

# And unary minus:
-a      # is interpreted as
a.-@()

## The `call` Method
# Invoking procs:
a.(b)   # is equivalent to
a.call(b)

## Setters and Getters
# Attribute assignment:
a.foo = b   # is the syntactic sugar for
a.foo=(b)

## Indexing and Index Assignment
# Array and Hash access:
a[b]    # is the same as
a.[](b)

# And for setting an element's value:
a[b] = c    # translates to
a.[]=(b, c)

