// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


contract Function {
    function returnMany() public returns (uint, bool, uint)
    {
        return (5, true, 10);
    }

    function named() public returns (uint x, bool y, uint z)
    {
        return (6, false, 9);
    }

    function assigned() public returns (uint x, bool y, uint z)
    {
        x = 6;
        y = true;
        z = 7;
    }

    function func() public returns (uint, bool, uint, uint )
    {
        (uint x, bool b, uint u) = returnMany();

        (a, , b) = (5, 6, 7);

        return (a, b, u, 5);
    }
}