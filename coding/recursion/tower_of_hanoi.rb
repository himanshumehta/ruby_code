a = [1, 2, 3, 4]
b = []
c = []

def move_disk(number_of_disks, source, destination, helper)
  if number_of_disks == 1
    print(number_of_disks, source, destination, helper)
    destination.unshift(source.shift)
  else
    move_disk(number_of_disks - 1, source, helper, destination)
    destination.unshift(source.shift)
    move_disk(number_of_disks - 1, helper, destination, source)
  end
end

def print(number_of_disks, source, destination, helper)
  p "Moving n = #{number_of_disks}, from source #{source}, to destination #{destination},helper #{helper}"
end

move_disk(4, a, b, c)
p a, b, c

# >> "Moving n = 1, from source [1, 2, 3, 4], to destination [],helper []"
# >> "Moving n = 1, from source [1], to destination [2],helper [3, 4]"
# >> "Moving n = 1, from source [1, 2], to destination [4],helper [3]"
# >> "Moving n = 1, from source [1, 4], to destination [2, 3],helper []"
# >> "Moving n = 1, from source [1, 2, 3], to destination [4],helper []"
# >> "Moving n = 1, from source [1, 4], to destination [2],helper [3]"
# >> "Moving n = 1, from source [1, 2], to destination [],helper [3, 4]"
# >> "Moving n = 1, from source [1], to destination [2, 3, 4],helper []"
# >> []
# >> [1, 2, 3, 4]
# >> []
