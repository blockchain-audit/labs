
include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx
// Hoare Triples


// P = { x == 12} x = x + 8 {x = 20}
method hoare1(x: int) returns (x': int)
requires x == 12
ensures  x' == 20 {
  x' := x + 8;
}

// P = {21 > x >= 12} x = x + 8 { x = 20 }
method hoare1a(x: int) returns (x': int)
requires 21 > x >= 12
ensures  29 > x' >= 20 {
    x' := x + 8;
}

method hoare1b(x: int, y: int) returns (x': int, y': int)
requires 21 > x >= 12 
requires y > 32
ensures  29 > x' >= 20 
ensures  if x' > 21 then y' > 33 else y' > 40
ensures  y' > 44 {
    x' := 20;
    y' := 45;
}


// {{ x < 18 }} S {{ 0 <= y }}
method hoare2(x: int) returns (y: int)
requires x < 18
ensures  0 <= y {
    var a := 13;
    var b := 22;

    if (x > a && x > 0) {
        y := 99 + x;
    } else {
        y := b + 2;
    }
}

// {{ x < 18 }} S {{ 0 <= y }}
method hoare2A(x: int) returns (y: int)
requires x < 18
ensures  0 <= y {
    y := 18 - x;
}

method hoare2B(x : int) returns (y: int)
requires x < 10
ensures  0 <= y {
    y := x;  // cant pass
    y := 99;
}

method hoare2C(x : int) returns (y: int)
requires x < 10
ensures  0 <= y {
    y := 2 * (x + 3); // cant pass
    y := 99;
}

method hoare23C(x: u256, y: u256) returns (z: u256)
requires x == y
ensures  z == 0 {
    z := x - y;
}

// holds because output is respectin
method hoare23b()  returns (x: u256)
requires true
ensures x == 100 {
    x := 100;
}

// {{ true }} x := 2 * y {{ x is even }}
method hoare23c(y: u128) returns (x: u256)
requires true
ensures  isEven(x) {
    x := 2 * y as u256;
}

predicate isEven(x: u256) {
    x % 2 == 0
}

// {{ x == 89 }} y := x - 32 {{ x == 89 }}
method hoare23d(x: u256) returns (y: u256)
requires x == 89
ensures  x == 89 {
    y := x - 32;
}

method hoare23e(x: u256) returns (y: u256)
requires x == 3
ensures  y == 4 {
    y := x + 1;
}

method hoare23f(x: u256) returns (y: u256)
requires 0 <= x  < 100
ensures  0 <  y <= 100 {
    y := x + 1;
}


method hoare23fb(x: u256) returns (y: u256)
requires 0 <= x  < MAX_U256 as u256
ensures  0 <  y <= MAX_U256 as u256 {
    y := x + 1;
}

// { true } x := 2 * y { y <= x}
method hoare24a(p: bool, x: int, y: int) returns (x': int, y': int)
requires p == true
ensures  y' <= x' || y' > x' {
    y' := y;
    x' := 2 * y';
}

// {true } x = 2 * y {y <= x} -> not hold with -1
// {y > 0} x = 2 * y {y <= x} -> hold
method hoare24a2(y: int) returns (x: int)
requires true
requires y > 0
ensures y <= x {
    x := 2 * y;
}

// { x == 3 } x == x + 1 { y == 4 } -> not hold
// adding y := 4 holds
method hoare24b(x: int) returns (y: int) 
requires x == 3
ensures  y == 4 {
    var x' := x + 1;
    y := 4; // here
}

// added y == 4 to make it hold
method hoare24b2(y: int) 
requires y == 4 {
    var x := 3;
    x := x + 1;
    assert y == 4; // not hold
}

method hoare24d() {
    var    x := 0; // Precondition is true
    assert 0 <= x; // Assert precondition
    x := x - 1;    // Execute the statement
    // assert 0 <= x; // Assert postcondition [not hold]
}



