pragma solidity ^0.8.20;

uint WAD = 10 ^18;
uint RAY = 10 ^ 27;

uint a = 2;
uint b = 100;
 
uint c = a *WAD /b;


uint z = c + (9 * WAD);
uint z1 = (z * c) / WAD;
