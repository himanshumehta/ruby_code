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
