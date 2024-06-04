// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.24 and less than 0.9.0
pragma solidity ^0.8.24

contract Primitive{
    bool public boo = true;

    uint8 u8 = 1;
    uint256 u256 = 456;
    uint256 u = 123;

    int8 i8 = -1;
    int256 = 456;
    int256 = -123;

    int256 minInt = type(int256).min;
    int256 maxInt = type(int256).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    bool public defaultBoo;
    uint256 public defaultuint;
    int256 public defaultInt;
    address public defaultAddr;
}