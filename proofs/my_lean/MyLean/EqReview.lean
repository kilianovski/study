variable (α : Type) (a b c d : α)
variable (hab : a = b) (hcb : c = b) (hcd : c = d)

universe u


#check Eq.symm
#check @Eq.symm
#check @Eq.symm.{u}


#check @Eq.refl.{u}

#check @Eq.trans.{u}

example : a = d := by
  have hac := Eq.trans hab (Eq.symm hcb)
  have had := Eq.trans hac hcd
  exact had


-- subst


example (α : Type) (a b : α) (p : α → Prop)
        (h1 : a = b) (h2 : p a) : p b :=
        h1.subst h2


example (α : Type) (a b : α) (p : α → Prop)
        (h1 : a = b) (h2 : p a) : p b :=
        h1 ▸ h2


#check congrArg
