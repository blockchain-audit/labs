pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet_1.sol";


contract Wallet1TestFuzz{

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
    assert(wallet.withdraws(sender) == true);
}
function testChangeWithdraws() public{
    wallet.changeWithdraws(sender,address(this));
    assert(wallet.withdraws(address(this)) == true);
    assert(wallet.withdraws(sender) == false);
}
function testDeleteWithdraws() public{
    wallet.deleteWithdraws(sender);
    assert(wallet.withdraws(sender) == false);
}

function testWithdraw() public{
    console.log(address(this));
    console.log(address(this).balance);
    console.log(address(wallet));
    console.log(address(wallet).balance);
    console.log(msg.sender);
    console.log(msg.sender.balance);
    wallet.withdraw(1);
    console.log(msg.sender.balance);   
}
function testGetBalance() public{
     assert(address(wallet).balance == wallet.getBalance());
}

}