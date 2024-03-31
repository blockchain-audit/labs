// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/walletGabaim.sol";

contract TestFuzzWalletGabaim is Test {
    //מופע לארנק
    WalletGabaim public walletG;
    

    function setUp() public {
        walletG = new WalletGabaim();
        //מכניסה כסף לחוזה חכם שלייי הנוכחייי
        vm.deal(address(this), 100);
    }

    function test_fuzzReceive(uint256 amount) public {
        vm.deal(address(this), amount);
        uint256 balance = walletG.getValue();
        console.log(balance);
        payable(address(walletG)).transfer(amount);
        //check if balance the same ;
        assertEq(walletG.getValue(), balance + amount);
    }
        function testChangeOwnerExsist(address oldOwner, address newOwner) public {
            //if new owner is exsist
            // vm.startPrank(newOwner);
        vm.assume(newOwner == address(this)||1== walletG.getGabaim(newOwner));
        vm.expectRevert("you are owner");
        walletG.changeOwners(newOwner, oldOwner);
    }
       function testChangeOwner(address oldOwner, address newOwner) public {
        vm.startPrank(oldOwner);
        vm.assume(oldOwner == address(this)&& (newOwner != address(this)||1!= walletG.getGabaim(newOwner)));
        walletG.changeOwners(newOwner, oldOwner);
    }
    function testChangeOwnerNotAllowed(address oldOwner, address newOwner) public {
        vm.startPrank(oldOwner);
        vm.assume(oldOwner != address(this));
        vm.expectRevert("Only the Owner allowed to do this");
        walletG.changeOwners(newOwner, oldOwner);
        vm.stopPrank();
    }

    function test_fuzzWithDrawIsOwner(uint amountWithDraw,address ownerAddress) public {
        vm.deal(address(walletG), amountWithDraw);
        uint balance = address(walletG).balance;
        vm.startPrank(ownerAddress);
        vm.assume(amountWithDraw >0 && amountWithDraw<=balance);
        walletG.withDraw(amountWithDraw);
        assertEq(walletG.getValue(), balance - amountWithDraw);
    }
      function test_fuzzWithDrawBigAmount(uint256 amountWithDraw,uint256 amount) public {
        vm.deal(address(walletG), amount);
        uint balance = address(walletG).balance;
        //vm.startPrank(ownerAddress);
        vm.assume(amountWithDraw >balance);
        vm.expectRevert("Dont have enough money");
        walletG.withDraw(amountWithDraw);
    }
     function test_fuzzWithDrawIsnOwner(uint256 amountWithDraw,address noOwnerAddress) public {
        //vm.startPrank(noOwnerAddress);
        vm.assume(noOwnerAddress!=address(this)||1!= walletG.getGabaim(noOwnerAddress));
        vm.expectRevert("Only the owner can withdraw");
        walletG.withDraw(amountWithDraw);
        vm.stopPrank();
        // assertEq(walletG.getValue(), balance);
    }
     function testGetBalance() public {
        assertEq(
            walletG.getValue(),
            address(walletG).balance,
            "Not equal"
        );
     }
}
