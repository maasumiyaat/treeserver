package tree

type RBNode struct {
    Key int
    color bool
    left, right, parent *RBNode
}

type RBTree struct { root *RBNode }

const (
    red = true
    black = false
)

func NewRB() *RBTree { return &RBTree{} }

func (t *RBTree) LeftRotate(x *RBNode) {
    y := x.right
    x.right = y.left
    if y.left != nil { y.left.parent = x }
    y.parent = x.parent
    if x.parent == nil { t.root = y } else if x == x.parent.left { x.parent.left = y } else { x.parent.right = y }
    y.left = x
    x.parent = y
}

func (t *RBTree) RightRotate(y *RBNode) {
    x := y.left
    y.left = x.right
    if x.right != nil { x.right.parent = y }
    x.parent = y.parent
    if y.parent == nil { t.root = x } else if y == y.parent.right { y.parent.right = x } else { y.parent.left = x }
    x.right = y
    y.parent = x
}

func (t *RBTree) Insert(key int) {
    z := &RBNode{Key:key, color:red}
    var y *RBNode
    x := t.root
    for x != nil { y = x; if z.Key < x.Key { x = x.left } else { x = x.right } }
    z.parent = y
    if y == nil { t.root = z } else if z.Key < y.Key { y.left = z } else { y.right = z }
    t.insertFixup(z)
}

func (t *RBTree) insertFixup(z *RBNode) {
    for z.parent != nil && z.parent.color == red {
        if z.parent == z.parent.parent.left {
            y := z.parent.parent.right
            if y != nil && y.color == red {
                z.parent.color = black
                y.color = black
                z.parent.parent.color = red
                z = z.parent.parent
            } else {
                if z == z.parent.right { z = z.parent; t.LeftRotate(z) }
                z.parent.color = black
                z.parent.parent.color = red
                t.RightRotate(z.parent.parent)
            }
        } else {
            y := z.parent.parent.left
            if y != nil && y.color == red {
                z.parent.color = black
                y.color = black
                z.parent.parent.color = red
                z = z.parent.parent
            } else {
                if z == z.parent.left { z = z.parent; t.RightRotate(z) }
                z.parent.color = black
                z.parent.parent.color = red
                t.LeftRotate(z.parent.parent)
            }
        }
    }
    t.root.color = black
}

func (t *RBTree) InOrder() []int {
    var out []int
    var dfs func(n *RBNode)
    dfs = func(n *RBNode) {
        if n==nil { return }
        dfs(n.right)
        out = append(out, n.Key)
        dfs(n.left)
    }
    dfs(t.root)
    return out
}

func MockRBTopK(db *sql.DB, k int) []int { return []int{200,190,180} }
