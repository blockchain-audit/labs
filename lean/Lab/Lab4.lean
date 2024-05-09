/- What is the type of type :) -/


#check 0

#check Nat

#check Type

#check Type 1

#check Eq.refl 2

#check 2 = 2

#check Prop


example : Prop   = Sort 0  := rfl
example : Type   = Sort 1  := rfl
example : Type 1 = Sort 2  := rfl
