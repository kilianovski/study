
-- KEY NOTES
/-


-/

/-
 1. abbrev vs def
 2. constructor overloading ::
-/

-- NOTES
/-
1. Definitions written using abbrev are always unfolded
2. Definitions that are to be unfolded are called reducible.
-/

-- ##########

#eval 42 + 19

#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"

#eval if 3 == 4 then "equal" else "not equal"


-- Define the function joinStringsWith with type String -> String -> String -> String
-- that creates a new string
-- by placing its first argument between its second and third arguments.
-- joinStringsWith ", " "one" "and another" should evaluate to "one, and another"

def joinStringsWith (a : String) (b : String) (c : String) :=
  String.append b (String.append a c)

#eval joinStringsWith ", " "one" "and another"


-- Define a function volume with type Nat → Nat → Nat → Nat
-- that computes the volume of a rectangular prism
-- with the given height, width, and depth.

structure Point where
  x : Float
  y : Float

deriving Repr

def origin : Point := { x:=0, y:=0 }
def my_origin := {origin with x := 1 }

#eval my_origin

#eval Point.mk 2 2


-- Define a structure named RectangularPrism
-- that contains the height, width, and depth of a rectangular prism, each as a Float.

structure RectangularPrism where
  height : Float
  width : Float
  depth : Float
deriving Repr

#eval RectangularPrism.mk 2 2 2

def RectangularPrism.volume (prism : RectangularPrism) : Float := prism.depth * prism.height * prism.width

def my_prism := RectangularPrism.mk 2 2 2

#eval my_prism.volume


inductive Sign where
 | pos
 | neg



def posOrNegThree (s : Sign) : match s with | Sign.pos => Nat | Sign.neg => Int :=
  match s with
  | Sign.pos => 3
  | Sign.neg =>( -3)

#check posOrNegThree
