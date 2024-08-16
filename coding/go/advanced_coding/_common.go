CUPID stands for Clarity, Uniqueness, Performance, Insight, and Depth. 

Concurrent Task Scheduling:

// Wrong Approach: Implementing custom task scheduling with goroutines without considering the system's concurrency limits, leading to resource exhaustion.
for _, task := range tasks {
    go task.Execute()
}

// Right Approach: Using a worker pool or a task scheduling library to limit the number of concurrently running tasks and manage system resources efficiently.
var wg sync.WaitGroup
for _, task := range tasks {
    wg.Add(1)
    go func(t Task) {
        t.Execute()
        wg.Done()
    }(task)
}
wg.Wait()
// ******************************************************************************************************************************************************************************************************************

Error Wrapping:

// Wrong Approach: Losing the original error context when wrapping errors, making it difficult to trace the source of the error.
_, err := ioutil.ReadFile("filename.txt")
if err != nil {
    return fmt.Errorf("custom error: %w", err)
}

// Right Approach: Wrapping errors using the %w verb to maintain the original error context and provide more detailed error information.
_, err := ioutil.ReadFile("filename.txt")
if err != nil {
    return fmt.Errorf("failed to read file: %w", err)
}

// ******************************************************************************************************************************************************************************************************************

Resource Cleanup:
// Wrong Approach: Neglecting to release resources like file handles, database connections, or network connections, leading to resource leaks.
// ... open a file or database connection
// ... operations with the resource

// Right Approach: Defer the release of resources and use appropriate cleanup methods to ensure timely and proper resource release.
// ... open a file or database connection
defer func() {
    // close the file or release the connection
}()
// ... operations with the resource

// ******************************************************************************************************************************************************************************************************************

Concurrent Map Access:
// Wrong Approach: Accessing a map concurrently without proper synchronization, leading to potential race conditions.
var m = make(map[string]int)

// ... concurrent access to m
// Right Approach: Using the sync package or sync.Map for safe concurrent access to maps.
var m sync.Map
// ... concurrent access to m

// ******************************************************************************************************************************************************************************************************************

Working with Time:
// Wrong Approach: Using the time.Sleep function for long delays, which can block the entire program.

time.Sleep(10 * time.Second)

// Right Approach: Using the time.After channel or a ticker for handling long delays without blocking the program.
<-time.After(10 * time.Second)
// ******************************************************************************************************************************************************************************************************************

// String Comparison:
// Wrong Approach: Using the == operator for string comparison, which can lead to unexpected results due to different string representations.
str1 := "hello"
str2 := "hello"
if str1 == str2 {
    // do something
}
// Right Approach: Using the strings.EqualFold or strings.Compare functions for case-insensitive or lexicographic comparison, respectively.
str1 := "hello"
str2 := "hello"
if strings.EqualFold(str1, str2) {
    // do something
}

// ******************************************************************************************************************************************************************************************************************
// Process large data in chunks
package main

import (
    "bufio"
    "fmt"
    "io/ioutil"
    "os"
)

type HugeStruct struct {
    // ...
}

func main() {
    // Open the file containing the large dataset
    file, err := os.Open("large_dataset.txt")
    if err != nil {
        fmt.Println(err)
        return
    }
    defer file.Close()

    // Create a buffered reader
    reader := bufio.NewReader(file)

    // Create a buffer to store the chunks of data
    buffer := make([]byte, 1024)

    // Read the data in chunks
    for {
        // Read a chunk of data into the buffer
        n, err := reader.Read(buffer)
        if err == io.EOF {
            // We have reached the end of the file
            break
        }
        if err != nil {
            fmt.Println(err)
            return
        }

        // Process the chunk of data
        // ...

        // Clear the buffer
        buffer = buffer[:0]
    }
}

// ******************************************************************************************************************************************************************************************************************
String concatenation:

// Wrong Approach: Using the "+" operator for string concatenation in a loop, which can lead to inefficient memory usage.
result := ""
for _, s := range strings {
    result += s
}
// Right Approach: Using the strings.Join function or the bytes.Buffer type for efficient string concatenation, especially within loops.
// The bytes.Buffer type provides a way to efficiently build strings. It uses a growable buffer to store the string data, which avoids the need to allocate new buffers as the string grows.
var buffer bytes.Buffer
for _, s := range strings {
    buffer.WriteString(s)
}
result := buffer.String()
// OR
// The strings.Join() function is more efficient than using the "+" operator for string concatenation, especially within loops. 
// This is because the strings.Join() function only allocates a single buffer for the result string, whereas the "+" operator allocates a new buffer for each string in the loop.
func main() {
    strings := []string{"hello", "world"}

    // Concatenate strings using the strings.Join() function
    result := strings.Join(strings, " ")

    fmt.Println(result)
}

// ******************************************************************************************************************************************************************************************************************
Array/Slice manipulation:

// Wrong Approach: Modifying a slice without considering the underlying array's capacity, leading to unexpected behavior and potential memory issues.
slice := make([]int, 0, 5)
// appending more than the capacity
// Right Approach: Using the append function to add elements to a slice, letting Go manage the underlying array's capacity dynamically.
slice := make([]int, 0, 5)
slice = append(slice, 1, 2, 3)

// ******************************************************************************************************************************************************************************************************************
Custom Error Handling:

// Wrong Approach: Creating custom error types without providing proper context, leading to difficulty in understanding the error origin.
type CustomError string

func (e CustomError) Error() string {
    return string(e)
}
// Right Approach: Creating custom error types with additional context to provide more meaningful error messages and information.
type CustomError struct {
    Context string
}

func (e *CustomError) Error() string {
    return fmt.Sprintf("Custom error: %s", e.Context)
}

// ******************************************************************************************************************************************************************************************************************
make([]int, 0, 5)
The expression make([]int, 0, 5) in Go creates an empty integer slice with an initial length of 0 and a capacity of 5, meaning it has room for up to 5 elements without requiring reallocation.
// ******************************************************************************************************************************************************************************************************************

// Wrong
func get_product_price(product_name string) float64 {
  if product_name == "A" {
    return 10.00
  } else if product_name == "B" {
    return 20.00
  } else if product_name == "C" {
    return 30.00
  } else {
    return 0.00
  }
}

// Right
// Supplier interface
type Supplier interface {
  GetPrice(product_name string) float64
}

// Concrete supplier classes
type PrimarySupplier struct{}

func (s *PrimarySupplier) GetPrice(product_name string) float64 {
  switch product_name {
  case "A":
    return 10.00
  case "B":
    return 20.00
  case "C":
    return 30.00
  default:
    return 0.00
  }
}

type FallbackSupplier struct{}

func (s *FallbackSupplier) GetPrice(product_name string) float64 {
  return 5.00
}

// SupplierFactory
type SupplierFactory struct{}

func (f *SupplierFactory) CreateSupplier(product_name string) Supplier {
  switch product_name {
  case "A", "B", "C":
    return &PrimarySupplier{}
  default:
    return &FallbackSupplier{}
  }
}

// Example usage:

func main() {
  factory := &SupplierFactory{}

  // Get the price for product "A" from the primary supplier
  supplier := factory.CreateSupplier("A")
  price := supplier.GetPrice("A")
  fmt.Println("Price of product A:", price)

  // Get the price for product "D" from the fallback supplier
  supplier = factory.CreateSupplier("D")
  price = supplier.GetPrice("D")
  fmt.Println("Price of product D:", price)
}

// ******************************************************************************************************************************************************************************************************************

// Interface to avoid coupling
// Wrong approach:
type User struct {
    Name string
    Age int
}

func main() {
    user := User{
        Name: "Alice",
        Age: 25,
    }

    // Do something with the user object
}

// ******************************************************************************************************************************************************************************************************************

// Right approach
type User interface {
    GetName() string
    GetAge() int
}

type ConcreteUser struct {
    Name string
    Age int
}

func (u *ConcreteUser) GetName() string {
    return u.Name
}

func (u *ConcreteUser) GetAge() int {
    return u.Age
}

func main() {
    var user User = &ConcreteUser{
        Name: "Alice",
        Age: 25,
    }

    // Do something with the user object
}

// This code is loosely coupled because the main() function depends on the User interface, not the ConcreteUser struct. 
// This means that we can easily change the way that the User struct is implemented without modifying the main() function.

// Not using dependency injection
// Wrong approach:

func main() {
    db := database.NewConnection()
    repo := userRepository.NewRepository(db)

    // Do something with the repo object
}

// Right approach:
func main(db database.Database, repo userRepository.Repository) {
    // Do something with the repo object
}

// ******************************************************************************************************************************************************************************************************************

// Why context
func getResponse(ctx context.Context, url string) (string, error) {
    req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
    if err != nil {
        return "", fmt.Errorf("error creating request: %v", err)
    }

    resp, err := http.DefaultClient.Do(req)
    if err != nil {
        return "", fmt.Errorf("error getting response: %v", err)
    }
    defer resp.Body.Close()

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        return "", fmt.Errorf("error reading response: %v", err)
    }

    return string(body), nil
}

func main() {
    ctx, cancel := context.WithTimeout(context.Background(), 5 * time.Second)
    defer cancel()

    response, err := getResponse(ctx, "https://example.com")
    if err != nil {
        if errors.Is(err, context.DeadlineExceeded) {
            fmt.Println("request timed out")
            os.Exit(1)
        } else {
            fmt.Println(err)
            os.Exit(1)
        }
    }

    fmt.Println(response)
}

// ******************************************************************************************************************************************************************************************************************

// Defer and ensuring no resource leaks
func openFile(path string) (*os.File, error) {
    file, err := os.Open(path)
    if err != nil {
        return nil, fmt.Errorf("error opening file: %v", err)
    }
    return file, nil
}

func main() {
    defer file.Close() // Close the file when the function returns

    file, err := openFile("myfile.txt")
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }

    // Do something with the file
}

// ******************************************************************************************************************************************************************************************************************

// Mutex lock
var counter int
var mutex sync.Mutex

func main() {
    go func() {
        mutex.Lock()
        counter++
        mutex.Unlock()
    }()

    mutex.Lock()
    fmt.Println(counter)
    mutex.Unlock()
}

// ******************************************************************************************************************************************************************************************************************

// Type Assertion:
// Wrong Approach: Using type assertions without checking the type, leading to runtime panics if the type assertion fails.
value, _ := someInterface.(int)

// Right Approach: Using type assertions with type checks to ensure the type assertion is safe.
value, ok := someInterface.(int)
if !ok {
    // handle the type assertion failure
}

// ******************************************************************************************************************************************************************************************************************

// Channel communication:
// Wrong Approach: Not closing channels properly, leading to potential deadlocks or goroutine leaks.

ch := make(chan int)
// operations with the channel

// Right Approach: Close the channel appropriately when it's no longer needed, ensuring all goroutines are properly closed.
ch := make(chan int)
// operations with the channel
close(ch)

// ******************************************************************************************************************************************************************************************************************

// Logging:
// Wrong Approach: Using fmt.Print or fmt.Println for logging, which can be inefficient and can't be easily controlled or disabled.
fmt.Println("Error occurred: ", err)

// Right Approach: Using a proper logging package like the standard library's log or a third-party logging library to control log levels and format logs appropriately.
log.Println("Error occurred: ", err)

// ******************************************************************************************************************************************************************************************************************

Unmarshaling JSON:
// Wrong Approach: Unmarshaling JSON into an interface{}, making it challenging to work with the unmarshaled data in a type-safe manner.
var data interface{}
json.Unmarshal(jsonData, &data)

// Right Approach: Unmarshaling JSON into a predefined struct, ensuring that the data is unmarshaled into a specific data structure that can be easily worked with.
type Data struct {
    Field1 string `json:"field1"`
    Field2 int    `json:"field2"`
}
var data Data

// ******************************************************************************************************************************************************************************************************************

Database Transactions:
// Wrong Approach: Using multiple SQL statements without wrapping them in a transaction, leading to inconsistent or incomplete database updates in case of failures.
_, err1 := db.Exec("UPDATE table1 SET column1 = value1 WHERE id = 1")
_, err2 := db.Exec("UPDATE table2 SET column2 = value2 WHERE id = 2")

// Right Approach: Using transactions to ensure atomicity and consistency in database updates, rolling back changes in case of failures.
tx, err := db.Begin()
if err != nil {
    // handle the error
}
_, err1 := tx.Exec("UPDATE table1 SET column1 = value1 WHERE id = 1")
_, err2 := tx.Exec("UPDATE table2 SET column2 = value2 WHERE id = 2")
if err1 != nil || err2 != nil {
    tx.Rollback()
    // handle the error
}
tx.Commit()

// ******************************************************************************************************************************************************************************************************************

var (
	once           sync.Once
	singleInstance *Single
)

func GetInstance() *Single {
	once.Do(func() {
		fmt.Println("Created.")
		singleInstance = &Single{}
	})
	fmt.Println("Single instance already created.")
	return singleInstance
}
