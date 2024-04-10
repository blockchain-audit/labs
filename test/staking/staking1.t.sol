pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking1.sol";


contract stakeTest is Test {

    Staking1 public stake;

   function setUp() public {
        stake = new Staking1();  
        // stake.mint(address(stake), stake.totalReward());
    }
    function test_staking() public {
        console.log("total staking:", stake.totalStaking());
        console.log("total staking:", stake.totalReward());
        console.log("balance:", stake.balanceOf(address(stake)));
        }
}