import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LibrarySearch

def byte := Fin 256

opaque BYTE_0 : byte := {val:=0, isLt:=(by simp)}


inductive Stack: Type
| empty: Stack
| push: u256 -> Stack -> Stack

def pop (s: Stack): Except (Stack × u256) (Stack × u256) :=
 match s with
 | Stack.empty => Except.error s
 | Stack.push v s' => Except.ok (s', v)

def peek (s: Stack): Except u256 u256 :=
 match s with
 | Stack.empty => Except.error ()
 | Stack.push v s' => Except.ok v

def push (v: u256) (s: Stack): Stack :=
 Stack.push v s

def add (evm: Stack): Except Stack Stack :=
 let s1 := evm.pop.bind (fun (s, v) =>
    let s2 := s.pop.bind (fun (s', v') =>
      Except.ok (s', v + v'))
    s2)
 s1

def ADD (evm: Stack) : Except Stack Stack :=
 match evm with
 | Stack.empty => Except.error evm
 | _ => add evm

