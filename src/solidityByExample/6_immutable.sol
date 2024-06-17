// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// immutable variables are like constant but immutable vaariables can be initialize or set inside constructor
// but cannot be modified afterwards.
contract Immutable {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(uint256 _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
