// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Variables{
    uint256 public i = 123;
    string public s = "hello";

    function doSomething() public 
    {
        uint256 number = 456;

        uint256 timestamp = block.timeStamp;

        address sender = msg.sender;
    }
}