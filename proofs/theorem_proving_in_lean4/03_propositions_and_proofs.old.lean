#eval Lean.versionString
#check False.elim

theorem t1 {p q : Prop} (hp : p) (hq : q) : p := hp

#check t1
#print t1


theorem t2 (h₁ : q → r) (h₂ : p → q) : p → r := 
  fun (hp : p) => 
    h₁ (h₂ hp)

theorem t2_1 (h₁ : q → r) (h₂ : p → q) : p → r :=
  by assume h: 
    h₁ (h₂ hp)

variable (p q : Prop)

-- **************** CONJUNCTION
variable (p q : Prop)

theorem my_t0 : (p → q → p ∧ q) := 
  fun hp :p => fun hq : q => And.intro hp hq

theorem my_and_comm : (p ∧ q -> q ∧ p ) := 
  fun ⟨hp, hq⟩ => ⟨hq, hp⟩

variable (my_hp : p)

#check p
#check my_hp

example (h: p ∨ q) : q ∨ p := 
  Or.elim h 
  (fun hp => Or.intro_right q hp)
  (fun hq => Or.intro_left  p hq)


-- EXERCISES

variable (p q r : Prop)


-- commutativity of ∧ and ∨
-- example : p ∧ q ↔ q ∧ p := 
--   Iff.intro



#check Or.intro_left
example : p ∨ q ↔ q ∨ p := sorry

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) := sorry
example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := sorry

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) := 
  Iff.intro
  (fun h =>
    have hp := h.left
    h.right.elim 
    (fun hq => Or.intro_left (p ∧ r) (And.intro hp hq))
    (fun hr => Or.intro_right (p ∧ q) (And.intro hp hr))
    )
  (fun h  => 
    h.elim 
      (fun hpq => And.intro hpq.left (Or.intro_left r hpq.right))
      (fun hpr => And.intro hpr.left (Or.intro_right q hpr.right))
    )
  
example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) := 
  Iff.intro
  (fun h => sorry)
  (fun h => sorry)

-- other properties
example : (p → (q → r)) ↔ (p ∧ q → r) := sorry
example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := sorry
example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := sorry
example : ¬p ∨ ¬q → ¬(p ∧ q) := sorry
example : ¬(p ∧ ¬p) := sorry
example : p ∧ ¬q → ¬(p → q) := sorry
example : ¬p → (p → q) := sorry
example : (¬p ∨ q) → (p → q) := sorry
example : p ∨ False ↔ p := sorry
example : p ∧ False ↔ False := sorry
example : (p → q) → (¬q → ¬p) := sorry
