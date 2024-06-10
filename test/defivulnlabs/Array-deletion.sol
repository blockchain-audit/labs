pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract contractTest is Test{
    arreyDeletionBug arreyContract;
    fixedArreyDeletion fixedContract;

    function setup() public {
        arreyContract = new arreyDeletionBug();
        fixedContract = new fixedArreyDeletion();
    }

    function testDeletionBug() public {
        arreyContract.arr(1);
        arreyContract.deleteElement(1);
        arreyContract.arr(1);
        arreyContract.getlength();
    }

    function testFixedDeletion() public {
        fixedContract.arr(1);
        fixedContract.deleteElement1(1);
        fixedContract.arr(1);
        fixedContract.getlength();
    }
}


contract arreyDeletionBug {
    uint[] public arr = [1,2,3,4,5];

    function deleteElement(uint index) external {
        require(index < arr.length , "index out of bound");
        delete arr[index];
    }

    function getlength() external view returns (uint) {
        return arr.length;
    }
}



contract fixedArreyDeletion{
    uint[] public arr = [1,2,3,4,5];

    function deleteElement1(uint index) external{

        require(index < arr.length , "index out of bound");

        arr[index] = arr[arr.length - 1];

        arr.pop();

    }

    function deleteElement(uint index) external {
        require(index < arr.length , "index out of bound");

        for (uint i = index; i < arr.length - 1 ; i++) {
            arr[i] = arr[i+1];
            arr.pop();
        }
    }

    function getlength() external view returns (uint) {
        return arr.length;
    }
}