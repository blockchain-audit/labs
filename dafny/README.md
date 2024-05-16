


## Numbers


1. **Natural Numbers**: 1, 2, 3, 4, 5, ...
   - Example: Number of apples in a basket: 1, 2, 3, ...

2. **Whole Numbers**: 0, 1, 2, 3, 4, ...
   - Example: Counting the number of students absent in a class: 0, 1, 2, 3, ...

3. **Integers**: ..., -3, -2, -1, 0, 1, 2, 3, ...
   - Example: Temperatures below zero: -5°C, -10°C, -15°C, ...

4. **Rational Numbers**: Fractions and decimals that can be expressed as a quotient of integers.
   - Example: \( \frac{3}{4} \), \( -\frac{2}{5} \), \( 0.25 \)

5. **Irrational Numbers**: Numbers that cannot be expressed as fractions and have non-repeating, non-terminating decimal representations.
   - Example: \( \sqrt{2} \), \( \pi \), \( e \)

6. **Real Numbers**: All rational and irrational numbers.
   - Example: \( \frac{3}{4} \), \( -\frac{2}{5} \), \( \sqrt{2} \), \( \pi \)

7. **Complex Numbers**: Numbers with a real part and an imaginary part.
   - Example: \( 3 + 2i \), \( -1 - i \), \( 2i \)


## First 2 Days

- wallet
- immutable computer
- private/public key (assymetric cryptography)
- transactions
- etherscan
- smart contract deposit
- simple bank application
- project: will with heartbeat


## Course


- intro.dfy
- funcs.dfy
- floyd.dfy
- hoare.dfy




## Resources


* [uniswap-invariants](https://medium.com/blockapex/uniswap-v3-liquidity-and-invariants-101-cb956816d62d)
* [fv-dafny-1](https://www.youtube.com/watch?v=k9fwDxZP-0Y)
* [fv-dafny-2](https://www.youtube.com/watch?v=tBNV5LoXlDY)
* [dafny-guide](https://ece.uwaterloo.ca/~agurfink/stqam/rise4fun-Dafny/)
* [dafny-tutorial](https://github.com/bor0/dafny-tutorial)
* [dafny-guide](http://dafny.org/dafny/OnlineTutorial/guide.html)
* [dafny-solidity](https://www.youtube.com/watch?v=k9fwDxZP-0Y)
* [projects-using-dafny](https://github.com/ConsenSys/projects-using-dafny/blob/main/list.md)
* [dafny-tactics](https://link.springer.com/chapter/10.1007/978-3-662-49674-9_3)
* [examples](https://codeberg.org/mathprocessing/learning-dafny/src/branch/master/src)


## Syntax

### Methods

A method is a piece of imperative, executable code. In other languages, they might be called procedures, or functions.


### functions

Unlike a method, which can have all sorts of statements in its body, a function body must consist of exactly one expression, with the correct type, they can only appear in annotations and are never part of the final compiled program, they are just tools to help us verify our code.

### Lemma

A lemma (lemma) is a type of ghost method that can be used to express richer properties, where assumptions are preconditions, and the conclusion becomes the postcondition. The proof is a method body that satisfies the
postcondition, given the precondition.


## Properties

### Pre-conditions
Like postconditions, multiple preconditions can be written either with the boolean "and" operator (&&), or by multiple requires keywords. Traditionally, requires precede ensures in the source code, though this is not strictly necessary

### Postconditions

Postconditions, declared with the ensures keyword, are given as part of the method's declaration, after the return values (if present) and before the method body. The keyword is followed by the boolean expression. Like an if or while condition and most specifications, a postcondition is always a boolean expression: something that can be true or false.

### Assertions

An assertion says that a particular expression always holds when control reaches that part of the code. Every time Dafny encounters an assertion, it tries to prove that the condition holds for all executions of the code.


## Loop Invariants


## Repos
* [basic-tutorial](https://github.com/dafny-lang/dafny/blob/master/docs/OnlineTutorial/guide.md)
* [examples](https://github.com/dafny-lang/dafny/tree/master/Test/hofs)
* [exercises](https://github.com/zhuzilin/dafny-exercises)
* [learn-logic](https://github.com/matiashrnndz/programming-logic-with-dafny)
* [deposit-dafny](https://github.com/ConsenSys/deposit-sc-dafny)
* [evm-dafny](https://github.com/ConsenSys/evm-dafny)
* [dafny-token-mimics](https://github.com/ConsenSys/dafny-sc-fmics)
* [eth2-dafny](https://github.com/ConsenSys/eth2.0-dafny)
* [dafny-fsm](https://github.com/microsoft/Ironclad)
* [dafny-classes](https://www.cse.unsw.edu.au/~anymeyer/2011/lectures/)


## Who

* [maker](https://github.com/makerdao/dss/tree/certora-v1.2/certora)
* [compound](https://github.com/compound-finance/compound-protocol/tree/master/spec/certora)
* [balancer](https://medium.com/certora/formal-verification-helps-finding-insolvency-bugs-balancer-v2-bug-report-1f53ee7dd4d0)
* [aave](https://github.com/aave/aave-v3-core/tree/master/certora)


## Plan


* simple tutorials
* make algos on `learn-logic`
* study the pdfs
* translate certora stuff to dafny  [compound, open zeppelin, etc..]

