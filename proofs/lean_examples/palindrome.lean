-- the arguments of the constructors can include objects of type Foo,
-- subject to a certain "positivity" constraint,
-- which guarantees that elements of Foo are built from the bottom up

inductive Weekday where
  | sunday
  | monday

#check fun (n:Weekday) => 4

#check Weekday.rec
#check Weekday.rec (motive := fun x => Sort 3)

inductive Palindrome : List α → Prop where
| nil : Palindrome α
| single : (a : α) → Palindrome [a]
| sandwich : (a : α) → Palindrome as → Palindrome ([a] ++ as ++ [a])

#check List.reverse

lemma sandwich_list_reverse

-- #check reverse
theorem palindrome_reverse ( h : Palindrome as) : (Palindrome as.reverse) := by
induction h
