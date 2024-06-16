// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "Hello World!");
        emit Log(msg.sender, "Hello Evm!");
        emit AnotherLog();
    }
}
