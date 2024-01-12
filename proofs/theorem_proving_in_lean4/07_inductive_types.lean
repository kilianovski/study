

inductive MyBool where
| the_false : MyBool
| the_true  : MyBool
deriving Repr

namespace MyBool
def and (a b : MyBool) : MyBool :=
match a with
| MyBool.the_true => b
| MyBool.the_false => MyBool.the_false

def or (a b : MyBool) : MyBool :=
match a with
| MyBool.the_true => MyBool.the_true
| _ => b

#eval (and the_true the_false)
#check (or the_true the_false)
#eval (or the_true the_false)
#eval (or the_false the_false)

end MyBool
#check Prod
#check Prod.casesOn -- ⊢ {α : Type u} →
  --  {β : Type v} → {motive : α × β → Sort u_1} → (t : α × β) → ((fst : α) → (snd : β) → motive (fst, snd)) → motive t

#check Prod.rec -- ⊢ {α : Type u} →
  -- {β : Type v} → {motive : α × β → Sort u_1} → ((fst : α) → (snd : β) → motive (fst, snd)) → (t : α × β) → motive t

def prod_example (p : Bool × Nat) : Nat :=
  Prod.casesOn (motive := fun _ => Nat) p (fun b n => cond b (2 * n) (2 * n + 1))

#eval prod_example (false, 3)
#eval prod_example (true, 3)


inductive MySum (α : Type u) (β : Type v) where
| inl : α → MySum α β
| inr : β → MySum α β

def x : MySum Bool Nat := MySum.inr 3
def y : MySum Bool Nat := MySum.inl False

-- {motive : MySum α β → Sort u_1}
#check MySum.casesOn -- (t : MySum α β) → ((a : α) → motive (MySum.inl a)) → ((a : β) → motive (MySum.inr a)) → motive t
#check @MySum.casesOn Bool Nat (fun _ => Sort 1) x (fun b => cond b Nat Float) (fun _ => String)
#check (@MySum.casesOn Bool Nat (fun _ => Sort 1) y (fun b => cond b Nat Float) (fun _ => String))

#check @MySum.casesOn
