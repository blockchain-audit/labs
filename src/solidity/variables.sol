// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract variables {
    string public text = "hello";
    uint256 public num = 123;

    function dooSomething() public {
        uint256 i = 456;

        uint256 timestamp = block.timestamp;
        address sender = msg.sender;
    }
}