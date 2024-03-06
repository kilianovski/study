import matplotlib.pyplot as plt
import networkx as nx
from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

    def __repr__(self): return str(tree2ascii(self))
    # def __repr__(self): return f'TreeNode({self.val}, left={self.left}, right={self.right})'

def list2tree(root_list, cls=TreeNode):
    root = cls(val=root_list[0])

    node = root
    queue = deque()
    state = 0

    for val in root_list[1:]:
        # print(queue)
        if state == 2:
            node = queue.pop()
            state = 0

        if val is None:
            state += 1
            continue

        new_node = cls(val=val)


        if state == 0:
            node.left = new_node
        else:
            node.right = new_node
        state += 1

        queue.appendleft(new_node)


    return root

def draw_unique_tree(root):
    if type(root) != TreeNode:
        root = list2tree(root)

    graph = nx.DiGraph()
    pos = {}
    labels = {}
    def add_unique_edges(graph, node, pos, labels, x=0, y=0, layer=0):
        if node is None:
            return
        pos[node] = (x, y)
        labels[node] = node.val
        if node.left:
            graph.add_edge(node, node.left)
            l = x - 1 / 2**layer
            add_unique_edges(graph, node.left, pos, labels, l, y - 1, layer + 1)
        if node.right:
            graph.add_edge(node, node.right)
            r = x + 1 / 2**layer
            add_unique_edges(graph, node.right, pos, labels, r, y - 1, layer + 1)
    add_unique_edges(graph, root, pos, labels)
    fig, ax = plt.subplots(figsize=(8, 10))
    nx.draw(graph, pos, labels=labels, with_labels=True, arrows=False)
    plt.show()




class BinaryTreeASCIIArt:
    def __init__(self, rows, root_i=None):
        self.rows = rows
        self.root_i = root_i
    
    def __repr__(self):
        return '\n'.join(s.rstrip() for s in self.rows)


def pad_right(s, upto, symbol=' '):
    pad = max(0, upto-len(s))
    return s+symbol*pad


def pad_left(s, upto, symbol=' '):
    pad = max(0, upto-len(s))
    return symbol*pad+s


def grow_connections(root_row, left, right):
    connections = []
    
    if not left and not right: return connections

    # FIRST
    connections.append( pad_left('|', len(root_row)) )


    # SECOND
    elbow = '+'
    
    # SECOND: LEFT
    if left:
        elbow_len = len(root_row) - left.root_i
        elbow = '+'+('-'*(elbow_len-2)) + elbow

    elbow = pad_left(elbow, len(root_row))
    
    # SECOND: RIGHT
    if right:
        elbow_len = right.root_i + 2
        elbow += ('-'*(elbow_len-2)) + '+'

    connections.append( elbow )

    # THIRD
    bottom = ''
    if left:
        bottom += pad_left('|', left.root_i+1)
        
    bottom = pad_right(bottom, len(root_row))
    if right:
        bottom += pad_left('|', right.root_i+1)
        
    # bottom = pad_left
    connections.append( bottom )
    return connections


import itertools

def merge_rows(left_rows, right_rows, left_pad_n):
    res = []
    for l,r in itertools.zip_longest(left_rows, right_rows, fillvalue=''):
        l = pad_right(l, left_pad_n)
        res.append(l + r)
    return res


def _tree2ascii(root, W) -> BinaryTreeASCIIArt:
    if not root: return None

    rows = []
    root_pad_n = W

    left = _tree2ascii(root.left, W)
    right = _tree2ascii(root.right, W)

    if left:
        root_pad_n += max(map(len, left.rows))
        rows += left.rows


    root_row = pad_left(str(root.val), root_pad_n)


    if right:
        rows = merge_rows(rows, right.rows, root_pad_n)


    connections = grow_connections(root_row, left, right)


    our_rows = [root_row] + connections + rows
    return BinaryTreeASCIIArt(our_rows, len(root_row)-1)


def max_val_len(root):
    if not root: return 0

    return max(
        len(str(root.val)),
        max_val_len(root.left),
        max_val_len(root.right),
    )

def tree2ascii(root):
    W = 1+max_val_len(root)
    return _tree2ascii(root, W)

def ascii_draw(root):
    print(tree2ascii(root))
