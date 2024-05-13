// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/staking/ERC20Implementation.sol";
import "../../src/staking/stakingRewards.sol";

contract StakingRewardsTest is Test {
    uint WAD = 10 ** 18;

    StakingRewards staking;

    ERC20Implementation rewardToken;
    ERC20Implementation stakingToken;

    uint256 duration = 604800;

    address user1 = vm.addr(1);
    address user2 = vm.addr(2);
    address user3 = vm.addr(3);

    function setUp() public {
        rewardToken = new ERC20Implementation();
        stakingToken = new ERC20Implementation();

        staking = new StakingRewards(address(stakingToken), address(rewardToken));

        rewardToken.mint(address(staking), 100000 * WAD);

        stakingToken.mint(user1, 1000 * WAD);
        stakingToken.mint(user2, 1000 * WAD);
        stakingToken.mint(user3, 1000 * WAD);
    }

    function testStake() public {
        vm.startPrank(user1);
        uint256 amountToStake = 100 * WAD;
        stakingToken.approve(address(staking), amountToStake);
        staking.stake(amountToStake);
        vm.stopPrank();
        console.log(staking.staked());
        assertEq(staking.staked(), amountToStake, "False");
    }

    function testUpdateRate() public {
        vm.warp(staking.finish() + 1);
        console.log("1");
        console.log("rate before", staking.rate());
        uint256 rate = 2000 * WAD;
        staking.updateRate(rate);
        console.log("rate", staking.rate());
        console.log("block.timestamp", block.timestamp);
        console.log("finish", staking.finish());
        assertEq(staking.rate(), rate / duration, "False");
        
        console.log("2");
        console.log("rate before", staking.rate());
        rate = 1000 * WAD;
        uint256 rateBefore = staking.rate();
        staking.updateRate(rate);
        console.log("rate", staking.rate());
        console.log("block.timestamp", block.timestamp);
        console.log("finish", staking.finish());
        assertEq(staking.rate(), (rate + (duration * rateBefore)) / duration, "False");   
    }

    function testWithdraw() public {
        vm.startPrank(user1);
        uint256 amountToStake = 6 * WAD;
        stakingToken.approve(address(staking), amountToStake);
        staking.stake(amountToStake);

        uint256 balanceBefore = staking.balances(user1);
        console.log("user1 balance before withdraw", staking.balances(user1));
        uint256 amountToWithdraw = 5 * WAD;
        staking.withdraw(amountToWithdraw);
        console.log("user1 balance after withdraw", staking.balances(user1));
        vm.stopPrank();
        assertEq(balanceBefore, staking.balances(user1) + amountToWithdraw, "False");
    }
}
