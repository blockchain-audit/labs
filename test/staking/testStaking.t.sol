// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "@labs/staking/MyToken.sol";
import "@labs/staking/Staking.sol";
import "forge-std/Test.sol";


contract testStaking is Test{
    Staking staking;
    MyToken myToken ;

    function setUp() public {
        myToken = new MyToken();
        staking = new Staking(address(myToken));
    }

    function testStake () public{
        uint totalStaking = myToken.balanceOf(address(staking));
        uint wad = 10 ** 18;
        myToken.mint(10 * wad);
        myToken.approve(address(staking), 2 * wad);
        staking.stake(2 * wad);
        assertEq(myToken.balanceOf(address(staking)), totalStaking + 2 * wad);
    }

    function testWithdraw()public{
        uint totalStaking = myToken.balanceOf(address(staking));
        uint wad = 10 ** 18;
        myToken.mint(10 * wad);
        myToken.approve(address(staking), 2 * wad);
        staking.stake(2 * wad);
        // vm.warp(2);
        staking.withdraw();
        assertEq(myToken.balanceOf(address(staking)), 0);
    }
}