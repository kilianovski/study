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

theorem Theorem_4_3_10 {A : Type} (R : BinRel A) :
    {(x, x) : Dom (extension R) | x = y} ⊆ extension R := by

    sorry