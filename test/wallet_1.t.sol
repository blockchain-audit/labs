pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet_1.sol";


contract Wallet1Test{

Wallet public wallet;

function setUp() public {
    wallet = new Wallet();
}

function testWithraw() public{
    
    
}
function testGetBalance() public{
     assert(address(wallet).balance == wallet.getBalance());
}








}