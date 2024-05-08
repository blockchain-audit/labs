// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@labs/staking/MyToken.sol";
import "@labs/AMM/CP.sol";
import "forge-std/Test.sol";

contract TestCP is Test {
    MyToken token0;
    MyToken token1;
    CP cp;
    uint256 wad = 1e18;

    function setUp() public {
        token0 = new MyToken();
        token1 = new MyToken();
        cp = new CP(address(token0), address(token1));
    }

    function test() public {
        add(5 * wad, 10 * wad);
        assertEq(cp.totalSupply(), 7071067811865475244);
        assertEq(cp.reserve0(), 5 * wad);
        assertEq(cp.reserve1(), 10 * wad);
        assertEq(cp.balances(address(this)), 7071067811865475244);

        vm.startPrank(vm.addr(1));
        add(15 * wad, 30 * wad);
        assertEq(cp.totalSupply(), 21213203435596425732 + 7071067811865475244);
        assertEq(cp.reserve0(), 20 * wad);
        assertEq(cp.reserve1(), 40 * wad);
        assertEq(cp.balances(address(vm.addr(1))), 21213203435596425732);
        vm.stopPrank();

        vm.startPrank(vm.addr(2));
        add(1 * wad, 2 * wad);
        assertEq(cp.totalSupply(), 1414213562373095048 + 21213203435596425732 + 7071067811865475244);
        assertEq(cp.reserve0(), 21 * wad);
        assertEq(cp.reserve1(), 42 * wad);
        assertEq(cp.balances(address(vm.addr(2))), 1414213562373095048);
        vm.stopPrank();

        vm.startPrank(vm.addr(3));
        // swap(address(token0),5 * wad);
        // assertEq(cp.reserve0(),25985000000000000000);
        // assertEq(cp.reserve1(),41,991,942,659,226,476,814)
        // 4,985,000,000,000,000,000
        // 1,000,000,000,000,000,000
        // 21,000,000,000,000,000,000
        // 7,085,000,000,000,000,000

        // 42,000,000,000,000,000,000

        // 25985000000000000000

        // 8,057,340,773,523,186
    }

    function add(uint256 amount0, uint256 amount1) private {
        token0.mint(amount0);
        token0.approve(address(cp), amount0);
        token1.mint(amount1);
        token1.approve(address(cp), amount1);
        cp.addLiquidity(amount0, amount1);
    }

    // function swap(address token,uint amount) private{
    //     token.mint(amount);
    //     token.approve(amount);
    //     cp.swap(address(token),amount);
    // }
}
