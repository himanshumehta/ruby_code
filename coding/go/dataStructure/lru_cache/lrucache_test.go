package lrucache

import (
	"testing"
)

func TestLRUCache(t *testing.T) {
	cache := Constructor(2)

	// Test Put and Get
	cache.Put(1, 1)
	cache.Put(2, 2)

	result := cache.Get(1)
	if result != 1 {
		t.Errorf("Expected cache.Get(1) to be 1, but got %v", result)
	}

	result = cache.Get(2)
	if result != 2 {
		t.Errorf("Expected cache.Get(2) to be 2, but got %v", result)
	}

	// Test eviction
	cache.Put(3, 3) // This should evict key 1
	result = cache.Get(1)
	if result != -1 {
		t.Errorf("Expected cache.Get(1) to be -1 (evicted), but got %v", result)
	}

	// Test non-existent key
	result = cache.Get(4) // This key doesn't exist
	if result != -1 {
		t.Errorf("Expected cache.Get(4) to be -1 (not found), but got %v", result)
	}
}

func TestLRUCache_WhenEmpty(t *testing.T) {
	cache := Constructor(2)

	// Cache is empty, so Get should return -1 for any key
	result := cache.Get(1)
	if result != -1 {
		t.Errorf("Expected cache.Get(1) to be -1 (not found), but got %v", result)
	}
}

func TestLRUCache_Eviction(t *testing.T) {
	cache := Constructor(2)

	// Cache capacity is 2
	cache.Put(1, 1)
	cache.Put(2, 2)
	cache.Put(3, 3) // This should evict key 1

	// Now, key 1 should not exist
	result := cache.Get(1)
	if result != -1 {
		t.Errorf("Expected cache.Get(1) to be -1 (evicted), but got %v", result)
	}
}

func TestLRUCache_Update(t *testing.T) {
	cache := Constructor(2)

	// Cache capacity is 2
	cache.Put(1, 1)
	cache.Put(2, 2)
	cache.Put(1, 10) // Update the value of key 1

	// Key 1 should be updated
	result := cache.Get(1)
	if result != 10 {
		t.Errorf("Expected cache.Get(1) to be 10, but got %v", result)
	}
}
