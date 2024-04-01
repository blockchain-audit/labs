// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "@hack/libs/ierc20.sol";


/*
Name: Array Deletion Oversight: leading to data inconsistency

Description:
In Solidity where improper deletion of elements from dynamic arrays can result in data inconsistency.
When attempting to delete elements from an array, if the deletion process is not handled correctly,
the array may still retain storage space and exhibit unexpected behavior.


Mitigation:
Option1: By copying the last element and placing it in the position to be removed.
Option2: By shifting them from right to left.

REF:
https://twitter.com/1nf0s3cpt/status/1677167550277509120
https://blog.solidityscan.com/improper-array-deletion-82672eed8e8d
https://github.com/sherlock-audit/2023-03-teller-judging/issues/88
*/


contract ArrayDeletion {
    uint[] public a = [1, 2, 3, 4, 5];

    function deleteElement(uint index) external {
        require(index < a.length, "Invalid index");
        delete a[index];
    }

    function getLength() public view returns (uint) {
        return a.length;
    }
}


contract FixedArrayDeletion {
    uint[] public a = [1, 2, 3, 4, 5];

    //Mitigation 1: By copying the last element and placing it in the position to be removed.
    function deleteElement(uint index) external {
        require(index < a.length, "Invalid index");

        // Swap the element to be deleted with the last element
        a[index] = a[a.length - 1];

        // Delete the last element
        a.pop();
    }

    // Mitigation 2: By shifting them from right to left.
    function deleteElementB(uint index) external {
        require(index < a.length, "Invalid index");
        for (uint i = index; i < a.length - 1; i++) {
            a[i] = a[i + 1];
        }
        // Delete the last element
        a.pop();
    }
    function getLength() public view returns (uint) {
        return a.length;
    }
}
