// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/exercises/staking _pull.sol";

contract TestStaking is Test {
Staking_pool public staking_pool;
function setUp()public{
     staking_pool=new Staking_pool();
    vm.deal(address(this), 100);
}

function testReceive() public {

    uint256 deposit = 50;
    console.log('this',address(this));
    console.log('staking_pool',address(staking_pool));
        console.log('this',address(this).balance);
    payable(address(staking_pool)).transfer(deposit);
    console.log('staking_pool',address(staking_pool).balance);
        console.log('this',address(this).balance);
}
function testWhendeposit(){
    
}
}