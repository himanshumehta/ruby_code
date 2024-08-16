package lrucache

import "container/list"

type LRUCache struct {
	capacity int
	elems    map[int]*list.Element
	lruList  *list.List
}

type Pair struct {
	key   int
	value int
}

func Constructor(capacity int) LRUCache {
	return LRUCache{
		capacity: capacity,
		elems:    make(map[int]*list.Element),
		lruList:  list.New(),
	}
}

func (this *LRUCache) Get(key int) int {
	if elem, ok := this.elems[key]; ok {
		this.lruList.MoveToFront(elem)
		return elem.Value.(Pair).value
	}

	return -1
}

func (this *LRUCache) Put(key int, value int) {
	if elem, ok := this.elems[key]; ok {
		this.lruList.MoveToFront(elem)
		elem.Value = Pair{key, value}
	} else {
		elem := this.lruList.PushFront(Pair{key, value})
		this.elems[key] = elem
		if len(this.elems) > this.capacity {
			delete(this.elems, this.lruList.Back().Value.(Pair).key)
			this.lruList.Remove(this.lruList.Back())
		}
	}
}

func main() {
	cache := Constructor(2)
	cache.Put(1, 1)
	cache.Put(2, 2)
	println(cache.Get(1)) // returns 1
	cache.Put(3, 3)       // evicts key 2
	println(cache.Get(2)) // returns -1 (not found)
	cache.Put(4, 4)       // evicts key 1
	println(cache.Get(1)) // returns -1 (not found)
	println(cache.Get(3)) // returns 3
	println(cache.Get(4)) // returns 4
}
