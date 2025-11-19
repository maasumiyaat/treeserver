package tree

import (
	"container/heap"
)

// Task and TaskHeap used by handlers
type Task struct {
	ID       string
	TaskName string
	Priority int
}

type TaskHeap []Task

func (h TaskHeap) Len() int            { return len(h) }
func (h TaskHeap) Less(i, j int) bool  { return h[i].Priority < h[j].Priority }
func (h TaskHeap) Swap(i, j int)       { h[i], h[j] = h[j], h[i] }
func (h *TaskHeap) Push(x interface{}) { *h = append(*h, x.(Task)) }
func (h *TaskHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func PopMin(h *TaskHeap) Task {
	heap.Init(h)
	return heap.Pop(h).(Task)
}
