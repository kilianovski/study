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

    def subtree_first(A):
        if A.left: return A.left.subtree_first()
        return A.val
    
    def successor(A):
        if A.right: return A.right.subtree_first()


lesson_tree = BinaryNode('A', BinaryNode('B', BinaryNode('D', BinaryNode('F')), BinaryNode('E')), BinaryNode('C'))

print(list(lesson_tree.subtree_iter()))
print(lesson_tree.subtree_first())
