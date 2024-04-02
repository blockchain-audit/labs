// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/Wallet/Wallet.sol";

contract WalletTest is Test{

    Wallet public w;
    function  setUp() public{
        w = new Wallet();
    }
       function testReceive() public {
        address randomAddress = vm.addr(1234); // create random address
        vm.startPrank(randomAddress); // send from random address
        uint256 amount = 100;
        vm.deal(randomAddress, amount); // put money in this wallet
        uint256 initialBalance = address(w).balance; // the balance in the begining (before transfer)
        payable(address(w)).transfer(50); // move 50 to the contract
        uint256 finalBalance = address(w).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance + 50);
        vm.stopPrank();
    }
 function testAllowedWithdraw() external {
    
        uint256 withdrawAmount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        // address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from random address
        // vm.expectRevert();
        uint256 initialBalance = address(w).balance; // the balance in the begining (before transfer)
        w.withdraw(withdrawAmount);
        uint256 finalBalance = address(w).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance - 50);
        
        vm.stopPrank();
    }
    
   /* function testUpdate() public{
        address oldGabai = "0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d";
        address newGabai = "0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b";

        // address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        //address userAddress = vm.addr(1); // address of not allowed user
        //vm.startPrank(userAddress); // send from random address
        vm.expectRevert();
        w.update(oldGabai, newGabai);
         vm.stopPrank();
       
        //assert(w.gabaim[newGabai] == 1);
        /*assertEq(w.gabaim[newGabai],1);
        assertEq(w.gabaim[oldGabai],0);
        //assertEq(w.owner(),"0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f"); 
    }*/

    function testGetBalance() public{
       
        // assertEq(wallet.getBalance(), 50 , "not equals"); 
        assertEq(w.getBalance(), address(w).balance , "not equals");
    }

}