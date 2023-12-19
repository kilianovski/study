class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        
    def __repr__(self):
        return f'Tree({self.val}, left={self.left}, right={self.right})'

PAD = ' '

def lpad(s, n, p=PAD):
    t = n - len(s)
    return p*t + s


def rpad(s, n, p=PAD):
    t = n - len(s)
    return s + p*t

W = 5

def _draw(root):
    if not root: return [""], -1
    
    if (not root.left) and (not root.right): return [lpad(str(root.val), W)], W

    left, left_i = _draw(root.left)
    right, right_i = _draw(root.right)
    
    head = rpad( lpad(str(root.val), W+len(left[0])), len(right[0]) )
    grid = [
        head,
        lpad('|', W+len(left[0]))
    ]
    
    return grid

def full_draw(root):
    grid, _ = _draw(root)
    return "\n".join( grid )

print(full_draw(TreeNode(111, TreeNode(222), TreeNode(333))))
