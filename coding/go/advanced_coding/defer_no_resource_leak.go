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
