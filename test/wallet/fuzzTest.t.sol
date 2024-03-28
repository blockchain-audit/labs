// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/Wallet/Wallet.sol";

contract WalletFuzzTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
        //payable(address(wallet)).transfer(1000); 
        console.log(address(wallet));

    }
   
     function fuzzTestReceive(uint256 amount) public {
        
        address randomAddress = vm.addr(1234); // create random address
        vm.startPrank(randomAddress); // send from random address
        vm.deal(randomAddress, amount); // put money in this wallet
        uint256 initialBalance = address(wallet).balance; // the balance in the begining (before transfer)
        payable(address(wallet)).transfer(amount); // move amount to the contract
        uint256 finalBalance = address(wallet).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance + amount);
        vm.stopPrank();
    }

    function testAllowedWithdraw(uint256 amount) external {
        address userAddress = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d; // address of allowed user
        vm.startPrank(userAddress); // send from random address
        vm.deal(userAddress, amount); // put money in this wallet
        payable(address(wallet)).transfer(amount); // move amount to the contract
        uint256 initialBalance = address(wallet).balance; // the balance in the begining (before transfer)
        console.log(amount);
        wallet.withdraw(amount);
        uint256 finalBalance = address(wallet).balance; // the balance in the final (aftere transfer)
        assertEq(finalBalance, initialBalance - amount);
        vm.stopPrank();
    }
     function testNotAllowedWithdraw(address userAddress,uint8 amount) external {
        console.log(amount);
        console.log(userAddress);
        vm.startPrank(userAddress); // send from random address
        uint256 initialBalance = address(wallet).balance; // the balance in the begining (before transfer)
        console.log(initialBalance);
        vm.expectRevert();
        wallet.withdraw(amount);
        uint256 finalBalance = address(wallet).balance; // the balance in the final (aftere transfer)
        console.log(finalBalance);
        vm.stopPrank();
    }
     function testUpdate(address newGabai) public{
        console.log(newGabai,"new gabay");
        address oldGabai = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f;
        address userAddress = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496; // address of allowed user
        vm.startPrank(userAddress); // send from random address
        if(wallet.gabaim(newGabai)==1){
            vm.expectRevert();
            wallet.update(oldGabai, newGabai);
        }
        else{
            wallet.update(oldGabai, newGabai);
            assertEq(wallet.gabaim(newGabai),1);
            assertEq(wallet.gabaim(oldGabai),0);     
        }
        vm.stopPrank();
    }
}