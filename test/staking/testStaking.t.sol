// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "@labs/staking/MyToken.sol";
import "@labs/staking/Staking.sol";
import "forge-std/Test.sol";

contract testStaking is Test {
    Staking staking;
    MyToken myToken;

    function setUp() public {
        myToken = new MyToken();
        staking = new Staking(address(myToken));
    }

    function testStake() public {
        uint256 totalStaking = myToken.balanceOf(address(staking));
        uint256 wad = 10 ** 18;
        myToken.mint(10 * wad);
        myToken.approve(address(staking), 2 * wad);
        staking.stake(2 * wad);
        assertEq(myToken.balanceOf(address(staking)), totalStaking + 2 * wad);
    }

    function testWithdraw() public {
        uint256 totalStaking = myToken.balanceOf(address(staking));
        uint256 wad = 10 ** 18;
        myToken.mint(2 * wad);
        myToken.approve(address(staking), 2 * wad);
        staking.stake(2 * wad);
        vm.warp(block.timestamp + 7 days);
        staking.withdraw();
        assertEq(myToken.balanceOf(address(staking)) - staking.reward(), 0);
        assertEq(myToken.balanceOf(address(this)), 2 * wad + 20000 * 1e18);
        assertEq(staking.reward(), 980000 * 10 ** 18);
    }

    function testWithdraw1() public {
        uint256 totalStaking = myToken.balanceOf(address(staking));
        uint256 wad = 10 ** 18;
        //staker 1 : stake 2 tokens
        myToken.mint(2 * wad);
        myToken.approve(address(staking), 2 * wad);
        staking.stake(2 * wad);
        //staker 2 : stake 18 tokens
        vm.startPrank(vm.addr(1));
        myToken.mint(18 * wad);
        myToken.approve(address(staking), 18 * wad);
        staking.stake(18 * wad);
        vm.stopPrank();
        vm.warp(block.timestamp + 7 days);
        //staker 1 : withdraw tokens
        staking.withdraw();
        assertEq(myToken.balanceOf(address(staking)) - staking.reward(), 18 * 10 ** 18);
        assertEq(myToken.balanceOf(address(this)), 2 * wad + 2000 * 1e18);
        assertEq(staking.reward(), 998000 * 10 ** 18);
        //staker 3 : stake 18 tokens
        vm.startPrank(vm.addr(12));
        myToken.mint(18 * wad);
        myToken.approve(address(staking), 18 * wad);
        staking.stake(18 * wad);
        vm.stopPrank();
        //staker 2 : withdraw tokens
        vm.startPrank(vm.addr(1));
        staking.withdraw();
        vm.stopPrank();
        assertEq(myToken.balanceOf(address(staking)) - staking.reward(), 18 * 10 ** 18);
        assertEq(myToken.balanceOf(vm.addr(1)), 18 * wad + 9980 * 1e18);
        assertEq(staking.reward(), 988020 * 10 ** 18);
    }

    function testWithdrawLessSevenDays() public {
        uint256 totalStaking = myToken.balanceOf(address(staking));
        uint256 wad = 10 ** 18;
        myToken.mint(2 * wad);
        myToken.approve(address(staking), 2 * wad);
        staking.stake(2 * wad);
        vm.expectRevert("It hasn't been 7 days yet");
        staking.withdraw();
    }

    function testCalcReward() public {
        console.log(staking.calcReward(18 * 10 ** 18, 36 * 10 ** 18, 998000 * 10 ** 18));
        assertEq(staking.calcReward(5000 * 10 ** 18, 25000 * 10 ** 18, 1000000 * 10 ** 18), 4000 * 10 ** 18);
        assertEq(staking.calcReward(10000 * 10 ** 18, 25000 * 10 ** 18, 1000000 * 10 ** 18), 8000 * 10 ** 18);
        assertEq(staking.calcReward(10000 * 10 ** 18, 10000 * 10 ** 18, 1000000 * 10 ** 18), 20000 * 10 ** 18);
    }
}
