// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/wallet/CollectorsWallet.sol";

contract collectorsFuzzTest is Test {
    CollectorsWallet public walletGabaim;
    address userAddress = vm.addr(1);

    function setUp() public {
        walletGabaim = new CollectorsWallet();
        // why it is not work?
        // payable(address(walletGabaim)).transfer(1000); // move 1000 to the contract
    }

    function testReceive(uint256 amount) public {
        console.log(amount, " receive amount");
        vm.startPrank(userAddress);
        vm.deal(userAddress, amount);
        uint256 initialBalance = address(walletGabaim).balance; // the balance in the begining (before transfer)
        payable(address(walletGabaim)).transfer(amount); // move amount to the contract
        uint256 finalBalance = address(walletGabaim).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance + amount);
        vm.stopPrank();
    }

    function testAllowedWithDraw(uint256 amount) external {
        console.log(amount, " with draw amount");
        userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        vm.startPrank(userAddress); // send from user address
        vm.deal(userAddress, amount); 
        payable(address(walletGabaim)).transfer(amount); // move amount to the contract
        uint256 initialBalance = address(walletGabaim).balance; // the balance in the begining (before transfer)
        walletGabaim.withdraw(amount);
        uint256 finalBalance = address(walletGabaim).balance; // the balance in the final (after transfer)
        assertEq(finalBalance, initialBalance - amount);
        vm.stopPrank();
    }

    function testWithDrawNoMoney(uint256 amount) external {
        console.log(amount, " with draw amount");
        userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        vm.startPrank(userAddress); // send from user address
        if(amount!= 0){
            vm.expectRevert();
        }
        walletGabaim.withdraw(amount);
        vm.stopPrank();
    }

    function testNotAllowedWithDraw(uint256 amount) external {
        console.log(amount, " with draw amount");
        // console.log(userAddress, " with draw randomAddress");
        vm.startPrank(userAddress); // send from user address
        vm.deal(userAddress, amount); 
        payable(address(walletGabaim)).transfer(amount); // move amount to the contract
        vm.expectRevert();
        walletGabaim.withdraw(amount);
        vm.stopPrank();
    }

    function testUpdateCollectors(address oldGabai, address newGabai) public {
        address ownerAddress = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496; // address of owner user
        vm.startPrank(ownerAddress); // send from owner address
        console.log(address(msg.sender));
        if(walletGabaim.collectors(oldGabai)!=1){
            vm.expectRevert();
        }
        walletGabaim.updateCollectors(oldGabai, newGabai);
        vm.stopPrank();
    }
}
