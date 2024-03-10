import Mathlib.Data.Nat.Basic


universe u

def f (α β : Sort u) (a : α) (b : β) : α := a


#eval f Bool String true "hello"
#eval f Nat String 1 "hello"
#eval f Nat Nat 3 3



-- in curly braces the type recognition is on
def g {α β : Sort u} (a : α) (b: β) : α := a

#eval g 1 "heelo"
#check g 1 "heelo"


def h (a : α) (b : β) : α := a
#eval h Bool Bool



#eval g 1 "hello"





#check g


#check @g


#check @h

#check g (α := Nat) (β := String) (a := 1)



