import Mathlib.Data.Nat.Basic
example: ℕ = Nat := rfl

inductive Weekday where
  | sunday | monday | tuesday | wednesday
  | thursday | friday | saturday


#check Weekday.sunday

open Weekday
#check sunday

def natOfWeekday (d: Weekday) : ℕ :=
  match d with
  | sunday    => 1
  | monday    => 2
  | tuesday   => 3
  | wednesday => 4
  | thursday  => 5
  | friday    => 6
  | saturday  => 7


def Weekday.next (d: Weekday) : Weekday :=
  match d with
  | sunday    => monday
  | monday    => tuesday
  | tuesday   => wednesday
  | wednesday => thursday
  | thursday  => friday
  | friday    => saturday
  | saturday  => sunday


def Weekday.previous : Weekday → Weekday
  | sunday    => saturday
  | monday    => sunday
  | tuesday   => monday
  | wednesday => tuesday
  | thursday  => wednesday
  | friday    => thursday
  | saturday  => friday


theorem Weekday.position (d: Weekday) : d.next.previous = d :=
  match d with
  | sunday    => rfl
  | monday    => rfl
  | tuesday   => rfl
  | wednesday => rfl
  | thursday  => rfl
  | friday    => rfl
  | saturday  => rfl


theorem Weekday.position' (d: Weekday) : d.next.previous = d := by
  cases d -- create 7 goals
  rfl; rfl; rfl; rfl ;rfl; rfl; rfl;

theorem Weekday.position'' (d: Weekday) :d.next.previous = d := by
  cases d <;> rfl
