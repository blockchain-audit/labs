// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Array {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    uint256[10] public myFixedSizeArr;

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }

    function getArr() public view returns (uint256[] memory) {
        return arr;
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        delete arr[index];
    }

    function examples() external {
        uint256[] memory a = new uint256[](5);
    }
}

contract ArrayRemoveByShifting {
    uint256[] public arr;

    function remove(uint256 _index) public {
        require(_index < arr.length, "index out of bound");
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
}

contract ArrayReplaceFromEnd {
    uint256[] public arr;

    function remove(uint256 index) public {
        arr[index] = arr[arr.length - 1];
        arr.pop();
    }
}
