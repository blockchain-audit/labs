// // SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
 import "foundry-huff/HuffDeployer.sol";
 import "forge-std/Test.sol";
import "../../src/staking/staking.sol";
import "../../src/MyToken.sol";


 contract StakingTest is Test{
    uint constant WAD=10**18;
    StakingRewards staking;
    ERC20 rt;
    ERC20 st;
    address user=vm.addr(1);
  function setUp() public  {
    rt = new ERC20('REWARD_TOKEN');
    st = new ERC20('STAKING_TOKEN');
    staking = new StakingRewards(address(st),address(rt));
    rt.mint(address(staking),100000*WAD);
    rt.mint(user,1000*WAD);
    }
 }