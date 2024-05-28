// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet_1.sol";


contract Wallet1Test is Test{

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
function testAddWithdraws() public{
    wallet.addWithdraws(sender);
    assertEq(wallet.withdraws(sender) , true);
}
function testChangeWithdraws() public{
    wallet.changeWithdraws(sender,address(this));
    assertEq(wallet.withdraws(address(this)) , true);
    assertEq(wallet.withdraws(sender) , false);
}
function testDeleteWithdraws() public{
    wallet.deleteWithdraws(sender);
    assertEq(wallet.withdraws(sender) , false);
}

function testWithdraw() public{
    uint256 balance1=address(this).balance;
    uint256 balance2=address(wallet).balance;
    uint256 amountToWithdraw = 40;
    wallet.withdraw(amountToWithdraw);
    assertEq(address(this).balance , (balance1+amountToWithdraw));
    assertEq(address(wallet).balance , (balance2 - amountToWithdraw));
}
function testGetBalance() public{
     assertEq(address(wallet).balance, wallet.getBalance());
}

}