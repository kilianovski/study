-- The Universal Quantifier

-- I think, universal quantifier MUST act on predicates.
-- Can it act on non-predicates? 
-- Well, looks like in most cases universal quantifier is about predicates, so let us focus on that.
-- > Typically, the expression p will depend on x : α

-- So, how can a predicate look like in Lean?
-- Let us think about predicates as of functions that takes a value and returns boolean.
-- Can we think about them in such way?

variable (α : Type)

-- Unary Predicate in Lean:
#check (α → Prop)
-- #check Proof

-- What is the introduction rule for the UQ?

example (α : Type) (p q : α → Prop) : (∀ x : α, p x ∧ q x) → ∀ y : α, p y :=
  fun h1 : ((x : α) → (p x ∧ q x)) => (fun y : α => show p y from (h1 y).left)


-- As another example, here is how we can express the fact that a relation, r, is transitive:

variable (α : Type) (r : α → α → Prop)
variable (trans_r : ∀ x y z, r x y → r y z → r x z)

variable (a b c : α)
variable (hab : r a b)
variable (hbc : r b c)

#check trans_r
#check trans_r a
#check trans_r a b
#check trans_r a b c
#check trans_r a b c hab
#check trans_r b c a hbc


variable (α : Type) (r : α → α → Prop)
variable (trans_r : ∀ {x y z}, r x y → r y z → r x z)

variable (a b c : α)
variable (hab : r a b) (hbc : r b c)

#check trans_r
#check @trans_r a b c hab
#check trans_r hab hbc


variable (α : Type) (r : α → α → Prop)

variable (refl_r : ∀ x, r x x)
variable (symm_r : ∀ {x y}, r x y → r y x)
variable (trans_r : ∀ {x y z}, r x y → r y z → r x z)

example (a b c d : α) (hab : r a b) (hcb : r c b) (hcd : r c d) : r a d :=
  trans_r (trans_r hab (symm_r hcb)) hcd


example (a b c d : α) (hab : r a b) (hcb : r c b) (hcd : r c d) : r a d :=
  have hbc := symm_r hcb
  have hac := trans_r hab hbc
  have had := trans_r hac hcd
  had
  -- show r a d from had

#check Eq.subst

example (α : Type) (a b : α) (p : α → Prop)
        (h1 : a = b) (h2 : p a) : p b :=
  Eq.subst h1 h2

example (α : Type) (a b : α) (p : α → Prop)
        (h1 : a = b) (h2 : p a) : p b :=
  h1 ▸ h2


-- EQUALITY

variable (α β : Type)

example (a : α) (b : β) : (a, b).2 = b := Eq.refl _


example (x y : Nat) : (x + y) * (x + y) = x * x + y * x + x * y + y * y :=
  have h1 : (x + y) * (x + y) = (x + y)*x + (x + y)*y := Nat.mul_add (x+y) x y

  
  -- have h2 : (x*x + y*x) := 
  sorry



-- EXERCISES

variable (α : Type) (p q : α → Prop)

example : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x) :=
  Iff.intro
  (fun h : ((x : α) → p x ∧ q x) => 
  ⟨fun hx => (h hx).left, fun hx => (h hx).right⟩
  )
  (fun hpq : ((x:α) → p x) ∧ ((x:α) → q x)  =>
    fun hx => ⟨hpq.left hx, hpq.right hx⟩
  )


example : (∀ x, p x → q x) → (∀ x, p x) → (∀ x, q x) :=
  fun h : ((x:α) → p x → q x) => 
    fun h1 : ((y:α) → p y)  => 
      fun z : α =>
        have h2 : (p z → q z) := h z
        have pz : p z := h1 z
      h2 pz



example : (∀ x, p x) ∨ (∀ x, q x) → ∀ x, p x ∨ q x :=
  fun hor => hor.elim
    (fun h : (∀ x, p x) => fun x : α => Or.inl (h x))
    (fun h : (∀ x, q x) => fun x : α => Or.inr (h x))

variable (α : Type) (p q : α → Prop)
variable (r : Prop)

example : α → ((∀ x : α, r) ↔ r) :=
  fun a => Iff.intro
  (fun h => h a)
  (fun h => fun _ => h)

open Classical

#check byCases

example : (∀ x, p x ∨ r) ↔ (∀ x, p x) ∨ r :=
  Iff.intro
  (fun h => byCases
    (fun hr : r => Or.inr hr)
    (fun hnr : ¬r => Or.inl fun hx : α => 
      have res : (p hx ∨ r) := h hx
      res.elim 
        (fun hpx : (p hx) => hpx)
        (fun hr : r => absurd hr hnr)
    )
  )


  (fun h => fun (hx:α) => h.elim
    (fun hf => Or.inl (hf hx))
    (fun hr => Or.inr hr)
  )


example : (∀ x, r → p x) ↔ (r → ∀ x, p x) :=
  Iff.intro
  (fun h : ((x:α) → r → p x) => fun hr => fun hx => (h hx) hr)
  (fun h : (r → (x:α) → p x) => fun hx => fun hr => (h hr) hx)

variable (g : Nat → Nat → Nat)
variable (hg : g 0 0 = 0)

theorem gex1 : ∃ x, g x x = x := ⟨0, hg⟩
theorem gex2 : ∃ x, g x 0 = x := ⟨0, hg⟩
theorem gex3 : ∃ x, g 0 0 = x := ⟨0, hg⟩
theorem gex4 : ∃ x, g x x = 0 := ⟨0, hg⟩

set_option pp.explicit true  -- display implicit arguments
#print gex1
#print gex2
#print gex3
#print gex4

variable (α : Type) (p q : α → Prop)

#check Exists.elim

example (h : ∃ x, p x ∧ q x) : ∃ x, q x ∧ p x :=
  h.elim
  (fun w => fun hpq => Exists.intro w (⟨hpq.right, hpq.left⟩))


example (h : ∃ x, p x ∧ q x) : ∃ x, q x ∧ p x :=
  match h with
  | ⟨w, hpw, hqw⟩ => ⟨w, hqw, hpw⟩



open Classical

variable (α : Type) (p q : α → Prop)
variable (r : Prop)

example : (∃ x : α, r) → r := fun h => h.elim fun a => fun hr => hr

example (a : α) : r → (∃ x : α, r) := fun hr => Exists.intro a hr

example : (∃ x, p x ∧ r) ↔ (∃ x, p x) ∧ r :=
  Iff.intro
  (fun h => h.elim fun w => fun ⟨pw, hr⟩ => ⟨Exists.intro w pw, hr⟩
  )
  (fun ⟨he, hr⟩ => he.elim fun w => fun pw => Exists.intro w ⟨pw, hr⟩)


example : (∃ x, p x ∨ q x) ↔ (∃ x, p x) ∨ (∃ x, q x) := Iff.intro
  (fun h => h.elim fun w => fun pw => pw.elim 
    (fun hp => Or.inl (Exists.intro w hp))
    (fun hq => Or.inr (Exists.intro w hq)))

  (fun h => h.elim
    (fun hl => hl.elim fun w => fun pw => Exists.intro w (Or.inl pw))
    (fun hl => hl.elim fun w => fun pw => Exists.intro w (Or.inr pw))
  )


#check byContradiction


example : (∀ x, p x) ↔ ¬ (∃ x, ¬ p x) := Iff.intro
  (fun h : (x : α) → p x  => fun he : ∃ x, (p x → False) => 
    he.elim fun w => fun hnpw =>
      have pw := h w
      show False from hnpw pw
  )

  (fun hne : (∃ x, (p x → False)) → False => fun w : α => byContradiction (fun hnp : ¬p w => 
    have he : ∃ x, ¬ p x := Exists.intro w hnp
    show False from hne he
    )
  )


example : (∃ x, p x) ↔ ¬ (∀ x, ¬ p x) := Iff.intro
  (fun h => fun ha => h.elim fun w => fun pw => 
    have hn : ¬ p w := ha w
    hn pw
  )


  (fun h : (∀ x, ¬ p x) → False => byContradiction (fun hnp => sorry))


example : (¬ ∃ x, p x) ↔ (∀ x, ¬ p x) := sorry
example : (¬ ∀ x, p x) ↔ (∃ x, ¬ p x) := sorry

example : (∀ x, p x → r) ↔ (∃ x, p x) → r := sorry


example (a : α) : (∃ x, p x → r) ↔ (∀ x, p x) → r := Iff.intro
(fun h : (∃ x, p x → r) => fun ha : ((x : α) → p x) => h.elim fun u => fun pur => 
  have pu : p u := ha u
  show r from pur pu
)


(fun h => sorry)


example (a : α) : (∃ x, r → p x) ↔ (r → ∃ x, p x) := sorry
