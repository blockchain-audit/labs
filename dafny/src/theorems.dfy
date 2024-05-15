


// from https://hrmacbeth.github.io/math2001/01_Proofs_by_Calculation.html
//  a and b are rational
//  supose  a - b = 4 and ab = 1
//  show that (a + b)^2 = 20

method equation1(a: real, b: real) returns (r: real)
requires a - b == 4.0 
requires a * b == 1.0 
ensures  r == 20.0 {
    r := (a + b) * (a + b);
}


lemma equation2(a: real, b: real)
requires a - b == 4.0 
requires a * b == 1.0  {
    assert (a + b) * (a + b) == 20.0;
}


// 5(4 + 5 + m) = 85
// the solution of m is 
lemma eq3(m: int) 
requires m == 8 {
    assert 5 * (4 + 5 + m) == 85;
}