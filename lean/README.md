# Mathematics in Lean

* [main-website](https://leanprover.github.io)
* [mechanics-of-proof](https://hrmacbeth.github.io/math2001/)
* [mechanics-of-proof-repo](https://github.com/hrmacbeth/math2001)
* [theorem-proving](https://leanprover.github.io/theorem_proving_in_lean4/)
* [functional-programming](https://lean-lang.org/functional_programming_in_lean/)
* [lean-manual](https://lean-lang.org/lean4/doc/)
* [math-lib-docs](https://leanprover-community.github.io/mathlib4_docs/)
* [logic-and-proof](https://leanprover.github.io/logic_and_proof/introduction.html)
* [community-website](https://leanprover-community.github.io/)

* [vscode-plugin](https://www.youtube.com/watch?v=zyXtbb_eYbY)
* [math-intro](https://leanprover-community.github.io/mathematics_in_lean/C01_Introduction.html)
* [tutorial](https://leanprover-community.github.io/learn.html)
* [glimpse](https://github.com/PatrickMassot/GlimpseOfLean)
* [natural-game](https://adam.math.hhu.de/#/g/hhu-adam/NNG4)
* [chat](https://leanprover.zulipchat.com/)
* [on-line-ide](https://lean.math.hhu.de/)

## Tatics


* [tatics](https://github.com/leanprover/theorem_proving_in_lean4/blob/master/tactics.md)
* [tatics-list](https://github.com/henry-hz/lean3-tactic-lean4)
* [tatics-learn4](https://github.com/madvorak/lean4-tactics)

## Videos

* [intro-video](https://www.youtube.com/watch?v=S-aGjgIDQZY)
* [install-lean-vscode](https://www.youtube.com/watch?v=yZo6k48L0VY)
* [simple-prove](https://www.youtube.com/watch?v=POHVMMG7pqE&list=PL88g1zsvCrjexLVWaHTnXs23kuwDUZIbL)
* [prime-prover-demo](https://www.youtube.com/watch?v=b59fpAJ8Mfs&list=PL88g1zsvCrjexLVWaHTnXs23kuwDUZIbL&index=2)
* [language-overview](https://www.youtube.com/watch?v=UeGvhfW1v9M)
* [seminar-intro](https://www.youtube.com/watch?v=S-aGjgIDQZY)
* [proof-intro](https://www.youtube.com/watch?v=Lji9_p6rkPc&list=PLLSwxwJoqOFFXB1bEL643JIgQMI11bkih)
* [empowering-math](https://www.youtube.com/watch?v=rDe0nIHINXs&t=1865s)

## Overview
Lean  4, as of my last update, is a theorem prover and programming language that is designed for formal verification, much like Dafny. However, the way Lean  4 handles preconditions (`requires`) and postconditions (`ensures`) is somewhat different from Dafny, and it does not support the same level of automatic proof generation for preconditions and postconditions as Dafny does.

In Dafny, you can specify preconditions (`requires`) and postconditions (`ensures`) directly in the function or method signature, and Dafny's verification system will automatically generate proofs for these conditions as part of the verification process. This is a powerful feature that allows for a high degree of automation in proving properties about code.

Lean  4, on the other hand, is more focused on providing a powerful and flexible environment for formal proofs. While it does support preconditions and postconditions, these are typically specified as part of the function's body using Lean's proof language, rather than as part of the function's signature. This means that in Lean  4, you would need to manually write the proofs for these conditions, rather than having them automatically generated.

However, Lean  4 does offer a powerful and flexible system for proving properties about code, including the ability to specify and prove preconditions and postconditions. This is done using Lean's proof language, which allows for the construction of complex proofs using logical reasoning, tactics, and other proof techniques.

Here's a simple example to illustrate how you might specify and prove a precondition and a postcondition in Lean  4:

```lean
import Lean

def add (a b : Nat) (h : a  ≤ b) : Nat :=
  have h' : a + b = b + a, from Nat.add_comm a b,
  have h'' : a + b  ≤ b + a, from Nat.add_le_add_right h b,
  have h''' : a + b  ≤ b + a, from Nat.add_le_add_left h a,
  b + a

theorem add_comm (a b : Nat) (h : a  ≤ b) : add a b h = b + a :=
  rfl
```

In this example, the `add` function takes two natural numbers `a` and `b`, and a precondition `h` that `a` is less than or equal to `b`. The function returns the sum of `a` and `b`, but with the order of addition reversed. The `add_comm` theorem then proves that the result of the `add` function is equal to the sum of `b` and `a`, demonstrating that the function preserves the sum of the two numbers.

While this example does not fully replicate the automatic proof generation of Dafny's `requires` and `ensures`, it does illustrate how you can specify and prove preconditions and postconditions in Lean  4. The key difference is that in Lean  4, you need to manually write the proofs for these conditions, rather than having them automatically generated.

To write the `add` function example in Dafny, you would specify the precondition and postcondition directly in the function signature using `requires` and `ensures`. Here's how you could translate the Lean example into Dafny:

```dafny
method add(a: nat, b: nat)
requires a <= b
ensures result == b + a {
    return b + a;
}
```

In Dafny, the `requires` clause specifies the precondition that must be true before the method is called, and the `ensures` clause specifies the postcondition that must be true after the method returns. Dafny's verification system will automatically generate proofs for these conditions as part of the verification process.

This Dafny code snippet defines a method `add` that takes two natural numbers `a` and `b` and a precondition that `a` is less than or equal to `b`. The method ensures that the result is equal to the sum of `b` and `a`, demonstrating that the function preserves the sum of the two numbers. Dafny's automatic proof generation feature will handle the verification of this precondition and postcondition, ensuring that the method behaves as expected.

## Numbers


1. **Nat: Natural Numbers**: 1, 2, 3, 4, 5, ...
   - Example: Number of apples in a basket: 1, 2, 3, ...

2. **Whole Numbers**: 0, 1, 2, 3, 4, ...
   - Example: Counting the number of students absent in a class: 0, 1, 2, 3, ...
   - def Whole := {n :  ℤ | n  ≥  0}

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


## Overview

This tutorial depends on Lean 4, VS Code, and Mathlib.
You can find the textbook both online and in this repository
in
[html format](https://leanprover-community.github.io/mathematics_in_lean/)
or as a
[pdf document](https://leanprover-community.github.io/mathematics_in_lean/mathematics_in_lean.pdf).
The book is designed to be read as you
work through examples and exercises,
using a copy of this repository on your computer.
Alternatively, you can use Github Codespaces or Gitpod to run Lean and VS Code in the cloud.

This version of *Mathematics in Lean* is designed for [Lean 4](https://leanprover.github.io/) and
[Mathlib](https://github.com/leanprover-community/mathlib4).
For the Lean 3 version, see [https://github.com/leanprover-community/mathematics_in_lean3](https://github.com/leanprover-community/mathematics_in_lean3).


## To use this repository on your computer

Do the following:

1. Install Lean 4 and VS Code following
   these [instructions](https://leanprover-community.github.io/get_started.html).

2. Make sure you have [git](https://git-scm.com/) installed.

3. Follow these [instructions](https://leanprover-community.github.io/install/project.html#working-on-an-existing-project)
   to fetch the `mathematics_in_lean` repository and open it up in VS Code.

4. Each section in the textbook has an associated Lean file with examples and exercises.
   You can find them in the folder `MIL`, organized by chapter.
   We strongly recommend making a copy of that folder and experimenting and doing the
   exercises in that copy.
   This leaves the originals intact, and it also makes it easier to update the repository as it changes (see below).
   You can call the copy `my_files` or whatever you want and use it to create
   your own Lean files as well.

At that point, you can open the textbook in a side panel in VS Code as follows:

1. Type `ctrl-shift-P` (`command-shift-P` in macOS).

2. Type `Lean 4: Docview: Open Docview` in the bar that appears, and then
  press return. (You can press return to select it as soon as it is highlighted
  in the menu.)

3. In the window that opens, click on `Open documentation of current project`.

The textbook and this repository are still a work in progress.
You can update the repository by typing `git pull`
followed by `lake exe cache get` inside the `mathematics_in_lean` folder.
(This assumes that you have not changed the contents of the `MIL` folder,
which is why we suggested making a copy.)


## To use this repository with Github Codespaces

If you have trouble installing Lean, you can use Lean directly in your browser using Github
Codespaces.
This requires a Github account. If you are signed in to Github, click here:

<a href='https://codespaces.new/leanprover-community/mathematics_in_lean' target="_blank" rel="noreferrer noopener"><img src='https://github.com/codespaces/badge.svg' alt='Open in GitHub Codespaces' style='max-width: 100%;'></a>

Make sure the Machine type is `4-core`, and then press `Create codespace`
(this might take a few minutes).
This creates a virtual machine in the cloud,
and installs Lean and Mathlib.

Opening any `.lean` file in the MIL folder will start Lean,
though this may also take a little while.
We suggest making a copy of the `MIL` directory, as described
in the instructions above for using MIL on your computer.
You can update the repository by opening a terminal in the browser
and typing `git pull` followed by `lake exe cache get` as above.

Codespaces offers a certain number of free hours per month. When you are done working,
press `Ctrl/Cmd+Shift+P` on your keyboard, start typing `stop current codespace`, and then
select `Codespaces: Stop Current Codespace` from the list of options.
If you forget, don't worry: the virtual machine will stop itself after a certain
amount of time of inactivity.

To restart a previous workspace, visit <https://github.com/codespaces>.


## To use this repository with Gitpod

Gitpod is an alternative to Github Codespaces, but is a little less convenient,
since it requires you to verify your phone number.
If you have a Gitpod account or are willing to sign up for one,
point your browser to
[https://gitpod.io/#/https://github.com/leanprover-community/mathematics_in_lean](https://gitpod.io/#/https://github.com/leanprover-community/mathematics_in_lean).
This creates a virtual machine in the cloud,
and installs Lean and Mathlib.
It then presents you with a VS Code window, running in a virtual
copy of the repository.
We suggest making a copy of the `MIL` directory, as described
in the instructions above for using MIL on your computer.
You can update the repository by opening a terminal in the browser
and typing `git pull` followed by `lake exe cache get` as above.

Gitpod gives you 50 free hours every month.
When you are done working, choose `Stop workspace` from the menu on the left.
The workspace should also stop automatically
30 minutes after the last interaction or 3 minutes after closing the tab.

To restart a previous workspace, go to [https://gitpod.io/workspaces/](https://gitpod.io/workspaces/).
If you change the filter from Active to All, you will see all your recent workspaces.
You can pin a workspace to keep it on the list of active ones.


## Contributing

PRs and issues should be opened at the upstream
[source repository](https://github.com/avigad/mathematics_in_lean_source).
