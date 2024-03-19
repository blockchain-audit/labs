// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../WalletGabaiim.sol";

contract TestWalletGabaiim is Test {
    WalletGabaiim public wallet;

    function setUp() public {
        wallet = new WalletGabaiim();
    }

    function testWithdraw() public {
        addBalance(10000);
        console.log(wallet.balance());
        wallet.withdraw(5);
        console.log(wallet.balance());
        assertEq(wallet.balance(), 50);
    }

    function testWithdrawButNoMoney() public {
        addBalance(10);
        vm.expectRevert("Not Enough Money in wallet");
        wallet.withdraw(100);
    }
    function addBalance(uint256 amount) public {
        address someRandomUser = vm.addr(13);
        vm.startPrank(someRandomUser);
        vm.deal(someRandomUser, amount);
        payable(address(wallet)).transfer(amount);
        vm.stopPrank();
    }
}
