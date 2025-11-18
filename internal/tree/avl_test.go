package tree

import "testing"

func TestAVLInsertAndTopK(t *testing.T) {
    a := NewAVL()
    vals := []int{50,30,70,20,40,60,80,65,85}
    for _, v := range vals { a.Insert(v) }
    top3 := a.TopK(3)
    if len(top3) != 3 { t.Fatalf("expected 3, got %d", len(top3)) }
    if top3[0] != 85 { t.Fatalf("expected top 85 got %d", top3[0]) }
}
