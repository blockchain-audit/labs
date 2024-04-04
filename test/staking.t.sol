// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/exercises/staking _pull.sol";

contract TestStaking is Test {

function setUp()public{
    staking_pool=new Staking_pool();
    vm.deal(address(this), 100);
}
function testReceive()payable public{
    uint256 deposit=100;
    payable(address(staking_pool)).transfer(deposit);

}
}