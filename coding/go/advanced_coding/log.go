// Logging:

// Wrong Approach: Using fmt.Print or fmt.Println for logging, which can be inefficient and can't be easily controlled or disabled.
fmt.Println("Error occurred: ", err)

// Right Approach: Using a proper logging package like the standard library's log or a third-party logging library to control log levels and format logs appropriately.
log.Println("Error occurred: ", err)
