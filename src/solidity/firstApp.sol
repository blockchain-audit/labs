// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter{
    uint256 public num;

    function get() public view returns (uint256)
    {
        return num;
    }

    function inc() public 
    {
        num ++;
    }

    function dec() public
    {
        num --;
    }
}