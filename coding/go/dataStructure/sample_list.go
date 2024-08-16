package main

import (
	"container/list"
	"fmt"
)

func main() {
	l := list.New()

	// Adding elements
	l.PushBack(1)
	l.PushFront(2)

	// Traversing the list
	for e := l.Front(); e != nil; e = e.Next() {
		fmt.Println(e.Value)
	}

	// Modifying an element
	element := l.Front()
	element.Value = 3

	// Removing an element
	l.Remove(l.Front())

	fmt.Println("----")
	// Traversing the modified list
	for e := l.Front(); e != nil; e = e.Next() {
		fmt.Println(e.Value)
	}
}

