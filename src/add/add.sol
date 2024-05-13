// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Add {
    constructor() {}

    function addTwo(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
}