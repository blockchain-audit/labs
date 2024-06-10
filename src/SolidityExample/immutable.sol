// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Immutable {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor (uint256 _MyUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _MyUint;
    }


}