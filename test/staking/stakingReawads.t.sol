// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/stakingReawads.sol";

contract StakingRewardsTest is Test {
    StakingRewards stakingRewards;

    function beforeEach() public {
        stakingRewards = new StakingRewards(address(this), address(this));
    }

    function testStake() public {
        uint256 initialBalance = stakingRewards.stakingToken().balanceOf(address(this));
        uint256 amountToStake = 100;

        stakingRewards.stake(amountToStake);

        uint256 finalBalance = stakingRewards.stakingToken().balanceOf(address(this));
        assertTrue(finalBalance == initialBalance - amountToStake, "Staking failed");
    }

    function testWithdraw() public {
        uint256 amountToStake = 100;
        stakingRewards.stake(amountToStake);

        uint256 initialBalance = stakingRewards.stakingToken().balanceOf(address(this));

        stakingRewards.withdraw(amountToStake);

        uint256 finalBalance = stakingRewards.stakingToken().balanceOf(address(this));
        assertTrue(finalBalance == initialBalance + amountToStake, "Withdrawal failed");
    }

    function testGetReward() public {
        uint256 amountToStake = 100;
        stakingRewards.stake(amountToStake);

        uint256 initialRewardBalance = stakingRewards.rewardsToken().balanceOf(address(this));
        stakingRewards.getReward();
        uint256 finalRewardBalance = stakingRewards.rewardsToken().balanceOf(address(this));

        assertTrue(finalRewardBalance != initialRewardBalance, "Reward not received");
    }
}
