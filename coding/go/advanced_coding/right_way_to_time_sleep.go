Working with Time:
// Wrong Approach: Using the time.Sleep function for long delays, which can block the entire program.

time.Sleep(10 * time.Second)

// Right Approach: Using the time.After channel or a ticker for handling long delays without blocking the program.
<-time.After(10 * time.Second)
