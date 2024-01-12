inductive Tree (β : Type a) where
| leaf
| node (left : Tree β) (key : Nat) (value : β) (right : Tree β)

deriving Repr


def simple_tree_list : List (Nat × Option String) := [
  (0, "the root"),
  (1, Option.none),
  (2, "child"),

  (3, "left subchild"),
  (4, "right subchild")
]

-- def _list2tree {β : Type a} (root : Tree β) (data : List (Nat × Option β)) (queue : List Tree β) : Tree β :=


-- def list2tree {β : Type a} (l : List (Nat × Option β)) :=

def a := 3
def b := 5

#eval (a = b)


#eval (Tree.node Tree.leaf 0 "maya" Tree.leaf)


def Tree.contains ( t : Tree β ) (k : Nat) : Bool :=
match t with
| Tree.leaf => false
| Tree.node left key _ right =>
  if key = k then true else if key < k then right.contains k else left.contains k
