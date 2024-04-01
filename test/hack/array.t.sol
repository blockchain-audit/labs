// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "@hack/hack/array.sol";

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

contract ContractTest is Test {
    ArrayDeletion arrayDeletion;
    FixedArrayDeletion fixedArrayDeletion;

    function setUp() public {
        arrayDeletion = new ArrayDeletion();
        fixedArrayDeletion = new FixedArrayDeletion();
    }

    function testArrayDeletion() public {
        arrayDeletion.a(0);
        arrayDeletion.a(1);
        arrayDeletion.a(2);
        arrayDeletion.a(3);
        arrayDeletion.a(4);
        //delete incorrectly
        arrayDeletion.deleteElement(1);
        console.log('lenght:');
        arrayDeletion.getLength();
        console.log('state:');

        arrayDeletion.a(0);
        arrayDeletion.a(1);
        arrayDeletion.a(2);
        arrayDeletion.a(3);
        arrayDeletion.a(4);
    }

    function testFixedArrayDeletion() public {
        fixedArrayDeletion.a(0);
        fixedArrayDeletion.a(1);
        fixedArrayDeletion.a(2);
        fixedArrayDeletion.a(3);
        fixedArrayDeletion.a(4);
        //delete incorrectly
        fixedArrayDeletion.deleteElement(1);
        console.log('lenght:');
        fixedArrayDeletion.getLength();
        console.log('state: [we deleted !!!]');

        fixedArrayDeletion.a(0);
        fixedArrayDeletion.a(1);
        fixedArrayDeletion.a(2);
        fixedArrayDeletion.a(3);
    }

    receive() external payable {}
}


