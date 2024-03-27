// SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.11;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/SmartWallet.sol";

contract FuzzTestWallet is Test {
    
    SmartWallet public s;

    receive() external payable {}

    function setUp() public {
        s = new SmartWallet();
        testFuzz_Withdraw(0.00000001 ether);
    }

    function testFuzz_Withdraw(uint256 amount) public {
        console.log(amount);
        console.log(1 ether);
        console.log(2 ether);
        payable(address(s)).transfer(1 ether);
        uint256 preBalance = address(this).balance;
        s.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }
}