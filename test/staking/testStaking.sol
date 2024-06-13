pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/staking/staking.sol";
import "@hack/staking/myToken.sol";
contract TestStaking is Test
{
    Staking public staking;
    MyToken token;
    uint public wad = 1000000000000000000;
    
    
    address public staker1 = address(123);
    address public staker2 = address(456);
    address public staker3 = address(789);

    function setUp() public
    {
        token = new MyToken();
        staking = new Staking(address(token));
    }

    function testStaking() public
    {
        uint amount = 875 * wad;
        token.mint(address(this), amount);
        token.approve(address(staking), amount);
        staking.staking(amount);
        assertEq(staking.getStakerAmount(address(this)), amount);
    }
    
    function testWithdrawLessDays() public
    {
        vm.warp(block.timestamp + 6 days);
        vm.expectRevert("You must wait at least 7 days");
        staking.withdraw();
    }

    function testWithdraw() public
    {
        uint amount = 875 * wad;

        token.mint(address(this), amount);
        token.approve(address(staking), amount);
        staking.staking(amount);
        vm.warp(block.timestamp + 8 days);
        staking.withdraw();
        assertEq(staking.getStakerAmount(address(this)), 0);
        uint reward = amount * wad / (staking.totalStakersSupply() * staking.rewards() * 2 / 100 / wad);
        assertEq(token.balanceOf(address(this)), amount + reward);
    }

    function testWithdrawFewStakers() public 
    {
        uint amount1 = 875 * wad;
        address user1 = address(123);
        token.mint(user1, amount1);
        vm.startPrank(user1);
        token.approve(address(staking), amount1);
        staking.staking(amount1);
        vm.stopPrank();

        uint amount2 = 5000 * wad;
        address user2 = address(234);
        token.mint(user2, amount2);
        vm.startPrank(user2);
        token.approve(address(staking), amount2);
        staking.staking(amount2);
        vm.stopPrank();

        uint amount3 = 1500 * wad;
        address user3 = address(456);
        token.mint(user3, amount3);
        vm.startPrank(user3);
        token.approve(address(staking), amount3);
        staking.staking(amount3);
        vm.stopPrank();

        vm.warp(block.timestamp + 8 days);
        vm.startPrank(user1);
        staking.withdraw();
        assertEq(staking.getStakerAmount(user1), 0);
        uint reward1 = amount1 * wad / (staking.totalStakersSupply() * staking.rewards() * 2 / 100 / wad);
        assertEq(token.balanceOf(user1), amount1 + reward1);
        vm.stopPrank();

        vm.startPrank(user2);
        staking.withdraw();
        assertEq(staking.getStakerAmount(user2), 0);
        uint reward2 = amount2 * wad / (staking.totalStakersSupply() * staking.rewards() * 2 / 100 / wad);
        assertEq(token.balanceOf(user2), amount2 + reward2);
        vm.stopPrank();

        vm.startPrank(user3);
        staking.withdraw();
        assertEq(staking.getStakerAmount(user3), 0);
        uint reward3 = amount3 * wad / (staking.totalStakersSupply() * staking.rewards() * 2 / 100 / wad);
        assertEq(token.balanceOf(user3), amount3 + reward3);
        vm.stopPrank();
    }
}
