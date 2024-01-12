# https://www.codingame.com/ide/puzzle/binary-tree-visual


class BinaryNode:
    def __init__(A, x=None, left=None, right=None, parent=None):
        A.left = left
        A.right = right
        A.parent = parent
        A.val = x
        
        A.link_parents()
    
    def __repr__(self): return f'BinaryNode({self.val}, left={self.left}, right={self.right})'
    
    def link_parents(A):
        if A.left and not A.left.parent:
            A.left.parent = A
            A.left.link_parents()
        
        if A.right and not A.right.parent:
            A.right.parent = A
            A.right.link_parents()
        return A

    def l(A): return list(A.subtree_iter())

    def subtree_iter(A): # O(n)
        if A.left: yield from A.left.subtree_iter()
        yield A.val
        if A.right: yield from A.right.subtree_iter()


from queue import deque


def old_list2tree(root_list):
    root = BinaryNode(root_list[0])

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

        new_node = BinaryNode(val)


        if state == 0:
            node.left = new_node
        else:
            node.right = new_node
        state += 1

        queue.appendleft(new_node)


    return root

null = None
def list2tree(li):
    if not li: return None

    the_root = BinaryNode(li[0])
    r = the_root

    q = deque()
    left_flag = False
    
    for i in range(1, len(li)):
        left_flag = not left_flag
        if li[i] is None: continue
        child = BinaryNode(li[i])
        q.append(child)

        if left_flag:
            r.left = child
        else:
            r.right = child
            r = q.popleft()

    the_root.link_parents()
    return the_root


li = [2,null,3,4,null,5]
print(list2tree(li))
print(old_list2tree(li))
tree = BinaryNode('111', BinaryNode('222', BinaryNode('44'), BinaryNode('555', None, BinaryNode('66'))), BinaryNode('3'))
