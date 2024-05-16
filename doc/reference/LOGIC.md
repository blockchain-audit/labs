Classical Logic
===============

* read this Rambam [book](file:///Users/henry/Downloads/rambam-logic.pdf)


### Crossed Intermediate Field

```
All   C is  B
All   B is  A
All   C is  A

Every C is  B
No    B is  A
No    C is  A

Some  C is  B
All   B is  A
Some  C is  A

Some  C is  B
No    B is  A
Some  C is! A
```

### Right Intermediate Field

```
All   C is  B
No    A is  B
No    C is  A

No    C is  B
All   A is  B
No    C is  A

Some  C is  B
No    A is  B
Some  C is! A

Some  C is! B
All   A is  B
Some  C is! A
```

### Left Intermediate Field

```
All   B is  C
All   B is  A
Some  C is  A

Some  B is  C
All   B is  A
Some  C is  A

All   B is  C
Some  B is  A
Some  C is  A

All   B is  C
No    B is  A
Some  C is! A

Some  B is  C
No    B is  A
Some  C is! A

All   B is  C
Some  B is! A
Some  C is! A
```


Propositional Logic
===================


## Introduction

* In algebra letters represent numbers [common letters: x, y and z]
* In Propositional Logic letters represent statements. [common letters: p, q, r and s]

* We are concerned with how the sentences is said to relate to others, worring about thos statemements that are laready sentences by themselves.


> If **its raining outside** then **I will bring an umbrella**

These are two sentences that can be represented by:

```
If p then q
```

You can use a truth table generator to test the outcomes and make new ones

* [truth-table-generator](https://hackage.haskell.org/package/hatt)
* [logicola](https://www.harryhiker.com/lc/)


## Truth Tables

What are the all outcomes of the "Is it raining" statement ?

* TRUE - it's raining
* FALSE - it's not raining


What are the all possible outcomes of:

```
p: It's raining  q: I have an umbrella

T T - it's raining     and I have an umbrella
T F - it's raining     and I don't have an umbrella
F T - it's not raining and I have an umbrella
F F - it's not raining and I dont' have an umbrella
```

What are all the possible outcomes of:

```
p: It's raining   q: I have an umbrella  r: Reuven drinks water

T T T - it's raining       and I have an umbrella        and Reuven drinks watter
T T F - it's raining       and I have an umbrella        and Reuven doesn't drink watter
T F T - it's raining       and I don't have an umbrella  and Reuven drinks watter
T F F - it's not raining   and I don't have an umbrella  and Reuven drinks watter
F T T - it's not raining   and I have an umbrella        and Reuven drinks watter
F T F - it's not raining   and I have an umbrella        and Reuven doesn't drink watter
F F T - it's not raining   and I don't have an umbrella  and Reuven drinks watter
F F F - it's not raining   and I don't have an umbrella  and Reuven doesn't drink watter
```


## Negation

```
~p  = not p

 p: It's raining      T
~p: It's not raining  F

 p: It's not raining  F
~p: It's raining      T

so:

~  p
F  T
T  F
```


## Disjunction

> The Disjunction statement is true when at least one of the statements is true.

```
v = or = Disjunction

p: it's raining
q: I have an umbrella

p v q                    |-|
T T T - It's raining     or I have an umbrella          v: T [at least one statement is T]
T T F - It's raining     or I don't have an umbrella    v: T [at least one statement is T]
F T T - It's not raining or I have an umbrella          v: T [at least one statement is T]
F F F - It's not raining or I dont' have an umbrella    v: F [neither statement is T]
```


## Conjunction

> Then conjunction statement is false when at least one of the statements is false.

```
& = 'and' = Conjunction

p: it's raining
q: I have an umbrella

p & q                    |-|
T T T - It's raining     and I have an umbrella          &: T [Both statements are T]
T F F - It's raining     and I don't have an umbrella    &: F [at least one statement is F]
F F T - It's not raining and I have an umbrella          &: F [at least one statement is F]
F F F - It's not raining and I dont' have an umbrella    &: F [at least one statement is F]
```


## Implication

> The implication statement is only a false implication if the "if" statement is true and the "then" statement is false.
> If we start with a false statement we can imply anything, because the full statement will never
> be fullfiled.

```
⊃ or > = 'If ... then ...' = Implication

p: it's raining
q: I have an umbrella

p ⊃ q                       |---|
T T T - if it's raining     then  I have an umbrella          ⊃: T [since both statemements are true]
T F F - if it's raining     then  I don't have an umbrella    ⊃: F [the 'if' is true and 'then' is false]
F T T - if it's not raining then  I have an umbrella          ⊃: T [the 'if' is false, so we imply anything]
F T F - if it's not raining then  I dont' have an umbrella    ⊃: T [the 'if' is false, so we imply anything]
```


## Equivalence

> Equivalence statement: If and only if... represented by three lines. Equivalent statemements are true
> only if the two statemements have the same truth value, i.e., or both are false or both are true.
> Equivalence is also known as a bicondition, because it is the same as two conditions.
> Example: If it's raining then I have my umbrella and if I have my umbrella the it is raining.
```

≡ or iff = 'If and only if...'

p: it's raining
q: I have an umbrella

p ≡ q                       |------------|
T T T - if it's raining     if and only if I have an umbrella          ⊃: T [both statemements have the same truth value, T&T]
T F F - if it's raining     if and only if I don't have an umbrella    ⊃: F [statemements have different truth values]
F F T - if it's not raining if and only if I have an umbrella          ⊃: T [statemements have different truth values]
F T F - if it's not raining if and only if I dont' have an umbrella    ⊃: T [both statemements have the same truth value, F&F]

```


## Compound


> A compound proposition is a statement that is composed of one or more simpler statements,
> or propositions. When you have parenthesis, do what is inside first, after what is connected
> directly to the parenthesis.


```
~ p    : not p
~ q    : not q
~p v ~q: not p or not q


~ p v ~ q
F T F F T
F T T T F
T F T F T
T F T T F


~(p & q)> q: not (p and q) implies q
F T T T T T
T T F F F F
T F F T T T
T F F F F F


p >(p > p)  [tautolotous]
T T T T T
F T F T F


[(р > q)> q]> p
  T T T T T T T
  T F F T F T T
  F T T T T F F
  F T F F F T F


| p | q | p > q | (p > q) > q | [(p > q) > q] > p |
|---|---|-------|-------------|------------------|
| T | T |   T   |      T      |        T         |
| T | F |   F   |      T      |        T         |
| F | T |   T   |      T      |        F         |
| F | F |   T   |      F      |        T         |



[(p>q& (pvq)]>q

| p | q | p > q | p v q | (p > q) & (p v q) | [(p > q) & (p v q)] > q |
|---|---|-------|-------|-------------------|-------------------------|
| T | T |   T   |   T   |        T          |           T             |
| T | F |   F   |   T   |        F          |           T             |
| F | T |   T   |   T   |        T          |           T             |
| F | F |   T   |   F   |        F          |           T             |


[p&(qvr)]≡{(~q v~p)&(~rv~p)]

| p | q | r | q v r | p & (q v r)|~q |~p |~r |~q v ~p |~r v~p |[p & (q v r)] ≡ {(~q v ~p) & (~r v ~p)}|
|---|---|---|-------|------------|---|---|---|--------|-------|---------------------------------------|
| T | T | T |   T   |     T      | F | F | F |   F    |   F   |              F                        |
| T | T | F |   T   |     T      | F | F | T |   F    |   T   |              F                        |
| T | F | T |   T   |     T      | T | F | F |   T    |   F   |              F                        |
| T | F | F |   F   |     F      | T | F | T |   T    |   T   |              F                        |
| F | T | T |   T   |     F      | F | T | F |   T    |   T   |              F                        |
| F | T | F |   T   |     F      | F | T | T |   T    |   T   |              F                        |
| F | F | T |   T   |     F      | T | T | F |   T    |   T   |              F                        |
| F | F | F |   F   |     F      | T | T | T |   T    |   T   |              F                        |


```


## Modus Ponens

Modus Ponens is a rule of inference in propositional logic. It allows you to draw a conclusion from a conditional statement (implication) and its antecedent (the "if" part). The general form of Modus Ponens is:

```
If P, then Q.
P.
Therefore, Q.
```

In other words, if you have a conditional statement "If P, then Q" and you know that P is true, then you can conclude that Q is also true.

Here's an example to illustrate Modus Ponens:

```
If it is raining, then the ground is wet. (If P, then Q)
It is raining. (P)
Therefore, the ground is wet. (Q)
```

In this example, we know that it is raining (P), and based on the conditional statement "If it is raining, then the ground is wet" (If P, then Q), we can conclude that the ground is wet (Q).



## Modus Tollens

Modus Tollens is a rule of inference in propositional logic. It allows you to draw a conclusion from a conditional statement (implication) and the negation of its consequent (the "then" part). The general form of Modus Tollens is:

```
If P, then Q.
Not Q.
Therefore, not P.
```

In other words, if you have a conditional statement "If P, then Q" and you know that Q is false (not Q), then you can conclude that P must also be false (not P).

Here's an example to illustrate Modus Tollens:

```
If it is raining, then the ground is wet. (If P, then Q)
The ground is not wet. (Not Q)
Therefore, it is not raining. (Not P)
```
In this example, we know that the ground is not wet (not Q), and based on the conditional statement "If it is raining, then the ground is wet" (If P, then Q), we can conclude that it is not raining (not P).



## Contradictory

Add a "not".

```
(p > q) ≡ (p & (~q))

| p | > | q | ≡ | p | & | ~ | q |
|---|---|---|---|---|---|---|---|
| T | T | T | F | T | F | F | T |
| T | F | F | F | T | T | T | F |
| F | T | T | F | F | F | F | T |
| F | T | F | F | F | F | T | F |

```

## Consistent

Two propositions with at least one world in which they are both true. Logically equivalent propositions are **not necessarily** consistent. If two propositions are contradictory they cannot be consistent.

```
p v q   p & q
T T T   T T T   -> This two propositions are consistent
T T F   T F F
F T T   F F T
F F F   F F F
```



## Logic Rules

### Simplification

```
 (P & Q)  -> P, Q
~(P v Q)  -> ~P, ~Q
~(P ⊃ Q)  -> P , ~Q
~ ~ P     -> P
 (P ≡ Q)  -> (P ⊃ Q),  (Q ⊃ P)
~(P ≡ Q)  -> (P v Q), ~(P & Q)
```

### Inference

```
~ (P & Q),  P -> ~Q
~ (P & Q),  Q -> ~P
  (P v Q), ~P ->  Q
  (P v Q), ~Q ->  P
  (P ⊃ Q),  P ->  Q
  (P ⊃ Q), ~Q -> ~P

```



###  ~ (P & Q),  P ->  ~Q

```
P Q | -(P & Q)
––––––––––––––
0 0 | 1 0 0 0   = 1
0 1 | 1 0 0 1   = 1
1 0 | 1 1 0 0   = 1
1 1 | 0 1 1 1   = 0

P Q | P -> -Q
–––––––––––––
0 0 | 0 1 1     = 1
0 1 | 0 1 0     = 1
1 0 | 1 1 1     = 1
1 1 | 1 0 0     = 0

then we have the inference rule:
~ (P & Q),  P ->  ~Q
```


## Resources


* [math-icons](https://cloford.com/resources/charcodes/utf-8_mathematical.htm)

