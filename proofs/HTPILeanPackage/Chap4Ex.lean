import HTPILib.Chap4
namespace HTPI.Exercises



/- Section 4.2 -/
-- 1.
theorem Exercise_4_2_9a {A B C : Type} (R : Set (A × B))
    (S : Set (B × C)) : Dom (comp S R) ⊆ Dom R := by
    define
    fix a : A
    assume h1
    define
    define at h1
    obtain c h2 from h1
    define at h2
    obtain b h3 from h2
    apply Exists.intro b
    exact h3.left

    done




-- 2.
theorem Exercise_4_2_9b {A B C : Type} (R : Set (A × B))
    (S : Set (B × C)) : Ran R ⊆ Dom S → Dom (comp S R) = Dom R := by
    intro h1
    apply Set.ext
    fix a : A
    apply Iff.intro
    . --
        intro h2
        define at h2
        obtain c h3 from h2
        define at h3
        define
        obtain b h4 from h3
        apply Exists.intro b
        show (a, b) ∈ R from h4.left
    . --
        intro h2
        define at h1
        define at h2
        obtain b h3 from h2
        define
        have h_b_RanR : (b ∈ Ran R) := by
            apply Exists.intro a -- b ∈ Ran R --> (a, b) ∈ R
            show (a, b) ∈ R from h3

        have h_b_DomS : (b ∈ Dom S) := h1 h_b_RanR
        define at h_b_DomS
        obtain c h4 from h_b_DomS
        apply Exists.intro c
        define
        apply Exists.intro b
        show (a, b) ∈ R ∧ (b, c) ∈ S from ⟨h3, h4⟩

    done



-- 3.
--Fill in the blank to get a correct theorem and then prove the theorem
theorem Exercise_4_2_9c {A B C : Type} (R : Set (A × B))
    (S : Set (B × C)) : Dom S ⊆ Ran R → Ran (comp S R) = Ran S := by
    intro h1
    define at h1
    apply Set.ext
    fix c
    apply Iff.intro
    . -- c ∈ Ran (comp S R) → c ∈ Ran S
        intro h2
        define
        define at h2
        obtain a h3 from h2
        define at h3
        obtain b h4 from h3
        apply Exists.intro b
        show (b, c) ∈ S from h4.right
    . -- c ∈ Ran S -> c ∈ Ran (comp S R)
        intro h2
        define
        define at h2
        obtain b h3 from h2

        have h5 := @h1 b

        have hb_RanR : (b ∈ Ran R) := by
            apply h5
            define
            apply Exists.intro c
            show (b, c) ∈ S from h3
            done

        define at hb_RanR
        obtain a h6 from hb_RanR
        apply Exists.intro a
        define
        apply Exists.intro b
        show (a, b) ∈ R ∧ (b, c) ∈ S from ⟨h6, h3⟩

    done


-- 4.
theorem Exercise_4_2_12a {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    (comp S R) \ (comp T R) ⊆ comp (S \ T) R := by
    define
    intro ⟨a,c⟩ h1
    define
    define at h1

    have ⟨h2, h3⟩ := h1
    define at h2
    obtain b hb from h2
    apply Exists.intro b

    apply And.intro

    show (a, b) ∈ R from hb.left
    define
    apply And.intro
    show (b, c) ∈ S from hb.right

    assume hn

    define at h3


    have hcontra : (a, b) ∈ R ∧ (b, c) ∈ T := ⟨hb.left, hn⟩
    have xxx : ∃ (x : B), (a, x) ∈ R ∧ (x, c) ∈ T := by
        apply Exists.intro b
        exact hcontra

    have xx := h3 xxx
    show False from xx
    done


-- 5.
--You won't be able to complete this proof
theorem Exercise_4_2_12b {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    comp (S \ T) R ⊆ (comp S R) \ (comp T R) := by
    define
    fix ⟨a,c⟩
    assume h1
    define at h1
    obtain b h2 from h1

    have ⟨h3, h4⟩ :  ((b,c) ∈ S) ∧ ((b,c) ∉ T) := h2.right
    have h5 : (a,c) ∈ comp S R := by
        define
        apply Exists.intro b
        show (a, b) ∈ R ∧ (b, c) ∈ S from ⟨h2.left, h3⟩

    -- this is where the mistake comes:

    -- we need to prove non-existence of element x
    -- ¬∃ (x : B), (a, x) ∈ R ∧ (x, c) ∈ T
    -- satisfying property (a, x) ∈ R ∧ (x, c) ∈ T
    -- and proof tries to do it with showing that
    -- particular element b does not satisfy property (b, c) ∉ T
    -- thanks for reference to https://github.com/debbie-drg/HowToProveItWithLean/blob/main/Chap4Ex.lean#L121
    have h6 : (a,c) ∉ comp T R := by
        define
        sorry
    -- have ⟨h3 : ((b,c) ∈ S), h4 :  ⟩ := sorry


-- self-BONUS

theorem Exercise_4_2_14a {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :

    (S ⊆ T) → (comp S R ⊆ comp T R) := by
        assume h1
        define
        fix ⟨a,c⟩
        assume h2
        define at h2
        obtain b h3 from h2

        define at h1
        obtain h4 : (b,c) ∈ T := by
            exact h1 h3.right

        define
        apply Exists.intro b
        show (a, b) ∈ R ∧ (b, c) ∈ T from ⟨h3.left, h4⟩




-- 6.
--You might not be able to complete this proof
theorem Exercise_4_2_14c {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    comp (S ∩ T) R = (comp S R) ∩ (comp T R) := by

    /-
    R = { (0,0), (0, 1) }

    S = { (0, a) }
    T = { (1, a) }

    comp S R = { (0, a) }
    comp T R = { (0, a) }
    (comp S R) ∩ (comp T R) = {}


    S ∩ T = {}
    comp (S ∩ T) R = {}

    -/
    sorry



-- 7.
--You might not be able to complete this proof
theorem Exercise_4_2_14d {A B C : Type}
    (R : Set (A × B)) (S T : Set (B × C)) :
    comp (S ∪ T) R = (comp S R) ∪ (comp T R) := by
    apply Set.ext
    fix ⟨a,c⟩

    apply Iff.intro

    . -- (a, c) ∈ comp (S ∪ T) R → (a, c) ∈ comp S R ∪ comp T R
        intro h1
        define  at h1
        obtain b h2 from h1
        define
        have h3 := h2.right
        define at h3
        by_cases on h3
        . -- Case 1: (b, c) ∈ S
            have h4 : (a, c) ∈ comp S R := by
                define
                apply Exists.intro b
                show (a, b) ∈ R ∧ (b, c) ∈ S from ⟨h2.left, h3⟩
            exact Or.inl h4

        . -- Case 2: (b, c) ∈ T
            have h4 : (a, c) ∈ comp T R := by
                define
                apply Exists.intro b
                show (a, b) ∈ R ∧ (b, c) ∈ T from ⟨h2.left, h3⟩
            exact Or.inr h4
    . -- (a, c) ∈ comp S R ∪ comp T R → (a, c) ∈ comp (S ∪ T) R
        intro h1
        define
        define at h1
        by_cases on h1
        . -- Case 1: h1 : (a, c) ∈ comp S R
            define at h1
            obtain b hb from h1
            apply Exists.intro b
            apply And.intro
            show (a, b) ∈ R from hb.left
            apply Or.inl
            show (b, c) ∈ S from hb.right
        . -- Case 2: h1 : (a, c) ∈ comp T R
            define at h1
            obtain b hb from h1
            apply Exists.intro b
            apply And.intro
            show (a, b) ∈ R from hb.left
            apply Or.inr
            show (b, c) ∈ T from hb.right
    done


/- Section 4.3 -/

theorem Theorem_4_3_4_2 {A : Type} (R : BinRel A) :
    symmetric R ↔ extension R = inv (extension R) := by
    apply Iff.intro
    . -- symmetric R -> (R == inv R)
        assume h1 : symmetric R
        define at h1 -- h1 : ∀ (x y : A), R x y → R y x
        ext ⟨x,y⟩
        show (x, y) ∈ extension R ↔ (x, y) ∈ inv (extension R) from
            calc (x, y) ∈ extension R
            _ ↔ R x y := by rfl
            _ ↔ R y x := by exact (Iff.intro (h1 x y) (h1 y x))
            _ ↔ (y, x) ∈ (extension R) := by rfl
            _ ↔ (x, y) ∈ inv (extension R) := by rfl
    . -- (R == inv R) -> symmetric R
        assume h1 : extension R = inv (extension R)
        define
        fix x; fix y;
        assume h2 : R x y
        -- have h3 : (x,y) ∈ extension R := ext_def R x y
        have h3 := (ext_def R x y).mpr h2

        rw [h1] at h3

        define at h3
        exact h3


-- 1.

example :
    elementhood Int 6 {n : Int | ∃ (k : Int), n = 2 * k} := by
    define
    apply Exists.intro 3
    rfl


-- 2.
theorem Theorem_4_3_4_1 {A : Type} (R : BinRel A) :
    reflexive R ↔ {(x, y) : A × A | x = y} ⊆ extension R := by
    apply Iff.intro
    . -- reflexive R -> i_A ⊆ R
        assume h1
        define at h1

        define
        fix ⟨x,y⟩
        assume h2
        define at h2
        define
        have h3 := h1 y
        rw [h2]
        show R y y from h3
    . -- i_A ⊆ R -> reflexive R
        assume h1
        define at h1
        define
        fix x
        have pair : A × A := ⟨x,x⟩

        have h2 := @h1 ⟨x,x⟩
        have h3 :((x, x) ∈ {(x, y) : A × A | x = y}) := by
            rfl
        have h4 := h2 h3
        define at h4
        show R x x from h4

#check RelFromExt
#check ext_def

-- 3.
theorem Theorem_4_3_4_3 {A : Type} (R : BinRel A) :
    transitive R ↔
      comp (extension R) (extension R) ⊆ extension R := by
      apply Iff.intro
      . -- transitive -> R ∘ R ⊆ R
        assume h1
        fix ⟨x,y⟩

        assume h2
        define at h2
        obtain z h3 from h2
        define at h1
        have h4 := h1 x z y
        have h5 := h4 ((ext_def R x z).mp h3.left) ((ext_def R z y).mp h3.right)

        show (x, y) ∈ extension R from (ext_def R x y).mpr  h5


      . -- (R ∘ R) ⊆ R --> transitive
        assume h1
        define
        define at h1

        fix x; fix y; fix z;
        have h1 := @h1 ⟨x, z⟩
        assume h2; assume h3;


        have h_comp :  (x, z) ∈ comp (extension R) (extension R)  := by
            define
            apply Exists.intro y
            -- have h4 :=
            show (x, y) ∈ extension R ∧ (y, z) ∈ extension R
                from ⟨(ext_def R x y).mpr h2, (ext_def R y z).mpr h3⟩


        have h5 := (ext_def R x z).mp (h1 h_comp)

        show R x z from h5



theorem Exercise_4_3_12a_more_general {A : Type} (R : BinRel A) :
    reflexive R ↔
    reflexive (RelFromExt (inv (extension R))) := by
    apply Iff.intro
    --
    . --
        assume h1
        define at h1
        define
        intro a
        define
        exact h1 a
    . --
        assume h1
        define at h1
        define
        fix a
        have h2 := h1 a
        define at h2
        show R a a from h2



-- 4.
-- Reflexive means ∀ x, R x x
theorem Exercise_4_3_12a {A : Type} (R : BinRel A) (h1 : reflexive R) :
    reflexive (RelFromExt (inv (extension R))) := by
    define
    fix x
    define
    define at h1
    show R x x from h1 x
    done

-- transitive means: R x y -> R y z -> R x z

-- theorem says: transitive R → transitive inv R
-- R y x -> R z y -> R z x
-- 5.
theorem Exercise_4_3_12c {A : Type} (R : BinRel A) (h1 : transitive R) :
    transitive (RelFromExt (inv (extension R))) := by
    define at h1
    define
    fix x; fix y; fix z;
    assume h2; define at h2
    assume h3; define at h3;
    define;

    have proof := (h1 z y x) h3 h2
    exact proof;


-- S ∘ R ⊆ R ∘ S → transitive (R ∘ S)
-- 6.

theorem Exercise_4_3_18b {A : Type}
    (R S : BinRel A) (h1 : transitive R) (h2 : transitive S)
    (h3 : comp (extension S) (extension R) ⊆
      comp (extension R) (extension S)) :

      extension R ⊆ extension S := by
      define
      fix ⟨x, y⟩
      assume h4;

      define at h3;
      have h3₁ := @h3 ⟨x, y⟩
      have mh1 : ((x, y) ∈ comp (extension S) (extension R)) := by
        define;
        sorry
      define;
      sorry


theorem Exercise_4_3_18 {A : Type}
    (R S : BinRel A) (h1 : transitive R) (h2 : transitive S)
    (h3 : comp (extension S) (extension R) ⊆
      comp (extension R) (extension S)) :
    transitive (RelFromExt (comp (extension R) (extension S))) := by
    define
    fix x; fix y; fix z;
    assume hRSxy; define at hRSxy;
    assume hRSyz; define at hRSyz;
    obtain a₁ hr₁ from hRSxy;
    obtain a₂ hr₂ from hRSyz;

    define;

    define at h3;

    have hm1 : (a₁, a₂) ∈ comp (extension S) (extension R) := by
        define
        apply Exists.intro y
        show (a₁, y) ∈ extension R ∧ (y, a₂) ∈ extension S from ⟨hr₁.right, hr₂.left⟩

    have hm2 : (a₁, a₂) ∈ comp (extension R) (extension S) := h3 hm1
    define at hm2

    obtain a₃ hr₃ from hm2;

    ---
    define at h1;
    define at h2;
    apply Exists.intro a₃
    apply And.intro

    .
        define
        have hpart1 : (S x a₁ → S a₁ a₃ → S x a₃) := h2 x a₁ a₃

        -- describe 'long way'
        have hp1_1 : (S x a₁) := (ext_def S x a₁).mp hr₁.left
        have hp1_2 : (S a₁ a₃) := (ext_def S a₁ a₃).mp hr₃.left
        -- shortcut because S is transitive

        show S x a₃ from hpart1 hp1_1 hp1_2
    .
        define
        have hpart1 : (R a₃ a₂ → R a₂ z → R a₃ z) := h1 a₃ a₂ z

        -- long way from a₃ to z through a₂
        have hp1_1 : (R a₃ a₂) := (ext_def R a₃ a₂).mp hr₃.right
        have hp1_2 : (R a₂ z) := (ext_def R a₂ z).mp hr₂.right

        -- shortcut to z
        show R a₃ z from hpart1 hp1_1 hp1_2




lemma obtain_nonempty {A : Type} {X : Set A} (h : X ≠ ∅) : X.Nonempty := by
    by_contra' h1
    show False from h h1


-- 7.
theorem Exercise_4_3_20 {A : Type} (R : BinRel A) (S : BinRel (Set A))
    (h : ∀ (X Y : Set A), S X Y ↔ X ≠ ∅ ∧ Y ≠ ∅ ∧
    ∀ (x y : A), x ∈ X → y ∈ Y → R x y) :
    transitive R → transitive S := by
    assume h1
    define; define at h1;
    fix X; fix Y; fix Z;

    assume hSXY; assume hSYZ;
    -- have hSXY := extension S

    have ⟨hXne, hYne, hXY⟩ := (h X Y).mp hSXY
    have ⟨hYne, hZne, hYZ⟩ := (h Y Z).mp hSYZ

    apply (h X Z).mpr

    apply And.intro
    show X ≠ ∅ from hXne

    apply And.intro
    show Z ≠ ∅ from hZne
    fix x; fix z; assume hx; assume hz;


    define at hYne;

    obtain y hy from obtain_nonempty hYne;
    have hRxy : R x y  := hXY x y hx hy
    have hRyz : R y z  := hYZ y z hy hz
    -- have q :=
    show R x z from h1 x y z hRxy hRyz



-- 8.
--You might not be able to complete this proof
theorem Exercise_4_3_13b {A : Type}
    (R1 R2 : BinRel A) (h1 : symmetric R1) (h2 : symmetric R2) :
    symmetric (RelFromExt ((extension R1) ∪ (extension R2))) := by
    define at h1; define at h2;
    define;
    fix x; fix y;
    assume h3;
    define at h3;
    define;

    by_cases on h3;


    define at h3;
    have t := (ext_def R1 y x).mpr ((h1 x y) h3)
    exact Or.inl t

    define at h3;
    have t : (y,x) ∈ extension R2 := (ext_def R2 y x).mpr ((h2 x y) h3)
    exact Or.inr t

    -- show (y, x) ∈ extension R1 from t


-- 9.
--You might not be able to complete this proof
theorem Exercise_4_3_13c {A : Type}
    (R1 R2 : BinRel A) (h1 : transitive R1) (h2 : transitive R2) :
    transitive (RelFromExt ((extension R1) ∪ (extension R2))) := sorry

-- 10.
--You might not be able to complete this proof
theorem Exercise_4_3_19 {A : Type} (R : BinRel A) (S : BinRel (Set A))
    (h : ∀ (X Y : Set A), S X Y ↔ ∃ (x y : A), x ∈ X ∧ y ∈ Y ∧ R x y) :
    transitive R → transitive S := sorry

/- Section 4.4 -/
-- 1.
theorem Example_4_4_3_1 {A : Type} : partial_order (sub A) := by
    define
    apply And.intro
    -- reflexive ⊆
    define
    fix x;
    define
    fix a;
    assume h; exact h;

    apply And.intro
    -- transitive
    define
    fix X; fix Y; fix Z;
    assume hxy
    define at hxy;

    assume hyz
    define at hyz;

    define;
    fix a
    assume hx
    have hy := hxy hx
    exact hyz hy

    define
    fix X; fix Y;
    assume hXY
    define at hXY

    assume hYX
    define at hYX
    ext x;
    apply Iff.intro

    . -- x ∈ X → x ∈ Y
        assume hX
        show x ∈ Y from hXY hX
    . --
        assume hY
        show x ∈ X from hYX hY

-- Smallest el: ∀ x ∈ B, bRx
-- Minimal el: ¬∃ x ∈ B, (xRb) ∧ (x ≠ b)

-- 2.
theorem Theorem_4_4_6_1 {A : Type} (R : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R) (h2 : smallestElt R b B) :
    ∀ (c : A), smallestElt R c B → b = c := by

    -- How to prove it?
    -- Goal: smallest b is unique ---> no c ≠ b such that c is also smallest
    -- More formally: from `smallest c` we can conclude that `c = b`
    -- How?
    -- ...
    -- smallest means ∀ x, bRx.
    -- Even for `c`
    -- that is, bRc
    -- but c is also smallest
    -- antisymmetry!

    define at h1
    define at h2

    have h_antisymmetric := h1.right.right
    define at h_antisymmetric;
    fix c
    assume h_c_smallest
    define at h_c_smallest

    have h_cRb := h_c_smallest.right b h2.left
    have h_bRc := h2.right c h_c_smallest.left

    have proof := h_antisymmetric b c h_bRc h_cRb

    exact proof



-- lub = smallestElt R a {c : A | upperBd R c B}
-- upperBd = ∀ x ∈ B, R x a
-- 3.
--If F is a set of sets, then ⋃₀ F is the lub of F in the subset ordering
theorem Theorem_4_4_11 {A : Type} (F : Set (Set A)) :
    lub (sub A) (⋃₀ F) F := by
    define
    apply And.intro
    -- (⋃₀ F) is upperBd
    define
    fix X
    assume h1
    define
    fix a
    assume h2
    define
    apply Exists.intro X
    show X ∈ F ∧ a ∈ X from ⟨h1, h2⟩


    -- smallest
    -- Proof Plan: we need to prove that (⋃₀ F) is smaller then any upperBd
    -- that is, (⋃₀ F) ⊆ X, where X is upperBd
    -- if X is upperBd, every set Y in F: Y ⊆ X
    -- Goal (⋃₀ F) ⊆ X transform to (Z from F) ⊆ X
    --
    fix X
    assume h1 -- h1: X - upperBd
    define at h1 -- definition of upperBd: ∀ x ∈ F, sub A x X
    define
    fix a : A
    assume h2 -- a ∈ ⋃₀ F
    define at h2
    obtain Z h3 from h2
    have h4 := h1 Z h3.left
    define at h4
    show a ∈ X from h4 h3.right


-- 4.
theorem Exercise_4_4_8 {A B : Type} (R : BinRel A) (S : BinRel B)
    (T : BinRel (A × B)) (h1 : partial_order R) (h2 : partial_order S)
    (h3 : ∀ (a a' : A) (b b' : B),
      T (a, b) (a', b') ↔ R a a' ∧ S b b') :
    partial_order T := by
    define

    apply And.intro
    -- reflexive T

    define
    fix p
    have ⟨a,b⟩ := p
    have Raa := h1.left a
    have Sbb := h2.left b
    have reflexive := (h3 a a b b).mpr ⟨Raa, Sbb⟩
    exact reflexive

    apply And.intro
    -- transitive T
    define

    fix ⟨a₁, b₁⟩;
    fix ⟨a₂, b₂⟩;
    fix ⟨a₃, b₃⟩;

    assume hT1
    assume hT2

    have ⟨hR1, hS1⟩ := (h3 a₁ a₂ b₁ b₂).mp hT1
    have ⟨hR2, hS2⟩ := (h3 a₂ a₃ b₂ b₃).mp hT2

    -- have hR3  := h1.right.left hR1 hR2
    have hR3 : (R a₁ a₃) := (h1.right.left a₁ a₂ a₃) hR1 hR2
    have hS3 : (S b₁ b₃) := (h2.right.left b₁ b₂ b₃) hS1 hS2

    have proof := (h3 a₁ a₃ b₁ b₃).mpr ⟨hR3, hS3⟩
    exact proof

    -- antisymmetric!
    define

    fix ⟨a₁, b₁⟩;
    fix ⟨a₂, b₂⟩;

    assume hT1;
    assume hT2;

    have ⟨hR1, hS1⟩ := (h3 a₁ a₂ b₁ b₂).mp hT1
    have ⟨hR2, hS2⟩ := (h3 a₂ a₁ b₂ b₁).mp hT2

    have antisymmetricT := h1.right.right
    define at antisymmetricT
    have ha := antisymmetricT a₁ a₂ hR1 hR2
    rw [ha]

    have antisymmetricS := h2.right.right
    define at antisymmetricS
    have hb := antisymmetricS b₁ b₂ hS1 hS2

    rw [hb]



-- 5.

theorem Exercise_4_4_9_simpler {A B : Type} (R : BinRel A) (S : BinRel B)
    (L : BinRel (A × B)) (h1 : total_order R) (h2 : total_order S)
    (h3 : ∀ (a a' : A) (b b' : B),
      L (a, b) (a', b') ↔ R a a') :
    ∀ (a a' : A) (b b' : B),
      L (a, b) (a', b') ∨ L (a', b') (a, b) := by
        fix a; fix a';
        fix b; fix b';

        have ⟨h1_partial, h1_total⟩ := h1
        have ⟨h2_partial, h2_total⟩ := h2

        have h1or := h1_total a a'


        by_cases on h1or

        . -- R a a'
            have hp1 := (h3 a a' b b').mpr -- R a a' → L (a, b) (a', b')
            apply Or.inl
            show L (a, b) (a', b') from (hp1 h1or)
        . -- R a a'
            have hp1 := (h3 a' a b' b).mpr -- R a a' → L (a, b) (a', b')
            apply Or.inr
            show L (a', b') (a, b) from (hp1 h1or)

theorem Exercise_4_4_9_part {A B : Type} (R : BinRel A) (S : BinRel B)
    (L : BinRel (A × B)) (h1 : total_order R) (h2 : total_order S)
    (h3 : ∀ (a a' : A) (b b' : B),
      L (a, b) (a', b') ↔ R a a' ∧ (a = a' → S b b')) :
    ∀ (a a' : A) (b b' : B),
      L (a, b) (a', b') ∨ L (a', b') (a, b) := by
        fix a; fix a';
        fix b; fix b';

        have ⟨h1_partial, h1_total⟩ := h1
        have ⟨h2_partial, h2_total⟩ := h2

        have h1or := h1_total a a'
        have h2or := h2_total b b'

        have h_my : a = a' → R a a' ∧ R a' a := by
            assume heq
            have h1_reflexive := h1_partial.left
            define at h1_reflexive
            have hRa := h1_reflexive a'
            rw [heq]
            exact ⟨hRa, hRa⟩


        have h6 : a = a' ∨ a ≠ a' := eq_or_ne a a'

        by_cases on h6

        . -- a = a'
            have ⟨hRa1, hRa2⟩ := h_my h6
            by_cases on h2or
            . --S b b'
                left; rw [h3];
                apply And.intro hRa1;
                assume _; exact h2or;

            . -- S b' b
                right;
                rw [h3];
                apply And.intro hRa2;
                assume _; exact h2or;

        . -- a ≠ a'
            by_cases on h1or;
            . -- R a a'
                left;
                rw [h3];
                apply And.intro h1or;
                assume h6n; by_contra;
                show False from h6 h6n;
            . -- R a' a
                right;
                rw [h3]
                apply And.intro h1or;
                assume h6n;
                by_contra;
                have h6n := Eq.symm h6n;

                show False from h6 h6n;

    --     by_cases on h1or
    --     by_cases on h2or
    --     . -- R a a' S b b'
    --         have hp1 := (h3 a a' b b').mpr -- R a a' → L (a, b) (a', b')
    --         have hSb : (a = a' → S b b') := (λ x => h2or)

    --         apply Or.inl
    --         show L (a, b) (a', b') from (hp1 ⟨h1or, hSb⟩)

    --     . -- R a a' S b' b
    --         have hp1 := (h3 a a' b' b).mpr -- R a a' → L (a, b) (a', b')
    --         have hSb : (a = a' → S b' b) := (λ x => h2or)

    --         apply Or.inl
    --         show L (a, b) (a', b') from (hp1 ⟨h1or, hSb⟩)






    --   sorry

-- 6.
theorem Exercise_4_4_15a {A : Type}
    (R1 R2 : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R1) (h2 : partial_order R2)
    (h3 : extension R1 ⊆ extension R2) :
    smallestElt R1 b B → smallestElt R2 b B := by


-- 7.
theorem Exercise_4_4_15b {A : Type}
    (R1 R2 : BinRel A) (B : Set A) (b : A)
    (h1 : partial_order R1) (h2 : partial_order R2)
    (h3 : extension R1 ⊆ extension R2) :
    minimalElt R2 b B → minimalElt R1 b B := sorry

-- 8.
theorem Exercise_4_4_18a {A : Type}
    (R : BinRel A) (B1 B2 : Set A) (h1 : partial_order R)
    (h2 : ∀ x ∈ B1, ∃ y ∈ B2, R x y) (h3 : ∀ x ∈ B2, ∃ y ∈ B1, R x y) :
    ∀ (x : A), upperBd R x B1 ↔ upperBd R x B2 := sorry

-- 9.
theorem Exercise_4_4_22 {A : Type}
    (R : BinRel A) (B1 B2 : Set A) (x1 x2 : A)
    (h1 : partial_order R) (h2 : lub R x1 B1) (h3 : lub R x2 B2) :
    B1 ⊆ B2 → R x1 x2 := sorry

-- 10.
theorem Exercise_4_4_24 {A : Type} (R : Set (A × A)) :
    smallestElt (sub (A × A)) (R ∪ (inv R))
    {T : Set (A × A) | R ⊆ T ∧ symmetric (RelFromExt T)} := sorry

/- Section 4.5 -/
-- 1.
lemma overlap_implies_equal {A : Type}
    (F : Set (Set A)) (h : partition F) :
    ∀ X ∈ F, ∀ Y ∈ F, ∀ (x : A), x ∈ X → x ∈ Y → X = Y := by
    define at h;
    intro X; intro hX;
    intro Y; intro hY;

    intro x; intro hxX; intro hxY;

    ext a;


    apply Iff.intro;

    intro h2;



-- 2.
lemma Lemma_4_5_7_ref {A : Type} (F : Set (Set A)) (h : partition F) :
    reflexive (EqRelFromPart F) := sorry

-- 3.
lemma Lemma_4_5_7_symm {A : Type} (F : Set (Set A)) (h : partition F) :
    symmetric (EqRelFromPart F) := sorry

-- 4.
lemma Lemma_4_5_7_trans {A : Type} (F : Set (Set A)) (h : partition F) :
    transitive (EqRelFromPart F) := sorry

-- 5.
lemma Lemma_4_5_8 {A : Type} (F : Set (Set A)) (h : partition F) :
    ∀ X ∈ F, ∀ x ∈ X, equivClass (EqRelFromPart F) x = X := sorry

-- 6.
lemma elt_mod_equiv_class_of_elt
    {A : Type} (R : BinRel A) (h : equiv_rel R) :
    ∀ X ∈ mod A R, ∀ x ∈ X, equivClass R x = X := sorry

-- Definitions for next three exercises:
def dot {A : Type} (F G : Set (Set A)) : Set (Set A) :=
    {Z : Set A | ¬empty Z ∧ ∃ X ∈ F, ∃ Y ∈ G, Z = X ∩ Y}

def conj {A : Type} (R S : BinRel A) (x y : A) : Prop :=
    R x y ∧ S x y

-- 7.
theorem Exercise_4_5_20a {A : Type} (R S : BinRel A)
    (h1 : equiv_rel R) (h2 : equiv_rel S) :
    equiv_rel (conj R S) := sorry

-- 8.
theorem Exercise_4_5_20b {A : Type} (R S : BinRel A)
    (h1 : equiv_rel R) (h2 : equiv_rel S) :
    ∀ (x : A), equivClass (conj R S) x =
      equivClass R x ∩ equivClass S x := sorry

-- 9.
theorem Exercise_4_5_20c {A : Type} (R S : BinRel A)
    (h1 : equiv_rel R) (h2 : equiv_rel S) :
    mod A (conj R S) = dot (mod A R) (mod A S) := sorry

-- 10.
def equiv_mod (m x y : Int) : Prop := m ∣ (x - y)

theorem Theorem_4_5_10 : ∀ (m : Int), equiv_rel (equiv_mod m) := sorry
