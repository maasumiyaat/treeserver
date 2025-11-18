package tree

import "database/sql"

type AVLNode struct {
    Key   int
    Left  *AVLNode
    Right *AVLNode
    h     int
}

func height(n *AVLNode) int { if n == nil { return 0 }; return n.h }
func max(a, b int) int { if a>b { return a }; return b }

func rightRotate(y *AVLNode) *AVLNode {
    x := y.Left
    T2 := x.Right
    x.Right = y
    y.Left = T2
    y.h = max(height(y.Left), height(y.Right)) + 1
    x.h = max(height(x.Left), height(x.Right)) + 1
    return x
}

func leftRotate(x *AVLNode) *AVLNode {
    y := x.Right
    T2 := y.Left
    y.Left = x
    x.Right = T2
    x.h = max(height(x.Left), height(x.Right)) + 1
    y.h = max(height(y.Left), height(y.Right)) + 1
    return y
}

func getBalance(n *AVLNode) int {
    if n == nil { return 0 }
    return height(n.Left) - height(n.Right)
}

type AVL struct { Root *AVLNode }

func NewAVL() *AVL { return &AVL{} }

func (t *AVL) Insert(key int) {
    t.Root = insertNode(t.Root, key)
}

func insertNode(node *AVLNode, key int) *AVLNode {
    if node == nil { return &AVLNode{Key:key, h:1} }
    if key < node.Key { node.Left = insertNode(node.Left, key) }
    else if key > node.Key { node.Right = insertNode(node.Right, key) }
    else { return node }

    node.h = 1 + max(height(node.Left), height(node.Right))
    balance := getBalance(node)

    if balance > 1 && key < node.Left.Key { return rightRotate(node) }
    if balance < -1 && key > node.Right.Key { return leftRotate(node) }
    if balance > 1 && key > node.Left.Key {
        node.Left = leftRotate(node.Left)
        return rightRotate(node)
    }
    if balance < -1 && key < node.Right.Key {
        node.Right = rightRotate(node.Right)
        return leftRotate(node)
    }
    return node
}

func (t *AVL) InOrder() []int {
    var out []int
    var dfs func(n *AVLNode)
    dfs = func(n *AVLNode) {
        if n==nil { return }
        dfs(n.Right)
        out = append(out, n.Key)
        dfs(n.Left)
    }
    dfs(t.Root)
    return out
}

func (t *AVL) TopK(k int) []int {
    all := t.InOrder()
    if k > len(all) { k = len(all) }
    return all[:k]
}

// Mock helper used by handlers (simple DB-driven)
func MockAVLTopK(db *sql.DB, k int) []int {
    // placeholder: in real code, fetch and insert into AVL
    return []int{100,90,80}
}
