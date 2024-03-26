// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/WalletGabaim.sol";

 contract TestWallet is Test{
    //מופע לארנק 
    WalletGabaim public walletG  ;
    //כתובת רנדומילית על מנת להכניס כסף ולבצע את הבדיקות 
    address public userAddress=0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
   function setUp ()public {
      //יצירת מנופע מהמחלקה
      walletG =new WalletGabaim();
      //מעבירה כסף לכתובת 
      // vm.deal(userAddress, 200);
      // מעבירה לארנק חלק מהכסף שנמצא בכתובת 
      payable(address(walletG)).transfer(100);
      //שליחה לפונקציה להוספת גבאי -מנהל חדש 
      vm.expectRevert();
      walletG.changeOwners(0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7);
   }
  function testReceive()public {
   uint256 balance=walletG.getValue();
   uint256 amount=50;
   payable(address(walletG)).transfer(amount);
   //check if balance the same ;
   assertEq(walletG.getValue(), balance+amount);
   }
function testwithDraw()public{
uint balance= walletG.getValue();
vm.startPrank(userAddress);
//vm.expectRevert();
walletG.withDraw(50);
assertEq(walletG.getValue(), balance - 50);


}
}

   