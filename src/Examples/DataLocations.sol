// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract DataLocations {
    uint256[] arr;
    mapping(uint256 => address) map;

    struct MyStruct {
        uint256 foo;
    }

    mapping(uint256 => MyStruct) myStructs;

    function f() public {
        _f(arr, map, myStructs[1]);
        MyStruct storage myStruct = myStructs[1];
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(uint256[] storage _arr, mapping(uint256 => address) storage map, MyStruct storage _myStruct) internal {}

    function g(uint256[] memory _arr) public returns (uint256[] memory) {}
    function h(uint256[] calldata _arr) external {}
}
