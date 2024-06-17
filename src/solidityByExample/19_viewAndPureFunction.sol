// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract viewAndPure {
    uint256 public x = 1;

    function addToX(uint256 y) public view returns (uint256) {
        return x + y;
    }

    function add(uint256 i, uint256 j) public pure returns (uint256) {
        return i + j;
    }
}
