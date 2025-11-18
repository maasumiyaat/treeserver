package trie

import "strings"

type Node struct {
    Children map[rune]*Node
    End bool
    Words []string
}

type Trie struct { root *Node }

func New() *Trie { return &Trie{root:&Node{Children:map[rune]*Node{}}} }

func (t *Trie) Insert(s string) {
    node := t.root
    for _, r := range s {
        if node.Children[r] == nil { node.Children[r] = &Node{Children:map[rune]*Node{}} }
        node = node.Children[r]
        if len(node.Words) < 50 { node.Words = append(node.Words, s) }
    }
    node.End = true
}

func (t *Trie) Prefix(p string) []string {
    node := t.root
    for _, r := range strings.ToLower(p) {
        if node.Children[r] == nil { return nil }
        node = node.Children[r]
    }
    return node.Words
}
