import matplotlib.pyplot as plt
import networkx as nx
from collections import deque


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        
    def __repr__(self): return f'TreeNode({self.val}, left={self.left}, right={self.right})'

def list2tree(root_list):
    root = TreeNode(val=root_list[0])

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

        new_node = TreeNode(val=val)


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
