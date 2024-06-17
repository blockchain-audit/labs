// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/staking/staking.sol";

contract StakingTest is Test {
    Staking public staking;
    MyToken public myToken;

    function setUp() public {
        myToken = new MyToken();
        staking = new Staking();
        myToken.mint(10 ** 6);
    }

    function testDeposit() public {
        uint256 initialPoolBalance = staking.stakingPool();
        staking.deposit(1000);
        uint256 finalPoolBalance = staking.stakingPool();
        assertEq(initialPoolBalance + 1000, finalPoolBalance);
    }

    function testAllowWithdraw() public {
        address userAddress = vm.addr(123);
        vm.startPrank(userAddress);
        vm.deal(userAddress, 500);
        uint256 dateBefore7Days = block.timestamp - 604800;
        uint256 sum = 500;
        staking.pushDatabase(dateBefore7Days, sum, userAddress);
        uint256 initialPoolBalance = staking.stakingPool();
        uint256 initalUserBalance = staking.myToken().balanceOf(userAddress);
        staking.print(userAddress);
        staking.withdraw(500);
        staking.print(userAddress);
        uint256 finalPoolBalance = staking.stakingPool();
        assertEq(initialPoolBalance - 500, finalPoolBalance);
        //uint256 finalUserBalance = staking.myToken().balanceOf(userAddress);
        assertEq(initalUserBalance - 500, finalPoolBalance - staking.calculateSum(500));
    }
}
