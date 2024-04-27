import HTPILib.HTPIDefs

def Dom {A B : Type} (R : Set (A × B)) : Set A :=
  {a : A | ∃ (b : B), (a, b) ∈ R}


def comp {A B C : Type} (S : Set (B × C)) (R : Set (A × B)) : Set (A × C) :=
  {(a, c) : A × C | ∃ (b : B), (a, b) ∈ R ∧ (b, c) ∈ S}


def A := {1, 2, 3}
def B := {0, 1, 2}
def R := Set (A × B)

def D := @Dom (ℕ) (ℕ)
