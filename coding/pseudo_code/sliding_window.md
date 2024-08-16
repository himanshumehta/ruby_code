
SLIDING PATTERN 

1. Fixed window size
2. Fixed window size example - Maximum of all sub arrays of size k
3. Variable window size
4. Variable window size example - Minimum window substring

#### Fixed window size
Template
```ruby
def sliding_window(nums, k)
  return nums if k == 1
  res = []
  i = 0
  j = 0
  q = [] # Queue
  while j < nums.size
    if j - i + 1 < k
      # window not hit
      j += 1
    end

    if j - i + 1 == k
      # window hit
      i += 1
      j += 1
    end
  end
  res
end
```

=begin
This problem is example of fixed window size
Right way to solve any sliding window

Set two pointers
i = j = 0
Run loop while j < size && window size k = j - i + 1
    j++  <!-- We need to reach window size -->

OR 

if j - i + 1 < k
    window size is smaller
    do work
    j++    
else j - i + 1 == k
    window size is matching
    do work, find answer
    prepare or update answer so we can remove calculation for element which will not be part of window going forward
    i++ <!-- move window -->
    j++ <!-- move window -->
=end

#### Fixed window size example - Maximum of all sub arrays of size k
Flow of solution
- Problem statement - input - output
- Identification
- Explanation
- Code

- Problem statement - input - output:
Array size given - 8
Array given = 1, 3, -1, -3, 5, 3, 6, 7 
Subarray size - 3

Problem statement - For all sub array of given size, find maximum element
like
- max (1, 3, -1) => 3
- max (3, -1, -3) => 3
- max (-1, -3, 5) => 5
....

Output - Return all max in one array
Output = [3, 3, 5, 5, 6, 7]  <!--  Please note it is not of size 8 -->

<!-- 
Brute force we can do with 2 loops, one for entire array and one for sub array size
O(N) = N2
Let's see optimized solution
 -->
- Identification - For fixed window size, 3 things 
1. arr or string given
2. subarray given
3. window size given

As above 3 are applicable so we can apply fixed window algorithm
Please note - We will need to store max in QUEUE so we can find max for window when we slide
<!-- Think and remember why we can't use stack -->
<!-- Answer as it should be open from both ends so stack cannot be used -->

-------------------------------------j------------------------------------------------------------------------
SMALLER BEFORE J ARE OF NO USE  ---- j ----- SMALLER AFTER J CAN BE OF USE AS THEY CAN BE MAX IN FUTURE WINDOW

Connect remaining dots...

#### Variable window size

=begin
This problem is example of variable window size
Right way to solve any sliding window

Set two pointers
i = j = 0
sum = 0
while j < size
    calculate sum = sum + sum[j]
    if sum == condition met    
        store result, which is window size j - i + 1 
        update sum - subtract value of i
        i++
        j++
    else
        j++
    end
=end

#### Variable window size example - Minimum window substring
Problem statement:
t = toc
s = "time to practice"

Minimum substring in s where all letters of toc are available in same quantity, continuous or discontinuos.
Individual letters can come for more than once..

Key word - Atleast same quantity for all in t string

Solution: We can maintain a hash for each chracter of t with count, for ex
{
    t => 1,
    o => 1,
    c => 1
}

Now start variable window and update above hashmap if we find these chracter - 
If at any time all 3 comes to zero or less than zero, store that as one of possible solution.


