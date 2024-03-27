// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";

contract WalletTest is Test {
    Wallet public w;
    address public myUser = vm.addr(1);

    function setUp() public {
      vm.startPrank(myUser);
      w = new Wallet();
      vm.deal(myUser, 200);
      payable(address(w)).transfer(100);
      w.addGabay(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
      vm.stopPrank();
    }
        function testReceive() public {
        uint256 balance =w.getBalance();
        payable(address(w)).transfer(20);
        assertEq(w.getBalance(), balance + 20);
    }
     function testAddGabay() public {
      uint256 countTest=w.count;
      vm.startPrank(myUser);
      w.addGabay(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
      assertTrue(w.gabaim[0x074AC318E0f004146dbf4D3CA59d00b96a100100]);
      assertEq(w.count, countTest + 1);
      vm.stopPrank();

    }

    function testAddGabayNotOwner() public {
        uint256 countTest=w.count;
        vm.startPrank(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
        w.addGabay(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
        assertTrue(w.gabaim[0x074AC318E0f004146dbf4D3CA59d00b96a100100]==false);
        assertEq(w.count,countTest);
        vm.stopPrank();
    }

    function testAddGabayAlreadyExists() public {
        vm.startPrank(myUser);
        vm.expectRevert("this is already a gabay");
        w.addGabay(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
        vm.stopPrank();

    }
        function testAddGabayMoreThanThree() public {
        vm.startPrank(myUser);
        w.addGabay(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
        w.addGabay(0x29392969D235eA463A6AA42CFD4182ED2ecB5117);
        vm.expectRevert("too many Gabaim");
        w.addGabay(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        vm.stopPrank();

    }

       function testWithdraw() public {
        uint256 amount=50 wei;
        uint256 prevBalance=address(w).balance;
        uint256 expectedBalance=prevBalance-amount;

        w.withdraw(amount);

         assertEq(expectedBalance,address(w).balance,"ERROR! the balance didn't decrease after the withdraw");
    }
      function testWithdrawNotAllowed() public {
        address anotherUser = vm.addr(12);
        vm.startPrank(anotherUser);
        vm.expectRevert("Caller is not allowed");
        w.withdraw(20);
        vm.stopPrank();
    }
      function testWithdrawTooBigAmount() public {
         uint256 balance = w.getBalance();
        vm.startPrank(myUser);
        vm.expectRevert("There is no enough money to withdraw");
        w.withdraw(balance + 1);
        vm.stopPrank();

    }


       function testGetBalance() public {
        uint256 myBalance=address(w).balance;
        uint256 expected=w.getBalance();
        assertEq(myBalance,expected,"ERROR! you should get the balance");
    }

       function testDeleteGabay() public {
        uint256 countTest=w.count;
       vm.startPrank(myUser);
       w.deleteGabay(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
       assertTrue(w.gabaim[0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7]==false);
       assertEq(w.count,countTest-1);
       vm.stopPrank();
    }
}
