#check And


variable (p q : Prop)

-- CONTRAPOSITIVE

theorem contrapositive (hpq : p → q) (hnq : ¬q) : ¬p :=
  fun hp : p => False.elim (hnq (hpq hp))


variable (j : Prop)

example (hp : p) (hnp : ¬p) : j := False.elim (hnp hp)

-- TODO: STATE CLEARLY WHY YOU CAN'T DO THIS
theorem wrong_contrapositive (hpq : p → q) (hnq : ¬q) : ¬p :=
  fun hp : p => False.elim ( hnq (hpq hp) )


-- ABSURD
#check absurd

-- TODO: what is the difference between p∧p → j and p → q → j?
-- 1.1 Connetct this to absurd signature


def my_absurd (hp : p) (hnp : ¬p) : j := False.elim (hnp hp)

def my_absurd2 (hp_hnp  : p∧¬p) : j :=
  have hp := And.left hp_hnp
  have hnp := And.right hp_hnp
  absurd hp hnp


theorem contra_contrapositive (hnpnq : ¬q → ¬p) (hp : p) : q :=
  sorry

-- IFF

theorem and_swap : p∧q ↔ q∧p :=
  Iff.intro
  (fun hpq : p∧q => And.intro (hpq.right) (hpq.left) )
  (fun hqp : q∧p => And.intro hqp.right hqp.left)


theorem or_subswap (h : p∨q) : q∨p :=
  h.elim (fun hp : p => Or.inr hp) (fun hq => Or.inl hq)


theorem or_swap : p∨q ↔ q∨p :=
  Iff.intro
  (fun hpq : p∨q => or_subswap p q hpq)
  (fun hqp : q∨p => or_subswap q p hqp)

-- SUFFICES TO SHOW

example (h : p ∧ q) : q ∧ p :=
  have hq := h.right
  suffices hp : p from ⟨hq, hp⟩
  show p from h.left





open Classical

#check Classical.em

#check Or.elim



theorem dne {p : Prop} (h : ¬¬p) : p :=
  have np := Classical.em p
  Or.elim np
  (fun hp : p => hp)
  (fun nhp : ¬p => absurd nhp h)


-- How does `dne` lead to proof by contradiction?

-- proof by contradiction means: to prove p, 
-- it suffices to assume ¬p and deriving false



-- EXERCISE: prove em from dne

axiom my_dne {a : Prop}  : ¬¬a → a

#check 1 = 2
#eval 2 = 3

#check my_dne
#check dne

#check Neg.mk

theorem neg_definition {b : Prop} (h : b → False) : ¬b  := h



theorem my_demorgan (h : ¬(p∨q)) : ¬p∧¬q :=
  have hnp : ¬p := fun hp : p =>
      have hpq : p ∨ q := Or.inl hp
      h hpq

  have hnq : ¬q := fun hq : q =>
      have hpq : p ∨ q := Or.inr hq
      h hpq

  And.intro hnp hnq


-- theorem my_weak_demorgan (h : ¬(p∨¬p)) : (¬p∧p) :=
--   my_dne (fun ng : ¬(¬p∧p) => )

theorem my_em  : (p ∨ ¬p) :=
  my_dne (fun nh : ¬(p ∨ ¬p) => 
  have h : ¬p ∧ ¬¬p := my_demorgan p (¬p) nh
  nh (Or.inr h.left)
  )


theorem my_em2  : (p ∨ ¬p) :=
  my_dne (fun nh : ¬(p ∨ ¬p) => 
  have h : ¬p ∧ ¬¬p := my_demorgan p (¬p) nh
  nh (Or.inr h.left)
  )


  -- suffices nh : (¬(p ∨ ¬p) → False) from my_dne nh

  -- show ¬h from sorry


open Classical

#check byCases
#check byContradiction
#check absurd
#check False.elim

-- https://github.com/leanprover/lean4/blob/0b64c1e3301f04b7b36fed76ee1593962f6c34e5/tests/lean/Reformat.lean.expected.out#L84
theorem my_absurd3 {a : Prop} {b : Prop} (h : a) (nh : ¬a) : b :=
  False.elim (nh h)

variable (p : Prop)

example (h: ¬¬p) : p :=
  byCases 
  (fun hp : p => hp)
  (fun hnp : ¬p => absurd hnp h)


example (h: ¬¬p) : p :=
  byContradiction
    (fun hn : ¬p => h hn)


theorem my_demorgan2 (h : ¬(p ∧ q)) : ¬p∨¬q :=
  have hpem := em p
  Or.elim hpem
  (fun hp : p   => 
  have hnq : ¬q := fun hq : q => h ⟨hp, hq⟩
  Or.inr hnq)
  (fun hnp : ¬p => Or.inl hnp)



-- EXERCISES

variable (p q r : Prop)

variable (test_hp : p)
variable (test_hq : q)
#check (And.intro test_hp test_hq)
#check (and_swap (And.intro test_hp test_hq))

-- commutativity of ∧ and ∨
example : p ∧ q ↔ q ∧ p := and_swap p q
example : p ∨ q ↔ q ∨ p := or_swap p q

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) := 
  Iff.intro
  (fun h : (p ∧ q) ∧ r => ⟨h.left.left, ⟨h.left.right, h.right⟩⟩)
  (fun h : p ∧ (q ∧ r) => ⟨⟨h.left, h.right.left⟩, h.right.right⟩)
  
example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := 
  Iff.intro
  (fun h => h.elim
    (fun hpq => hpq.elim
      (fun hp => Or.inl hp)
      (fun hq => Or.inr (Or.inl hq))
      )
    (fun hr => Or.inr (Or.inr hr))
  )
  (fun h => h.elim
  (fun hp => Or.inl (Or.inl hp))
  (fun hqr => hqr.elim
    (fun hq => Or.inl (Or.inr hq))
    (fun hr => Or.inr hr)
  )
  )

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) := sorry

example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) :=
  Iff.intro
  (fun h => h.elim
    (fun hp => ⟨ Or.inl hp, Or.inl hp ⟩)
    (fun hqr => ⟨Or.inr hqr.left, Or.inr hqr.right⟩)
  )

  (fun h => 
    h.left.elim
    (fun hp => Or.inl hp)
    (fun hq => h.right.elim
      (fun hp => Or.inl hp)
      (fun hr => Or.inr ⟨hq, hr⟩)
    )
  )

-- other properties
theorem imp2and : (p → (q → r)) ↔ (p ∧ q → r) := 
  Iff.intro
  (fun h => fun hpq => h hpq.left hpq.right)
  (fun h => fun hp => fun hq => h ⟨hp, hq⟩)

example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := 
  Iff.intro
  (fun h => ⟨fun hp => h (Or.inl hp), fun hq => h (Or.inr hq)⟩)
  (fun h => fun hpq => 
    hpq.elim
    (fun hp => h.left hp)
    (fun hq => h.right hq)
  )

example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := sorry
example : ¬p ∨ ¬q → ¬(p ∧ q) := sorry
example : ¬(p ∧ ¬p) := sorry
example : p ∧ ¬q → ¬(p → q) := sorry
example : ¬p → (p → q) := sorry
example : (¬p ∨ q) → (p → q) := sorry
example : p ∨ False ↔ p := sorry
example : p ∧ False ↔ False := sorry
example : (p → q) → (¬q → ¬p) := sorry


-- Prove ¬(p ↔ ¬p) without using classical logic.

-- TODO: describe what is going on!
theorem detuple : (p∧p → q) → (p → q) :=
  fun h => fun hp => h ⟨hp, hp⟩

theorem mega_theorem_no_classical_logic : ¬(p ↔ ¬p) := fun h =>
  have test := (imp2and p (p) False).mp
  have hnp : ¬p := detuple p False (test h.mp)
  have hp := h.mpr hnp
  hnp hp


open Classical

#check byCases

-- It is needed in the following example because
-- , from a constructive standpoint, 
-- knowing that p and q are not both true 
-- does not necessarily tell you which one is false:

example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
  Or.elim (em p)
  (fun hp => fun h => Or.inr (fun hq => h ⟨hp, hq⟩))
  (fun hnp => fun h => Or.inl hnp)

variable (p q r : Prop)

example : ((p → q) ∨ (p → r)) → (p → q ∨ r) :=
  fun h => h.elim
  (fun hpq => fun hp => Or.inl (hpq hp))
  (fun hpr => fun hp => Or.inr (hpr hp))

#check byCases
#check absurd

example : (p → q ∨ r) → ((p → q) ∨ (p → r)) :=
  fun h => 
  @byCases p ((p → q) ∨ (p → r))
  (fun hp : p => 
    have hqr := h hp
    show ((p → q) ∨ (p → r)) from
      hqr.elim 
        (fun hq => Or.inl (fun xp => hq))
        (fun hr => Or.inr (fun xq => hr))
  )
  (fun hnp : ¬p => 
    show ((p → q) ∨ (p → r)) from
    Or.inl (fun hp : p => show q from absurd hp hnp)
  )
example : ¬(p ∧ q) → ¬p ∨ ¬q :=
  (fun h => my_demorgan2 q p h)

theorem impl_ass {p q r : Prop} :  ((p → q) → r) → (p → q → r) :=
  fun h => fun hp => fun hq => h (fun _ => hq)

theorem conditional_law : ¬(p → q) → p ∧ ¬q :=
  fun hnpq : (p → q) →  False =>
  show p ∧ ¬q from @byCases p (p ∧ ¬q)
    (fun hp : p => 
      have h2 := impl_ass hnpq
      have hnq : ¬q := h2 hp
      ⟨hp, hnq⟩
    )
    (fun hnp : ¬p => 
      have h2 := impl_ass hnpq
    )


example : (p → q) → (¬p ∨ q) := sorry
example : (¬q → ¬p) → (p → q) := sorry
example : p ∨ ¬p := sorry
example : (((p → q) → p) → p) := sorry
