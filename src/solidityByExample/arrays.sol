// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


contract Array{
      
    uint256[] public arr;
    uint256[] public arr2 = [1,2,3];
    uint256[10] public arr3;

    function get(uint256 i) public view returns (uint256){
        return arr[i];
    }

    function getArr() public view returns (uint256[] memory){
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        arr.pop();
    }

    function getLength() public view returns (uint256){
        return arr.length;
    }

    function remove(uint256 index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }

    function examples() pure external {
        // create array in memory, only fixed size can be created.
        uint256[] memory a = new uint256[](1);
        delete a;
    } 
}