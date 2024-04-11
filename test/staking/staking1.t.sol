pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking1.sol";


contract stakeTest is Test {

    Stake public stake;

   function setUp() public {
        stake = new Stake(); 
        stake.mint(msg.sender , 1000000);
        stake.mint(address(this),10000000);
    }
    function testStaking() public { 
        vm.warp(1648739200);
        uint amount =1234;
        uint total = stake.totalStaking();
        uint amountStaked = stake.stakers(address(this));
        stake.approve(address(this),amount);
        stake.stakeing(amount);
        assertEq(stake.totalStaking() , total+amount);
        console.log("bb",block.timestamp);
        assertEq(stake.dates(address(this)),block.timestamp);
        assertEq(stake.stakers(address(this)),amountStaked+amount);
    }

    function testUnlockAll() public{
        vm.warp(1648739200);
        stake.approve(address(this),1234);
        stake.stakeing(1233);
        vm.warp(1648739200 + 8 days);
        stake.approve(address(this),1234);
        stake.unlockAll();
    }

    function testUnlock() public {
        vm.warp(1648739200);
        console.log("bb",block.timestamp);
        uint amount=11;
        stake.approve(address(this),1234);
        stake.stakeing(1233);
        vm.warp(1648739200 + 8 days);
        stake.approve(address(this),amount);
        stake.unlock(11);
    }
}