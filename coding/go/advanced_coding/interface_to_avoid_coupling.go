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
