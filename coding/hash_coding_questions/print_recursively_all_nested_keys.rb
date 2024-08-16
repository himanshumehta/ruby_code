data = {
  "a" => {
    "b" => {
      "c" => [],
    },
    "d" => {},
  },
  "e" => "e",
  "f" => nil,
  "g" => -2,
}

def recursive_keys(data)
  # data.keys + data.values.map { |value| recursive_keys(value) if value.is_a?(Hash) }
  data.keys + data.values.map { |i| recursive_keys(i) if i.is_a? Hash }
end

def all_keys(data)
  recursive_keys(data).flatten.compact.uniq
end

pp all_keys(data)

# >> ["a", "e", "f", "g", "b", "d", "c"]
