# treeserver

Demo repo with various tree data structures exposed over HTTP.

List:
TREES CHEAT SHEET
=================

SHAPE & SIZE:
- Binary Tree = Max 2 children per node
- Complete Binary = Fill left-to-right like reading
- Perfect Binary = All levels completely filled
- N-ary Tree = Up to N children per node
- General Tree = Unlimited children

SEARCHING (sorted data):
- BST = Left < Parent < Right
- AVL = BST + heights differ by max 1
- Red-Black = BST + color rules for balance
- B-Tree = Multiple keys per node, for databases
- Trie = Common prefixes share paths

PRIORITY (min/max at top):
- Min Heap = Parent ≤ children, smallest at root
- Max Heap = Parent ≥ children, largest at root

GEOGRAPHY (divide space):
- K-D Tree = Alternate axis cuts (x, y, z...)
- Quadtree = Divide into 4 quadrants recursively
- Octree = Divide into 8 cubes recursively
- R-Tree = Group points in bounding rectangles

SPECIALISTS (one superpower):
- Segment Tree = Fast range sum/min/max queries
- Merkle Tree = Detect data tampering via hashing
- Huffman Tree = Compress by giving frequent items short codes