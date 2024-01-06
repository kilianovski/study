inductive MyNat where
  | zero : MyNat
  | succ (n : MyNat) : MyNat

def isEven (n : MyNat) : Bool :=
  match n with
  | MyNat.zero => true
  | MyNat.succ k => not (isEven k)


#eval isEven (MyNat.succ MyNat.zero)

def add (a : MyNat) (b : MyNat) :=
  match a with
  | MyNat.zero => b
  | MyNat.succ n => add n (MyNat.succ b)

def mul (a : MyNat) (b : MyNat) :=
  match a with
  | MyNat.zero => MyNat.zero
  | MyNat.succ n => add b (mul n b)

def three := MyNat.succ (MyNat.succ MyNat.zero)
