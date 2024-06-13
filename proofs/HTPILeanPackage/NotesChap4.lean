import HTPILib.Chap4
import HTPILib.HTPIDefs

def Dom {A B : Type} (R : Set (A × B)) : Set A :=
  {a : A | ∃ (b : B), (a, b) ∈ R}


def comp {A B C : Type} (S : Set (B × C)) (R : Set (A × B)) : Set (A × C) :=
  {(a, c) : A × C | ∃ (b : B), (a, b) ∈ R ∧ (b, c) ∈ S}


def A := {1, 2, 3}
def B := {0, 1, 2}
def R := Set (A × B)

def D := @Dom (ℕ) (ℕ)


---


def M := Rel A B
def M' := Set (A × B)

def j := 1
def k := 42
def p := j ∈ A
def q := k ∈ B

def extension {A B : Type} (R : Rel A B) : Set (A × B) :=
  {(a, b) : A × B | R a b}

theorem ext_def {A B : Type} (R : Rel A B) (a : A) (b : B) :
    (a, b) ∈ extension R ↔ R a b := by rfl

def BinRel (A : Type) := Rel A A

def reflexive {A : Type} (R : BinRel A) : Prop :=
  ∀ (x : A), R x x

def symmetric {A : Type} (R : BinRel A) : Prop :=
  ∀ (x y : A), R x y → R y x

def transitive {A : Type} (R : BinRel A) : Prop :=
  ∀ (x y z : A), R x y → R y z → R x z

-- def qq := (M j k)
-- def pp := (j,k) ∈ M'

-- propositions (M a b) <--> (a,b) ∈ M' should be equivalent

-- [ ] How do you test if two propositions are equivalent?
-- [ ] How do you create two propositions in question?

-- [ ] How do you craft elementary prop in the first place?

variable (p : Prop)

axiom the_first_axiom : p
axiom the_second_axiom : p

def r := (the_first_axiom = the_second_axiom)
#check (the_first_axiom = the_second_axiom)

#eval (the_first_axiom = the_second_axiom)



theorem youtube_transitive {A : Type} (R : BinRel A) (h: ∀ (x y z : A), (R x y ∧ ¬R y z) → ¬R x z) : transitive R := by
  define
  fix x; fix y; fix z;
  assume hxy;
  assume hyz;
  have h1 := h x y z
  by_contra hnrxz
  contrapos at h1
  sorry



-- theorem Theorem_4_3_4_1



def antisymmetric {A : Type} (R : BinRel A) : Prop :=
  ∀ (x y : A), (R x y) → (R y x) → (x = y)

def partial_order {A : Type} (R : BinRel A) : Prop :=
  transitive R ∧ reflexive R ∧ antisymmetric R

def total_order {A : Type} (R : BinRel A) : Prop :=
  partial_order R ∧ ∀ (x y : A), (R x y) ∨ (R y x)

#check antisymmetric
-- def total_order

def smallestElt {A : Type} (R : BinRel A) (b : A) (B : Set A) : Prop :=
  b ∈ B ∧ ∀ x ∈ B, R b x

def minimalElt {A : Type} (R : BinRel A) (b : A) (B : Set A) : Prop :=
  b ∈ B ∧ ¬∃ x ∈ B, R x b ∧ x ≠ b



theorem Theorem_4_4_6_2 {A : Type} (R : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R) (h2 : smallestElt R b B) :
    minimalElt R b B ∧ ∀ (c : A), minimalElt R c B → b = c := by
    define at h1
    define at h2
    have ⟨hbB, hbSmallest⟩ := h2

    have hAntisymmetric := h1.right.right
    define at hAntisymmetric

    apply And.intro
    · -- Proof that b is minimal
      define
      apply And.intro hbB
      assume hExistsEvenSmaller
      obtain x hx from hExistsEvenSmaller
      have hRbx : R b x := (hbSmallest x) hx.left
      have hRxb : R x b := hx.right.left
      have hxb := hAntisymmetric x b hRxb hRbx
      show False from hx.right.right hxb
    . -- Proof that it is unique minimal
      intro c
      assume hmin
      have ⟨hcB, hmin⟩ := hmin

      contradict hmin with h4

      apply Exists.intro b

      apply And.intro hbB

      have h5 := (hbSmallest c) hcB
      apply And.intro h5
      show b ≠ c from h4


theorem Theorem_4_4_6_3 {A : Type} (R : BinRel A) (B : Set A) (b : A)
    (h1 : total_order R) (h2 : minimalElt R b B) : smallestElt R b B := by
    define
    define at h2
    have ⟨h_partial, h_total⟩ := h1
    define at h_partial

    have ⟨h_transitive, h_reflexive, h_antisymmetric⟩ := h_partial

    define at h_reflexive


    apply And.intro h2.left
    intro x

    assume hxB

    by_cases h4 : x = b
    -- Case 1. h4 : x = b

    rw [h4]
    show R b b from h_reflexive b

    -- Case 2. h4 : x ≠ b

    have h5 : ∀ (x y : A), R x y ∨ R y x := h1.right
    have h6 : R x b ∨ R b x := h5 x b

    have h7 : ¬R x b := by
      contradict h2.right with h8
      apply Exists.intro x
      apply And.intro hxB
      apply And.intro h8
      exact h4
      done

    disj_syll h6 h7
    show R b x from h6
