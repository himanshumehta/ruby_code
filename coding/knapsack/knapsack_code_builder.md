```ruby
Float::INFINITY

(n + 1).times do |i|
    (w + 1).times do |j|
      if i == 1 && t[i][j] == -1
        t[i][j] = if (j % weights[0]).zero?
            j / weights[0]
          else
            Float::INFINITY - 1
          end
      end

      t[i][j] = 0 if j.zero? # Fill zero in 1st columns
      t[i][j] = Float::INFINITY - 1 if i.zero? # Fill infinity in 1st row
    end
end
```

