
// ---------- FUNCTIONS

// * Functions:
//   - Purely mathematical constructs representing a mapping between input and output values.
//   - Bodies consist of a single expression that calculates and returns the output.
//   - No side effects (no modification of program state).
//   - Visible Implementation: The verifier can inspect the function's body and
//     use its definition during reasoning.
//   - Mathematical Reasoning: Treated as mathematical expressions, allowing symbolic
//     manipulation and equational reasoning.
//   - No State Change: Since functions are pure (no side effects), their behavior is predictable
//     and verifiable based on their definitions alone.
//   - Seamless Integration: Can be substituted directly into other expressions and assertions for reasoning.
//   - Verification Focus: The verifier concentrates on different aspects of methods and functions.
//   - Predictability: Transparent functions enable precise reasoning about their behavior due to their pure nature.
//
//
// * Methods:
//   - Executable code blocks performing actions and potentially modifying program state.
//   - Bodies can contain multiple statements, including assignments, loops,
//     conditionals, and calls to other methods.
//   - Hidden Implementation: The verifier does not examine the internal workings of a method's body.
//   - Trust in Specification: It relies solely on the method's declared pre and postconditions
//     to reason about its behavior.
//   - Reasoning About Effects: Ensures that calls to the method adhere to its specifications without
//     needing to know exact steps involved.
//   - Encapsulation: Fosters modularity and prevents reasoning about code details
//     that might change, simplifying verification.
//   - Modularity: Opaque methods promote modular reasoning and allow implementation changes
//     without affecting verification of other code that calls them.


// Function (pure calculation, single expression)
// Method (can include additional logic and actions)
function square(x: int): int { x * x }
method printSquare(x: int) {
  var result := square(x);  // Call the function
  print("The square of ", x, " is ", result);
}


// Function (direct expression for comparison and return)
// Method (can involve more complex decision-making)
function max(a: int, b: int) : int { if a > b then a else b }
method adjustMax(a: int, b: int) returns (r: int) {
  var maxVal := max(a, b);
  if maxVal > 100 { return 100; } // Cap the maximum value
  else { return maxVal; }
}

method maxSeq(values: seq<int>) returns (max: int)
requires values != []
ensures max in values
ensures forall i | 0 <= i < |values| :: values[i] <= max {
  max := values[0];
  for idx := 0 to |values|
    invariant max in values
    invariant forall j | 0 <= j < idx :: values[j] <= max
  {
    if max < values[idx] {
      max := values[idx];
    }
  }
}

lemma maxUniq(values: seq<int>, m1: int, m2: int)
requires m1 in values && forall i | 0 <= i < |values| :: values[i] <= m1
requires m2 in values && forall i | 0 <= i < |values| :: values[i] <= m2
ensures m1 == m2 {
    // This lemma does not need a body: Dafny is able to prove it correct entirely automatically.
}

// Usage:
// dafny run ./src/intro.dfy
method Main() {
    print "hello, world\n";
    printSquare(9);
    assert 420 > 55;
}

