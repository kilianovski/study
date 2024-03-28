
-- 3 language

-- what is a Type? What is a Prop?


-- So they say:

-- "Every expression has a type. Those are mathematical objects"

#check (2 + 2)
#eval (2 + 2)

#check Nat
#check Prop
#check Sort 1
#check Type 2

-- #check ℕ

def f (x : Nat) := (x + 3)

#check f

-- "Some expressions have type `Prop`. These are mathematical statements."
#check (2 + 2 = 4)

-- "Some expressions have type `P`, where `P` itself has a type `Prop`."
-- Such an expression is a proof of the proposition `P`

theorem simple : (2 + 2 = 4) := by rfl

#check (simple)
