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
