package tree

import "testing"

func TestRBInsert(t *testing.T) {
    r := NewRB()
    vals := []int{10,20,30,15,25,5}
    for _, v := range vals { r.Insert(v) }
    out := r.InOrder()
    if len(out) != len(vals) { t.Fatalf("expected %d got %d", len(vals), len(out)) }
}
