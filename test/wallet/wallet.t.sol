// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/WalletGabaim.sol";

 contract TestWallet is Test{
    //מופע לארנק 
    WalletGabaim public walletG  ;
    address public userAddress=0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
   function setUp ()public {
      //יצירת מנופע מהמחלקה
      uint256 amountWithDraw=50;

      walletG =new WalletGabaim();
      // מעבירה לארנק חלק מהכסף שנמצא בכתובת 
      payable(address(walletG)).transfer(100);
   }
  function testReceive()public {
   uint256 balance=walletG.getValue();
   uint256 amount=50;
   payable(address(walletG)).transfer(amount);
   //check if balance the same ;
   assertEq(walletG.getValue(), balance+amount);
   }
   function testChangeOwnerExsist()public{
    vm.expectRevert();
    walletG.changeOwners(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

   }
    function testChangeOwnerError()public{
   // vm.expectRevert();
    address oldCollector = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address newCollector = 0x9876543210987654321098765432109876543210;
    vm.expectRevert();
    walletG.changeOwners(oldCollector,oldCollector);

   }
    function testChangeOwner()public{
    vm.expectRevert(); 
    address oldCollector = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address newCollector = 0x9876543210987654321098765432109876543210;
    walletG.changeOwners(newCollector,oldCollector);

   }
function testwithDrawIsnOwner(uint256 amountWithDraw)public{
uint balance= walletG.getValue();
vm.startPrank(userAddress);
vm.expectRevert();
walletG.withDraw(50,0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
assertEq(walletG.getValue(), balance );
}
function testwithDrawIsOwner(uint amountWithDraw)public{
uint balance= walletG.getValue();
vm.startPrank(userAddress);
payable(address(walletG)).transfer(200);
//console.log(address(walletG).getValue);
walletG.withDraw(amountWithDraw,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
assertEq(walletG.getValue(), balance - amountWithDraw);
}
  function testFuzz_Withdraw(uint256 amountWithDraw) public {
        payable(address(walletG)).transfer(amountWithDraw);
        
        uint256 preBalance = address(this).balance;
        walletG.withDraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + amountWithDraw, postBalance);
    }
}

   