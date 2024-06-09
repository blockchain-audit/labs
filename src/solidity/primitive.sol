// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract primitives {
    bool public boo = true;

    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    // bytes1 a = 0X56;
    // bytes1 b = 0X56;

    bool public defaultBool ;
    uint256 public defaultUint ;
    int256 public defaultInt ;
    bytes public defaultBytes ;
    address public defaultAddress ;
    
}