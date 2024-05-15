// https://dafny.org/dafny/OnlineTutorial/guide

// ---------- PRE & POS conditions

// It's possible to return more than one value
method MultipleReturns(x: int, y: int) returns (l: int, m: int)
requires x > 0 && y > 0
ensures  l < x < m {
    l := x - y;
    m := x + y;
}


//  The ensures could be: ensures 0 <= y && (y == x || y == -x) {
method Abs(x: int) returns (y: int)
ensures 0 <= y
ensures 0 <= x ==> y == x
ensures 0 > x ==> y == -x {
    if x < 0 {
        return -x;
    } else {
        return x;
    }
}


method Max(a: int, b: int) returns (max: int)
ensures (max == a && max > b) ||
        (max == b && max > a) ||
        (max == a && max == b) {
    if a > b {
        return a;
    } else {
        return b;
    }
}

method Divide(x: int, y: int) returns (result: int)
    requires y != 0
    requires x > 0
    ensures result == x / y
    ensures y * result + (x % y) == x
    ensures y > 0 ==> result >= 0 || result < 0
    ensures y < 0 ==> result <= 0
    ensures y == 0 ==> result == 0 {
    var o: int := 234; // declare var with type and aassign
    var remainder := x % y;
    result := x / y;
    assert y * result + remainder == x;
}



// ---------- ASSERTIONS

// Unlike pre- and postconditions, an assertion is placed somewhere in the
// middle of a method. Like the previous two annotations, an assertion has
// a keyword, assert, followed by the boolean expression and the semicolon
// that terminates simple statements. An assertion says that a particular
// expression always holds when control reaches that part of the code.



method ShowAssert() {
  var v := Abs(3);
  assert 0 <= v;
  assert v == 3;
}



