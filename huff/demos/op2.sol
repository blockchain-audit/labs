// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.20 and less than 0.9.0
pragma solidity ^0.8.20;

contract Op1 {
    function addTwo(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}
