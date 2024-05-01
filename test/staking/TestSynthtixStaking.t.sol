// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "@labs/staking/SynthetixStaking.sol";
import "@labs/staking/MyToken.sol";

contract TestSynthtixStaking is Test {
    MyToken stakingToken;
    MyToken rewardToken;
    StakingRewards staking;
    address user1 = vm.addr(1);
    address user2 = vm.addr(2);
    address user3 = vm.addr(3);

    function setUp() public {
        stakingToken = new MyToken();
        rewardToken = new MyToken();
        staking = new StakingRewards(address(stakingToken), address(rewardToken));
    }

    function test() public {
        rewardToken.mint(1000 * 1e18);
        rewardToken.transfer(address(staking),1000*1e18);
        staking.notifyRewardAmount(1000 * 1e18);
        vm.startPrank(user1);
        console.log(staking.rate());
        vm.warp(1 days);
        stakingToken.mint(10 * 1e18);
        stakingToken.transfer(address(user1),10 * 1e18);
        stakingToken.approve(address(staking),10*1e18);
        staking.stake(10*1e18);
        vm.stopPrank();
        assertEq(staking.totalSupply(),10 * 1e18);
        console.log(staking.duration());
        console.log(staking.acc());


        vm.startPrank(user2);
        console.log(staking.rate());
        vm.warp(2 days);
        console.log(staking.updated());
        stakingToken.mint(10 * 1e18);
        stakingToken.transfer(address(user2),10 * 1e18);
        stakingToken.approve(address(staking),10*1e18);
        staking.stake(10*1e18);
        console.log(staking.updated());
        vm.stopPrank();
        console.log(staking.acc());

    }
}
