// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract arrey {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 5];
    uint256[10] public fixed;

    function get(uint256 i) public view returns (uint256) {
        return arr(i);
    }

    function getArrey() public view returns (uint256[] memory){
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        arr.pop();
    }

    function getLength() public view returns (uint256) {
       return arr.length();
    }

    function remove(uint256 i) public {
        delete arr[i];
    }

    function example() external {
        uint256 memory a = new uint256[](5); 

    }
}

