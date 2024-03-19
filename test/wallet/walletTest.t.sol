// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/wallet/wallet.sol";

contract WalletTest is Test{
    wallet public w;
   



    function setUp() public {
        w = new wallet();  
       
        
    }

    
    function testgetBalance() public {
       
       assertEq(w.getBalance(),0.009999999999999999,"not equals");

    }
    function testOwnerwithdraw() external{
        uint256 initBalance = w.getBalance();
        uint256 withdrawAmount = 0.01;
        w.withdraw(withdrawAmount, {from: address(0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d)});
        uint256 finalBalance = w.getBalance();
        assertEq(initBalance + withdrawAmount, finalBalance,"fix the function");
    }
     function testGabaimWithdraw() external{
        uint256 initBalance = w.getBalance();
        uint256 withdrawAmount = 0.01;
        w.withdraw(withdrawAmount, {from: address(0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d)});
        uint256 finalBalance = w.getBalance();

        assertEq(initBalance + withdrawAmount, finalBalance,"it is not work!!!");
    }
     function testUpdate() private{
        address payable public oldGabai = "0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d";
        address payable public newGabai = "0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b";
        w.update(oldGabai,newGabai);
        assertEq(gabaim[newGabai],1);
        assertEq(gabaim[oldGabai],0);
    }
    
}