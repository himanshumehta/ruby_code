// Channel communication:
// Wrong Approach: Not closing channels properly, leading to potential deadlocks or goroutine leaks.

ch := make(chan int)
// operations with the channel

// Right Approach: Close the channel appropriately when it's no longer needed, ensuring all goroutines are properly closed.
ch := make(chan int)
// operations with the channel
close(ch)
