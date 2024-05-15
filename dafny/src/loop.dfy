
include "util/number.dfy"


import opened Number


// removing requires and invariant break the prove
method loop1(n: u256) returns (r: u256)
requires n >= 0
ensures  r == n {
    var i := 0;
    while (i < n)
    invariant i <= n {
        r := n;
        i := i + 1;
    }
    r := i;
}




// removing requires and invariant break the prove
method loop2(n: u128) returns (r: u256)
requires n >= 0
ensures  r == n as u256 {
    var i := 0;
    while (i < n)
    invariant i <= n {
        r := n as u256;
        i := i + 1;
    }
    r := i as u256;
}


// why we get a violation here ?
/**
method loop3(n: u256) returns (r: u128)
requires n >= 0
ensures  r == n as u128 {
    var i := 0;
    while (i < n)
    invariant i <= n {
        r := n as u128;
        i := i + 1;
    }
    r := i as u128;
}

*/



method loop3(n: int, a: array?<int>) returns (sum: int, max: int)
requires 0 <= n && a != null && a.Length == n
ensures  sum <= n * max {
    sum  := 0;
    max  := 0;
    var i:= 0;

    while i < n
    invariant i <= n && sum <= i * max {
        if max < a[i] {
            max := a[i];
        }
        sum := sum + a[i];
        i := i + 1;
    }
}
