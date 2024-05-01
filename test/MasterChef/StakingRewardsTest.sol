// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/defi/staking-rewards/
// Code is a stripped down version of Synthetix
pragma solidity ^0.8.20;
import "@hack/like/IERC20.sol";

contract StakingRewardsTest is Test {
    uint256 WAD = 10 ** 18;
    StakingRewards staking;
    ERC20 rt;
    ERC20 st;
    address user1 = vm.addr(1);
    address user2 = vm.addr(2);
    address user3 = vm.addr(3);

   function setUp ()public{
    rt = new ERC20('REWARD_TOKEN');
    st = new ERC20('STAKING_TOKEN');

    staking = new StakingRewards(address(st),address(rt));
    rt.mint(address(staking),100000 * WAD);
    st.mint(user1, 1000 * WAD);
    st.mint(user2, 1000 * WAD);
    st.mint(user3, 1000 * WAD);

   }

   function testStake() public {
    vm.startPrank(user1);
    st.approve(address(staking));
    staking.stake(100 * WAD);
    vm.stopPrank();

    vm.startPrank(user2);
    st.approve(address(staking));
    staking.stake(100 * WAD);
    vm.stopPrank();

    vm.startPrank(user1);
    console.log(block.timestamp);
    vw.warp(1000);
    staking.withdraw(5 * WAD);
    console.log(block.timestamp);
    console.log(staking.lastTime());
    console.log(staking.rate());
    console.log(staking.reward());
    vm.warp(100000);
    staking.withdraw(WAD);
    console.log(staking.reward());

   }
}
