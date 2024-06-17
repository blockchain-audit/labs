// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract ReceiveEther{
    receive()external payable{}
    fallback() external payable{}
    function getBalance() public 
}