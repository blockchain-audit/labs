

// specs:  10 <= x && y <= 25
// 10 <= x && a == x + 3 && b == 12 && y == a + b ==> 25 <= y
method exec1(x: int) returns (y: int)
requires 10 <= x
ensures  25 <= y {
    var a := x + 3;
    var b := 12;
    y := a + b;
}


// whatever is known to hold at each step, is also
// known to hold a the next step until the final implication
method exec1_forward(x: int) returns (y: int)
requires 10 <= x
ensures  25 <= y {
    // 10 <= x
    var a := x + 3;
    // 10 <= x && a == x + 3
    var b := 12;
    // 10 <= x && a == x + 3 && b == 12
    y := a + b;
    // 10 <= x && a == x + 3 && b == 12 && y == a + b ==> 25 <= y
}


// whatever is known to hold at each step, is also
// known to hold a the previous step until the final implication
// on the pre-state.
method exec1_backward(x: int) returns (y: int)
// 10 <= x ==> 25 <= x + 3 + 12
requires 10 <= x
ensures  25 <= y {
    // 25 <= x + 3 + 12
    var a := x + 3;
    // 25 <= a + 12
    var b := 12;
    // 25 <= a + b
    y := a + b;
    // 25 <= y
}

method exec2_backward(x: int) returns (y: int)
// 10 <= x ==> 25 <= x + 3 + 12
requires 10 <= x
ensures  25 <= y {
    y := 99;
}


method exec2(x: int) returns (y: int)
requires 10 <= x
ensures  20 <= y  {
    var a := x + 3;
    var b := 12;
    y := a + b;
}

method exec3(x: int) returns (y:int)
requires x < 10
ensures  y < 10 {
    y := x;
}


method exec4(x: int) returns (y: int)
    requires 10 <= x
    ensures 25 <= y  {

    var a, b;

    a := x + 3;

    if x < 20 {
        b := 32 -x;
    } else {
        b := 16;
    }

    y := a + b;
}
