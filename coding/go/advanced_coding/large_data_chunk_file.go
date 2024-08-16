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
