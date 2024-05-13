// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "@labs/staking/SynthetixStaking.sol";
import "@labs/tokens/MyToken.sol";

contract TestSynthtixStaking is Test {
    MyToken stakingToken;
    MyToken rewardToken;
    StakingRewards staking;
    address user1 = vm.addr(1);
    address user2 = vm.addr(2);
    address user3 = vm.addr(3);
    uint256 wad = 1e18;

    function setUp() public {
        stakingToken = new MyToken();
        rewardToken = new MyToken();
        staking = new StakingRewards(address(stakingToken), address(rewardToken));
        rewardToken.mint(1000 * 1e18);
        rewardToken.transfer(address(staking), 1000 * 1e18);
        staking.notifyRewardAmount(1000 * 1e18);
    }

    // function test() public {
    //     staking.notifyRewardAmount(1000 * 1e18);
    //     vm.startPrank(user1);
    //     console.log(staking.rate());
    //     vm.warp(1 days);
    //     stakingToken.mint(10 * 1e18);
    //     stakingToken.transfer(address(user1),10 * 1e18);
    //     stakingToken.approve(address(staking),10*1e18);
    //     staking.stake(10*1e18);
    //     vm.stopPrank();
    //     assertEq(staking.totalSupply(),10 * 1e18);
    //     console.log(staking.duration());
    //     console.log(staking.acc());

    //     vm.startPrank(user2);
    //     console.log(staking.rate());
    //     vm.warp(2 days);
    //     console.log(staking.updated());
    //     stakingToken.mint(10 * 1e18);
    //     stakingToken.transfer(address(user2),10 * 1e18);
    //     stakingToken.approve(address(staking),10*1e18);
    //     staking.stake(10*1e18);
    //     console.log(staking.updated());
    //     vm.stopPrank();
    //     console.log(staking.acc());

    // }

    function testOneStakerAfter2Seconds() public {
        vm.startPrank(user1);
        stakingToken.mint(100 * wad);
        stakingToken.approve(address(staking), 100 * wad);
        staking.stake(100 * wad);
        vm.warp(block.timestamp + 2);
        staking.getReward();
        // (1000 - reward from owner) /
        // 7 days *
        // 2 - second
        // beacuse one staker
        assertEq(rewardToken.balanceOf(user1), 3306878306878300);
    }

    function testOneStakerAfter2Days() public {
        vm.startPrank(user1);
        stakingToken.mint(100 * wad);
        stakingToken.approve(address(staking), 100 * wad);
        staking.stake(100 * wad);
        vm.warp(2 days);
        staking.getReward();
        // (1000 - reward from owner) /
        // 7 days *
        // 2 days
        // beacuse one staker
        assertEq(rewardToken.balanceOf(user1), 285712632275132199200);
    }

    function testWithdraw() public {
        vm.startPrank(user1);
        stakingToken.mint(10 * wad);
        stakingToken.approve(address(staking), 10 * wad);
        staking.stake(10 * wad);
        uint256 countTokens = stakingToken.balanceOf(user1);
        staking.withdraw(10 * wad);
        assertEq(stakingToken.balanceOf(user1), countTokens + 10 * wad);
    }

    function testStake() public {
        vm.startPrank(user1);
        uint256 BeforeStakeStaking = stakingToken.balanceOf(address(staking));
        uint256 supply = staking.totalSupply();
        stakingToken.mint(10 * wad);
        uint256 BeforeStakeUser1 = stakingToken.balanceOf(user1);
        stakingToken.approve(address(staking), 10 * wad);
        staking.stake(10 * wad);
        console.log(stakingToken.balanceOf(user1));
        assertEq(stakingToken.balanceOf(user1), BeforeStakeUser1 - 10 * wad);
        assertEq(staking.totalSupply(), supply + 10 * wad);
        assertEq(stakingToken.balanceOf(address(staking)), BeforeStakeStaking + 10 * wad);
    }
}
