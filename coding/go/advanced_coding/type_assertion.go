// Type Assertion:
// Wrong Approach: Using type assertions without checking the type, leading to runtime panics if the type assertion fails.
value, _ := someInterface.(int)

// Right Approach: Using type assertions with type checks to ensure the type assertion is safe.
value, ok := someInterface.(int)
if !ok {
    // handle the type assertion failure
}
