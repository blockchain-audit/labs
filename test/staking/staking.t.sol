// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../../src/staking/staking.sol";

contract StakingTest is Test {
    Staking public staking;

    CloudToken public cloudToken;

    uint WAD = 10 ** 18;

    function setUp() public {
        cloudToken = new CloudToken();
        staking = new Staking(address(cloudToken));
    }

    function testWasBeforeSevenDays() public {
        vm.warp(1641070800);
        uint256 stakingDate = block.timestamp - 605800;
        bool wasBeforeSevenDays = staking.wasBeforeSevenDays(stakingDate);
        assertEq(wasBeforeSevenDays, true, "Error");
    }

    function testWasNotBeforeSevenDays() public {
        vm.warp(1641070800);
        uint256 stakingDate = block.timestamp - 600800;
        bool wasBeforeSevenDays = staking.wasBeforeSevenDays(stakingDate);
        assertEq(wasBeforeSevenDays, false, "Error");
    }

    function testStake() public {
        vm.warp(1641070800);
        uint256 amountToDeposit = 2 * WAD;
        console.log("msg.sender", msg.sender);
        console.log("balance", (msg.sender).balance);
        console.log("address(this)", address(this));
        cloudToken.mint(60 * WAD);
        console.log("balanceOf", cloudToken.balanceOf(address(cloudToken)));
        cloudToken.approve(address(staking), amountToDeposit);
        staking.stake(amountToDeposit);
        assertEq(amountToDeposit, staking.getTotalStaked(), "Error");
    }

}
