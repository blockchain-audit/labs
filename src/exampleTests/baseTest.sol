pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract BaseTest is Test {
    uint256 testNumber;



    function setUp() public {
        testNumber = 42;

    }

    function test_NumberIs42() public {
        assertEq(testNumber, 42);
//        console.log(testNumber);
    }

    function testFail_Subtract43() public {
        testNumber -= 43;
    }
}

