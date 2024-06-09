// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract mappings {
    mapping (address => uint256) public myMap;

    function get(address addr) public view returns (uint256) {
        return myMap[addr];
    }

    function set(address addr, uint256 i) public {
        myMap[addr] = i;
    }

    function remove(address addr) public {
        delete myMap[addr];
    }
}

contract nestedMapping {
    mapping (address => mapping (uint256=>bool)) nested;

    function get(address addr, uint256 i) public view returns (bool){
        return nested[addr][i];
    }

    function set(address addr, uint256 i, bool b) public {
        nested[addr][i] = b;
    }

    function remove(address addr, uint256 i) public {
        delete nested[addr][i];
    }
}