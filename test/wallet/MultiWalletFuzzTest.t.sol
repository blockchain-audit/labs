// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/wallet/MultiWallet.sol";

contract MultiWalletFuzzTest is Test {
    MultiWallet public multiWallet;

    function setUp() public {
        multiWallet = new MultiWallet();
    }

    receive() external payable {}

    function testInsertOwner(address newOwner1, address newOwner2, address newOwner3, address newOwner4) public {
        multiWallet.insertOwner(newOwner1);
        multiWallet.insertOwner(newOwner2);
        multiWallet.insertOwner(newOwner3);
        
        vm.expectRevert("Only three owners allowed");
        multiWallet.insertOwner(newOwner4);
    }

    function testInsertOwnerNotAllowed(address newOwner) public {
        //address newOwner = vm.addr(1);
        vm.startPrank(newOwner);
        vm.assume(newOwner != multiWallet.getChairman());
        vm.expectRevert("Only the chairman allowed to do this");
        multiWallet.insertOwner(newOwner);
        vm.stopPrank();
    }

    function testReplaceOwner(address oldOwner, address newOwner) public {
        //address newOwner = vm.addr(1);
        //address oldOwner = vm.addr(2);
        multiWallet.insertOwner(oldOwner);
        multiWallet.replaceOwner(oldOwner, newOwner);
        address payable[] memory owners = multiWallet.getOwners();
        bool isReplaced = false;
        if (owners[0] == newOwner) isReplaced = true;
        assertEq(isReplaced, true, "Failed");
    }

    function testReplaceOwnerNotAllowed(address oldOwner, address newOwner) public {
        //address oldOwner = vm.addr(1);
        //address newOwner = vm.addr(2);
        vm.startPrank(oldOwner);
        vm.assume(oldOwner != multiWallet.getChairman());
        vm.expectRevert("Only the chairman allowed to do this");
        multiWallet.replaceOwner(oldOwner, newOwner);
        vm.stopPrank();
    }

    function testReplaceOwnerNotExist(address oldOwner, address newOwner) public {
        vm.assume(oldOwner != multiWallet.getChairman() && oldOwner != payable(0x0));
        vm.expectRevert("Owner not exist");
        multiWallet.replaceOwner(oldOwner, newOwner);
    }

    function testRemoveOwner(address oldOwner) public {
        //address oldOwner = vm.addr(1);
        multiWallet.insertOwner(oldOwner);
        vm.assume(oldOwner != address(0x0));
        multiWallet.removeOwner(oldOwner);
        address payable[] memory owners = multiWallet.getOwners();
        bool isRemoved = true;
        if (owners[0] == oldOwner) isRemoved = false;
        assertEq(isRemoved, true, "Failed");
    }

    function testRemoveOwnerNotAllowed(address oldOwner) public {
        //address oldOwner = vm.addr(1);
        vm.startPrank(oldOwner);
        vm.assume(oldOwner != multiWallet.getChairman());
        vm.expectRevert("Only the chairman allowed to do this");
        multiWallet.removeOwner(oldOwner);
        vm.stopPrank();
    }

    function testWithdraw(uint256 withdrawAmount) public {
        //address ownerAddress = vm.addr(1);
        //multiWallet.insertOwner(ownerAddress);
        uint256 initialBalance = 150;
        //uint256 withdrawAmount = 100;
        payable(address(multiWallet)).transfer(initialBalance);
        //vm.startPrank(ownerAddress);
        vm.assume(withdrawAmount > 0 && withdrawAmount <= initialBalance);
        multiWallet.withdraw(withdrawAmount);
        uint256 balanceAfter = multiWallet.getBalance();
        assertEq(initialBalance - withdrawAmount, balanceAfter, "Not equal");
        //vm.stopPrank();
    }

    // function testWithdrawBigAmount(uint256 withdrawAmount) public {
    //     //address ownerAddress = vm.addr(1);
    //     //multiWallet.insertOwner(ownerAddress);
    //     uint256 initialBalance = 150;
    //     //uint256 withdrawAmount = 200;
    //     payable(address(multiWallet)).transfer(initialBalance);
    //     //vm.startPrank(ownerAddress);
    //     vm.assume(withdrawAmount > initialBalance);
    //     vm.expectRevert("The amount to withdraw should be less than your current balance");
    //     multiWallet.withdraw(withdrawAmount);
    //     //vm.stopPrank();
    // }

    // function testWithdrawNotAllowed(address ownerAddress) public {
    //     //address ownerAddress = vm.addr(1);
    //     uint256 initialBalance = 150;
    //     uint256 withdrawAmount = 100;
    //     address payable[] memory owners = multiWallet.getOwners();
    //     payable(address(multiWallet)).transfer(initialBalance);
    //     vm.startPrank(ownerAddress);
    //     vm.assume(ownerAddress != multiWallet.getChairman() && ownerAddress != owners[0] && ownerAddress != owners[1] && ownerAddress != owners[2]);
    //     vm.expectRevert("Only the owner allowed to do this");
    //     multiWallet.withdraw(withdrawAmount);
    //     vm.stopPrank();
    // }

    function testGetBalance() public {
        assertEq(
            multiWallet.getBalance(),
            address(multiWallet).balance,
            "Not equal"
        );
    }
}
