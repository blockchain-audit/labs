// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "./WalletGabaiim.sol";

contract TestWalletGabaiim is Test{
    WalletGabaiim public wg ;

    function setUp() public{
        wg = new WalletGabaiim();
    }

    function testWithdraw(uint256 amount) {
        uint256 balance = wg.balance;
        wg.withdraw(3);
        assertEq(balance - 3, wg.balance);

    }
}