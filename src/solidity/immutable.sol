// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract immutables {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor (uint256 num) {
        MY_ADDRESS = msg.sender;
        MY_UINT = num;
    }
}