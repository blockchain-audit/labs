pragma solidity ^0.8.20;

// def WAD : N := 10 ^ 18
uint WAD = 10 ^18;
// def RAY : N := 10 ^ 27
uint RAY = 10 ^ 27;

// def a : N := 2
uint a = 2;
// def b : N := 1000
uint b = 100;

// def c : N := a * WAD / b 
uint c = a *WAD /b;

// #eval c        2000000000000000
// #eval x * 7   14000000000000000
// #eval c / 7     285714285714285


// def z := c + (9*WAD)
uint z = c + (9 * WAD);
// def z1 := (z * 9) / WAD
uint z1 = (z * c) / WAD;
// #eval z1    18004000000000000