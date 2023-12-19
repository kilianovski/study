import sys
import math
# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
        
    def __repr__(self):
        return f'Tree({self.val}, left={self.left}, right={self.right})'
# Steps:
# 1. Construct a DS
# 2. Create a list of fully-populated layers, with None's
# 3. Convert such a list to ASCII image.


# OR: create list in place!
# You know how many nodes should be at each level, right?
# So, you can create level "below" and pre-populate it with placeholders (or None's)
# After you get to "i", put the actual value over there

PAD = '_'
PAD = ' '

def pad(n, p=PAD): return p*n

def leftpad(s, W, p=PAD):
    n = W - len(s)
    return pad(n, p) + s


def rightpad(s, W, p=PAD):
    n = W - len(s)
    return s + pad(n, p)

W = 5
root = TreeNode(111, TreeNode(2), TreeNode(3))

def draw(root):
    if not root: return [""], -1

    level = leftpad(str(root.val), W)
    left, lefti = draw(root.left)
    right, righti = draw(root.right)

    width = len(left[0]) + len(right[0])
    if width == 0:
        return [level], len(level)-1
    else:
        depth = max( len(left), len(right))
        
        if lefti == -1:
            left_hand = PAD*(W-1)
            left_tick = PAD*(W-1)
        else:
            # lpad = (len(left[0]) - W)//2 + W - 1
            left_hand = rightpad(PAD*(lefti) + '+', len(left[0])+W-1,'-')
            left_tick = rightpad(PAD*(lefti) + '|', len(left[0])+W-1,' ')
        
        if righti == -1:
            right_hand = ''
            right_tick = ''
        else:
            right_hand = '-'*(righti)+'+'
            right_tick = PAD*(righti) + '|'
        # blocks = [rightpad ( leftpad(level, len(left[0]), '_'), len(right[0]))]
        blocks = [
            (PAD*len(left[0]) + level) + PAD*len(right[0]),
            # rightpad( ( (PAD*(len(left[0]) + W - 1))+'|' ), width ),
            (PAD*(len(left[0]) + len(level) - 1)+ '|')+ PAD*len(right[0]),
            ( left_hand+'+'+right_hand),
            left_tick + (PAD) + right_tick
        ]
        
        rooti = len(left[0]) + len(level) - 1
        # print(f'for {root.val=} {rooti=} {level=}')

        for i in range(depth):

            if i >= len(left):
                left_line = PAD*len(left[0])
            else:
                left_line = left[i]

            if i >= len(right):
                right_line = PAD*len(right[0])
            else:
                right_line = right[i]


            blocks.append(left_line + (PAD*W) + right_line)
        
        return blocks, rooti

def full_draw(root):
    grid, _ = draw(root)
    return "\n".join( grid )


print(full_draw(TreeNode(1)))
print('#'*20)

print(full_draw(TreeNode(1, TreeNode(22), TreeNode(33))))
print('#'*20)

print(full_draw(TreeNode(111, None, TreeNode(3))))
print('#'*20)

print(full_draw(TreeNode(3, TreeNode(44, TreeNode(55)))))
print(full_draw(TreeNode(111, TreeNode(2, TreeNode(44), TreeNode(55)), TreeNode(3, TreeNode(66, TreeNode(777))))))
# print(full_draw(TreeNode(111, None, TreeNode(3, TreeNode(66, TreeNode(777))))))
