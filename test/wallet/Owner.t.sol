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
      walletG =new WalletGabaim();
      // מעבירה לארנק חלק מהכסף שנמצא בכתובת 
      payable(address(walletG)).transfer(100);
      //שליחה לפונקציה להוספת גבאי -מנהל חדש 
    //  vm.expectRevert();
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
    address newCollector = 0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b;
    vm.expectRevert();
    walletG.changeOwners(oldCollector,oldCollector);

   }
    function testChangeOwner()public{
   // vm.expectRevert();
    address oldCollector = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address newCollector = 0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86;
    walletG.changeOwners(newCollector,oldCollector);

   }
function testwithDrawIsnOwner()public{
uint balance= walletG.getValue();
vm.startPrank(userAddress);
vm.expectRevert();
//0xCfEb056B0C0e2Cf1Cb321B4D22c1E35ee01CdAC7
walletG.withDraw(50,0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
assertEq(walletG.getValue(), balance );
}
// function testwithDrawIsOwner()public{
// uint balance= walletG.getValue();
// vm.startPrank(userAddress);
// payable(address(walletG)).transfer(200);
// //console.log(address(walletG).getValue);
// walletG.withDraw(50,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
// assertEq(walletG.getValue(), balance - 50);
// }

}

   