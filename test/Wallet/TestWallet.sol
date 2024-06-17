// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/Wallet/Wallet.sol";

contract WalletTest is Test{
    Wallet public w;
    address public myUser = 0x2881A96386DD97c5B4C63956A420e6E1A674Fc44;
    address gabay1;
     //Initializes all variables
    function setUp() public{
        vm.startPrank(myUser);
        vm.deal(myUser,200);
        payable(address(w)).transfer(100);
        gabay1=w.addGabay(0x81Ee0c1564B711bDf324295a1f1e02E1920876aD);
        vm.stopPrank();
    }
    function testReceive() public {
        uint256 value=100;
        uint256 balance =w.getBalance();   //How much money is in the current account.
        payable(address(w)).transfer(value);   //transfers the money to wallet w.
        assertEq(w.getBalance(), balance + value);   //Puts the money in the wallet.
    }
    function testAddGabayMoreTanthree () public{
        uint256 testCounter=w.counter;
        vm.startPrank(myUser);
        w.addGabay(0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15);
        w.addGabay(0x138b601992D3E744cD2a883bF5a46b3a23D9E7F5);
        w.addGabay(0x5ced660E3b925f034f99Df9466324F30A8Edf176);
        vm.expectRevert("There are too many collectors");
        assertTrue(testCounter>3);
        vm.stopPrank();
    }
    function testAddGabayAlreadyAGabay () public{
        vm.startPrank(myUser);
        w.addGabay(gabay1);
        vm.expectRevert("This address is already registered as a collector");
        vm.stopPrank();
    }
    function testWithdrowIsEnoughMoney() public{
        uint256 amount=50;
        uint256 prevbalance=address(w).balance;
        uint256 expectedbalance=prevbalance+amount;
        vm.startPrank(myUser);
        w.withdraw(amount);
        assertEq(prevbalance,expectedbalance);
        vm.stopPrank();
    }
    function testWithdrowIsntEnoughMoney() public{
        uint256 amount=250;
        uint256 prevbalance=address(w).balance;
        uint256 expectedbalance=prevbalance+amount;
        vm.startPrank(myUser);
        w.withdraw(amount);
        assertEq(prevbalance,expectedbalance,"You don't have enough money in your account");
        vm.stopPrank();
}
    function testWithdrowIsntAllowd() public{
        uint256 amount=50;
        address a=0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd;
        uint256 prevbalance=address(w).balance;
        uint256 expectedbalance=prevbalance+amount;
        vm.startPrank(a);
        w.withdraw(amount);
        assertEq(prevbalance,expectedbalance,"You don't have permission to transfer funds from the smart contract");
        vm.stopPrank();
    }
    function testWithdrowIsAllowd() public{
        uint256 amount=50;
        address a=0x81Ee0c1564B711bDf324295a1f1e02E1920876aD;
        uint256 prevbalance=address(w).balance;
        uint256 expectedbalance=prevbalance+amount;
        vm.startPrank(a);
        w.withdraw(amount);
        assertEq(prevbalance,expectedbalance);
        vm.stopPrank();
    }
    function testGetBalance() public{
        uint256 testBalance=w.getBalance();
        uint256 testWBalance=w.balance();
        vm.startPrank(myUser);
        assertEq(testGetBalance,testWBalance);
        vm.stopPrank();
    }
    function testDeleatGabayIsAlowdIsGabay()public{
        address testGabay= 0x09E7D0A2e83C6830CFcaf3C2822a74420D23EB63;
        uint256 testCounter=w.counter;
        vm.startPrank(myUser);
        w.deleatGabay(testGabay);
        vm.expectRevert("The address is not that of a debt collector");
        assertEq(w.counter,testCounter-1);
        vm.stopPrank();
    }
}