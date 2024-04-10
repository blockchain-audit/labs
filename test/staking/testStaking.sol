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

    function testWithdraw1() public
    {
        uint amount = 875 * wad;
        token.mint(address(this), amount);
        token.approve(address(staking), amount);
        staking.staking(amount);
        console.log(staking.getStakerAmount(address(this)));
        vm.warp(block.timestamp + 8 days);
        staking.withdraw();
        assertEq(staking.getStakerAmount(address(this)), 0);
        uint reward = staking.rewards() * 2 / 100 * amount / staking.totalStakersSupply();
        assertEq(token.balanceOf(address(this)), amount + reward);
    }
}