// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/Wallet/CollectorsWallet.sol";
contract CollectorsTest is Test {
    CollectorsWallet public wallet;
    function setUp() public {
        wallet = new CollectorsWallet();
        payable(address(wallet)).transfer(100); // Transfer 100 to a contract
    }

    function testReceive() public{
        uint256 startBalance= address(wallet).balance;
        console.log(startBalance);
        payable(address(wallet)).transfer(500);
        uint finalBalance= address(wallet).balance;
        console.log(finalBalance);
        assertEq(finalBalance, startBalance + 500);
     }

    function testNotAllowedWd() external {
        uint256 withdrawAmount = 50;
        address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from random address
        vm.expectRevert();
        wallet.withdraw(withdrawAmount);
        vm.stopPrank();
    }
    function testAllowedWd() external {
        uint256 withdrawAmount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        vm.startPrank(userAddress); // send from random address
        console.log(address(userAddress).balance);
        uint256 initialBalance = address(wallet).balance; // the balance in the begining (before transfer)
        wallet.withdraw(withdrawAmount);
        uint256 finalBalance = address(wallet).balance; // the balance in the final (after transfer)
        assertEq(finalBalance, initialBalance - withdrawAmount);
        vm.stopPrank();
    }

    function testWithdraw() public {
        require(address(this).balance>=50, "fff");
        uint amount = 50;
        uint256 startBalance = address(this).balance;
        console.log(startBalance);
        //finalBalance = address(wallet).balance;
        uint finalBalance = address(this).balance;
        console.log(address(this).balance);
        finalBalance = wallet.withdraw(amount);
        console.log(address(this).balance);
        assertEq(finalBalance, startBalance-amount);
         console.log(finalBalance);
    }

    // function testUpdateCollectors() public {
    //     address oldCollector = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;
    //     address newCollector = 0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b;
    //     address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
    //     // address userAddress = vm.addr(1); // address of not allowed user
    //     vm.startPrank(userAddress); // send from random address
    //     vm.expectRevert();
    //     wallet.updateCollectors(oldCollector, newCollector);
    //     // vm.startPrank(userAddress); // send from random address
    //     // vm.expectRevert();
    //     // walletC.updateCollectors(oldCollector, newCollector);
    //     // why it is not work?
    //     // assertEq(wallet.collectors(newCollector), 1);
    //     // assertEq(wallet.owner() , 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f);
    //     // assertEq(wallet.collectors(oldCollector), 0);
    //     vm.stopPrank();
    // }
    // function testGetBalance() public {
    //     // why it is not work?
    //     // assertEq(walletC.getBalance(), 50 , "not equals");
    //     assertEq(wallet.getBalance(), address(wallet).balance, "not equals");
    // }  
}
