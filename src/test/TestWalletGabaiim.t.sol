// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../WalletGabaiim.sol";

contract TestWalletGabaiim is Test{
    WalletGabaiim public wg ;

    function setUp() public{
        wg = new WalletGabaiim();
    }


/*    function testWithdraw(uint amount) public {
        uint256 balance = (payable(wg).balance);
        wg.withdraw(amount);
        if(balance >= amount)
            assertEq(balance - amount, (payable(wg).balance));
        else
            vm.expectRevert(abi.encodePacked("Not Enough Money in wallet"));

    }*/
        function testAddGabai(address newGabai) public {
        uint256 balance = (payable(wg).balance);
        assertTrue(wg.gabaiim[newGabai]);
    }
}