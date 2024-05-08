// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@labs/sheets/Divide.sol";
import "forge-std/Test.sol";

contract TestDivide is Test {
    Divide public d;
    address user = vm.addr(1);
    address user1 = vm.addr(11);
    address user2 = vm.addr(12);
    address user3 = vm.addr(13);

    function setUp() public {
        d = new Divide();
        d.addAddress(user);
        d.addAddress(user1);
        d.addAddress(user2);
        d.addAddress(user3);
    }

    function testDivide() public {
        d.divide{value: 100 * 1e18}();
        assertEq(user1.balance, 25 * 1e18);
    }
}
