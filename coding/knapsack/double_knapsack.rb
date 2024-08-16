def knapsack(w_array,w1,w2,n)
  if n==0 || w1+w2 == 0
    return 0
  elsif w_array[n-1] > w1 && w_array[n-1] > w2
    return knapsack(w_array,w1,w2,n-1)
  elsif w_array[n-1] <= w1 && w_array[n-1] > w2
    return [w_array[n-1] + knapsack(w_array,w1 - w_array[n-1],w2,n-1),knapsack(w_array,w1,w2,n-1)].max
  elsif w_array[n-1] > w1 && w_array[n-1] <= w2
    return [w_array[n-1] + knapsack(w_array,w1,w2-w_array[n-1],n-1),knapsack(w_array,w1,w2,n-1)].max
  else
    return [w_array[n-1] + knapsack(w_array,w1 - w_array[n-1],w2,n-1),w_array[n-1] + knapsack(w_array,w1,w2-w_array[n-1],n-1),knapsack(w_array,w1,w2,n-1)].max
  end
end
w_array = [8,5,7,10]
w1=11
w2=11
n = w_array.length
p knapsack(w_array,w1,w2,n)
