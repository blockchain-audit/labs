import Mathlib.Data.Nat.Basic
/- First-class functions -/


def twice (f: ℕ → ℕ) (a: ℕ) :=
  f (f a)

#check twice

#eval twice (fun x => x + 2) 10

#eval twice (λ x => x + 3) 13

#eval twice (· + 9) 2
