// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/exercises/staking_orginal.sol";
import "forge-std/interfaces/IERC20.sol";
import "../../src/exercises/my_token.sol";

contract TestStaking_Or is Test {
   StakingRewards staking_orginal;
MyToken stakingToken;
MyToken rewardsToken;
   function setUp()public{
        stakingToken = new MyToken();
        rewardsToken = new MyToken();
        staking_orginal=new StakingRewards(address(stakingToken),address(rewardsToken));
        //מנפיקה מטבעות שיהיה אפשרות לביא תגמולים 
        rewardsToken.mint(1000,address(staking_orginal));
        // מניפקה למשתמש מטבעות על מנת יכול להפקיד
        staking_orginal.updateRate(1000);
        //מעדכן את הזמן כאשר הפינש הסתיים אז אני מעדכנת את הזמן +7
        vm.expectRevert("reward duration not finished");
        staking_orginal.setRewardsDuration(7 days);
    }

    function testWithDrawO()public{
         uint256 withD=50;
         staking_orginal.withdraw(withD);
    }
    function testStake()public{
    
    }


}



