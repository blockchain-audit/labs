// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@labs/tokens/MyToken.sol";
import "@labs/staking/Staking.sol";
import "forge-std/Test.sol";

contract FuzzTestStaking is Test {
    Staking staking;
    MyToken myToken;

    function setUp() public {
        myToken = new MyToken();
        staking = new Staking(address(myToken));
    }

    //amount - it is wad
    function testStake(uint256 amount) public {
        //will not overflow or underflow
        uint256 totalSupply = myToken.totalSupply();
        vm.assume(amount <= type(uint256).max - totalSupply);
        uint256 beforeInStaking = myToken.balanceOf(address(staking));
        myToken.mint(amount);
        uint256 beforeInThis = myToken.balanceOf(address(this));
        myToken.approve(address(staking), amount);
        staking.stake(amount);
        assertEq(staking.totalStaking(), amount);
        assertEq(myToken.balanceOf(address(this)), beforeInThis - amount);
        assertEq(myToken.balanceOf(address(staking)), beforeInStaking + amount);
    }

    // function testCalcReward(uint256 amount, uint256 totalStaking, uint256 balanceReward) public {
    //     uint256 CountReward = staking.calcReward(amount, totalStaking, balanceReward);
    //     assertEq(CountReward, (balanceReward / 100 * 2 * 1e18 / ((totalStaking * 1e18 / amount))));
    // }
}
