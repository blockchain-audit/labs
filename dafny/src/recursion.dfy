




method mul1(x: int, y: int) returns (r: int)
requires 0 <= x && 0 <= y
ensures  r == x * y {
    if x == 0 {
        r := 0;
    } else {
        var m := mul1(x - 1, y);
        r := m + y;
    }
}





