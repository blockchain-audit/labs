// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract arrey {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 5];
    uint256[10] public fixe;

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
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
       return arr.length;
    }

    function remove(uint256 i) public {
        delete arr[i];
    }

    function example() external {
        uint256[] memory a = new uint256[](5); 

    }
}

contract arreyRemove {
    uint256[] public arr;

    function remove(uint256 index) public {

    require(index< arr.length, "index out of bound");

    for(uint256 i = index; i < arr.length; i++){
        arr[i] = arr [i + 1];
    }
    arr.pop();

    }

    function test() external{
        arr = [1, 2, 3, 4, 5];
        remove(2);

        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);

        assert(arr.length == 0);
    }

}

contract arreyReplace {
    uint256[] public arr;

    function remove(uint256 index) public {
        arr[index] = arr[arr.length - 1];

        arr.pop();
    }

    function test() public {

        arr = [1, 2, 3, 4];

        remove(1);
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    
    }

}
