<!-- # Recursion
# 3 things
# Base condition - Think of smallest valid input or think of invalid input
# Choice diagram
# For base condition - Think of smallest valid input
# Nested array with default - initialization and iterate
-->

### MCM - 7 problems on mcm pattern
1. MCM
2. Printing MCM
3. Evaluate expression to True/Boolean parenthesisation recursive
3a. Evaluate expression to True/Boolean parenthesisation bottom up dp
4. Min/Max value of any expression
5. Palindrome partioning
5a. Palindrome partioning memoization
5b. Optimization palindromic partioning
6. Scramble string recursively
6a. Scramble string memoization bottom up dp
7. Egg dropping problem recursively
7a. Egg dropping problem dp
7b. Optimization to Egg dropping problem

#### Format Identification: For any string or array
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
i   k        k k k  k  k    k       j

We will break into 2 problems at k
From i to k
And from (k + 1 ) to j

There will be temporary answers for every combination of (i, k) and (k+1, j)
We will loop through all temporary answers and find answer

Pseudo code
{
    if i > j then return 0

    for k = i; k < j; k++
    {
        Find all temporary answers
        temporary_answers = solve(i, k) && solve(k+1, j)
    }

    for all temporary answers in temporary_answers
    {
        find answer
    }
}
 
#### 1. MCM
Problem Statement:
A1 = Matrix [] 2*3 
A2 = Matrix [] 3*6

Note: 
- Above matrix can be multiplied as 3 is there, column of first matrix should be equal of row of second matrix
- Resulting matrix should be be of dimension 2*6 in above example
- Cost of matrix multiplication: In above example: 2 * 3 * 6 = 36

Question: A1, A2, A3, A4
A1 = Matrix [] 2*3 
A2 = Matrix [] 3*6  
A3 = Matrix [] 2*6
A4 = Matrix [] 3*6

There are multiple ways to to mcm
(A1, A2)(A3, A4)
(A1, A2, A3)(A4)

We need to find how to multiply so cost is minimum.

arr = [40, 20, 30, 10, 30] <- Dimension of matrix <- n-1 matrix
Formula Ai = Matrix [] arr[i-1]*arr[i], So

A1 = Matrix [] 40*20
A2 = Matrix [] 20*30
A3 = Matrix [] 30*10
A4 = Matrix [] 10*30

There are 2 schemes to break the proble
- Loop k from i to (j-1) ---- Break into i to k && (k+1) to j
- Loop k from (i+1) to j ---- Break into i to (k-1) && k to j

So solution options are:

```ruby
for k=i; k<=(j-1); k++
temporary_answers = {
    solve(arr, i, k) +
    solve(arr, k+1, j) +
    arr[i-1]*arr[k]*arr[j] # cost to multiply above 2 to get total cost 
}

OR

for k=i+1; k<=(j); k++
temporary_answers = {
    solve(arr, i, k-1) +
    solve(arr, k, j) +
    arr[i-1]*arr[k-1]*arr[j] # cost to multiply above 2 to get total cost - Need to double check
}

Find minimum in temporary_answers to find final answer
```

#### MCM bottom-up solution
t[1001][1001] and initialize with -1
<!-- TODO -->

#### 5. Palindromic partitioning algorithm
Problem statement -
s = "nitik"
Divide such that each string is palindromic, find minimum partion required
e.g.
5 partition - n, i, t, i, k
2 partition - n, iti, k
So in best case by observation it is clear we can do 2 partitions

Note: Worst case - n-1, as each letter is palindromic

<!-- Watch video number 36 of aditya series for undersrtanding so it is mcm at 06:55-->

So recursion base cond
if i >= j; return 0 # In this case as even single char is palindromic that's why i == j is also 0

2 possible schemes, same as MCM
- Loop k from i to (j-1) ---- Break into i to k && (k+1) to j
- Loop k from (i+1) to j ---- Break into i to (k-1) && k to j

Pseudocode for scheme 1st
if i >= j; return 0 # In this case as even single char is palindromic that's why i == j is also 0

if isPalindromic(s, i, j); return 0 # In this case string is already palindromic

for k = i; k <= (j-1); k++
{
    temporary_answers = {
        solve(str, i, k) +
        solve(str, (k+1), j) +
        1 <!-- As one partition we would have done to break into above 2  -->
}
ans = temporary_answers.min
<!-- TODO write code for this -->


#### Pseudocode for palindrome
```ruby
def isPalindromic(str, i, j)
    if i == j
        return true
    elsif i > j
        return true
    end

    while i < j
        if str[i] != str[j]
            return false
        end
        i -= 1
        j -= 1
    end
end
```



#### 5a. Palindrome partioning memoization
How to find n * m for table?
What are changing variables? - It is i and j
So make container for i * j

So if string has constraints 0 < string < 1000
So we make t[1001][1001]


#### 5b. Optimization palindromic partioning

temporary_answers = {
    solve(arr, i, k) +
    solve(arr, k+1, j) +
    arr[i-1]*arr[k]*arr[j] # cost to multiply above 2 to get total cost 
}

Don't call both sub problems
In above it is possible one of sub problem is already solved, we should avoid making call.
Also possible both sub problem are already same so solve only one of them before solving another

#### 3. Evaluate expression to True/Boolean parenthesisation recursive
Problem statement
String is made up of 5 symbols
T F & || ^
Input we will be given string with above 5 symbols
e.g. "T F & || ^"
- Also if we look at input, we will always do k -> k + 2
Output - No of ways we can put bracket so that output is True

How is it MCM?
We need to place brackets

Note:
(T) F (& || ^) -  No brackets like this as F is not operator
We can only place brackets around operator symbols
----------------------------------------------------------------
XOR table
0 0 => 0
1 0 => 1
0 1 => 1
1 1 => 0
----------------------------------------------------------------

Steps to solve the problem recursively
1. Find i and j 
i = 0, j = str.length - 1

2. Base condition for recursion 
if i > j; return False
if i == j
    if isTrue == True
        return s[i] == True
    else
        return s[i] == False
    end
end

Also note - on i or j there will always be T/F and operator on K

3. k loop
T || F && T ^ F => 
(T || F && T) ^ (F)
Expression XOR Expression
Expression(i to k-1) XOR(k) Expression(k+1 to j)

As XOR is True when one of the input is true so we need to find both false and true for sub problems
Sub problem 1 - false and sub problem 2 - true => result in true
Sub problem 1 - true and sub problem 2 - false => result in true

What above means is that 
Solve(string, i, j) is not sufficient, we need to solve
Solve(string, i, j, True) or Solve(string, i, j, False)
<!-- See video number 39 Evaluate expression to True Aditya verma at min 20:00 -->

##### k = i + 1 to j - 1 with k + 2 at each step
for(int k = i + 1; k <= j - 1; k = k + 2)
{
    int left_true = solve(string, i, j, True);
    int left_false = solve(string, i, j, True);
    int right_true = solve(string, i, j, False);
    int right_false = solve(string, i, j, False);
} 

4. Final answer from temporary answers
no_of_ways = 0

if isTrue == True
    if string[k] == '&&' 
        no_of_ways = no_of_ways + (left_true * right_true)
    if string[k] == '||'
        no_of_ways = no_of_ways + (left_true * right_false) + (left_false * right_true) + (left_true * right_false)
    if string[k] == '^'
        no_of_ways = no_of_ways + (left_true * right_false) + (left_false * right_true) 
else
    if string[k] == '&&' 
        no_of_ways = no_of_ways + (left_true * right_false) + (left_false * right_true) + (left_false * right_false)
    if string[k] == '||'
        no_of_ways = no_of_ways + (left_false * right_false)
    if string[k] == '^'
        no_of_ways = no_of_ways + (left_true * right_true) + (left_false * right_false)

#### 3a. Evaluate expression to True/Boolean parenthesisation bottom up dp
We can make hashmap with key of i, j and isTrue

#### 6. Scramble string recursively
Problem Statement:
a  = "great"
b = "rgeat"

If a and b are scramble string return True

Scramble strings - How to find scramble string of given string
2 Steps
1. Break the string with below criteria
- Binary tree
- Empty child not allowed
2. We can swap the children and merge back, re assembled string is scramble string of given string

Note: Zero or more swapping are allowed for non empty string
great and great are scramble strings with zero swaps

For example: Both of the following are valid
Eg 1
       great
       /   \
      gr    eat
    /  \     / \
   g    r   e   at
               /  \
              a    t   

       rgeat
       /   \
      rg    eat
    /  \     / \
   r    g   e   at
               /  \
              a    t   

great and rgeat are scrambled strings.


Eg 2
       great
       /   \
      gre    at
    /  \     / \
   gr   e   a   t
  /  \
 g    r    

       greta
       /   \
      gre    ta
    /  \     / \
   gr   e   t   a
  /  \
 g    r    

great and greta are scrambled strings

How Scramble string can be solved with MCM?
great
g | reat
gr | eat
gre | at

Run k from i = 1 to j - 1

##### So if we want to find 2 strings are scramble strings or not
great rgate
g | reat => Check against rgat | e
gr | eat => Check against rga | te
gre | at => Check against rg | ate
grea | t => Check against r | gate

If any of above is true, then they are scramble strings.

So pseudocode
a = gr | eat => b = rga | te
CONDITION 1 => 
solve a.substring(0,i), b.substring(n-i, i) => Retun true
solve a.substring(i, n-i), b.substring(0, n-i) => Retun true
If both above return true, strings are scramble strings.

CONDITION 2 => AND WE ALSO NEED TO CONSIDER CASE WHERE THERE IS NO SWAP


Base condition
if a.compare(b) == 0
    return true
if a.length() != b.length()
    return false
if a.length <= 1
    return false
solve(a,b)


isScrambled = false
solve(a,b)
{
    if condition 1 || condition 2
        isScrambled = true and break
    end
}

condition 1 => 
solve a.substring(0,i), b.substring(n-i, i) == True AND
solve a.substring(i, n-i), b.substring(0, n-i) == True

condition 2 =>
solve a.substring(0,i), b.substring(0, i) == True AND
solve a.substring(i, n-i), b.substring(i, n-i) == True


#### 6a. Scramble string memoization bottom up dp
Changing variables are a and b
So make composite keys with "a b" and cache using hash map

#### 7. Egg dropping problem recursively
Problem Statement:
Input
eggs  = 3
floors = 5
Find critical floor in minimum number of attempts with given quantity of eggs

Output 
number of attempts 

K loop
for k = 1 to k = f; k++

Base condition and pseudo code
if eggs == 1
    return floor # worst case as we don't have any eggs
if floors == 0 || 1
    retutn floor    

int mn = INT_MAX

for k = 1 to k = f; k++
{
    <!-- 2 case - either egg will break or it will not break -->
    break - solve(e-1, k-1)
    not_break - solve(e, f-k)

    <!-- As we need minimum number of attempts in worst case, we will choose max of above 2 -->
    temp_answer = 1 + MAX(
        break - solve(e-1, k-1)
        not_break - solve(e, f-k)
    )

    mn = MIN(mn, temp_answer)
}

return mn

#### 7a. Egg dropping problem dp
Changing variables e, f
t[e][f]
Initialize with -1

#### 7b. Optimization to Egg dropping problem
Same as palindromic, before calling both sub problem, check in t



