// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/wallet/MultiWallet.sol";

contract MultiWalletTest is Test {
    MultiWallet public multiWallet;

    function setUp() public {
        multiWallet = new MultiWallet();
    }

    receive() external payable {}

    function testInsertOwner() public {
        address newOwner1 = vm.addr(1);
        address newOwner2 = vm.addr(2);
        address newOwner3 = vm.addr(3);
        multiWallet.insertOwner(newOwner1);
        multiWallet.insertOwner(newOwner2);
        multiWallet.insertOwner(newOwner3);
        
        address newOwner4 = vm.addr(4);
        vm.expectRevert("Only three owners allowed");
        multiWallet.insertOwner(newOwner4);
    }

    function testInsertOwnerNotAllowed() public {
        address newOwner = vm.addr(1);
        vm.startPrank(newOwner);
        vm.expectRevert("Only the chairman allowed to do this");
        multiWallet.insertOwner(newOwner);
        vm.stopPrank();
    }

    function testReplaceOwner() public {
        address newOwner = vm.addr(1);
        address oldOwner = vm.addr(2);
        multiWallet.insertOwner(oldOwner);
        multiWallet.replaceOwner(oldOwner, newOwner);
        address payable[] memory owners = multiWallet.getOwners();
        bool isReplaced = false;
        if (owners[0] == newOwner) isReplaced = true;
        assertEq(isReplaced, true, "Failed");
    }

    function testReplaceOwnerNotAllowed() public {
        address oldOwner = vm.addr(1);
        address newOwner = vm.addr(2);
        vm.startPrank(oldOwner);
        vm.expectRevert("Only the chairman allowed to do this");
        multiWallet.replaceOwner(oldOwner, newOwner);
        vm.stopPrank();
    }

    function testReplaceOwnerNotExist() public {
        address newOwner = vm.addr(1);
        address oldOwner = vm.addr(2);
        vm.expectRevert("Owner not exist");
        multiWallet.replaceOwner(oldOwner, newOwner);
    }

    function testRemoveOwner() public {
        address oldOwner = vm.addr(1);
        multiWallet.insertOwner(oldOwner);
        multiWallet.removeOwner(oldOwner);
        address payable[] memory owners = multiWallet.getOwners();
        bool isRemoved = true;
        if (owners[0] == oldOwner) isRemoved = false;
        assertEq(isRemoved, true, "Failed");
    }

    function testRemoveOwnerNotAllowed() public {
        address oldOwner = vm.addr(1);
        vm.startPrank(oldOwner);
        vm.expectRevert("Only the chairman allowed to do this");
        multiWallet.removeOwner(oldOwner);
        vm.stopPrank();
    }

    function testWithdraw() public {
        //address ownerAddress = vm.addr(1);
        //multiWallet.insertOwner(ownerAddress);
        uint256 initialBalance = 150;
        uint256 withdrawAmount = 100;
        payable(address(multiWallet)).transfer(initialBalance);
        //vm.startPrank(ownerAddress);
        multiWallet.withdraw(withdrawAmount);
        uint256 balanceAfter = multiWallet.getBalance();
        assertEq(initialBalance - withdrawAmount, balanceAfter, "Not equal");
        //vm.stopPrank();
    }

    function testWithdrawBigAmount() public {
        //address ownerAddress = vm.addr(1);
        //multiWallet.insertOwner(ownerAddress);
        uint256 initialBalance = 150;
        uint256 withdrawAmount = 200;
        payable(address(multiWallet)).transfer(initialBalance);
        //vm.startPrank(ownerAddress);
        vm.expectRevert("The amount to withdraw should be less than your current balance");
        multiWallet.withdraw(withdrawAmount);
        //vm.stopPrank();
    }

    function testWithdrawNotAllowed() public {
        address ownerAddress = vm.addr(1);
        uint256 initialBalance = 150;
        uint256 withdrawAmount = 100;
        payable(address(multiWallet)).transfer(initialBalance);
        vm.startPrank(ownerAddress);
        vm.expectRevert("Only the owner allowed to do this");
        multiWallet.withdraw(withdrawAmount);
        vm.stopPrank();
    }

    function testGetBalance() public {
        assertEq(
            multiWallet.getBalance(),
            address(multiWallet).balance,
            "Not equal"
        );
    }
}
