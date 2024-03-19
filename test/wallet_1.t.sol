pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet_1.sol";


contract Wallet1Test{

Wallet public wallet;

address public sender ;

function setUp() public {
    wallet = new Wallet();
    sender = msg.sender;
}
// function testChangeLimit() public {
//         uint newLimit = 100;
//         wallet.changeLimit(newLimit);
//         uint currentLimit = wallet.limit();
//         assert.equal(currentLimit, newLimit, "Limit should be updated to newLimit");
//     }
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

function testWithraw() public{
    //add ether to be able to withraw
    uint256 todeposite = 10 ether;
    payable(address(wallet)).transfer(todeposite);
    assert(address(wallet).balance == todeposite);
    uint256 towithdraw = 5 ether;
    wallet.withdraw(towithdraw);    
}
function testGetBalance() public{
     assert(address(wallet).balance == wallet.getBalance());
}

}