import Mathlib.Topology.Basic

#check TopologicalSpace
#check Set


-- [ ] TODO: define your own "difference" on propositions
-- [ ] Add :? infix notation
-- Prove that if x in (A \ B), it is not in B

-- Can Lean do computation on sets?
def SymmetricDifference {U : Type} (A : Set U) (B : Set U) := (A ∪ B) \ (A ∩ B)

#check SymmetricDifference

theorem trivial_symm_diff {U : Type} (A : Set U) (B : Set U) : SymmetricDifference A B = SymmetricDifference A B := by
  rfl



variable (U: Type)
variable (A : Set α) (B : Set α)

variable (sd: (A \ B) )

-- theorem sdiff_alternative_definition {U : Type} (A : Set U) (B : Set U) (h: (A \ B) ∪ (B \ A))  :(SymmetricDifference A B) := by
