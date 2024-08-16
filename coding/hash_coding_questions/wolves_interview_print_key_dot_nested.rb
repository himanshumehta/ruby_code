def recursive_keys(data)
    data.keys + data.values.map { |value| recursive_keys(value) if value.is_a?(Hash) }
  end
  
  def all_keys(data)
    result = []
    data.each do |key, value|
      if value.is_a?(Hash)
        value.each do |child_key, child_value|
          keys = recursive_keys(child_value).flatten.compact.uniq
          result << if keys == []
                      "#{key}.#{child_key}"
                    else
                      "#{key}.#{child_key}.#{keys.join('.')}"
                    end
        end
      else
        result << key
      end
    end
    result.reverse
end
  
data = {
    "a" => {
      "b" => {
        "c" => []
      },
      "d" => {}
    },
    "e" => "e",
    "f" => nil,
    "g" => -2
  }
  
pp all_keys(data)

# >> ["g", "f", "e", "a.d", "a.b.c"]