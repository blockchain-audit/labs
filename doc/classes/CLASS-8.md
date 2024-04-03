




```dafny
method nativ(x: int) returns (y: int)
requires 15 <= x
ensures  30 <= y {
    // 10 <= x
    var a := x + 3;
    // 10 <= x && a == x + 3
    var b := 12;
    // 10 <= x && a == x + 3 && b == 12
    y := a + b;
    // [(10 <= x && a == x + 3 && b == 12 && y == a + b) ==> 25 <= y] = true
}
```
