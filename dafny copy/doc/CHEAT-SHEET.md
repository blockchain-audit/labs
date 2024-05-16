Dafny Cheat Sheet
=================



## Module



A Dafny program is a hierarchy of nested modules. Dependencies among modules
are announced by import declarations. A program’s import relation must not contain
cycles. The export set of a module determines which of the module’s declarations are
visible to importers. The outermost module of a program is implicit. Therefore,
small programs can define methods and functions without needing to wrap
them inside a module declaration. A module body can consist of anything
that you could put at the toplevel. This includes classes,
datatypes, types, methods, functions, etc.

### Name Resolution

For a module, the local names include those brought in by import opened, though these can be shadowed by non-imported local names. The names brought in by an import depend on which export set is designated (perhaps by default) in the import declaration.
Then subsequent identifiers are looked up in the scope of the qualified name prefix interpreted so far.



```dafny
module MyModule {

    export
        provides A, B, C
        reveals D, E, F
    import L = LibraryA // L is a local name for imported module LibraryA
    import LibraryB // shorthand for: import LibraryB = LibraryB
}
```



## Datatype


```dafny
datatype Color = Brown | Blue | Hazel | Green
datatype Unary = Zero | Suc(Unary)
datatype List<X> = Nil | Cons(head: X, tail: List<X>)
```


## Variables

```dafny
var nish: int;
var m := 5;           //inferred type
var i: int, j: nat;
var x, y, z: bool := 1, 2, true;
```


## Class

```dafny
class Point {
    var x: real, y: real

    method Dist2(that: Point) returns (z: real)
        requires that != null {
        z := Norm2(x - that.x, y - that.y);
    }
}
```

## Arrays

```dafny
var a := new bool[2];
a[0], a[1] := true, false;
method Find(a: array<int>, v: int)
returns (index: int)
```

## Methods


```dafny
// Without a return value
method Hello() { print “Hello Dafny”; }

// With a return value
method Norm2(x: real, y: real) returns (z: real)
{
    z := x * x + y * y;
}

// Multiple return values
method Prod(x: int) returns (dbl: int, trpl: int)
{
    dbl, trpl := x * 2, x * 3;
}
```


## Loops


```dafny
while x > y { x := x - y; }
forall i | 0 <= i < m { Foo(i); }


i := 0;
while i < a.Length
invariant 0 <= i <= a.Length
invariant forall k :: 0 <= k < i ==> a[k] == 0
{ a[i], i := 0, i + 1; }
assert forall k :: 0 <= k < a.Length ==> a[k] == 0;

```



## Conditionals

Statement (Braces are mandatory):

```dafny
if z { x := x + 1; }
else { y := y - 1; }
```

Expression:

```dafny
m := if x < y then x else y;
```

## Precondition

```dafny
method Rot90(p: Point) returns (q: Point)
    requires p != null {
    q := new Point;
    q.x, q.y := -p.y, p.x;
}
```

## Postcondition

```dafny
method max(a: nat, b: nat) returns (m: nat)
    ensures m >= a                  // can have as many
    ensures m >= b                  // as you like
{ if a > b { m := a; } else { m := b; } }
```


## Inline Propositions

```danfy
assume x > 1;
assert 2 * x + x / x > 3;
```

## Logical Connectives

```dafny
assume (z || !z) && x > y;
assert j < a.Length ==> a[j]*a[j] >= 0;
assert !(a && b) <==> !a || !b;

```

```
assume (z || !z) && x > y;

This assumes that either z or not z is true, and that x is greater than y.
This expression does not translate directly to propositional logic,
but we can break it down into its constituent parts:
z || !z:            This is a tautology in propositional logic, since z
                    is either true or false, so one of z or not z must be true.
x > y:              This is a simple inequality statement.


assert j < a.Length ==> a[j]*a[j] >= 0;
This assertion states that if j is less than the length of array a, then the square of the
value at index j in array a is greater than or equal to zero.
This expression can be translated to propositional logic as follows:

j < a.Length:                    This is a simple inequality statement.
a[j]*a[j] >= 0:                  This is a simple inequality statement.
j < a.Length ==> a[j]*a[j] >= 0: This is an implication in propositional logic,
which states that if j is less than the length of a,
then a[j]*a[j] is greater than or equal to zero.


assert !(a && b) <==> !a || !b;

This assertion states that the negation of the conjunction of a and b is equivalent to
the disjunction of the negations of a and b. This expression can be
translated to propositional logic as follows:

a && b: This is a conjunction in propositional logic.
!a: This is the negation of a.
!b: This is the negation of b.
!a || !b: This is a disjunction in propositional logic.
!(a && b): This is the negation of the conjunction of a and b.
!(a && b) <==> !a || !b: This is an equivalence in propositional logic,
which states that the negation of the conjunction of a and b is equivalent
to the disjunction of the negations of a and b.


```


## Logical Quantifiers

```dafny
assume forall n: nat :: n >= 0;
assert forall k :: k + 1 > k;    // inferred k:int
```


## Pure Definitions

```dafny
function min(a: nat, b: nat): nat
{                                // body must be an expression
    if a < b then a else b
}

predicate win(a: array<int>, j: int)
    requires a != null
{                                // just like function(...): bool
    0 <= j < a.Length
}
```

## Modifies

Framing for methods.

```dafny
method Reverse(a: array<int>)           // not allowed to
modifies a                              // assign to “a” otherwise
```

## Reads

Framing for functions

```dafny
predicate Sorted(a: array<int>)         // not allowed to
reads a                                 // refer to “a[_]” otherwise
```

## Types

Examples of types:
The X in these examples is a type parameter.

```dafny
bool int nat real set<X> seq<X> multiset<X> map<X, Y> char string X -> Y
() (X, Y) (X, Y, Z)
array<X> array?<X> array2<X>
object object? MyClass<X> MyClass?<X>


type OpaqueType
type TypeSynonym = int
```



```dafny
function F(a: A, b: B): C
requires Pre
reads obj0, obj1, objectSet
ensures Post // F(a, b) refers to the result of the function
decreases E0, E1, E2
```

If C is bool, then the first line of the function declaration can be written as
predicate F(a: A, b: B)


## Constants

```dafny
const n: nat
const greeting: string := "hello"
const year := 1402
```


## Set, seq, Multiset

```dafny
var s: set<int> := {4, 2};
assert 2 in s && 3 !in s;
var q: seq<int> := [1, 4, 9, 16, 25];
assert q[2] + q[3] == q[4];
assert forall k :: k in s ==> k*k in q[1..];
var t: multiset<bool> := multiset{true, true};
assert t - multiset{true} != multiset{};
```


## Statements

The “: X” can be omitted if the type can be inferred. When declaring more than one
variable, the : (colon) binds stronger than , (comma).

```dafny
var x: X;
var x, y: Y;

x := E;         // := is pronounced "gets" or "becomes" (NOT "equals"!)
x, y := E, F;   // simultaneous assignment
x :| E;         // assign x a value that makes E hold (assign such that)


c := new C(...);
a := new T[n];
a := new T[n](i => ...);

MethodWithNoResults(E, F);
x := MethodWithOneResult(E, F);
x, y := MethodWithTwoResults(E, F);

assert E;
return;
return E, F, G;
new;

```



## Expressions

```
<==>            iff (lowest binding power)
==>             implication
<==             reverse implication
&&              and
||              or
==              equality
!=              disequality
< <= => >       inequality comparisons
in !in          collection membership
!!              set disjointness
+ -             plus/union/concatenation/merge, minus
* / %           multiplication/intersection, division, modulus
_ as int        conversion to integer
! -             boolean not, unary negation
_.x             member selection
_[_] _[_ := _]  element selectionupdate
_[_ .. _]       subrange
_[.. _] _[_ ..] take, drop
_[..]           array-elements to sequence
```
