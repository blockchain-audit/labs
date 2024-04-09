// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/Staking/Staking.sol";

contract StakingTest is Test{

    Staking public staking;
    function setUp() public{
        staking = new Staking();

    }
    function testDeposit() public{
        uint256 initialPoolBalance = staking.poolBalance();
        console.log(initialPoolBalance);
        staking.deposit(1000);
        uint256 finalPoolBalance = staking.poolBalance();
        console.log(finalPoolBalance);
        console.log(block.timestamp,"time");
        
    }
    function testWithdraw() public{
        for(uint256 i=0;i<1000;i++)
        {
            testDeposit();
        }
    }
}





