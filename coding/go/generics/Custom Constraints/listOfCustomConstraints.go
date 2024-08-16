// Comparable (comparable):

// Used to constrain types that support equality and inequality comparisons using == and !=.
func Example[T comparable](a, b T) {
    // ...
}

// Numeric (numeric):

// Used to constrain numeric types, including integers, floating-point numbers, and complex numbers.
func Example[T numeric](x, y T) {
    // ...
}

// Ordered (ordered):

// Used to constrain types that support ordering operations such as <, <=, >, and >=.
func Example[T ordered](x, y T) {
    // ...
}

// Constraint Composition:

// You can compose constraints using the logical AND (&&) operator.
func Example[T comparable, U ordered](a T, b U) {
    // ...
}
