import Mathlib.Data.Nat.Basic

#eval "hello" ++ " " ++ "world"


#check true


def x := 10

#eval x + 2

def double (x: ℤ) := 2 * x

#eval double 3

#check double


example: double 4 = 8 := rfl
