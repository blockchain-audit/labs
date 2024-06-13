// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Array {
    uint256[] arr1 public;
    uint256[] arr2 public = [1,2,3];
    uint256[10] arr3 public;

    function get(uint256 i) public view returns (uint256)
    {
        return arr1[i];
    }

    function getArr() public view returns (uint256[] memory)
    {
        return arr1;
    }

    function push(uint256 x) public 
    {
        arr1.push(x);
    }

    function pop() public 
    {
        arr1.pop();
    }

    function getLength() public view returns (uint256)
    {
        arr1.length;
    }

    function remove(uint256 i) public 
    {
        delete arr1[i];
    }

    function examples () external 
    {
        uint256[] memory a = new uint256[](5);
    }
}