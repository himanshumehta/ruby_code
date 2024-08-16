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
