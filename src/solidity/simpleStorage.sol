// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
 contract simpleStorage {
    uint256 public num;

    function set(uint256 mynum) public {
        num = mynum;
    }

    function get() public view returns (uint256){
        return num;
    }
 }