// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet_1.sol";


contract Wallet1FuzzTest is Test{

Wallet public wallet;

address public sender ;

function setUp() public {
    wallet = new Wallet();
    sender = msg.sender;
    payable(address(wallet)).transfer(50);
}
// function testChangeLimit() public {
//         uint newLimit = 100;
//         wallet.changeLimit(newLimit);
//         // uint currentLimit = wallet.limit;
//         assert(wallet.limit newLimit);
//     }

receive() external payable {}
function testFuzzAddWithdraws(address check) public{
    wallet.addWithdraws(check);
    assertEq(wallet.withdraws(check) , true);
}
function testFuzzChangeWithdraws(address check) public{
    wallet.changeWithdraws(check,address(this));
    assertEq(wallet.withdraws(address(this)) , true);
    assertEq(wallet.withdraws(check) , false);
}
function testFuzzDeleteWithdraws(address check) public{
    wallet.deleteWithdraws(check);
    assertEq(wallet.withdraws(check) , false);
}

function testFuzzWithdraw(uint256 amount) public{
    vm.assume(amount <= address(wallet).balance);
    uint256 balance1=address(this).balance;
    uint256 balance2=address(wallet).balance;
    wallet.withdraw(amount);
    assertEq(address(this).balance , (balance1 + amount));
    assertEq(address(wallet).balance , (balance2 - amount));
}
function testGetBalance() public{
     assertEq(address(wallet).balance, wallet.getBalance());
}

}